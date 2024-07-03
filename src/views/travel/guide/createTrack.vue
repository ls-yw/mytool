<template>
  <div v-loading="loading" class="container">
    <div id="container" :style="'height:'+fullHeight+'px'" />
    <div class="info-box">
      <div class="title"><el-input v-model="info.title" placeholder="请输入轨迹标题" /></div>
      <div class="travelType">
        <el-radio-group v-model="info.travelType" @input="changeTravelType">
          <el-radio :label="1">驾车</el-radio>
          <el-radio :label="2">骑行</el-radio>
          <el-radio :label="3">步行</el-radio>
        </el-radio-group>
      </div>
      <div class="mileage"><el-input v-model="info.mileage"><template slot="prepend">里程(米)</template></el-input></div>
      <div class="date">
        <el-date-picker
          v-model="info.durationInterval"
          type="datetimerange"
          range-separator="至"
          value-format="yyyy-MM-dd HH:mm:ss"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        />
      </div>
      <div class="btn"><el-button type="success" size="small" @click="saveLine">保存</el-button></div>
    </div>
    <el-dialog :visible.sync="showCreateMarkerDialog" title="选择要打的点位" append-to-body>
      <div class="marker-type-box">
        <p v-for="item in liShui1929Points" :key="item.code" @click="setMarkerLatLon(item.code)">{{ item.name }}</p>
        <p class="custom-marker" @click="setMarkerLatLon(null)">自定义打卡点</p>
      </div>
    </el-dialog>
    <el-dialog :visible.sync="showEditPointDialog" :title="'修改点位：'+currentMarker.name" append-to-body @close="initCurrentMarker">
      <div class="edit-point-box">
        <el-form ref="ruleForm" :model="currentMarker" label-width="100px" class="demo-ruleForm">
          <el-form-item label="名称" prop="name" required>
            <el-input v-model="currentMarker.name" />
          </el-form-item>
          <el-form-item label="照片">
            <div
              v-for="(item,index) in currentMarker.images"
              :key="index"
              class="imgs-container"
            >
              <el-image
                :preview-src-list="currentMarker.images"
                style="width: 80px; height: 80px;"
                :src="item"
                fit="cover"
              />
              <div class="del-icon flex-center" @click="currentMarker.images.splice(index, 1)">
                <i class="el-icon-close" />
              </div>
            </div>
            <uploader
              @start="loading = true"
              @finish="loading = false"
              @success="uploadMarker"
            />
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="saveMarker">保存</el-button>
            <el-button type="danger" @click="delMarker">删除</el-button>
          </el-form-item>
        </el-form>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import AMap from '@amap/amap-jsapi-loader'
