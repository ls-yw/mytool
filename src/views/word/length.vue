<template>
  <div class="container">
    <div class="info"><strong>{{stringLength}}</strong>个字符串，<strong>{{chineseLength}}</strong>个中文字</div>
    <div class="content">
      <el-input type="textarea" rows="10" v-model="content" @input="computeLength" placeholder="输入字符串统计长度"></el-input>
    </div>
  </div>
</template>

<script>
export default {
  name: "length",
  data(){
    return {
      content:'',
      stringLength:0,
      chineseLength:0
    }
  },
  methods:{
    computeLength(){
      this.stringLength = this.content.length
      const chineseChars = this.content.match(/[\u4e00-\u9fff]/g);
      this.chineseLength = chineseChars ? chineseChars.length : 0;
    }
  }
}
</script>

<style scoped lang="scss">
.container{
  width: 80%;
  margin: 100px auto 0;
  .info{
    border-radius: 10px;
    background-color: #eeeeee;
    height: 50px;
    line-height: 50px;
    text-align: center;
    color: #409EFF;
    strong{
      margin-right: 5px;
    }
  }
  .content{
    margin-top: 50px;
  }
}
</style>
