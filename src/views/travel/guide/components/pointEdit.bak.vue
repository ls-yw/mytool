<template>
  <div>
    <el-drawer
      ref="editPoint"
      :title="(pointId === 0 ? '添加': '编辑')+'点位'"
      :visible.sync="drawerShow"
      direction="rtl"
      :before-close="handleClose"
      custom-class="demo-drawer"
      size="800px"
    >
      <div v-loading="loading" class="content-box drawer__content" :style="'height:'+formHeight+'px;'">
        <el-form ref="pointForm" :rules="rules" :model="pointObj" label-width="80px">
          <el-form-item label="名称" prop="name">
            <el-input v-model="pointObj.name" />
          </el-form-item>
          <el-form-item label="类型" prop="point_type">
            <el-select v-model="pointObj.point_type" placeholder="请选择类型">
              <el-option
                v-for="item in pointTypes"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              />
            </el-select>
          </el-form-item>
          <el-form-item label="定位" prop="latitude">
            <el-tag style="cursor: pointer" @click="selectAddress">{{ addressObj.address || '请点击选择点位定位' }}</el-tag>
          </el-form-item>
          <el-form-item label="缩略图" prop="thumb_img">
            <upload-file :file-list-data.sync="thumbImages" />
          </el-form-item>
          <el-form-item label="展示图" prop="images">
            <upload-file :file-list-data.sync="images" :limit="9" />
          </el-form-item>
          <el-form-item label="视频" prop="video">
            <upload-file upload-type="video" :file-list-data="videos" />
          </el-form-item>
          <el-form-item label="简介" prop="desc">
            <el-input v-model="pointObj.desc" type="textarea" :rows="4" />
          </el-form-item>
          <el-form-item label="是否显示">
            <el-switch v-model="pointObj.is_show" :active-value="1" :inactive-value="0" />
          </el-form-item>
          <el-form-item label="图文内容" prop="content">
            <tinymce ref="tin" v-model="pointObj.content" />
          </el-form-item>
        </el-form>
        <div class="drawer__footer">
          <el-button type="primary" @click="savePoint">保 存</el-button>
          <el-button @click="cancelForm">取 消</el-button>
          <el-button v-if="pointId > 0" type="danger" @click="delPoint">删 除</el-button>
        </div>
      </div>
    </el-drawer>
    <picker-address :dialog-visible.sync="selectAddressDialog" :address-obj.sync="addressObj" />
  </div>
</template>
<script>
import { delPointApi, getPointInfoApi, savePointApi } from '@/api/point'
import PickerAddress from '@/views/travel/components/pickerAdress'
export default {
  name: 'PointEdit',
  components: { PickerAddress },
  props: {
    editPointDrawer: {
      type: Boolean,
      default: false
    },
    pointId: {
      type: Number,
      default: 0
    },
    // eslint-disable-next-line vue/require-default-prop
    beforeCloseFun: Function
  },
  data() {
    return {
      loading: false,
      pointTypes: [
        {
          value: 1,
          label: '景点'
        },
        {
          value: 2,
          label: '美食'
        },
        {
          value: 3,
          label: '文化'
        },
        {
          value: 4,
          label: '民宿'
        },
        {
          value: 5,
          label: '停车'
        },
        {
          value: 6,
          label: '购物'
        },
        {
          value: 7,
          label: '服务'
        },
        {
          value: 8,
          label: '公厕'
        },
        {
          value: 9,
          label: '维修'
        },
        {
          value: 10,
          label: ' 加油'
        }
      ],
      formHeight: 800,
      thumbImages: [],
      images: [],
      videos: [],
      selectAddressDialog: false,
      addressObj: {
        latitude: '',
        longitude: '',
        address: ''
      },
      pointObj: {
        id: 0,
        is_show: 1
      },
      rules: {
        name: [
          { required: true, message: '名称不能为空', trigger: 'blur' },
          { message: '长度在2到100个字符之间', trigger: 'blur', max: 100, min: 2 }
        ],
        latitude: [
          { required: true, message: '请选择点位定位', trigger: 'change' }
        ],
        point_type: [
          { required: true, message: '请选择类型', trigger: 'blur' }
        ],
        content: [
          { required: true, message: '请填写点位的图文内容', trigger: 'change' }
        ]
      }
    }
  },
  computed: {
    drawerShow: {
      get() {
        return this.editPointDrawer
      },
      set(val) {
        this.$emit('update:editPointDrawer', val)
      }
    }
  },
  watch: {
    pointId(newData, oldData) {
      console.log(newData, 'newData')
      console.log(oldData, 'oldData')

      this.getPointInfo()
    }
  },
  created() {
    this.formHeight = window.innerHeight - 100
  },
  methods: {
    handleClose(done) {
      this.$confirm('确认关闭？')
        .then(_ => {
          this.beforeCloseFun()
          done()
        })
        .catch(_ => {})
    },
    savePoint() {
      this.pointObj.thumb_img = this.thumbImages[0] || ''
      this.pointObj.images = this.images.join(',')
      this.pointObj.video = this.videos[0] || ''
      this.pointObj.latitude = this.addressObj.latitude
      this.pointObj.longitude = this.addressObj.longitude
      this.pointObj.address = this.addressObj.address

      this.$refs.pointForm.clearValidate()
      this.$refs.pointForm.validate(valid => {
        if (valid) {
          this.loading = true
          savePointApi(this.pointObj).then(response => {
            if (response.code === 0) {
              this.$message.success('保存成功')
              this.drawerShow = false
              this.beforeCloseFun()
            } else {
              this.$message.error(response.msg)
            }
            this.loading = false
          })
        } else {
          console.log('error submit!!')
          return false
        }
      })
    },
    cancelForm() {
      this.drawerShow = false
    },
    delPoint() {
      this.$confirm('确认删除该点位?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        delPointApi({ id: this.pointObj.id }).then(response => {
          if (response.code !== 0) {
            this.$message.success(response.msg)
            return
          }
          this.$message.success('删除成功')
          this.drawerShow = false
          this.beforeCloseFun()
        })
      }).catch(() => {
      })
    },
    selectAddress() {
      this.selectAddressDialog = true
    },
    getPointInfo() {
      if (this.pointId !== 0) {
        this.loading = true
        getPointInfoApi({ id: this.pointId }).then(response => {
          if (response.code !== 0) {
            this.$message.error(response.msg)
            this.drawerShow = false
          } else {
            this.pointObj = response.data
            console.log(this.pointObj, 'getPointInfo')
            this.initPointObj()
          }
          this.loading = false
        })
      } else {
        this.pointObj = {
          id: 0,
          is_show: 1,
          content: ''
        }
        this.initPointObj()
      }
    },
    initPointObj() {
      this.addressObj.latitude = this.pointObj.latitude || ''
      this.addressObj.longitude = this.pointObj.longitude || ''
      this.addressObj.address = this.pointObj.address || ''

      this.thumbImages = this.pointObj.thumb_img ? this.pointObj.thumb_img.split(',') : []
      this.images = this.pointObj.images ? this.pointObj.images.split(',') : []
      this.videos = this.pointObj.video ? this.pointObj.video.split(',') : []

      this.$refs.tin.setContent(this.pointObj.content)
    }
  }
}
</script>

<style scoped lang="scss">
.content-box{
  padding: 0 20px;
  display: flex;
  flex-direction: column;
  height: 100%;
  form{
    flex: 1;
    overflow-y: auto;
    overflow-x: hidden;
    padding: 0 10px;
  }
  .drawer__footer{
    display: flex;
    padding-top: 10px;
    text-align: center;
    button{
      flex: 1;
    }
  }
}
</style>
