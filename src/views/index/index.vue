<template>
  <div class="container">
    <div class="menu-box">
      <div class="menu-list">
        <div class="menu-name">编码转换:</div>
        <div class="menu-item">
          <router-link to="/code/timeConvert" class="item">时间戳转换</router-link>
        </div>
      </div>
      <el-divider />
      <div class="menu-list">
        <div class="menu-name">加密解密:</div>
        <div class="menu-item">
          <router-link to="/crypt/generatePwd" class="item">生成密码</router-link>
        </div>
      </div>
      <el-divider />
      <div class="menu-list">
        <div class="menu-name">文字处理:</div>
        <div class="menu-item">
          <router-link to="/word/length" class="item">统计长度</router-link>
          <router-link to="/word/special" class="item">特殊字符</router-link>
        </div>
      </div>
      <el-divider />
      <div class="menu-list">
        <div class="menu-name">交通查询:</div>
        <div class="menu-item">
          <router-link to="/traffic/plane" class="item">机票查询</router-link>
        </div>
      </div>
      <el-divider />
      <div class="menu-list">
        <div class="menu-name">旅行指南:</div>
        <div class="menu-item">
          <router-link to="/travel/guideMap?id=1" class="item">攻略地图</router-link>
        </div>
      </div>
      <el-divider />
      <div class="menu-list">
        <div class="menu-name">不知归处:</div>
        <div class="menu-item">
          <router-link to="/other/music" class="item">音乐下载</router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Index',
  methods: {
  }
}
</script>

<style scoped lang="scss">
.container{
    .menu-box{
      width: 90%;
      margin: 100px auto 0;
      .menu-list{
        display: flex;
        flex-direction: row;
        .menu-name{
          width: 100px;
          color: #333333;
          font-weight: bold;
        }
        .menu-item{
          .item{
            color: #337ab7;
            cursor: pointer;
            margin-right: 10px;
          }
        }
      }
    }
}
</style>
