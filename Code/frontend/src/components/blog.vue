<template>
  <div>
    <div id="mask"></div>
    <div id="pop-up-reset" class="pop-up">
      <span id="reset-title"></span>
      <img src="../assets/close.png" class="closeBtn" @click="close">
      <input id="inputBox1">
      <input id="inputBox2" v-model="newVal">
      <button class="clickBtn" @click="reset">Reset</button>
    </div>
    <div id="pop-up-post" class="pop-up">
      <span id="post-title">Post</span>
      <img src="../assets/close.png" class="closeBtn" @click="close">
      <textarea type="text" placeholder="Please enter the title/subject of your question/blog..." id="blog_title"></textarea>
      <textarea placeholder="Please enter the detailed information..." id="blog_content"></textarea>
      <el-row>
        <el-col :span="5" :offset="6" style="cursor: pointer;background-color: #82beec;border-radius: 5px;height: 10%;">
          <el-dropdown trigger="click" placement="bottom" @command="selectPartition">
            <span style="color: white;">
              {{ partition }}<i class="el-icon-arrow-down el-icon--right"></i>
            </span>
            <el-dropdown-menu slot="dropdown" style="height: 130px;overflow: auto;">
              <el-dropdown-item command="CSC4001">CSC4001</el-dropdown-item>
              <el-dropdown-item command="CSC3050">CSC3050</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </el-col>
        <el-col :span="5" :offset="2" style="cursor: pointer;background-color: #82beec;border-radius: 5px;height: 10%;">
          <el-dropdown trigger="click" placement="bottom" @command="selectSubPartition">
            <span style="color: white;">
              {{ subPartition }}<i class="el-icon-arrow-down el-icon--right"></i>
            </span>
            <el-dropdown-menu slot="dropdown" style="height: 130px;overflow: auto;">
              <el-dropdown-item command="Assignments">Assignments</el-dropdown-item>
              <el-dropdown-item command="Projects">Projects</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </el-col>
      </el-row>
      <div id="upload_info">
          <el-button type="primary" id="loadFile">upload</el-button>
          <input @change="handleFileChange" type="file" multiple="multiple" id="file" name="attachments">
          <span id="fileTip">You can upload some attachment here</span>
      </div>
      <button class="clickBtn" @click="submitPost">Post</button>
    </div>
    <el-menu
      default-active="Main"
      class="el-menu-demo"
      mode="horizontal"
      @select="handleSelect"
      background-color="#545c64"
      text-color="#ffffff"
      active-text-color="#ffd04b"
    >
      <el-menu-item index="Main" class="menu-item">Main</el-menu-item>
      <el-menu-item index="Partitions" class="menu-item">Partitions</el-menu-item>
      <el-input v-model="searchContent" placeholder="Please enter something you want to search..." class="searchBox">
        <el-button v-if="searchCondition !== 'All'" slot="prepend" icon="el-icon-close" style="padding: 0;width: 130px;font-size: 12px;" @click="cancel($event)" round>{{ searchCondition }}</el-button>
        <el-dropdown slot="suffix" trigger="click">
          <img src="../assets/filter.png" style="position: relative;top: 5px;cursor: pointer;"/>
          <el-dropdown-menu slot="dropdown" style="width: 440px;height: 100px;">
            <el-dropdown-item disabled>Limit the search results by following conditions:</el-dropdown-item>
            <el-dropdown trigger="click" placement="bottom-start" @command="selectSearchCondition">
              <el-dropdown-item divided command="Partition">Search in Partition</el-dropdown-item>
              <el-dropdown-menu slot="dropdown" style="width: 160px;height: 150px;overflow: auto;">
                <el-dropdown-item divided v-for="(item,index) in partitions" :key="'partition_'+index" :command="item.group_name">{{ item.group_name }}</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
            <el-dropdown trigger="click" placement="bottom-start" @command="selectSearchCondition">
              <el-dropdown-item divided command="Sub-Partition">Search in Sub-Partition</el-dropdown-item>
              <el-dropdown-menu slot="dropdown" style="width: 270px;height: 150px;overflow: auto;">
                <el-dropdown-item divided v-for="(item,index) in filterCondition" :key="'subpartition_'+index" :command="item">{{ item }}</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </el-dropdown-menu>
        </el-dropdown>
      </el-input>
      <el-button class="searchIcon" icon="el-icon-search" @click="search" circle></el-button>
      <el-button class="postIcon" @click="showPost" round>Post</el-button>
      <el-dropdown trigger="click" placement="bottom" @command="selectUserFunctions" class="userIcon">
        <el-avatar v-if="profileURL" :src="profileURL"></el-avatar>
        <el-avatar v-else icon="el-icon-user-solid"></el-avatar>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item disabled><input :value="username" id="user"/></el-dropdown-item>
          <el-dropdown-item divided command="Reset Username">Reset Username</el-dropdown-item>
          <el-dropdown-item divided command="Reset Password">Reset Password</el-dropdown-item>
          <el-dropdown-item divided>
            <el-upload
              class="avatar-uploader"
              action="/api/getProfile/"
              :show-file-list="false"
              :http-request="uploadProfile"
              :on-success="handleAvatarSuccess"
              :before-upload="beforeAvatarUpload">Upload Profile
            </el-upload>
          </el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </el-menu>
    <div v-if="index === 'Main'" class="tab">
      <div id="leftBox"></div>
      <div id="rightBox"></div>
      <img src="../assets/back.png" @click="backToMain" style="position: fixed;left: 80%;cursor: pointer;"/>
      <div style="padding: 0 50px;">
        <h2>{{ blog.title }}</h2>
        <p v-html="blog.content"></p>
        <el-image v-for="(item,index) in blog.pic_urls" :key="'image_'+index" :src="item" style="display: block;margin-bottom: 20px;" :preview-src-list="previewArr">
        </el-image>
        <button v-if="blog.isliked" class="click_icon" @click="like($event,blog,0,false)">
          <img src="../assets/like-click.png" />
          <span style="color: #409EFF;font-weight: bold;">{{ blog.like }}</span>
        </button>
        <button v-else class="click_icon" @click="like($event,blog,0,false)">
          <img src="../assets/like.png" />
          <span style="color: white;">{{ blog.like }}</span>
        </button>
        <button v-if="blog.isfollowed" class="click_icon" @click="follow($event,blog,false)">
          <img src="../assets/follow-click.png" />
          <span style="color: #409EFF;font-weight: bold;">{{ blog.follow }}</span>
        </button>
        <button v-else class="click_icon" @click="follow($event,blog,false)">
          <img src="../assets/follow.png" />
          <span style="color: white;">{{ blog.follow }}</span>
        </button>
        <div class="noclick_icon">
          <i class="el-icon-collection-tag"></i>
          <span>{{ blog.sub_group_name }}</span>
        </div>
        <div class="noclick_icon">
          <i class="el-icon-collection-tag"></i>
          <span>{{ blog.group_type }}</span>
        </div>
      </div>
      <hr style="color: gray;margin: 20px 0;"/>
      <div class="comments-container">
        <ul id="comments-list" class="comments-list" style="list-style-type: none;">
          <li v-for="(item,index) in answers" :key="'answer_'+index">
            <div class="comment-main-level">
              <div class="comment-avatar">
                  <el-avatar v-if="item.author_profile_url" :src="item.author_profile_url" style="position: absolute;margin: auto; left: 0;top: 0;right: 0;bottom: 0;"></el-avatar>
                  <el-avatar v-else icon="el-icon-user-solid" style="position: absolute;margin: auto; left: 0;top: 0;right: 0;bottom: 0;"></el-avatar>
              </div>
              <div class="comment-box">
                <div class="comment-head">
                  <h6 class="comment-name">{{ item.author_name }}</h6>
                  <span>hace 20 minutos</span>
                  <i class="fa fa-reply"></i>
                  <i class="fa fa-heart"></i>
                </div>
                <div class="comment-content" v-html="item.content"></div>
              </div>
            </div>
            <ul class="comments-list reply-list" style="list-style-type: none;">
              <li v-for="(child,index) in item.Children" :key="'child_'+index">
                <div class="comment-avatar">
                  <el-avatar v-if="child.author_profile_url" :src="child.author_profile_url" style="position: absolute;margin: auto; left: 0;top: 0;right: 0;bottom: 0;"></el-avatar>
                  <el-avatar v-else icon="el-icon-user-solid" style="position: absolute;margin: auto; left: 0;top: 0;right: 0;bottom: 0;"></el-avatar>
                </div>
                <div class="comment-box">
                  <div class="comment-head">
                      <h6 class="comment-name">{{ child.author_name }}</h6>
                      <span>hace 10 minutos</span>
                      <i class="fa fa-reply"></i>
                      <i class="fa fa-heart"></i>
                  </div>
                  <div class="comment-content" v-html="child.content"></div>
                </div>
              </li>
            </ul>
          </li>
        </ul>
      </div>
      <div style="height: 200px;"></div> <!-- Used to leave some blank -->
    </div>
    <div v-if="index === 'Partitions'" class="tab">
      <div id="leftBox"></div>
      <div id="rightBox"></div>
      <img v-show="p_type === false" src="../assets/back.png" @click="back" style="position: fixed;left: 80%;cursor: pointer;"/>
      <div v-if="p_type" class="partition" v-for="(item,index) in partitions" :key="'partition_'+index">
        <img :src="item.url" class="partition-icon"/>
        <h3>{{ item.group_name + ' - ' + item.description }}</h3>
        <div id="sub-container">
          <el-button type="primary" class="sub-partitions" round>Sub Partitions:</el-button>
          <el-button type="primary" class="sub-partitions" @click="skipToSub($event,item)" v-for="(subitem,subindex) in item.sub_groups" :key="'subpartition_'+subindex" round>{{ subitem }}</el-button>
        </div>
        <button v-if="item.isFollowed" class="follow-partition" @click="followGroup(item)" style="float: right;">
          <img src="../assets/follow-click.png" />
          <span style="color: #409EFF;font-weight: bold;">{{ item.amount_of_follows }}</span>
        </button>
        <button v-else class="follow-partition" @click="followGroup(item)" style="float: right;">
          <img src="../assets/follow.png" />
          <span style="color: white;">{{ item.amount_of_follows }}</span>
        </button>
      </div>
      <div v-if="p_type === false" class="blog" v-for="(item,index) in subBlogs" :key="index+'_sub'">
        <h3 @click="skipToBlog(item)">{{ item.title }}</h3>
        <p @click="skipToBlog(item)">{{ item.content }}</p>
        <button v-if="item.isliked" class="click_icon" @click="like($event,item,0,true)">
          <img src="../assets/like-click.png" />
          <span style="color: #409EFF;font-weight: bold;">{{ item.like }}</span>
        </button>
        <button v-else class="click_icon" @click="like($event,item,0,true)">
          <img src="../assets/like.png" />
          <span style="color: white;">{{ item.like }}</span>
        </button>
        <button v-if="item.isfollowed" class="click_icon" @click="follow($event,item,true)">
          <img src="../assets/follow-click.png" />
          <span style="color: #409EFF;font-weight: bold;">{{ item.follow }}</span>
        </button>
        <button v-else class="click_icon" @click="follow($event,item,true)">
          <img src="../assets/follow.png" />
          <span style="color: white;">{{ item.follow }}</span>
        </button>
        <div class="noclick_icon">
          <i class="el-icon-collection-tag"></i>
          <span>{{ item.group_type }}</span>
        </div>
        <div class="noclick_icon">
          <i class="el-icon-chat-line-round"></i>
          <span>{{ item.amount_of_answers }}</span>
        </div>
        <div class="noclick_icon">
          <i class="el-icon-view"></i>
          <span>{{ item.views }}</span>
        </div>
      </div>
      <div style="height: 200px;"></div> <!-- Used to leave some blank -->
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import Qs from 'qs'
export default {
  data () {
    return {
      searchContent: '',
      searchCondition: 'All',
      index: 'Main',
      profileURL: '',
      partitions: {},
      partition: 'Partitions', // used in selecting the partition when posting a question
      subPartition: 'Sub Partitions', // used in selecting the partition when posting a question
      p_type: true, // true => partition, false => sub-partition
      subBlogs: {},
      username: '',
      newVal: '',
      blog: {},
      answers: {}
    }
  },
  computed: {
    filterCondition: function () {
      var arr = []
      for (let item in this.partitions) {
        for (let subitem in this.partitions[item].sub_groups) {
          arr.push(this.partitions[item].group_name + ' ' + this.partitions[item].sub_groups[subitem])
        }
      }
      return arr
    },
    previewArr: function () {
      var arr = []
      for (let url in this.blog.pic_urls) {
        arr.push(this.blog.pic_urls[url])
      }
      return arr
    }
  },
  created () {
    this.username = this.$route.query.username
    let sendData = {
      question_id: this.$route.query.question_id,
      username: this.username
    }
    axios.all([
      // Initialized the profile
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/api/getProfile/',
        data: Qs.stringify(sendData)
      }),
      // Initialize the partitions
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/api/Groups/',
        data: Qs.stringify(sendData)
      }),
      // Initialize the blog
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/api/GetQuestions',
        data: Qs.stringify(sendData)
      }),
      // Initialize the answer of the blog
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/api/GetAnswers',
        data: Qs.stringify(sendData)
      })
    ]).then((response) => {
      if (response[0].data.url !== '') {
        this.profileURL = response[0].data.url
      }
      this.partitions = response[1].data
      this.blog = response[2].data
      this.answers = response[3].data
      console.log(this.answers)
    })
  },
  methods: {
    // close the pop-up window
    close () {
      document.getElementById('mask').style.display = 'none'
      document.getElementById('pop-up-reset').style.display = 'none'
      document.getElementById('pop-up-post').style.display = 'none'
    },
    // show the pop-up post window
    showPost () {
      document.getElementById('mask').style.display = 'block'
      document.getElementById('pop-up-post').style.display = 'block'
    },
    // user select which partition the blog belongs to
    selectPartition (command) {
      this.partition = command
    },
    // user select which sub partition the blog belongs to
    selectSubPartition (command) {
      this.subPartition = command
    },
    // user select the file wait for uploading
    handleFileChange (e) {
      const input = e.target
      const files = e.target.files
      const fileTip = document.getElementById('fileTip')
      let tips = ''
      for (let i = 0; i < files.length; i++) {
        if (files[i].size > 1024 * 1024 * 3) {
          alert('文件大小不能超过3M, 请重新选择!')
          input.value = ''
          return false
        }
        tips += files[i].name
        tips += ', '
      }
      tips = tips.substring(0, tips.length - 2)
      if (tips.length > 40) {
        tips = tips.substring(0, 40) + '...'
      }
      fileTip.innerHTML = tips
      this.fileList = files
    },
    // user submit the post
    submitPost () {
      let fd = new FormData()
      for (let i = 0; i < this.fileList.length; i++) {
        fd.append('attachments[' + i + ']', this.fileList[i])
      }
      axios({
        method: 'POST',
        url: '/api/submitPost/',
        data: fd,
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      })
    },
    // Determine the page where the user stay on
    handleSelect (key, keyPath) {
      this.index = key
    },
    // Deal with the user functions
    selectUserFunctions (command) {
      if (command === 'Reset Username') {
        document.getElementById('mask').style.display = 'block'
        document.getElementById('pop-up-reset').style.display = 'block'
        document.getElementById('reset-title').innerHTML = command
        document.getElementById('inputBox1').type = 'text'
        document.getElementById('inputBox1').placeholder = this.username
        document.getElementById('inputBox1').disabled = true
        document.getElementById('inputBox2').type = 'text'
        document.getElementById('inputBox2').placeholder = 'Please enter your new username...'
      }
      if (command === 'Reset Password') {
        document.getElementById('mask').style.display = 'block'
        document.getElementById('pop-up-reset').style.display = 'block'
        document.getElementById('reset-title').innerHTML = command
        document.getElementById('inputBox1').type = 'password'
        document.getElementById('inputBox1').placeholder = 'Please enter you new password...'
        document.getElementById('inputBox1').disabled = false
        document.getElementById('inputBox2').type = 'password'
        document.getElementById('inputBox2').placeholder = 'Please check your new password...'
      }
    },
    // Reset username or password
    reset () {
      let type = document.getElementById('reset-title').innerHTML
      if (type === 'Reset password' && document.getElementById('inputBox1') !== this.newVal) {
        alert('The passwords are not the same, please check it!')
        return
      }
      let sendData = {
        type: type,
        username: this.username,
        newVal: this.newVal
      }
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/updateInformation/',
        data: Qs.stringify(sendData)
      }).then((response) => {
        if (type === 'Reset Username' && response.data === 'UserName has been taken') {
          alert('The username has already been used, please change it again!')
        } else {
          alert(response.data)
          this.close()
          if (type === 'Reset Username') {
            this.username = this.newVal
            this.$router.replace({
              path: '/blank',
              name: 'blank',
              params: {
                username: this.username
              }
            })
          } else {
            this.$router.push({
              path: '/login',
              name: 'login'
            })
          }
        }
      })
    },
    // Callback when the user successfully upload a profile
    handleAvatarSuccess (res, file) {
      this.profileURL = 'http://175.178.34.84/profiles/' + res.data.profile_name
    },
    uploadProfile (option) {
      let fd = new FormData()
      fd.append('profile', option.file)
      fd.append('id', fd.get('profile').uid)
      fd.append('username', this.username)
      return axios({
        method: 'POST',
        url: '/api/uploadProfile/',
        data: fd,
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      })
    },
    // Execute this before the user upload a profile
    beforeAvatarUpload (file) {
      const isJPG = file.type === 'image/jpeg'
      const isLt2M = file.size / 1024 / 1024 < 2
      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG 格式!')
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!')
      }
      return isJPG && isLt2M
    },
    // User like the blog if no like, dislike the blog if like
    like (e, item, t, inPartition) {
      let sendData = {
        id: item.id,
        username: this.username,
        type: t // 0 is question, 1 is answer
      }
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/api/like/',
        data: Qs.stringify(sendData)
      }).then((response) => {
        if (response.data.ok) {
          let sendData = {
            username: this.username,
            question_id: item.id
          }
          axios({
            method: 'POST',
            url: 'http://175.178.34.84/api/GetQuestions',
            data: Qs.stringify(sendData)
          }).then((response) => {
            this.blog = response.data
          })
          if (inPartition) {
            let sendData = {
              username: this.username,
              group_name: item.group_type,
              sub_group_name: item.sub_group_name
            }
            axios({
              method: 'POST',
              url: 'http://175.178.34.84/api/getGroup/',
              data: Qs.stringify(sendData)
            }).then((response) => {
              this.subBlogs = response.data
            })
          }
        }
      })
    },
    // User follow the blog if not follow, unfollow the blog if follow
    follow (e, item, inPartition) {
      let sendData = {
        id: item.id,
        username: this.username
      }
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/api/follow/',
        data: Qs.stringify(sendData)
      }).then((response) => {
        if (response.data.ok) {
          let sendData = {
            username: this.username,
            question_id: item.id
          }
          axios({
            method: 'POST',
            url: 'http://175.178.34.84/api/GetQuestions',
            data: Qs.stringify(sendData)
          }).then((response) => {
            this.blog = response.data
          })
          if (inPartition) {
            let sendData = {
              username: this.username,
              group_name: item.group_type,
              sub_group_name: item.sub_group_name
            }
            axios({
              method: 'POST',
              url: 'http://175.178.34.84/api/getGroup/',
              data: Qs.stringify(sendData)
            }).then((response) => {
              this.subBlogs = response.data
            })
          }
        }
      })
    },
    // User follow the partition if not follow, unfollow the partition if follow
    followGroup (item) {
      let sendData = {
        group_name: item.group_name,
        username: this.username
      }
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/api/followGroup/',
        data: Qs.stringify(sendData)
      }).then((response) => {
        if (response.data.ok) {
          let sendData = {
            username: this.username
          }
          axios.all([
            axios({
              method: 'POST',
              url: 'http://175.178.34.84/api/Groups/',
              data: Qs.stringify(sendData)
            }),
            axios({
              method: 'POST',
              url: 'http://175.178.34.84/api/MyGroups/',
              data: Qs.stringify(sendData)
            })
          ]).then((response) => {
            this.partitions = response[0].data
            this.followedPartitions = response[1].data
          })
        }
      })
    },
    // User click the link to skip to the sub-partition
    skipToSub (event, item) {
      let sendData = {
        username: this.username,
        group_name: item.group_name,
        sub_group_name: event.target.innerHTML
      }
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/api/getGroup/',
        data: Qs.stringify(sendData)
      }).then((response) => {
        this.p_type = false
        this.subBlogs = response.data
      })
    },
    // User click to go back to the partition
    back () {
      this.p_type = true
    },
    // User cancel the filter condition
    cancel (event) {
      event.target.parentNode.parentNode.style.display = 'none'
      this.searchCondition = 'All'
    },
    // User select the search condition
    selectSearchCondition (condition) {
      if (condition !== 'Partition' && condition !== 'Sub-Partition') {
        this.searchCondition = condition
      }
    },
    search () {
      alert(this.searchContent)
    },
    // User click to go back to main
    backToMain () {
      this.$router.push({
        name: 'home',
        params: {
          username: this.username
        }
      })
    },
    timeDiff (start) {
      var staytimeGap = new Date().getTime() - new Date(start).getTime()
      var stayHour = Math.floor(staytimeGap / (3600 * 1000))
      var leave1 = staytimeGap % (3600 * 1000)
      var stayMin = Math.floor(leave1 / (60 * 1000))
      var leave2 = leave1 % (60 * 1000)
      var staySec = Math.floor(leave2 / 1000)
      return stayHour + ':' + stayMin + ':' + staySec
    }
  }
}
</script>

