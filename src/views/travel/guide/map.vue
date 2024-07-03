<template>
  <div class="container map">
    <div id="mapContainer" class="map-container" />
    <div class="day-box">
      <div class="title">游玩日</div>
      <div class="cursor-pointer all-day" :class="{active: currentDay === 0}" @click="changeDay(0)">全部</div>
      <div v-for="(day, index) in days" :key="index" class="cursor-pointer day" :class="{active: currentDay === index+1}" @click="changeDay(index+1)">第{{ day }}天
        <div><i class="el-icon-remove-outline red" /></div></div>
      <div class="add-day cursor-pointer" @click="addDay"><i class="el-icon-circle-plus-outline" /> 新增天</div>
    </div>
  </div>
</template>

<script>
import AMap from '@amap/amap-jsapi-loader'
import {parseTime} from "@/utils";

export default {
  name: 'Map',
  data() {
    return {
      map: null,
      aMap: null,
      mapContextMenu: null,
      mapContextMenuPosition: null, // 右键菜单位置
      days: [],
      markers: {},
      lines: {},
      currentDay: 0,
      tmpMarkers:{},
      travelMode: 'driving',
      info:{
        id: 0,
        title: '',
        thumbnail: '',
        markers: [],
        lines: [],
        days: [],
      }
    }
  },
  created() {
    this.initMap()
  },
  methods: {
    initMap() {
      AMap.load({
        key: process.env.VUE_APP_MAP_KEY, // 申请好的Web端开发者Key，首次调用 load 时必填
        version: '2.0', // 指定要加载的 JSAPI 的版本，缺省时默认为 1.4.15
        plugins: ['AMap.PolylineEditor', 'AMap.MouseTool', 'AMap.Driving', 'AMap.Walking', 'AMap.PolylineEditor'] // 需要使用的的插件列表，如比例尺'AMap.Scale'等
      }).then((AMap) => {
        this.aMap = AMap
        this.map = new this.aMap.Map('mapContainer', { // 设置地图容器id
          // viewMode: '3D', // 是否为3D地图模式
          resizeEnable: true,
          zoom: 14, // 初始化地图级别
          center: [120.152809, 30.267461] // 初始化地图中心点位置
        })

        // 右键菜单
        this.registerRightClickMenu()
      }).catch(e => {
        console.log(e)
      })
    },
    // 注册右键菜单
    registerRightClickMenu() {
      const _this = this

      const top = document.createElement('div')
      const addStartPoint = document.createElement('p')
      const addEndPoint = document.createElement('p')
      top.className = 'right-click-menu'
      addStartPoint.innerText = '起点'
      addStartPoint.onclick = this.createLineStart
      addEndPoint.innerText = '终点'
      addEndPoint.onclick = this.createLineEnd
      top.appendChild(addStartPoint)
      top.appendChild(addEndPoint)
      const addCoustomPoint = document.createElement('p')
      addCoustomPoint.innerText = '打点'
      addCoustomPoint.onclick = this.createMarkerDialog
      top.appendChild(addCoustomPoint)

      // 通过content自定义右键菜单内容
      this.mapContextMenu = new this.aMap.ContextMenu({ isCustom: true, content: top })

      // 地图绑定鼠标右击事件——弹出右键菜单
      this.map.on('rightclick', function(e) {
        _this.mapContextMenu.open(_this.map, e.lnglat)
        _this.mapContextMenuPosition = e.lnglat
      })
    },
    addDay() {
      this.days.push(this.days.length + 1)
      this.currentDay = this.days.length
      this.tmpMarkers[this.currentDay]={}
    },
    changeDay(index) {
      this.currentDay = index
      // 重新绘制线路和标记点
    },
    clearTmpMarkers(day){
      for(let i in this.tmpMarkers[day]){
        this.map.remove(this.tmpMarkers[day][i])
      }
      this.tmpMarkers[day]={}
    },
    // 创建线路起点
    createLineStart() {
      if (this.currentDay === 0) {
        this.$message.error('请添加或者选择游玩日')
        return
      }
      this.createMarker('begin')
      this.generateLine()
      this.mapContextMenu.close()
    },
    // 创建线路终点
    createLineEnd() {
      if (this.currentDay === 0) {
        this.$message.error('请添加或者选择游玩日')
        return
      }
      this.createMarker('end')
      this.generateLine()
      this.mapContextMenu.close()
    },
    // 创建自定义标记点弹窗
    createMarkerDialog() {
      if (this.currentDay === 0) {
        this.$message.error('请添加或者选择游玩日')
        return
      }
    },
    // 创建自定义标记点
    createMarker(m) {
      if (this.tmpMarkers[this.currentDay] && this.tmpMarkers[this.currentDay][m]) {
        this.map.remove(this.tmpMarkers[this.currentDay][m])
      }
      const marker = new this.aMap.Marker({
        position: [this.mapContextMenuPosition.lng, this.mapContextMenuPosition.lat],
        anchor: 'bottom-center',
        offset: new this.aMap.Pixel(0, 0)
      })
      marker.setMap(this.map)
      marker.setLabel({
        direction: 'top',
        offset: new this.aMap.Pixel(0, -5), // 设置文本标注偏移量
        content: "<div class='info'>" + (m === 'begin' ? '起点' : '终点') + '</div>' // 设置文本标注内容
      })
      this.tmpMarkers[this.currentDay][m] = marker
    },
    generateLine(){ // 生成线路
      const startMarker = this.tmpMarkers[this.currentDay]['begin']
      const endMarker = this.tmpMarkers[this.currentDay]['end']
      if (!startMarker ||!endMarker) {
        return
      }

      const _this = this
      let mapDriving = null
      switch (this.travelMode) {
        case 'walking':
          mapDriving = new this.aMap.Walking({
            map: this.map,
          })
          break
        default:
          mapDriving = new this.aMap.Driving({
            map: this.map,
            showTraffic: false,
          })
          break
      }
      mapDriving.search(new this.aMap.LngLat(startMarker._position[0], startMarker._position[1]), new this.aMap.LngLat(endMarker._position[0], endMarker._position[1]), function(status, result) {
        // result 即是对应的驾车导航信息，相关数据结构文档请参考  https://lbs.amap.com/api/javascript-api/reference/route-search#m_DrivingResult
        if (status === 'complete') {
          console.log('绘制驾车路线完成', result)
          const polyline = []
          let steps = result.routes[0].steps
          steps.forEach(ele => {
            ele.path.forEach(e => {
              polyline.push({ latitude: e.lat, longitude: e.lng })
            })
          })
          _this.lines[this.currentDay].push(_this.initLineData())
/*          _this.lineObj.polyline = polyline
          _this.info.mileage = result.routes[0].distance

          const durationInterval = [parseTime((new Date()) - result.routes[0].time * 1000), parseTime(new Date())]
          // _this.info.durationInterval[0] = parseTime((new Date()) - result.routes[0].time * 1000)
          // _this.info.durationInterval[1] = parseTime(new Date())
          _this.$set(_this.info, 'durationInterval', durationInterval)*/
        } else {
          console.log('获取驾车数据失败：', result)
        }
      })
      this.clearTmpMarkers(this.currentDay)
    },
    initLineData(){
      return {
        polyline: [],
      }
    }
  }
}
</script>

