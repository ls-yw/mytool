<template>
  <div v-loading="loading" class="container map">
    <div id="mapContainer" class="map-container" />
    <div class="day-box">
      <div class="header-title">游玩日</div>
      <div class="cursor-pointer day" :class="{active: currentDay === 0}" @click="changeDay(0)">
        <div class="day-title">全部</div>
        <div class="day-icon" />
      </div>
      <div v-for="(day, index) in days" :key="index" class="cursor-pointer day" :class="{active: currentDay === index+1}" @click="changeDay(index+1)">
        <div class="day-title">第{{ day }}天</div>
        <div class="day-icon"><i v-if="index === days.length - 1" class="el-icon-remove-outline red" @click.stop="delDay(index)" /></div>
      </div>
      <div class="add-day cursor-pointer" @click="addDay"><i class="el-icon-circle-plus-outline" /> 新增天</div>
    </div>
    <el-dialog
      :visible.sync="dialogClickEditLineMenu"
      custom-class="dialogClickEditLineMenu"
      width="200px"
      :show-close="false"
      center
    >
      <div class="menu-list">
        <el-button type="primary" @click="editLineTrackMenu">修改线路轨迹</el-button>
        <el-button type="primary" @click="delLineMenu">删除线路</el-button>
      </div>
    </el-dialog>
    <el-card v-if="editLineTrackHandler" class="editLineReminderBox">
      <div class="text item">
        <p>您正在编辑线路，编辑好后请选择操作</p>
        <el-button type="primary" size="mini" @click="saveEditLineTrack">保存</el-button>
        <el-button type="danger" size="mini" @click="cancelEditLineTrack">取消</el-button>
      </div>
      <div class="tips">拖动蓝点可新增线路节点，点击白点可删除线路节点</div>
    </el-card>
    <el-dialog
      :visible.sync="dialogEditMarker"
      custom-class="dialogClickEditLineMenu"
      width="800px"
      :show-close="false"
      center
      :title="(currentMarker.uniqueId === '' ? '新增' : '编辑')+'标记点'"
    >
      <div class="marker-box">
        <el-form ref="form" :model="currentMarker" label-width="80px" :rules="editMarkerRules">
          <el-form-item label="名称" required prop="name">
            <el-input v-model="currentMarker.name" placeholder="请输入点位名称" maxlength="90" />
          </el-form-item>
          <el-form-item label="类型" required prop="markerType">
            <el-select v-model="currentMarker.markerType" placeholder="请选择类型">
              <el-option v-for="item in markerTypeIcons" :key="item.markerType" :label="item.name" :value="item.markerType" />
            </el-select>
          </el-form-item>
          <el-form-item label="介绍" prop="intro">
            <el-input v-model="currentMarker.intro" type="textarea" maxlength="250" placeholder="请输入点位介绍" />
          </el-form-item>
          <el-form-item class="text-center">
            <el-button type="primary" @click="saveEditMarker">保存</el-button>
            <el-button @click="dialogEditMarker = false">取消</el-button>
            <el-button v-if="currentMarker.uniqueId!== ''" type="danger" @click="deleteMarker">删除</el-button>
          </el-form-item>
        </el-form>
      </div>
    </el-dialog>
    <div class="handle-box">
      <el-button type="success" @click="onsubmit">保存</el-button>
      <el-button @click="goBack">返回</el-button>
    </div>
  </div>
</template>

<script>
import AMap from '@amap/amap-jsapi-loader'
import { randomWord } from '@/utils'
import { getGuideInfo, saveGuide } from '@/api/guide'

