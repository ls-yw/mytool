                            <template>
  <div class="container createStrategyMap content-box">
    <div id="container" :style="'height:'+fullHeight+'px'" />
    <point
      :update-points="getPoints"
      :point-id.sync="pointId"
      :edit-point.sync="editPointDrawer"
      :search-obj.sync="pointSearch"
    />
    <el-dialog :visible.sync="dialogEditLine" :title="(editLineObj.id === 0 ? '添加' : '编辑')+'线路'" width="500px">
      <el-form ref="editLineForm" :rules="rules" :model="editLineObj" label-position="left" label-width="70px" style="">
        <el-form-item label="名称" prop="title">
          <el-input v-model="editLineObj.title" maxlength="100" />
        </el-form-item>
        <el-form-item label="时长" prop="duration">
          <el-input v-model="editLineObj.duration" maxlength="100" />
        </el-form-item>
        <el-form-item label="简介" prop="desc">
          <el-input v-model="editLineObj.desc" maxlength="250" type="textarea" :autosize="{ minRows: 6, maxRows: 10}" />
        </el-form-item>
        <el-form-item label="状态">
          <el-switch
            v-model="editLineObj.is_show"
            active-color="#13ce66"
            inactive-color="#ff4949"
            active-text="显示"
            inactive-text="隐藏"
            :active-value="1"
            :inactive-value="0"
          />
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="saveLineBase">保存</el-button>
      </span>
    </el-dialog>
    <el-dialog
      :visible.sync="dialogClickEditLineMenu"
      custom-class="dialogClickEditLineMenu"
      width="200px"
      :show-close="false"

      center
    >
      <div class="menu-list">
        <el-button type="primary" @click="dialogClickEditLineMenu=false;dialogEditLine=true;editLineObj=dbClickLineObj">修改线路信息</el-button>
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
  </div>
</template>

<script>
import AMap from '@amap/amap-jsapi-loader'
import Point from '@/views/travel/components/point'

