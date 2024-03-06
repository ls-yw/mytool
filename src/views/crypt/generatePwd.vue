<template>
  <div class="container">
    <div class="container-header">生成随机字符串密码</div>
    <div class="container-body">
      <div class="condition">
        <div class="contain">加密条件：
          <el-checkbox-group v-model="pwdContain">
            <el-checkbox :label="1">包含A-Z</el-checkbox>
            <el-checkbox :label="2">包含a-z</el-checkbox>
            <el-checkbox :label="3">包含0-9</el-checkbox>
            <el-checkbox :label="4">包含!@#$%^&*</el-checkbox>
          </el-checkbox-group>
        </div>
        <div class="length">密码长度：<el-input v-model="pwdLength"></el-input></div>
      </div>
      <el-divider></el-divider>
      <div class="pwd">
        <el-button type="primary" @click="generatePwd">生成密码</el-button>
        <el-input v-model="pwd"></el-input>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "generatePwd",
  data(){
    return {
      pwdContain:[1,2,3,4],
      pwdLength:16,
      pwd:''
    }
  },
  methods:{
    generatePwd(){
      if (this.pwdContain.length === 0) {
        this.$message.error('请选择加密条件')
        return
      }
      this.pwd = this.generateRandomString(this.pwdLength, this.pwdContain)
    },
    generateRandomString(length, conditions) {
      const characterSets = {
        1: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
        2: 'abcdefghijklmnopqrstuvwxyz',
        3: '0123456789',
        4: '!@#$%^&*'
      };
      let allCharacters = '';

      conditions.forEach(option => {
        allCharacters += characterSets[option];
      });
      let result = '';
      for (let i = 0; i < length; i++) {
        const randomIndex = Math.floor(Math.random() * allCharacters.length);
        result += allCharacters[randomIndex];
      }

      return result;
    }
}
}
</script>

<style scoped lang="scss">
.container {
  width: 80%;
  margin: 50px auto 0;
  border: 1px solid #dddddd;
  border-radius: 5px;

  .container-header {
    background-color: #f5f5f5;
    border-bottom: 1px solid #dddddd;
    text-align: center;
    line-height: 50px;

    .el-input {
      width: 120px;
      margin-right: 10px;
    }
  }
  .container-body{
    padding: 0 50px;
    .condition{
      display: flex;
      padding: 20px 0;
      justify-content: flex-start;
      align-items: center;
      .length{
        display: flex;
        align-items: center;
        .el-input{
          width: 100px;
        }
      }
      .contain{
        display: flex;
        margin-right: 20px;
      }
    }
    .pwd{
      display: flex;
      padding: 20px 0;
      .el-button{
        margin-right: 20px;
      }
    }
  }
}
</style>
