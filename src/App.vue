<template>
  <div id="app">
    <div v-if="breadcrumb !== ''" class="breadcrumb">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>{{ breadcrumb }}</el-breadcrumb-item>
      </el-breadcrumb>
    </div>
    <router-view />
  </div>
</template>

<script>
export default {
  name: 'App',
  computed: {
    breadcrumb() {
      const route = this.$route
      const { meta } = route
      return meta.title || ''
    }
  },
  mounted() {
  }
}
</script>
<style scoped lang="scss">
#app{
  .breadcrumb{
    width: 80%;
    margin: 0 auto;
    padding: 20px 0;
  }
}
</style>