import { parseTime } from '@/utils'
import { saveTrackContentApi } from '@/api/v2/track/track'
import { getLiShuiShanLu1929PointsApi } from '@/api/v2/activity/liShuiShanLu1929'
export default {
  name: 'CreateTrack',
  props: {
    uid: {
      type: Number,
      default: 0
    },
    finish: {
      type: Function,
      default: () => {
        return Function
      }
    }
  },
  data() {
    return {
      loading: false,
      fullHeight: '800',
      tmp: null,
      map: null,
      aMap: null,
      mapDriving: null,
      mapContextMenu: null,
      mapContextMenuPosition: null,
      dialogClickEditLineMenu: false,
      dialogEditLine: false,
      showCreateMarkerDialog: false,
      showEditPointDialog: false,
      liShui1929Points: [],
      currentMarker: {
        name: '',
        thumbImg: '',
        imgs: '',
        images: []
      },
      lineObj: {
        markers: [],
        polyline: [],
        code: []
      },
      info: {
        title: '',
        travelType: 1,
        mileage: 0,
        durationInterval: ['', '']
      },
      dbClickLineObj: {},
      markers: {}
    }
  },
  created() {
    this.fullHeight = window.innerHeight - 120
    this.initMap()
    this.getLiShui1929Points()
  },
  methods: {
    initMap() {
      AMap.load({
        key: process.env.VUE_APP_MAP_KEY, // 申请好的Web端开发者Key，首次调用 load 时必填
        version: '2.0', // 指定要加载的 JSAPI 的版本，缺省时默认为 1.4.15
        plugins: ['AMap.PolylineEditor', 'AMap.MouseTool', 'AMap.Driving', 'AMap.Walking', 'AMap.Riding'] // 需要使用的的插件列表，如比例尺'AMap.Scale'等
      }).then((AMap) => {
        this.aMap = AMap
        this.map = new this.aMap.Map('container', { // 设置地图容器id
          // viewMode: '3D', // 是否为3D地图模式
          resizeEnable: true,
          zoom: 14, // 初始化地图级别
          center: [119.923285, 28.467707] // 初始化地图中心点位置
        })

        // 右键菜单
        this.rightClickMenu()

        // this.autoCreateLine()

        /*        this.getPoints()

        this.getLinesList()*/
      }).catch(e => {
        console.log(e)
      })
    },
    rightClickMenu() {
      const _this = this

      // 地图中添加鼠标工具MouseTool插件
      this.mouseTool = new this.aMap.MouseTool(this.map)

      this.contextMenuPositon = null

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
    createLineStart() {
      this.createMarker('begin')
      this.editLineStartOrEnd('begin')
      this.mapContextMenu.close()
    },
    createLineEnd() {
      this.createMarker('end')
      this.editLineStartOrEnd('end')
      this.mapContextMenu.close()
    },
    createMarkerDialog() {
      this.showCreateMarkerDialog = true
      this.mapContextMenu.close()
    },
    createMarker(m) {
      if (this.markers[m]) {
        this.map.remove(this.markers[m])
      }
      const marker = new this.aMap.Marker({
        position: [this.mapContextMenuPosition.lng, this.mapContextMenuPosition.lat],
        anchor: 'bottom-center',
        offset: new this.aMap.Pixel(0, 0)
      })
      marker.setMap(this.map)
      // 设置鼠标划过点标记显示的文字提示
      // 设置label标签
      // label默认蓝框白底左上角显示，样式className为：amap-marker-label
      marker.setLabel({
        direction: 'top',
        offset: new this.aMap.Pixel(0, -5), // 设置文本标注偏移量
        content: "<div class='info'>" + (m === 'begin' ? '起点' : '终点') + '</div>' // 设置文本标注内容
      })
      this.markers[m] = marker
    },
    editLineStartOrEnd(objectType) {
      const existingStartMarker = this.lineObj.markers.find(marker => marker.objectType === objectType)
      if (existingStartMarker) {
        existingStartMarker.latitude = this.mapContextMenuPosition.lat
        existingStartMarker.longitude = this.mapContextMenuPosition.lng
      } else {
        this.lineObj.markers.push({
          id: objectType,
          name: objectType === 'begin' ? '起点' : '终点',
          objectType: objectType,
          latitude: this.mapContextMenuPosition.lat,
          longitude: this.mapContextMenuPosition.lng
        })
      }
      this.generateLine()
    },
    generateLine() {
      const existingStartMarker = this.lineObj.markers.find(marker => marker.objectType === 'begin')
      const existingEndMarker = this.lineObj.markers.find(marker => marker.objectType === 'end')
      if (!existingStartMarker || !existingEndMarker) {
        return
      }
      if (!this.mapDriving) {
        // 构造路线导航类
        this.mapDriving = new this.aMap.Driving({
          map: this.map,
          showTraffic: false
        })
      }
      if (this.markers['begin']) {
        this.map.remove(this.markers['begin'])
      }
      if (this.markers['end']) {
        this.map.remove(this.markers['end'])
      }
      this.mapDriving.clear()
      const _this = this
      // 根据起终点经纬度规划驾车导航路线
      this.mapDriving.search(new this.aMap.LngLat(existingStartMarker.longitude, existingStartMarker.latitude), new this.aMap.LngLat(existingEndMarker.longitude, existingEndMarker.latitude), function(status, result) {
        // result 即是对应的驾车导航信息，相关数据结构文档请参考  https://lbs.amap.com/api/javascript-api/reference/route-search#m_DrivingResult
        if (status === 'complete') {
          console.log('绘制驾车路线完成', result)
          const polyline = []
          let steps
          if (_this.info.travelType === 2) {
            steps = result.routes[0].rides
          } else {
            steps = result.routes[0].steps
          }
          steps.forEach(ele => {
            ele.path.forEach(e => {
              polyline.push({ latitude: e.lat, longitude: e.lng })
            })
          })
          _this.lineObj.polyline = polyline
          _this.info.mileage = result.routes[0].distance

          const durationInterval = [parseTime((new Date()) - result.routes[0].time * 1000), parseTime(new Date())]
          // _this.info.durationInterval[0] = parseTime((new Date()) - result.routes[0].time * 1000)
          // _this.info.durationInterval[1] = parseTime(new Date())
          _this.$set(_this.info, 'durationInterval', durationInterval)
        } else {
          console.log('获取驾车数据失败：', result)
        }
      })
    },
    changeTravelType(e) {
      if (this.mapDriving) {
        this.mapDriving.clear()
      }
      if (e === 1) {
        // 构造路线导航类
        this.mapDriving = new this.aMap.Driving({
          map: this.map,
          showTraffic: false
        })
      } else if (e === 2) {
        // 构造路线导航类
        this.mapDriving = new this.aMap.Riding({
          map: this.map,
          showTraffic: false
        })
      } else if (e === 3) {
        // 构造路线导航类
        this.mapDriving = new this.aMap.Walking({
          map: this.map,
          showTraffic: false
        })
      } else {
        this.$message.error('不存在的类型')
        return
      }
      this.generateLine()
    },
    saveLine() {
      if (this.lineObj.polyline.length < 2) {
        this.$message.error('请先在地图上右击设置线路终点和起点')
        return
      }
      if (this.info.title === '') {
        this.$message.error('请设置线路标题')
        return
      }
      if (this.lineObj.markers.length > 0) {
        this.lineObj.code = [...new Set(this.lineObj.markers.filter(item => item.code).map(item => item.code))]
      }
      this.loading = true
      saveTrackContentApi({ uid: this.uid, ...this.info, ...this.lineObj, startTime: this.info.durationInterval[0], endTime: this.info.durationInterval[1] }).then(response => {
        this.finish()
      }).finally(() => {
        this.loading = false
      })
    },
    getLiShui1929Points() {
      const points = localStorage.getItem('liShui1929Points')
      if (points) {
        this.liShui1929Points = JSON.parse(points)
      }
      getLiShuiShanLu1929PointsApi().then(response => {
        this.liShui1929Points = response.data
        localStorage.setItem('liShui1929Points', JSON.stringify(response.data))
      })
    },
    setMarkerLatLon(code) {
      this.currentMarker.id = 'n' + (Math.floor(Math.random() * (9999 - 1000 + 1)) + 1000)
      this.currentMarker.name = '打卡点'
      this.currentMarker.objectType = 'checkIn'
      if (code === null) {
        this.currentMarker.latitude = this.mapContextMenuPosition.lat
        this.currentMarker.longitude = this.mapContextMenuPosition.lng
      } else {
        this.currentMarker.id = code
        const point = this.liShui1929Points.find(ele => ele.code === code)
        if (!point) {
          this.$message.error('系统找不到该点')
          return
        }
        if (!point.latitude || !point.longitude) {
          this.$message.error('该点位不存在经纬度')
          return
        }
        this.currentMarker.name = point.name
        this.currentMarker.latitude = point.latitude
        this.currentMarker.longitude = point.longitude
        this.currentMarker.code = code
      }

      const marker = new this.aMap.Marker({
        map: this.map,
        position: [this.currentMarker.longitude, this.currentMarker.latitude],
        extData: this.currentMarker
      })
      marker.setLabel({
        direction: 'top',
        offset: new this.aMap.Pixel(0, -5), // 设置文本标注偏移量
        content: "<div class='info'>" + this.currentMarker.name + "</div><div class='jt'></div>" // 设置文本标注内容
      })
      marker.on('dblclick', this.editPoint)
      this.markers[this.currentMarker.id] = marker

      const currentMarker = JSON.parse(JSON.stringify(this.currentMarker))

      this.saveLineMarkerByCurrentMarker()

      this.showCreateMarkerDialog = false
      this.initCurrentMarker()
      this.map.setFitView()
      this.editPoint(currentMarker)
    },
    editPoint(e) {
      this.currentMarker = e.target ? e.target.getExtData() : e
      this.currentMarker.images = this.currentMarker.imgs ? this.currentMarker.imgs.split(',') : []
      this.showEditPointDialog = true
    },
    saveLineMarkerByCurrentMarker() {
      this.currentMarker.imgs = this.currentMarker.images.length > 0 ? this.currentMarker.images.join(',') : ''
      this.currentMarker.thumbImg = this.currentMarker.images[0] ?? ''
      const currentMarker = JSON.parse(JSON.stringify(this.currentMarker))
      this.lineObj.markers.push(currentMarker)
    },
    saveMarker() {
      this.lineObj.markers = this.lineObj.markers.filter(item => item.id !== this.currentMarker.id)
      this.saveLineMarkerByCurrentMarker()
      this.showEditPointDialog = false
      this.markers[this.currentMarker.id].setExtData(this.currentMarker)
      this.markers[this.currentMarker.id].setLabel({
        direction: 'top',
        offset: new this.aMap.Pixel(0, -5), // 设置文本标注偏移量
        content: "<div class='info'>" + this.currentMarker.name + "</div><div class='jt'></div>" // 设置文本标注内容
      })
      this.initCurrentMarker()
    },
    delMarker() {
      this.showEditPointDialog = false
      this.lineObj.markers = this.lineObj.markers.filter(item => item.id !== this.currentMarker.id)
      if (this.markers[this.currentMarker.id]) {
        this.map.remove(this.markers[this.currentMarker.id])
      }
      this.initCurrentMarker()
    },
    initCurrentMarker() {
      this.currentMarker = {
        name: '',
        thumbImg: '',
        imgs: '',
        images: []
      }
    },
    uploadMarker(e) {
      if (this.currentMarker.images.length >= 6) {
        this.$message.error('照片最多6张')
        return
      }
      this.currentMarker.images.push(e)
    }
  }
}
</script>

<style scoped lang="scss">
.container{
  position: relative;
  #container {
    padding: 0;
    margin: 0;
    width: 100%;
    height: 100%;
  }
  .info-box{
    position: absolute;
    top: 10px;
    left: 10px;
    background: #FFFFFF;
    border-radius: 10px;
    padding: 20px;
    .travelType{
      height: 40px;
      line-height: 40px;
    }
    .mileage{
      margin-bottom: 10px;
    }
    .btn{
      margin-top: 10px;
      text-align: center;
    }
  }
  .dialogClickEditLineMenu.el-dialog {
    .el-dialog__header {
      display: none;
    }
    .dj-dialog-content {
      padding: 0;
      overflow: unset;
    }
  }

  .dialogClickEditLineMenu {
    .menu-list{
      text-align: center;
      display: flex;
      flex-direction: column;
      justify-content:center;
      button{
        margin-bottom: 10px;
        width: 150px;
        flex: 1;
      }
      .el-button+.el-button{
        margin-left: 0;
      }
    }
  }
  .editLineReminderBox{
    position: absolute;
    top: 50px;
    left: calc(50% - 450px/2);
    width: 450px;
    p{
      display: inline-block;
      margin: 0 10px 0 0;
      color: orange;
    }
    .tips{
      line-height: 20px;
      font-size: 12px;
      text-align: center;
      color: #666666;
      margin-bottom: -10px;
      margin-top: 5px;
    }
  }

  .right-click-menu {
    background: #FFFFFF;
    border-radius: 0.25rem;
    box-shadow: 0 2px 6px 0 rgb(114 124 245 / 50%);
    position: relative;
    top: 1rem;
    right: 1rem;
  }

  .right-click-menu p {
    line-height: 30px;
    width: 100px;
    text-align: center;
    margin: 0;
    cursor: pointer;
    padding: 5px 0;
  }

  .right-click-menu p:hover {
    background: #bbbbbb;
  }
}
.marker-type-box{
  overflow: hidden;
  p{
    width: 150px;
    float: left;
    cursor: pointer;
    padding: 5px;
  }
  p:hover{
    background: rgba(238, 238, 238, 0.8);
  }
  .custom-marker{
    color: orange;
  }
}
.edit-point-box{
  .imgs-container {
    display: inline-block;
    width: 80px;
    height: 80px;
    position: relative;
    margin-right: 15px;
    // border: 1px solid red;
    .del-icon {
      width: 18px;
      height: 18px;
      cursor: pointer;
      // border: 1px solid red;
      position: absolute;
      top: -10px;
      right: -10px;
      background: rgba(0, 0, 0, 0.3);
      font-size: 16px;
      color: white;
      border-radius: 50%;
      i {
        position: absolute;
        top: 1px;
        right: 0.5px;
      }
    }
  }
}
</style>
<style>

.right-click-menu {
  background: #FFFFFF;
  border-radius: 0.25rem;
  box-shadow: 0 2px 6px 0 rgb(114 124 245 / 50%);
  position: relative;
  top: 1rem;
  right: 1rem;
}

.right-click-menu p {
  line-height: 30px;
  width: 100px;
  text-align: center;
  margin: 0;
  cursor: pointer;
  padding: 5px 0;
}

.right-click-menu p:hover {
  background: #bbbbbb;
}
</style>