<style scoped>
#mask {
  position: fixed;
  width: 100%;
  height: 100%;
  left: 0;
  background-color: #bfbfbf;
  z-index: 1000;
  opacity: 0.8;
  display: none;
}
#pop-up-post {
  height: 55%;
}
.pop-up {
  position: fixed;
  height: 40%;
  width: 40%;
  left: 30%;
  top: 20%;
  border-radius: 10px;
  font-size: 25px;
  text-align: center;
  z-index: 1001;
  background-color: white;
  display: none;
}
.pop-up input {
  box-sizing: border-box;
  display: block;
  height: 12%;
  width: 60%;
  border-radius: 5px;
  border: 1px solid gray;
  margin: 10% auto;
}
#reset-title, #post-title {
  position: relative;
  width: 60%;
  top: 5%;
}
.clickBtn {
  height: 12%;
  width: 60%;
  cursor: pointer;
}
.closeBtn {
  width: 5%;
  float: right;
  cursor: pointer;
}
#blog_title {
  box-sizing: border-box;
  display: block;
  height: 12%;
  width: 60%;
  border-radius: 5px;
  border: 1px solid gray;
  margin: 7% auto 0;
  resize: none;
  font-size: 16px;
}
#blog_content {
  box-sizing: border-box;
  display: block;
  height: 20%;
  width: 60%;
  border-radius: 5px;
  border: 1px solid gray;
  margin: 5% auto;
  resize: none;
  font-size: 16px;
}
#upload_info {
  width: 60%;
  height: 8%;
  border-radius: 5px;
  border: 1px solid gray;
  margin: 5% auto;
  text-align: left;
  padding-top: 2%;
}
#file {
  box-sizing: border-box;
  display: block;
  height: 80%;
  width: 100%;
  margin: -10% auto;
  opacity: 0;
}
#loadFile {
  width: 20%;
  height: 70%;
  padding: 0;
  font-size: 18px;
  background-color: #82beec;
  border: 0;
}
#fileTip {
  position: relative;
  left: 22%;
  font-size: 14px;
}
#leftBox {
  position: fixed;
  width: 20%;
  height: 100%;
  left: 0;
  background-color: #bfbfbf;
  z-index: -9999;
}
#rightBox {
  position: fixed;
  width: 20%;
  height: 100%;
  left: 80%;
  background-color: #bfbfbf;
  z-index: -9999;
}
.menu-item {
  margin-left: 50px;
}
.searchBox {
  position: fixed;
  width: 450px;
  top: 10px;
  left: 360px;
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
#user {
  border: 0;
  font-size: 16px;
  font-weight: bold;
  color: #606266;
  width: 100px;
  text-align: center;
}
#user-function {
  top: 10px !important;
  left: 1200px !important;
}
.tab {
  position: absolute;
  width: 60%;
  height: 100%;
  padding: 0 20%;
  overflow: auto;
}
.blog {
  height: 200px;
  border-bottom: 1px solid gray;
  padding: 0 50px;
  font-size: 20px;
  line-height: 30px;
}
.blog>h3:hover, .blog>p:hover {
  cursor: pointer;
  color: #82beec;
}
.click_icon, .follow-partition {
  box-sizing: border-box;
  width: 100px;
  height: 40px;
  padding-top: 5px;
  padding-left: 15px;
  font-size: 15px;
  line-height: 25px;
  border-color: transparent;
  border-radius: 3px;
  background-color: #82beec;
  margin-right: 50px;
}
.click_icon img, .follow-partition img{
  float: left;
}
.click_icon:hover, .follow-partition:hover{
  cursor: pointer;
  background-color: #b3d8ff;
}
.noclick_icon {
  box-sizing: border-box;
  width: 120px;
  color: gray;
  font-size: 15px;
  text-align: center;
  float: right;
  margin-top: 10px;
}
.partition {
  border-bottom: 1px solid gray;
  padding: 0 50px;
  font-size: 20px;
  line-height: 30px;
}
.partition-icon {
  height: 50px;
  float: left;
  margin-right: 20px;
}
.partition>h3 {
  position: relative;
  top: 10px;
}
.sub-partitions {
  background-color: #82beec;
  border-color: transparent;
  width: 100px;
  padding: 10px 0;
  margin: 10px 15px;
}
.sub-partitions:hover{
  background-color: #b3d8ff;
}
.sub-partitions:first-child:hover{
  background-color: #82beec;
  cursor: default;
}
#sub-container {
  display: inline-block;
  position: relative;
  top: 10px;
  width: 75%;
  margin-bottom: 30px;
  font-size: 0px;
}
.follow-partition {
  float: right;
  margin: 0;
}
.comments-container {
  padding-right: 50px;
}
.comments-list li {
  margin-bottom: 15px;
  display: block;
  position: relative;
}
.comments-list li:after {
  content: '';
  display: block;
  clear: both;
  height: 0;
  width: 0;
}
.reply-list {
  padding-left: 88px;
  clear: both;
  margin-top: 15px;
}
.comments-list .comment-avatar {
  width: 65px;
  height: 65px;
  position: relative;
  z-index: 99;
  float: left;
  border: 3px solid #FFF;
  -webkit-border-radius: 4px;
  -moz-border-radius: 4px;
  border-radius: 4px;
  -webkit-box-shadow: 0 1px 2px rgba(0,0,0,0.2);
  -moz-box-shadow: 0 1px 2px rgba(0,0,0,0.2);
  box-shadow: 0 1px 2px rgba(0,0,0,0.2);
  overflow: hidden;
}
.reply-list .comment-avatar {
  width: 50px;
  height: 50px;
}
.comment-main-level:after {
  content: '';
  width: 0;
  height: 0;
  display: block;
  clear: both;
}
.comments-list .comment-box {
  width: 630px;
  float: right;
  position: relative;
  -webkit-box-shadow: 0 1px 1px rgba(0,0,0,0.15);
  -moz-box-shadow: 0 1px 1px rgba(0,0,0,0.15);
  box-shadow: 0 1px 1px rgba(0,0,0,0.15);
}
.comments-list .comment-box:before, .comments-list .comment-box:after {
  content: '';
  height: 0;
  width: 0;
  position: absolute;
  display: block;
  border-width: 10px 12px 10px 0;
  border-style: solid;
  border-color: transparent #bfbfbf;
  top: 8px;
  left: -11px;
}
.comments-list .comment-box:before {
  border-width: 11px 13px 11px 0;
  border-color: transparent rgba(0,0,0,0.05);
  left: -12px;
}
.reply-list .comment-box {
  width: 560px;
}
.comment-box .comment-head {
  background: #bfbfbf;
  padding: 10px 12px;
  border-bottom: 1px solid #E5E5E5;
  overflow: hidden;
  -webkit-border-radius: 4px 4px 0 0;
  -moz-border-radius: 4px 4px 0 0;
  border-radius: 4px 4px 0 0;
}
.comment-box .comment-name {
  color: #283035;
  font-size: 14px;
  font-weight: 700;
  float: left;
  margin: 0 10px 0 0;
}
.comment-box .comment-head span {
  float: left;
  color: #999;
  font-size: 13px;
  position: relative;
  top: 1px;
}
.comment-box .comment-content {
  background: #FFF;
  padding: 12px;
  font-size: 15px;
  color: #595959;
  -webkit-border-radius: 0 0 4px 4px;
  -moz-border-radius: 0 0 4px 4px;
  border-radius: 0 0 4px 4px;
}
</style>