<style scoped lang="scss">
.map{
  position: relative;
  .map-container{
    height: calc(100vh - 54px);
  }
  .day-box{
    position: absolute;
    left: 20px;
    top: 20px;
    background-color: #fff;
    border-radius: 10px;
    padding: 20px;
    font-size: 14px;
    text-align: center;
    line-height: 30px;
    width: 150px;
    .title{
      font-weight: bold;
      color: teal;
      margin-bottom: 10px;
      font-size: 16px;
    }
    .add-day{
      background: #f5f5f5;
      border-radius: 5px;
      padding: 0 5px;
    }
    .all-day{
      margin-bottom: 10px;
    }
    .day{
      margin-bottom: 10px;
      display: flex;
      flex-direction: row;
      align-items: center;
      justify-content: space-between;
    }
    .active{
      background-color: teal;
      color: #fff;
      border-radius: 5px;
    }
  }
}

</style>
<style lang="scss">
.right-click-menu {
  background: #FFFFFF;
  border-radius: 5px;
  box-shadow: 0 2px 6px 0 rgb(114 124 245 / 50%);
  position: relative;
  top: 1rem;
  right: 1rem;
  p {
    line-height: 30px;
    width: 100px;
    text-align: center;
    margin: 0;
    cursor: pointer;
    padding: 5px 0;
  }
  p:hover {
    background: rgba(0, 128, 128, 0.1);
  }
}
</style>
