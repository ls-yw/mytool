<template>
  <div class="container">
    <div class="search-box">
      <el-form :inline="true" :model="searchObj" class="demo-form-inline">
        <el-form-item label="出发地">
          <el-cascader
            v-model="searchObj.from"
            :options="regions"
            :show-all-levels="false"
            placeholder="请选择出发地"
            :props="{ value:'code', label:'name'}"
            filterable
            clearable></el-cascader>
        </el-form-item>
        <el-form-item label="目的地">
          <el-cascader
            v-model="searchObj.to"
            :options="regions"
            :show-all-levels="false"
            :props="{ multiple: true, checkStrictly: true ,value:'code', label:'name'}"
            placeholder="请选择目的地"
            filterable
            clearable></el-cascader>
        </el-form-item>
        <el-form-item label="查询天数">
          <el-select v-model="searchObj.day" placeholder="请选择">
            <el-option
              v-for="item in options"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="onSubmit">查询</el-button>
        </el-form-item>
        <el-form-item>
          <el-link type="success" @click="changeShowType">{{showType === 1 ? '表格' : '图标'}}</el-link>
        </el-form-item>
      </el-form>
    </div>
    <div class="echarts-box" v-show="showType === 1">
      <el-row>
        <el-col :xs="24" :sm="24" :md="24" :lg="12" :xl="8" v-for="item in echartsIdArr" :key="item"><div  :id="'echarts-'+item" class="echart-price"></div></el-col>
      </el-row>
    </div>
    <div v-show="showType !== 1" class="table-box">
      <el-table
        :data="tableData"
        style="width: 100%"
      >
        <el-table-column
          type="index"
          width="50">
        </el-table-column>
        <el-table-column
          prop="name"
          label="行程"
          fixed
          sortable
          width="120">
        </el-table-column>
        <el-table-column
          v-for="(item,i) in xAxisData"
          :label="item"
          sortable
          width="80">
          <template slot-scope="scope">
            {{scope.row[i].price}}
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script>
import {getPlaneRegionApi, getPlaneRegionBySearchApi} from "@/api/plane";
import {postCurl} from "@/api/api";
import {getDatesBetween} from "@/utils";

