
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
      window.open(downMusic(this.songs[index]), '_blank')
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
    padding-bottom: 50px;
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
    .song:last-child {
      border-bottom: none;
    }
  }
}
</style>