export default {
  name: 'Index',
  components: { Point },
  data() {
    return {
      tmp: null,
      map: null,
      aMap: null,
      mapContextMenu: null,
      mapContextMenuPosition: null,
      dbClickLineMapObj: null, // 被双击编辑线路的地图对象
      editLineTrackMapObj: null, // 编辑轨迹地图对象
      linesMapObjArr: [], // 轨迹地图对象
      mapMarkers: [],
      fullHeight: '800px',
      pointSearch: {
        keyword: '',
        type: '1,2,3,4,5,6,7,8,9,10',
        show: true
      },
      editPointObj: {},
      editPointDrawer: false,
      pointId: 0,
      lineList: [],
      editLineObj: {},
      listLoading: false,
      dialogEditLine: false,
      dialogClickEditLineMenu: false,
      showLinesBox: true,
      editLineTrackHandler: false,
      beforeEditLineTrackPaths: {}, // 在编辑前的线路轨迹点位
      dbClickLineObj: {},
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
      rules: {
        title: [
          { required: true, message: '请填写线路名称', trigger: 'blur' },
          { min: 2, max: 100, message: '线路名称长度在2到100个字符之间', trigger: 'blur' }
        ],
        duration: [
          { required: true, message: '请填写线路时长', trigger: 'blur' }
        ]
      }
    }
  },
  created() {
    this.fullHeight = window.innerHeight - 50

    console.log(this.fullHeight)
    this.initMap()

    this.$notify.info({
      title: '温馨提示',
      message: '在地图上右击添加线路和点位，双击线路或点位可进行编辑',
      duration: 0
    })
  },
  methods: {
    initMap() {
      AMap.load({
        key: process.env.VUE_APP_MAP_KEY, // 申请好的Web端开发者Key，首次调用 load 时必填
        version: '2.0', // 指定要加载的 JSAPI 的版本，缺省时默认为 1.4.15
        plugins: ['AMap.PolylineEditor', 'AMap.MouseTool'] // 需要使用的的插件列表，如比例尺'AMap.Scale'等
      }).then((AMap) => {
        this.aMap = AMap
        this.map = new this.aMap.Map('container', { // 设置地图容器id
          // viewMode: '3D', // 是否为3D地图模式
          resizeEnable: true,
          zoom: 14, // 初始化地图级别
          center: [118.842077, 29.17805] // 初始化地图中心点位置
        })

        // 右键菜单
        this.rightClickMenu()

        this.getPoints()

        this.getLinesList()
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
      const addLine = document.createElement('p')
      const addPoint = document.createElement('p')
      top.className = 'right-click-menu'
      addLine.innerText = '添加线路'
      addLine.onclick = this.addLine
      addPoint.innerText = '添加点位'
      addPoint.onclick = this.addPoint
      top.appendChild(addLine)
      top.appendChild(addPoint)

      // 通过content自定义右键菜单内容
      this.mapContextMenu = new this.aMap.ContextMenu({ isCustom: true, content: top })

      // 地图绑定鼠标右击事件——弹出右键菜单
      this.map.on('rightclick', function(e) {
        _this.mapContextMenu.open(_this.map, e.lnglat)
        _this.mapContextMenuPosition = e.lnglat
      })
    },
    getPoints() {
      getPointsApi(this.pointSearch).then(response => {
        if (response.code !== 0) {
          this.$message.error(response.msg)
          return
        }
        // this.map.clearMap()
        this.clearMarks()
        if (response.data.length > 0) {
          response.data.forEach(ele => {
            this.addMarker(ele)
          })
        }
      })
    },
    clearMarks() {
      this.mapMarkers.forEach(ele => {
        ele.setMap(null)
      })
      this.mapMarkers = []
    },
    addMarker(row) {
      console.log(row, 'marker')
      const marker = new this.aMap.Marker({
        map: this.map,
        position: [row.longitude, row.latitude],
        extData: row
      })
      this.mapMarkers.push(marker)

      marker.setLabel({
        direction: 'top',
        offset: new this.aMap.Pixel(0, -5), // 设置文本标注偏移量
        content: "<div class='info'>" + row.name + "</div><div class='jt'></div>" // 设置文本标注内容
      })
      marker.on('dblclick', this.editPoint)
    },
    editPoint(e) {
      this.editPointObj = e.target.getExtData()
      this.pointId = this.editPointObj.id
      this.editPointDrawer = true
    },

    getLinesList() {
      this.listLoading = true
      getLinesApi().then(response => {
        if (response.code !== 0) {
          this.$message.error(response.msg)
          return
        }
        this.listLoading = false
        this.lineList = response.data
        this.clearLinesMap()
        if (response.data.length > 0) {
          response.data.forEach(ele => {
            const lineStyle = this.showLineStyleOptions
            lineStyle.path = ele.content
            lineStyle.strokeStyle = ele.is_show === 1 ? 'solid' : 'dashed'
            lineStyle.extData = ele
            const line = new this.aMap.Polyline(lineStyle)
            this.tmp = line
            line.on('dblclick', this.editLineClick)
            this.linesMapObjArr.push(line)
          })
          this.map.add(this.linesMapObjArr)
        }
      })
    },
    clearLinesMap() {
      this.linesMapObjArr.forEach(ele => {
        ele.hide()
      })
      this.linesMapObjArr = []
    },
    addLine() {
      this.dialogEditLine = true
      this.mapContextMenu.close()
      this.initEditLineObj()
      this.editLineObj.latitude = this.mapContextMenuPosition.lat
      this.editLineObj.longitude = this.mapContextMenuPosition.lng
    },
    addPoint() {
      this.pointId = 0
      this.editPointDrawer = true
      this.mapContextMenu.close()
    },
    initEditLineObj() {
      this.editLineObj = {
        id: 0,
        is_show: 1
      }
    },
    editLineClick(e) {
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
      saveLineTrackApi({ id: this.dbClickLineObj.id, content: tmpPathArr }).then(response => {
        if (response.code !== 0) {
          this.$message.success(response.msg)
          return
        }
        this.$message.success('保存成功')
        this.clearLineTrackEditStatus()
        this.getLinesList()
      })
      console.log(tmpPathArr)
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
      }).catch(() => {
      })
    },
    clearLineTrackEditStatus() {
      this.editLineTrackMapObj.setTarget()
      this.editLineTrackMapObj.close()
      this.editLineTrackHandler = false
    },
    delLineMenu() {
      this.$confirm('确认要删除线路“' + this.dbClickLineObj.title + '”?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        delLineApi({ id: this.dbClickLineObj.id }).then(response => {
          if (response.code !== 0) {
            this.$message.success(response.msg)
            return
          }
          this.$message.success('删除成功')
          this.dialogClickEditLineMenu = false
          this.getLinesList()
        })
      }).catch(() => {
      })
    },
    saveLineBase() {
      this.$refs.editLineForm.validate(valid => {
        if (valid) {
          saveLineApi(this.editLineObj).then(response => {
            if (response.code === 0) {
              this.$message.success('保存成功')
              this.getLinesList()
              this.dialogEditLine = false
            } else {
              this.$message.error(response.msg)
            }
          })
        } else {
          console.log('error submit!!')
          return false
        }
      })
    }
  }
}
</script>

