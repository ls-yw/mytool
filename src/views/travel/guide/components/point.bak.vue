<template>
  <div>
    <div class="addPoint"><el-button type="primary" size="mini" @click="addPoint">添加</el-button></div>
    <div class="point-menu">
      <div class="title">点位</div>
      <div class="point-box" :class="{'blackWhite':searchTypeArray.indexOf('1') < 0}" @click="changeSearchType('1')">
        <span class="img"><img src="https://mytl-static.oss-cn-hangzhou.aliyuncs.com/qz-tzx/tz-menu-attractions.png"></span>
        <span>景点</span>
      </div>
      <div class="point-box" :class="{'blackWhite':searchTypeArray.indexOf('2') < 0}" @click="changeSearchType('2')">
        <span class="img"><img src="https://mytl-static.oss-cn-hangzhou.aliyuncs.com/qz-tzx/tz-menu-food.png"></span>
        <span>美食</span>
      </div>
      <div class="point-box" :class="{'blackWhite':searchTypeArray.indexOf('3') < 0}" @click="changeSearchType('3')">
        <span class="img"><img src="https://mytl-static.oss-cn-hangzhou.aliyuncs.com/qz-tzx/tz-menu-culture.png"></span>
        <span>文化</span>
      </div>
      <div class="point-box" :class="{'blackWhite':searchTypeArray.indexOf('4') < 0}" @click="changeSearchType('4')">
        <span class="img"><img src="https://mytl-static.oss-cn-hangzhou.aliyuncs.com/qz-tzx/tz-menu-accommodation.png"></span>
        <span>民宿</span>
      </div>
      <div class="point-box" :class="{'blackWhite':searchTypeArray.indexOf('5') < 0}" @click="changeSearchType('5')">
        <span class="img"><img src="https://mytl-static.oss-cn-hangzhou.aliyuncs.com/qz-tzx/tz-menu-prak.png"></span>
        <span>停车</span>
      </div>
      <div class="point-box" :class="{'blackWhite':searchTypeArray.indexOf('6') < 0}" @click="changeSearchType('6')">
        <span class="img"><img src="https://mytl-static.oss-cn-hangzhou.aliyuncs.com/qz-tzx/tz-menu-shopping.png"></span>
        <span>购物</span>
      </div>
      <div class="point-box" :class="{'blackWhite':searchTypeArray.indexOf('7') < 0}" @click="changeSearchType('7')">
        <span class="img"><img src="https://mytl-static.oss-cn-hangzhou.aliyuncs.com/qz-tzx/tz-menu-service.png"></span>
        <span>服务</span>
      </div>
      <div class="point-box" :class="{'blackWhite':searchTypeArray.indexOf('8') < 0}" @click="changeSearchType('8')">
        <span class="img"><img src="https://mytl-static.oss-cn-hangzhou.aliyuncs.com/qz-tzx/tz-menu-toilets.png"></span>
        <span>公厕</span>
      </div>
      <div class="point-box" :class="{'blackWhite':searchTypeArray.indexOf('9') < 0}" @click="changeSearchType('9')">
        <span class="img"><img src="https://mytl-static.oss-cn-hangzhou.aliyuncs.com/qz-tzx/tz-menu-maintenance.png"></span>
        <span>维修</span>
      </div>
      <div class="point-box" :class="{'blackWhite':searchTypeArray.indexOf('10') < 0}" @click="changeSearchType('10')">
        <span class="img"><img src="https://mytl-static.oss-cn-hangzhou.aliyuncs.com/qz-tzx/tz-menu-come.png"></span>
        <span>加油</span>
      </div>
      <div class="search-show-box">
        <el-tooltip :content="'只展示已“' + (localSearchObj.show === true ? '显示' : '隐藏')+'”的点位'" placement="top">
          <el-switch
            v-model="localSearchObj.show"
            active-color="#13ce66"
            inactive-color="#ff4949"
            @change="handleChangePointShow"
          />
        </el-tooltip>
      </div>
    </div>
    <point-edit :edit-point-drawer.sync="editPointDrawer" :point-id.sync="pointId" :before-close-fun="triggerUpdatePoints" />
  </div>
</template>

<script>
import PointEdit from '@/views/travel/components/pointEdit'

export default {
  name: 'Point',
  components: { PointEdit },
  props: {
    // eslint-disable-next-line vue/require-default-prop
    updatePoints: Function,
    updatePointDrawer: Function,
    searchObj: {
      type: Object,
      default() {
        return {
          type: ''
        }
      }
    },
    pointId: {
      type: Number,
      default: 0
    },
    editPoint: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      pointSearchShow: true,
      localPointId: 0,
      searchTypeArray: []
    }
  },
  computed: {
    localSearchObj: {
      get() {
        return this.searchObj
      },
      set(val) {
        this.$emit('update:searchObj', val)
      }
    },
    editPointDrawer: {
      get() {
        return this.editPoint
      },
      set(val) {
        this.$emit('update:editPoint', val)
      }
    }
  },
  created() {
    this.searchTypeArray = this.searchObj.type !== '' ? this.searchObj.type.split(',') : []
  },
  methods: {
    addPoint() {
      this.$emit('update:pointId', 0)
      this.editPointDrawer = true
    },
    triggerUpdatePoints() {
      this.updatePoints()
    },
    handleChangePointShow() {
      this.triggerUpdatePoints()
    },
    changeSearchType(type) {
      if (this.searchTypeArray.indexOf(type) < 0) {
        this.searchTypeArray.push(type)
      } else {
        console.log(this.searchTypeArray, 'del')
        console.log(this.searchTypeArray.indexOf(type), 'del')
        this.searchTypeArray.splice(this.searchTypeArray.indexOf(type), 1)
        console.log(this.searchTypeArray, 'del')
      }
      this.localSearchObj.type = this.searchTypeArray.length === 0 ? '' : this.searchTypeArray.join(',')
      this.handleChangePointShow()
    }
  }
}
</script>

<style scoped lang="scss">
.addPoint{
  position: absolute;
  top: 110px;
  right: 80px;
}
.point-menu{
  position: absolute;
  right: 80px;
  top: 150px;
  background: #ffffff;
  padding: 5px 0;
  width: 56px;
  text-align: center;
  border-radius: 5px;
  .title{
    font-size: 14px;
    font-weight: bold;
    line-height: 26px;
  }
  .point-box{
    display: inline-grid;
    padding: 5px 0;
    cursor: pointer;
    width:100%;
    text-align:center;
    img{
      width: 30px;
    }
    span{
      font-size: 12px;
    }
    span.img{
      height: 30px;
    }
  }
  .point-box:hover{
    background: #edf4ff;
  }
  .search-show-box{
    padding: 5px 0;
  }
}
.blackWhite{
  -webkit-filter: grayscale(100%);
  filter: grayscale(100%);
  color: #999999;
}
</style>