export default {
  name: 'Map',
  data() {
    return {
      loading: false,
      map: null,
      aMap: null,
      mapContextMenu: null,
      mapContextMenuPosition: null, // 右键菜单位置
      days: [],
      currentDay: 0,
      currentLineIndex: 0,
      tmpMarkers: {},
      travelMode: 'driving',
      info: {
        id: 0,
        title: '',
        thumbnail: '',
        markers: [],
        lines: [],
        days: []
      },
      editLineStyleOptions: {
        strokeColor: '#33ffaa',
        isOutline: true,
        // outlineColor: '#33ffaa',
        borderWeight: 3,
        lineJoin: true,
        lineCap: 'square',
        showDir: true,
        bubble: true
      },
      showLineStyleOptions: {
        strokeStyle: 'dashed',
        strokeWeight: 6,
        strokeColor: '#3366FF',
        strokeOpacity: 1,
        isOutline: true,
        outlineColor: '#ffeeff',
        borderWeight: 3,
        lineJoin: 'round',
        lineCap: 'round',
        showDir: true,
        cursor: 'pointer'
      },
      lines: {},
      allLines: [],
      linesMap: {}, // 线路地图对象
      editLineTrackMapObj: null, // 编辑线路轨迹地图对象
      editLineTrackHandler: false, // 编辑线路轨迹状态
      dialogClickEditLineMenu: false, // 点击编辑线路菜单状态
      dbClickLineMapObj: null, // 双击线路地图对象
      beforeEditLineTrackPaths: [], // 编辑线路轨迹前的线路路径
      dbClickLineObj: {}, // 双击线路对象
      dialogEditMarker: false, // 编辑标记点弹窗状态
      markers: {},
      allMarkers: [], // 所有标记点
      currentMarker: {}, // 当前选中标记点
      editMarkerRules: {
        name: [{ required: true, message: '请输入点位名称', trigger: ['blur', 'change'] }]
      },
      markersMap: {}, // 标记点地图对象
      markerTypeIcons: [
        { markerType: 'hotel', icon: '/static/images/tz-menu-accommodation.png', name: '住宿' },
        { markerType: 'clockIn', icon: '/static/images/clockIn.png', name: '打卡' },
        { markerType: 'scenery', icon: '/static/images/tz-menu-attractions.png', name: '景点' },
        { markerType: 'food', icon: '/static/images/tz-menu-food.png', name: '美食' },
        { markerType: 'shop', icon: '/static/images/tz-menu-shopping.png', name: '购物' }
      ],
      markerIconList: []
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

        this.getGuideInfo()
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
      // this.currentDay = this.days.length
      this.tmpMarkers[this.days.length] = {}
    },
    delDay(index) {
      this.$confirm('确定删除第“' + (index + 1) + '”天的游玩数据吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        const day = this.days[index]
        this.days.splice(index, 1)
        this.tmpMarkers.splice(index, 1)
        if ((index + 1) === this.currentDay) {
          this.changeDay(0)
        }
        delete this.lines[day]
        this.updateAllLines()
      })
    },
    changeDay(index) {
      this.currentDay = index
      // 重新绘制线路
      this.clearAllLines()
      const tmpLines = this.currentDay === 0 ? this.allLines : this.lines[this.currentDay]
      if (tmpLines && tmpLines.length > 0) {
        tmpLines.forEach((line) => {
          this.canvasLine(line)
        })
      }
      // 重新绘制标记点
      this.clearAllMarkers()
      const tmpMarkers = this.currentDay === 0 ? this.allMarkers : this.markers[this.currentDay]
      if (tmpMarkers && tmpMarkers.length > 0) {
        tmpMarkers.forEach((marker) => {
          this.canvasMarker(marker)
        })
      }
    },
    clearTmpMarkers(day) {
      for (const i in this.tmpMarkers[day]) {
        this.map.remove(this.tmpMarkers[day][i])
      }
      this.tmpMarkers[day] = {}
    },

    // 创建自定义标记点弹窗
    createMarkerDialog() {
      if (this.currentDay === 0) {
        this.$message.error('请添加或者选择游玩日')
        return
      }
      this.currentMarker = this.initMarkerData()
      this.dialogEditMarker = true
      this.mapContextMenu.close()
    },
    getGuideInfo() {
      getGuideInfo({ id: this.$route.query.id }).then(response => {
        this.info = response.data
        this.days = this.info.days.sort((a, b) => a - b)
        this.initOnlineLines()
        this.initOnlineMarkers()
        if (this.days.length > 0) {
          this.days.map(ele => {
            this.tmpMarkers[ele] = {}
          })
        }
        this.currentDay = 0
      })
    },
    /** ************* 点位方法开始 *******************/
    initMarkerData() {
      return {
        id: 0,
        name: '',
        markerType: 'clockIn',
        intro: '',
        uniqueId: '',
        longitude: 0,
        latitude: 0
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
    saveEditMarker() {
      this.$refs.form.validate((valid) => {
        if (valid) {
          if (this.currentMarker.uniqueId === '') {
            if (!this.markers[this.currentDay]) {
              this.markers[this.currentDay] = []
            }
            this.currentMarker.uniqueId = randomWord(10)
            this.currentMarker.day = this.currentDay
            this.currentMarker.longitude = this.mapContextMenuPosition.lng
            this.currentMarker.latitude = this.mapContextMenuPosition.lat
            this.markers[this.currentDay].push(this.currentMarker)
          } else {
            this.markers[this.currentDay] = this.markers[this.currentDay].map(ele => {
              if (ele.uniqueId === this.currentMarker.uniqueId) {
                return this.currentMarker
              }
              return ele
            })
            this.map.remove(this.markersMap[this.currentMarker.uniqueId])
          }
          this.canvasMarker(this.currentMarker)
          this.$message.success('保存成功')
          this.dialogEditMarker = false
          this.updateAllMarkers()
        }
      })
    },
    canvasMarker(row) {
      const marker = new this.aMap.Marker({
        map: this.map,
        icon: this.markerTypeIcons.find(ele => ele.markerType === row.markerType).icon,
        position: [row.longitude, row.latitude],
        extData: row,
        anchor: 'center'
      })
      this.markersMap[row.uniqueId] = marker

      marker.setLabel({
        direction: 'top',

        content: "<div class='info'>" + row.name + "</div><div class='jt'></div>" // 设置文本标注内容
      })
      marker.on('dblclick', this.editMarker)
    },
    editMarker(e) {
      this.currentMarker = e.target.getExtData()
      this.dialogEditMarker = true
    },
    deleteMarker() {
      this.$confirm('确定删除该标记点?', '提示', { type: 'warning' }).then(() => {
        this.map.remove(this.markersMap[this.currentMarker.uniqueId])
        this.markers[this.currentDay] = this.markers[this.currentDay].filter(ele => ele.uniqueId !== this.currentMarker.uniqueId)
        this.updateAllMarkers()
        this.dialogEditMarker = false
        this.$message.success('删除成功')
      })
    },
    clearAllMarkers() {
      for (const key in this.markersMap) {
        this.map.remove(this.markersMap[key])
      }
    },
    initOnlineMarkers() {
      this.info.markers.forEach(marker => {
        if (!this.markers[marker.day]) {
          this.markers[marker.day] = []
        }
        this.markers[marker.day].push(marker)
      })
      this.updateAllMarkers()
    },
    updateAllMarkers() {
      this.allMarkers = []
      for (const day in this.markers) {
        this.allMarkers = this.allMarkers.concat(this.markers[day])
      }
      this.updateMarkerIconList()
      this.$forceUpdate()
    },
    updateMarkerIconList() {
      // todo 侧面图标列表
    },
    /** ************* 点位方法结束 *******************/
    /** ************* 线路方法开始 *******************/
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
    generateLine() { // 生成线路
      const startMarker = this.tmpMarkers[this.currentDay]['begin']
      const endMarker = this.tmpMarkers[this.currentDay]['end']
      if (!startMarker || !endMarker) {
        return
      }

      const _this = this
      let mapDriving = null
      switch (this.travelMode) {
        case 'walking':
          mapDriving = new this.aMap.Walking({
            // map: this.map
          })
          break
        default:
          mapDriving = new this.aMap.Driving({
            // map: this.map,
            showTraffic: false
          })
          break
      }

      mapDriving.search(new this.aMap.LngLat(startMarker._position[0], startMarker._position[1]), new this.aMap.LngLat(endMarker._position[0], endMarker._position[1]), function(status, result) {
        // result 即是对应的驾车导航信息，相关数据结构文档请参考  https://lbs.amap.com/api/javascript-api/reference/route-search#m_DrivingResult
        if (status === 'complete') {
          const polyline = []
          const steps = result.routes[0].steps
          steps.forEach(ele => {
            ele.path.forEach(e => {
              polyline.push([e.lng, e.lat])
            })
          })
          const line = _this.initLineData()
          line.day = _this.currentDay
          line.content = polyline
          if (!_this.lines[_this.currentDay]) {
            _this.lines[_this.currentDay] = []
          }
          _this.canvasLine(line)
          _this.lines[_this.currentDay].push(line)
          _this.updateAllLines()
        } else {
          console.log('获取驾车数据失败：', result)
        }
      })

      this.clearTmpMarkers(this.currentDay)
    },
    // 画线
    canvasLine(line) {
      const lineStyle = this.showLineStyleOptions
      lineStyle.path = line.content
      lineStyle.strokeStyle = 'solid'
      lineStyle.extData = line
      const lineMap = new this.aMap.Polyline(lineStyle)
      lineMap.on('dblclick', this.editLineClick)
      this.linesMap[line.uniqueId] = lineMap
      this.map.add(this.linesMap[line.uniqueId])
    },
    initLineData() {
      return {
        day: 0,
        uniqueId: randomWord(10),
        content: []
      }
    },
    updateAllLines() { // 更新所有线路
      this.allLines = []
      for (const day in this.lines) {
        this.allLines = this.allLines.concat(this.lines[day])
      }
      this.$forceUpdate()
    },
    editLineClick(e) { // 点击编辑线路
      this.dialogClickEditLineMenu = true
      this.dbClickLineObj = e.target.getExtData()
      this.dbClickLineMapObj = e.target
      this.beforeEditLineTrackPaths = e.target.getPath()
    },
    editLineTrackMenu() {
      this.editLineMap(this.dbClickLineMapObj)
      this.dialogClickEditLineMenu = false
    },
    editLineMap(lineOpt) {
      this.editLineTrackHandler = true
      this.editLineTrackMapObj = new this.aMap.PolylineEditor(this.map, lineOpt, { editOptions: this.editLineStyleOptions })
      this.editLineTrackMapObj.open()
    },
    saveEditLineTrack() {
      const tmpPathArr = []
      this.editLineTrackMapObj.getTarget().getPath().forEach(ele => {
        tmpPathArr.push([ele.lng, ele.lat])
      })

      this.dbClickLineObj.content = tmpPathArr
      this.lines[this.currentDay] = this.lines[this.currentDay].map(ele => {
        if (ele.uniqueId === this.dbClickLineObj.uniqueId) {
          return this.dbClickLineObj
        }
        return ele
      })
      this.$message.success('保存成功')
      this.clearLineTrackEditStatus()
    },
    cancelEditLineTrack() {
      this.$confirm('确认取消对线路的修改?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        const tmpPathArr = []
        this.beforeEditLineTrackPaths.forEach(ele => {
          tmpPathArr.push([ele.lng, ele.lat])
        })
        this.editLineTrackMapObj.getTarget().setPath(tmpPathArr)
        this.clearLineTrackEditStatus()
      })
    },
    delLineMenu() { // 删除线路
      this.$confirm('确定删除该线路?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.map.remove(this.linesMap[this.dbClickLineObj.uniqueId])
        this.lines[this.currentDay] = this.lines[this.currentDay].filter(ele => ele.uniqueId !== this.dbClickLineObj.uniqueId)
        this.updateAllLines()
        this.$message.success('删除成功')
        this.dialogClickEditLineMenu = false
      })
    },
    clearLineTrackEditStatus() {
      this.editLineTrackMapObj.setTarget()
      this.editLineTrackMapObj.close()
      this.editLineTrackHandler = false
    },
    clearAllLines() {
      for (const key in this.linesMap) {
        this.map.remove(this.linesMap[key])
      }
    },
    initOnlineLines() {
      this.info.lines.forEach(line => {
        if (!this.lines[line.day]) {
          this.lines[line.day] = []
        }
        this.lines[line.day].push(line)
      })
      this.updateAllLines()
    },
    /** ************* 线路方法结束 *******************/
    goBack() {
      this.$router.go(-1)
    },
    onsubmit() {
      this.loading = true
      saveGuide({ days: this.days, markers: this.markers, lines: this.lines, id: this.$route.query.id }).then(response => {

      }).finally(() => {
        this.loading = false
      })
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
      .day-title{
        flex: 1;
      }
      .day-icon{
        width: 20px;
        text-align: left;
        text-shadow: 0 0 5px #FFFFFF;
      }
    }
    .active{
      background-color: teal;
      color: #fff;
      border-radius: 5px;
    }
  }
  .line-box{
    position: absolute;
    right: 20px;
    top: 20px;
    background-color: #fff;
    border-radius: 10px;
    width: 250px;
    box-shadow: 0 2px 6px 0 rgb(114 124 245 / 50%);
    padding: 10px;
    .header-title{
      padding-left: 10px;
    }
    .line-list{
      .line-item {
        border-bottom: 1px solid #dddddd;
        display: flex;
        flex-direction: row;
        align-items: center;
        padding: 10px 10px;
        .line-name{
          font-size: 12px;
          flex: 1;
        }
        .handle-box{
          width: 20px;
          .el-icon-delete{
            text-shadow: 0 0 5px #FFFFFF;
          }
        }
      }
      .line-item:last-child{
        border-bottom: none;
      }
      .active{
        background-color: teal;
        color: #fff;
        border-radius: 5px;
      }
    }
  }
  .header-title{
    font-weight: bold;
    color: teal;
    margin-bottom: 10px;
    font-size: 16px;
    line-height: 30px;
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
  .dialogClickEditLineMenu {
    .menu-list {
      text-align: center;
      display: flex;
      flex-direction: column;
      justify-content: center;

      button {
        margin-bottom: 10px;
        width: 150px;
        flex: 1;
      }

      .el-button + .el-button {
        margin-left: 0;
      }
    }
  }
  .handle-box{
    position: absolute;
    top: 10px;
    right: 10px;
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
.amap-marker-label {
  border: none;
  background: transparent;
}
.amap-marker-label .info {
  box-shadow: rgb(0 0 0 / 15%) 0px 2px 4px 0px;
  padding: 10px;
  background: #08ffff;
  border-radius: 6px;
}

.amap-marker-label .jt {
  width: 10px;
  height: 10px;
  background-color: #08ffff;
  transform: rotate(45deg);
  position: absolute;
  bottom: 1px;
  left: 0;
  right: 0;
  margin: auto;
  box-shadow: rgb(0 0 0 / 15%) 2px 2px 2px;
}
</style>