<style scoped lang="scss">
.content-box {
#container {
  padding: 0;
  margin: 0;
  width: 100%;
}

.line-box {
  display: inline-grid;
  position: absolute;
  top: 800px;
  right: 80px;
  background: #ffffff;
  padding: 5px 0;
  width: 56px;
  text-align: center;
  border-radius: 5px;
  cursor: pointer;

img {
  width: 30px;
}

span {
  font-size: 14px;
  font-weight: bold;
}
}

.line-table-box {
  position: absolute;
  top: 100px;
  width: 600px;
  left: 20px;
  background: #FFFFFF;
  padding: 10px;
  max-height: 200px;

.line-table-box-header {
  text-align: right;
  margin-bottom: 10px;
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
}

</style>
  <style>
  .content-window-card {
    position: relative;
    box-shadow: none;
    bottom: 0;
    left: 0;
    width: auto;
    padding: 0;
  }

.content-window-card p {
  height: 2rem;
}

.custom-info {
  border: solid 1px silver;
}

div.info-top {
  position: relative;
  background: none repeat scroll 0 0 #F9F9F9;
  border-bottom: 1px solid #CCC;
  border-radius: 5px 5px 0 0;
}

div.info-top div {
  display: inline-block;
  color: #333333;
  font-size: 14px;
  font-weight: bold;
  line-height: 31px;
  padding: 0 10px;
}

div.info-top img {
  position: absolute;
  top: 10px;
  right: 10px;
  transition-duration: 0.25s;
}

div.info-top img:hover {
  box-shadow: 0px 0px 5px #000;
}

div.info-middle {
  font-size: 12px;
  padding: 10px 6px;
  line-height: 20px;
  overflow: hidden;
}

div.info-bottom {
  height: 0px;
  width: 100%;
  clear: both;
  text-align: center;
}

div.info-bottom img {
  position: relative;
  z-index: 104;
}

.custom-info span {
  margin-left: 5px;
  font-size: 11px;
}

.info-middle img {
  float: left;
  margin-right: 6px;
}

.blackWhite {
  -webkit-filter: grayscale(100%);
  filter: grayscale(100%);
  color: #999999;
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
.amap-marker-label{
  border: none;
  background: transparent;
}
.amap-marker-label .info{
  box-shadow: rgb(0 0 0 / 15%) 0px 2px 4px 0px;
  padding: 10px;
  background: #FFFFFF;
  border-radius: 6px;
}
.amap-marker-label .jt{
  width: 10px;
  height: 10px;
  background-color: white;
  transform: rotate(45deg);
  position: absolute;
  bottom: 1px;
  left: 0;
  right: 0;
  margin: auto;
  box-shadow: rgb(0 0 0 / 15%) 2px 2px 2px;
}
</style>
