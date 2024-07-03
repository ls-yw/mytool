
<template>
  <div v-loading="loading" class="container music">
    <el-row>
      <el-col :span="20">
        <el-input v-model="keyword" placeholder="输入歌曲或歌手名称" />
      </el-col>
      <el-col :span="4">
        <el-button class="search-btn" type="primary" @click="searchSongs">搜索</el-button>
      </el-col>
    </el-row>
    <div class="songs">
      <div v-for="(song, index) in songs" :key="index" class="song">
        <span class="song-name">{{ song.name }}</span>
        <el-button type="success" style="float: right;" size="mini" @click="downloadSong(index)">下载</el-button>
      </div>
    </div>
    <div v-if="songs.length === 0 && isSearch" class="no-result">
      <p>未搜索到相关歌曲</p>
    </div>
  </div>
</template>
<script>
import { downMusic, searchMusic } from '@/api/other'
import axios from 'axios'

export default {
  data() {
    return {
      loading: false,
      keyword: '',
      songs: [],
      isSearch: false
    }
  },
  methods: {
    searchSongs() {
      this.loading = true
      searchMusic({ keyword: this.keyword }).then(response => {
        this.songs = response.data
      }).finally(() => {
        this.loading = false
        this.isSearch = true
      })
    },
    downloadSong(index) {
      this.loading = true
      downMusic(this.songs[index]).then(async res => {
        if (res.data === '') {
          this.$message.error('获取下载链接失败')
          return
        }
        const response = await fetch(res.data)
        if (response.ok) {
          const data = await response.json()
          const link = data.link

          const a = document.createElement('a')
          a.href = link
          a.download = 'edia_file.mp4' // 自定义文件名
          document.body.appendChild(a)
          a.click()
          document.body.removeChild(a)
        }
        /*        try {
          const response = await axios.get(res.data, {
            responseType: 'blob', // 设置响应类型为 blob
            headers: {
              'referer': 'https://www.hifini.com'
            }
          })

          // 创建一个下载链接
          const link = document.createElement('a')
          const url = window.URL.createObjectURL(new Blob([response.data]))
          link.href = url
          link.setAttribute('download', this.songs[index].name) // 设置下载文件名

          // 触发下载
          document.body.appendChild(link)
          link.click()

          // 清理下载链接
          document.body.removeChild(link)
          window.URL.revokeObjectURL(url)
        } catch (error) {
          console.error('Error downloading the file:', error)
        }*/
      }).finally(() => {
        this.loading = false
      })
    }
  }
}
</script>
<style scoped lang="scss">
.container{
  width: 90%;
  margin: 20px auto;
  .search-btn{
    margin-left: 10px;
  }
  .no-result{
    text-align: center;
  }
  .songs{
    width: 90%;
    margin-top: 20px;
    font-size: 12px;
    .song{
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      padding: 10px;
      border-bottom: 1px dashed #ddd;
      .song-name{
        color: #1482f0;
      }
    }
  }
}
</style>