export default {
  name: "plane",
  data(){
    return {
      searchObj:{
        from:[],
        to:[],
        day:30,
      },
      options:[{
        value: 30,
        label: '一个月'
      },{
        value: 0,
        label: '不限'
      }],
      regions:[],
      departure:{},
      destination:[],
      url:'https://sec-m.ctrip.com/restapi/soa2/13516/lowPriceCalendar',
      echartsIdArr:[],
      tableData:[],
      showType:1,
      xAxisData:[]
    }
  },
  mounted() {
    this.getRegion()
  },
  methods:{
    getRegion(){
      getPlaneRegionApi().then(response => {
        this.regions = []
        if (response.data.length === 0) {
          return false
        }
        this.regions = this.transformRegionsData(response.data)
      })
    },
    transformRegionsData(data){
      let result = [];

      for (let key in data) {
        let item = data[key];
        let newItem = {
          code: item.code,
          name: item.name,
          planeCode: item.planeCode,
          children: []
        };

        if (Object.keys(item.children).length > 0) {
          newItem.children = this.transformRegionsData(item.children);
        }

        if (item.planeCode !== "" || newItem.children.length > 0) {
          if (newItem.children.length === 0) {
            delete newItem.children
          }
          result.push(newItem);
        }
      }
      return result;
    },
    initData(){
      this.echartsIdArr = []
      this.xAxisData = []
      this.tableData = []
    },
    onSubmit(){
      if (this.searchObj.from.length === 0) {
        this.$message.error('请选择出发地')
        return
      }
      let fromArray = []
      let toArray = []
      this.searchObj.from.forEach(ele => {
        if (Array.isArray(ele)) {
          fromArray.push(ele[ele.length - 1])
        }else {
          console.log('ele', ele)
          fromArray.push(ele)
        }
      })
      this.searchObj.to.forEach(ele => {
        if (Array.isArray(ele)) {
          toArray.push(ele[ele.length - 1])
        }else {
          toArray.push(ele)
        }
      })
      this.initData()
      getPlaneRegionBySearchApi({from:fromArray, to:toArray}).then(resposne => {
        if (resposne.data.from.length === 0) {
          this.$message.error('获取不到出发地信息')
          return
        }
        this.departure = resposne.data.from[0]
        this.destination = resposne.data.to
        this.getPlanePrices()
      })
    },
    getPlanePrices(){
      const _this = this

      let index = 0;

      const processDestination = () => {
        if (index < this.destination.length) {
          const ele = this.destination[index];
          let res = _this.chartsPlanePrice(ele);
          if (res) {
            _this.echartsIdArr.push(ele.code);
          }

          setTimeout(() => {
            index++;
            processDestination();
          }, 2000);
        }
      };

      processDestination();

      //
      // this.destination.forEach(ele => {
      //   setTimeout(function () {
      //     _this.echartsIdArr.push(ele.code)
      //     _this.chartsPlanePrice(ele)
      //   }, 1000)
      // })
    },
    async chartsPlanePrice(destination){
      let param = {
        "head": {},
        "stype": 1, //1-国内 2-国际
        "dcty": this.departure.planeCode.toUpperCase(), //出发城市三字码
        "acty": destination.planeCode.toUpperCase(), //到达城市三字码
        "start": "",
        "end": '',
        "flag": 1
      };
      const _this = this
      const toResult = await postCurl(this.url, param)
      if (!toResult.prices) {
        this.$notify.error({
          message: this.departure.name+' - '+destination.name+'接口返回解析失败',
          duration: 0
        });
        console.log('toResult', toResult)
        return false
      }
      // setTimeout(async function  (){
        param.dcty = param.acty
        param.acty = _this.departure.planeCode.toUpperCase()
        const backResult = await postCurl(_this.url, param)
        if (!backResult.prices) {
          this.$notify.error({
            message: destination.name+' - '+this.departure.name+'接口返回解析失败',
            duration: 0
          });
          console.log('backResult', backResult)
          return false
        }
        _this.drawingCharts(destination, toResult.prices, backResult.prices)
      return true
      // }, 1000)
    },
    drawingCharts(destination, toResult, backResult){
      toResult.name = this.departure.name+'-'+destination.name
      backResult.name = destination.name+'-'+this.departure.name
      this.tableData.push(toResult)
      this.tableData.push(backResult)
      let chartDom = document.getElementById('echarts-'+destination.code);
      let myChart = this.$echarts.init(chartDom);
      let option;
      this.xAxisData = (this.searchObj.day === 30 ? getDatesBetween(toResult[0].dDate, (new Date(toResult[0].dDate)).setDate((new Date(toResult[0].dDate)).getDate()+30)) : getDatesBetween(toResult[0].dDate, toResult[toResult.length-1].dDate))
      option = {
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: [this.departure.name+'-'+destination.name, destination.name+'-'+this.departure.name]
        },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: this.xAxisData
        },
        yAxis: {
          type: 'value',
          axisLabel: {
            formatter: '{value}'
          }
        },
        series: [
          {
            name: this.departure.name+'-'+destination.name,
            type: 'line',
            data:  toResult.map(item => (item.price === 0 ? '-' : item.price)).slice(0, this.xAxisData.length),
            markPoint: {
              data: [
                { type: 'max', name: 'Max' },
                { type: 'min', name: 'Min' }
              ]
            },
            itemStyle: {
              color: '#378BFF' // 设置折线点的颜色为红色
            },
            // markLine: {
            //   data: [{ type: 'average', name: 'Avg' }]
            // }
          },
          {
            name: destination.name+'-'+this.departure.name,
            type: 'line',
            data: backResult.map(item => (item.price === 0 ? '-' : item.price)).slice(0, this.xAxisData.length),
            markPoint: {
              data: [
                { type: 'max', name: 'Max' },
                { type: 'min', name: 'Min' }
              ]
            },

            itemStyle: {
              color: '#008000' // 设置折线点的颜色为红色
            }
            // markLine: {
            //   data: [
            //     { type: 'average', name: 'Avg' },
            //   ]
            // }
          }
        ]
      }
      myChart.setOption(option);
    },
    changeShowType(){
      this.showType = this.showType === 1 ? 2 : 1
    }
  }
}
</script>

<style scoped lang="scss">
.container{
  .search-box{
    border: 1px solid #dddddd;
    margin: 20px;
    padding: 20px;
    text-align: center;
    .el-form--inline .el-form-item{
      margin-bottom: 0;
    }
  }
  .echarts-box{
    .echart-price{
      width: 100%;
      height: 300px;
    }
  }
}
</style>
