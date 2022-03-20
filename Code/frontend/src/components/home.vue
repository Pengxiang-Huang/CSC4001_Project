<template>
  <div>
    <el-menu
      default-active="1"
      class="el-menu-demo"
      mode="horizontal"
      @select="handleSelect"
      background-color="#545c64"
      text-color="#fff"
      active-text-color="#ffd04b"
    >
      <el-menu-item index="1" class="menu-item">Main</el-menu-item>
      <el-menu-item index="2" class="menu-item">Partitions</el-menu-item>
      <el-input
        v-model="input"
        placeholder="请输入内容"
        class="searchBox"
      ></el-input>
      <el-button class="searchIcon" icon="el-icon-search" circle></el-button>
      <el-button class="postIcon" round>Post</el-button>
      <el-dropdown trigger="click" placement="bottom" @command="handleCommand">
        <span class="el-dropdown-link">
          <el-avatar v-if="profileURL" :src="profileURL" class="userIcon"></el-avatar>
          <el-avatar v-else class="userIcon" icon="el-icon-user-solid"></el-avatar>
        </span>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item divided>
            <el-upload
              class="avatar-uploader"
              action="/api/getProfile/"
              :limit="1"
              :show-file-list="false"
              :on-success="handleAvatarSuccess"
              :before-upload="beforeAvatarUpload">Upload Profile
            </el-upload>
          </el-dropdown-item>
          <el-dropdown-item divided command="reset">Reset Password</el-dropdown-item>
          <el-dropdown-item divided>...</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </el-menu>
    <div v-if="index === 'Main'" id="tab">
      <div id="leftBox"></div>
      <div id="rightBox"></div>
      <el-tabs v-model="activeName" @tab-click="handleClick">
        <el-tab-pane></el-tab-pane>
        <el-tab-pane label="Hot quesitons" name="first">
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
          <p>hot questions</p>
        </el-tab-pane>
        <el-tab-pane label="Concerned questions" name="second"
          >concerned questions</el-tab-pane
        >
        <el-tab-pane label="Concerned partitions" name="third"
          >concerned partitions</el-tab-pane
        >
        <el-tab-pane label="Excellent answers" name="fourth"
          >excellent answers</el-tab-pane
        >
      </el-tabs>
    </div>
    <div v-if="index === 'Partitions'" id="tab">
      <div id="leftBox"></div>
      <div id="rightBox"></div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data () {
    return {
      input: '',
      index: 'Main',
      activeName: 'first',
      profileURL: ''
    }
  },
  created () {
    // axios({
    //   method: 'POST',
    //   url: '/api/getProfile/'
    // }).then((response) => {
    //   if (response.data.name !== '') {
    //     this.profileURL = require('../../dist/profiles/' + response.data.name)
    //   }
    // })
  },
  methods: {
    handleSelect (key, keyPath) {
      if (key === '1') {
        this.index = 'Main'
      }
      if (key === '2') {
        this.index = 'Partitions'
      }
    },
    handleClick (tab, event) {
      console.log(tab, event)
    },
    handleCommand (command) {
      if (command === 'reset') {
        this.$message('click on item ' + command)
      }
    },
    handleAvatarSuccess (response, file) {
      this.profileURL = require('../../dist/profiles/' + file.raw.name)
    },
    beforeAvatarUpload (file) {
      const isJPG = file.type === 'image/jpeg'
      const isLt2M = file.size / 1024 / 1024 < 2
      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG 格式!')
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!')
      }
      let fd = new FormData()
      fd.append('profile', file)
      console.log(fd.get('profile'))
      axios({
        method: 'POST',
        url: '/api/uploadProfile/',
        data: fd,
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      })
      return isJPG && isLt2M
    }
  }
}
</script>

<style scoped>
#leftBox {
  position: fixed;
  width: 20%;
  height: 100%;
  left: 0;
  background-color: #bfbfbf;
}
#rightBox {
  position: fixed;
  width: 20%;
  height: 100%;
  left: 80%;
  background-color: #bfbfbf;
}
.menu-item {
  margin-left: 50px;
}
.searchBox {
  position: fixed;
  width: 400px;
  top: 10px;
  left: 410px;
}
.searchIcon {
  position: fixed;
  top: 10px;
  left: 830px;
}
.postIcon {
  position: fixed;
  top: 10px;
  left: 900px;
  width: 100px;
  height: 40px;
  font-size: 18px;
}
.userIcon {
  position: fixed;
  top: 10px;
  left: 1253px;
}
.userIcon:hover {
  cursor: pointer;
}
#tab {
  position: absolute;
  width: 60%;
  height: 100%;
  padding: 0 20%;
  border: 1px solid gray;
  overflow: auto;
}
p {
  padding-left: 50px;
}
.el-dropdown-menu {
  top: 50px !important;
  left: 1200px !important;
}
</style>
