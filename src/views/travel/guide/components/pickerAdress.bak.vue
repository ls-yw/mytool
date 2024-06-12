<template>
  <el-dialog
    :visible.sync="dialogVisible"
    width="600px"
    top="8vh"
    :before-close="handleClose"
    :destroy-on-close="true"
  >
    <iframe id="getAddress" :src="mapUrl" width="100%" height="700px" />
  </el-dialog>
</template>

<script>
export default {
  name: 'PickerAddress',
  props: {
    dialogVisible: {
      type: Boolean,
      default: false
    },
    addressObj: {
      type: Object,
      default() {
        return {}
      }
    }
  },
  data() {
    return {
      mapUrl: '',
      selectObj: {},
      coord: ''
    }
  },
  created() {
    this.coord = this.addressObj.latitude === '' ? '29.17805,118.842077' : this.addressObj.latitude + ',' + this.addressObj.longitude

    // this.mapUrl = 'https://m.amap.com/picker/?center=118.842077, 29.17805&key=' + process.env.VUE_APP_MAP_KEY
    this.mapUrl = 'https://apis.map.qq.com/tools/locpicker?search=1&type=1&key=' + process.env.VUE_APP_MAP_QQ_KEY + '&referer=mayitanlu.cn&coord=' + this.coord

    const _this = this
    window.addEventListener(
      'message',
      function(event) {
        // 接收位置信息，用户选择确认位置点后选点组件会触发该事件，回传用户的位置信息
        const loc = event.data
        if (loc && loc.module === 'locationPicker') {
          // 防止其他应用也会向该页面post信息，需判断module是否为'locationPicker'
          _this.selectObj.latitude = loc.latlng.lat
          _this.selectObj.longitude = loc.latlng.lng
          _this.selectObj.address = loc.poiname
          _this.$emit('update:dialogVisible', false)
          _this.$emit('update:addressObj', _this.selectObj)
        }
      },
      false
    )
  },
  methods: {
    handleClose() {
      this.$emit('update:dialogVisible', false)
    }
  }
}
</script>

<style scoped>

</style>
