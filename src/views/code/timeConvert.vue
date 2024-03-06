<template>
  <div class="container">
    <div class="container-header">
      现在的时间戳是：
      <el-input v-model="timeStamp" readonly ></el-input>
      <el-button type="primary" size="medium" @click="startTimeStamp" v-if="!timeStampIntervalId">开始</el-button>
      <el-button type="danger" size="medium" @click="stopTimeStamp" v-if="timeStampIntervalId">停止</el-button>
      <el-button size="medium" @click="refreshTimeStamp" v-if="!timeStampIntervalId">刷新</el-button>
    </div>
    <div class="timeConvert-item">
      <div>时间戳 → 北京时间</div>
      <div class="input"><el-input v-model="timeTimestamp"  ></el-input></div>
      <div><el-button type="primary" size="medium" @click="timeToBj">转换</el-button></div>
      <div class="input"><el-input v-model="bjTimestamp"  ></el-input></div>
    </div>
    <el-divider></el-divider>
    <div class="timeConvert-item">
      <div>北京时间 ← 时间戳</div>
      <div class="input"><el-input v-model="bjTime"  ></el-input></div>
      <div><el-button type="primary" size="medium" @click="bjToTime">转换</el-button></div>
      <div class="input"><el-input v-model="timeTime"  ></el-input></div>
    </div>
  </div>
</template>

<script>
export default {
  name: "timeConvert",
  data(){
    return {
      timeStamp:0,
      timeStampIntervalId:null,
      timeTimestamp:0,
      bjTimestamp:'',
      bjTime:'',
      timeTime:''
    }
  },
  mounted() {
    let d = new Date()
    this.timeTimestamp = ((d.getTime())/1000).toFixed(0)
    this.bjTime = this.formatDate(d)
    this.startTimeStamp()
  },
  methods:{
    getTimestamp(){
      this.timeStamp = ((new Date().getTime())/1000).toFixed(0)
    },
    startTimeStamp(){
      this.refreshTimeStamp()
      this.timeStampIntervalId = setInterval(this.getTimestamp, 1000)
    },
    stopTimeStamp(){
      window.clearInterval(this.timeStampIntervalId)
      this.timeStampIntervalId = null
    },
    refreshTimeStamp(){
      this.timeStamp = ((new Date().getTime())/1000).toFixed(0)
    },
    formatDate(now)   {
      const year = now.getFullYear();
      const   month=now.getMonth()+1;
      const   date=now.getDate();
      let hour = now.getHours();
      if(hour < 10)hour = '0'+hour;
      let   minute=now.getMinutes();
      if(minute < 10)minute = '0'+minute;
      let   second=now.getSeconds();
      if(second < 10)second = '0'+second;
      return  year+"-"+month+"-"+date+" "+hour+":"+minute+":"+second;
    },
    timeToBj(){
      if(this.timeTimestamp.length !== 13 && this.timeTimestamp.length !== 10){
        this.$message.error('时间戳格式错误');
        return false;
      }
      const nowTime = this.timeTimestamp.length === 10 ? parseInt(this.timeTimestamp) * 1000 : this.timeTimestamp
      this.bjTimestamp = this.formatDate(new Date(nowTime))
    },
    bjToTime(){
      this.timeTime = Date.parse(new Date(this.bjTime))/1000
    }
  }
}
</script>

<style scoped lang="scss">
.container{
  width: 80%;
  margin: 50px auto 0;
  border: 1px solid #dddddd;
  border-radius: 5px;
  .container-header{
    background-color: #f5f5f5;
    border-bottom: 1px solid #dddddd;
    text-align: center;
    line-height: 50px;
    .el-input{
      width: 120px;
      margin-right: 10px;
    }
  }
  .timeConvert-item{
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    height: 100px;
    line-height: 100px;
    padding: 0 80px;
    .input{
      width: 200px;
    }
  }
  .el-divider{
    margin: 0 50px;
  }
}
</style>
