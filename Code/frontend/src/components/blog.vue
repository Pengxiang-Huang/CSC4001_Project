<template>
  <div>
    <div class="initbackground" v-show="showbackground(2)">
      <div class="anitext" >
        <h1 class="loadtext">Loading....</h1>
        <div class="container">
          <span class="bar-fill bar"></span>
          <span class="bar-inside bar"></span>
        </div>
      </div>
      <div id="cloud-intro"></div>
      <div id="frame">
        <div id="wave"></div>
        <div id="boat"></div>
      </div>
    </div>
    <div v-show="!showbackground(2)">
      <div id="mask"></div>
      <div id="pop-up-reset" class="pop-up">
        <span id="reset-title"></span>
        <img src="../assets/close.png" class="closeBtn" @click="close">
        <input id="inputBox1">
        <input id="inputBox2" v-model="newVal">
        <button class="clickBtn" @click="reset">Reset</button>
      </div>
      <div id="textcode">
        <froala :tag="'textarea'" :config="config" v-model="answerText"></froala>
        <img src="../assets/close.png" @click="closeAnwserBox" style="position: fixed;top: 21%;left: 81%;cursor: pointer">
        <el-button type="primary" @click="submitPost" round style="width: 100%;margin-top: 20px;">Post</el-button>
      </div>
      <el-menu
        default-active="Main"
        class="el-menu-demo"
        mode="horizontal"
        @select="handleSelect"
        background-color="rgb(32, 129, 181)"
        text-color="#ffffff"
        active-text-color="#d3c90a"
      >
        <el-menu-item index="Main" class="menu-item">主页面</el-menu-item>
        <el-menu-item index="Partitions" class="menu-item">分区</el-menu-item>
        <el-button class="searchIcon" icon="el-icon-search" @click="search" circle></el-button>
        <el-button class="postIcon" @click="skipToPost" round>Post</el-button>
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
        <button class="logout" @click="logout" >Log Out</button>
      </el-menu>
      <el-input v-model="searchContent" placeholder="Please enter something you want to search..." class="searchBox" @keyup.enter.native="search">
        <el-button v-if="searchCondition !== 'All'" slot="prepend" icon="el-icon-close" style="padding: 0;width: 140px;font-size: 12px;" @click="cancel($event)" round>{{ searchCondition }}</el-button>
        <el-dropdown slot="suffix" trigger="click">
          <img src="../assets/filter.png" style="position: relative;top: 5px;cursor: pointer;"/>
          <el-dropdown-menu slot="dropdown" style="width: 34%;height: 100px;">
            <el-dropdown-item disabled>Limit the search results by following conditions:</el-dropdown-item>
            <el-dropdown trigger="click" placement="bottom-start" @command="selectSearchCondition">
              <el-dropdown-item divided command="Partition">Search in Partition</el-dropdown-item>
              <el-dropdown-menu slot="dropdown" style="width: 12%;height: 150px;overflow: auto;">
                <el-dropdown-item divided v-for="(item,index) in partitions" :key="'partition_'+index" :command="item.group_name">{{ item.group_name }}</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
            <el-dropdown trigger="click" placement="bottom-start" @command="selectSearchCondition">
              <el-dropdown-item divided command="Sub-Partition">Search in Sub-Partition</el-dropdown-item>
              <el-dropdown-menu slot="dropdown" style="width: 22%;height: 150px;overflow: auto;">
                <el-dropdown-item divided v-for="(item,index) in filterCondition" :key="'subpartition_'+index" :command="item">{{ item }}</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </el-dropdown-menu>
        </el-dropdown>
      </el-input>
      <div v-if="index === 'Main'" class="tab">
        <div id="leftBox"></div>
        <div id="rightBox"></div>
        <div id="deletion" class="fa fa-trash"  @click="deleteblog" v-show="ismyblog"></div>
        <div class="bk-btn" src="../assets/back.png" @click="backToMain" ><div class="bk-btn-triangle"></div><div class="bk-btn-bar"></div></div>
        <div style="padding: 0 50px;" class="animate__animated animate__zoomIn">
          <el-tooltip class="item" effect="dark" :content="blog.author_name" placement="left">
            <el-avatar v-if="blog.author_profile" :src="blog.author_profile" style="float: left;cursor: pointer;margin-right: 10px;"></el-avatar>
            <el-avatar v-else icon="el-icon-user-solid" style="float: left;cursor: pointer;margin-right: 10px;"></el-avatar>
          </el-tooltip>
          <h2>{{ blog.title }}</h2>
          <span v-show="JSON.stringify(blog.file_urls) !== '{}'">Attachments:</span>
          <a v-for="(url,index) in blog.file_urls" :href="url" :key="index" target="_blank" style="margin: 0 10px;">{{ url.substring(url.lastIndexOf('/')+1) }}</a>
          <hr />
          <p v-html="blog.content"></p>
          <p v-show="JSON.stringify(blog.pic_urls) !== '{}'">Below is the related images:</p>
          <el-image v-for="(item,index) in blog.pic_urls" :key="'image_'+index" :src="item" style="display: block;margin-bottom: 20px;" :preview-src-list="previewArr">
          </el-image>
          <p v-show="blog.code">Below is the related code:</p>
          <prism-editor v-show="blog.code" class="my-editor height-300" v-model="blog.code" :lineNumbers=true :highlight="highlighter" :readonly=true></prism-editor>
          <button v-if="blog.isliked" class="like" @click="like($event,blog,0,false)" style="background-color: #ff3300;">
            <img src="../assets/like.png" />
            <span style="color: white;">{{ blog.like }}</span>
          </button>
          <button v-else class="like" @click="like($event,blog,0,false)">
            <img src="../assets/like.png" />
            <span style="color: #bfbfbf;">{{ blog.like }}</span>
          </button>
          <button v-if="blog.isfollowed" class="follow" @click="follow($event,blog,false)" style="background-color: #ffcc00;">
            <img src="../assets/follow.png" />
            <span style="color: white;">{{ blog.follow }}</span>
          </button>
          <button v-else class="follow" @click="follow($event,blog,false)">
            <img src="../assets/follow.png" />
            <span style="color: #bfbfbf;">{{ blog.follow }}</span>
          </button>
          <div class="noclick_icon" @click="answer(blog)" style="cursor: pointer;">
            <i class="el-icon-chat-dot-square"></i>
            <span>Answer</span>
          </div>
          <div class="noclick_icon">
            <i class="el-icon-collection-tag"></i>
            <span>{{ blog.sub_group_name }}</span>
          </div>
          <div class="noclick_icon">
            <i class="el-icon-collection-tag"></i>
            <span>{{ blog.group_type }}</span>
          </div>
        </div>
        <hr style="color: gray;margin: 20px 0;" class="animate__animated animate__zoomIn"/>
        <div class="comments-container animate__animated animate__zoomIn">
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
                    <span v-show="item.author_name===blog.author_name" style="background-color: #707070;width: 50px;height: 20px;text-align: center;line-height: 20px;color: #dbdbdb;border-radius: 5px;margin-left: 10px;">author</span>
                    <span style="color: white;margin: 0 10px">reply</span>
                    <h6 class="comment-name">{{ blog.author_name }}</h6>
                    <span style="background-color: #707070;width: 50px;height: 20px;text-align: center;line-height: 20px;color: #dbdbdb;border-radius: 5px;margin-left: 10px;">author</span>
                    <div v-if="item.isliked">
                      <span style="float: right;margin-left: 10px;padding-top: 2px;font-size: 16px;color: #409EFF;">{{ item.like }}</span>
                      <img src="../assets/like-click.png" style="float: right;cursor: pointer;" @click="like($event,item,1,false)"/>
                    </div>
                    <div v-else>
                      <span style="float: right;margin-left: 10px;padding-top: 2px;font-size: 16px;color: white;">{{ item.like }}</span>
                      <img src="../assets/like.png" style="float: right;cursor: pointer;" @click="like($event,item,1,false)"/>
                    </div>
                    <i class="el-icon-chat-dot-square" @click="answer(item)" style="float: right;margin-right: 10px;font-size: 25px;color: white;cursor: pointer;"></i>
                  </div>
                  <div class="comment-content">
                    <div v-html="item.content"></div>
                    <el-image v-for="(pic,index) in item.pic_urls" :key="'image_'+index" :src="pic" style="margin-bottom: 20px;" :preview-src-list="answerImages(item)">
                    </el-image>
                    <span v-show="JSON.stringify(item.file_urls) !== '{}'">Attachments:</span>
                    <a v-for="(url,index) in item.file_urls" :href="url" :key="index" target="_blank" style="margin: 0 10px;">{{ url.substring(url.lastIndexOf('/')+1) }}</a>
                  </div>
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
                      <span v-show="child.author_name===blog.author_name" style="background-color: #707070;width: 50px;height: 20px;text-align: center;line-height: 20px;color: #dbdbdb;border-radius: 5px;margin-left: 10px;">author</span>
                      <span style="color: white;margin: 0 10px">reply</span>
                      <h6 class="comment-name">{{ child.father_name }}</h6>
                      <span v-show="item.author_name===blog.author_name" style="background-color: #707070;width: 50px;height: 20px;text-align: center;line-height: 20px;color: #dbdbdb;border-radius: 5px;margin-left: 10px;">author</span>
                      <div v-if="child.isliked">
                        <span style="float: right;margin-left: 10px;padding-top: 2px;font-size: 16px;color: #409EFF;">{{ child.like }}</span>
                        <img src="../assets/like-click.png" style="float: right;cursor: pointer;" @click="like($event,child,1,false)"/>
                      </div>
                      <div v-else>
                        <span style="float: right;margin-left: 10px;padding-top: 2px;font-size: 16px;color: white;">{{ child.like }}</span>
                        <img src="../assets/like.png" style="float: right;cursor: pointer;" @click="like($event,child,1,false)"/>
                      </div>
                      <i class="el-icon-chat-dot-square" @click="answer(child)" style="float: right;margin-right: 10px;font-size: 25px;color: white;cursor: pointer;"></i>
                    </div>
                    <div class="comment-content">
                      <div v-html="child.content"></div>
                      <el-image v-for="(pic,index) in child.pic_urls" :key="'image_'+index" :src="pic" style="margin-bottom: 20px;" :preview-src-list="answerImages(child)">
                      </el-image>
                      <span v-show="JSON.stringify(child.file_urls) !== '{}'">Attachments:</span>
                      <a v-for="(url,index) in child.file_urls" :href="url" :key="index" target="_blank" style="margin: 0 10px;">{{ url.substring(url.lastIndexOf('/')+1) }}</a>
                    </div>
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
          <button v-if="item.isliked" class="like" @click="like($event,item,0,true)">
            <img src="../assets/like.png" />
            <span style="color: white;">{{ item.like }}</span>
          </button>
          <button v-else class="like" @click="like($event,item,0,true)">
            <img src="../assets/like.png" />
            <span style="color: #bfbfbf;">{{ item.like }}</span>
          </button>
          <button v-if="item.isfollowed" class="follow" @click="follow($event,item,true)">
            <img src="../assets/follow.png" />
            <span style="color: white;">{{ item.follow }}</span>
          </button>
          <button v-else class="follow" @click="follow($event,item,true)">
            <img src="../assets/follow.png" />
            <span style="color: #bfbfbf;">{{ item.follow }}</span>
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
  </div>
</template>

<script>
import axios from 'axios'
import Qs from 'qs'
import VueFroala from 'vue-froala-wysiwyg'
import { PrismEditor } from 'vue-prism-editor'
import Prism from 'prismjs'
import 'vue-prism-editor/dist/prismeditor.min.css'
import { highlight, languages } from 'prismjs/components/prism-core'
import 'prismjs/components/prism-clike'
import 'prismjs/components/prism-javascript'
import 'prismjs/themes/prism-okaidia.css'
import VueMzcLoading from 'vue-mzc-loading'
import editor from '@/components/editor.vue'

export default {
  components: {
    PrismEditor,
    editor,
    VueFroala,
    VueMzcLoading
  },
  data () {
    return {
      searchContent: '',
      searchCondition: 'All',
      srPage: [], // used to show the search results page
      srBlogs: {}, // used to store the blogs resulting from the search
      inSearch: false, // true => show the search results, false => not show
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
      answers: {},
      config: {
        heightMax: 330,
        heightMin: 330,
        placeholderText: 'Type your answer...',
        fileUploadURL: 'http://175.178.34.84/api/getfile',
        fileUploadParams: {
          username: this.username
        },
        quickInsertButtons: ['table', 'ul', 'ol', 'hr'],
        toolbarButtons: ['bold', 'italic', 'underline', '|', 'fontFamily', 'fontSize', 'quote', '|',
          'print', 'markdown', 'align', '|',
          'html', 'insertLink', 'insertFile', '|',
          'paragraphStyle', 'paragraphFormat', 'specialCharacters', '|',
          'undo', 'redo', 'fullscreen'],
        events: {
          'file.uploaded': function (response) {
            this.link = JSON.parse(response).link
            sessionStorage.setItem('link', this.link)
          }
        },
        imageUploadURL: 'http://175.178.34.84/api/getfile'
      },
      answerText: '',
      father_answer_id: '',
      value: 0,
      ismyblog: true
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
    },
    answerImages: function () {
      return function (item) {
        var arr = []
        for (let url in item.pic_urls) {
          arr.push(item.pic_urls[url])
        }
        return arr
      }
    }
  },
  created () {
    this.username = this.$route.query.username
    this.config.fileUploadParams.username = this.username
    this.searchContent = this.$route.query.searchContent
    this.searchCondition = this.$route.query.searchCondition
    this.inSearch = this.$route.query.inSearch
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
      }),
      // Add the view of this blog by one
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/api/AddViews',
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
      if (this.blog.author_name !== this.username) {
        this.ismyblog = false
      }
    })
  },
  mounted: function () {
    document.body.style = 'overflow: hidden;'
    Prism.highlightAll()
    this.timer = setInterval(this.get, 1000)
  },
  beforeDestroy () {
    clearInterval(this.timer)
  },
  methods: {
    highlighter (code) {
      var lang = this.Language
      if (lang === 'C++') {
        return highlight(code, languages.cpp)
      } else if (lang === 'C') {
        return highlight(code, languages.c)
      } else if (lang === 'Java') {
        return highlight(code, languages.java)
      } else if (lang === 'Python') {
        return highlight(code, languages.python)
      } else if (lang === 'Rust') {
        return highlight(code, languages.rust)
      } else if (lang === 'Go') {
        return highlight(code, languages.go)
      } else if (lang === 'Javascript') {
        return highlight(code, languages.javascript)
      } else if (lang === 'markdown') {
        return highlight(code, languages.markdown)
      } else {
        return highlight(code, languages.bash)
      }
    },
    get () {
      this.value = this.value + 1
    },
    showbackground (time) {
      if (time > this.value) {
        return true
      } else {
        return false
      }
    },
    // close the pop-up window
    close () {
      document.getElementById('mask').style.display = 'none'
      document.getElementById('pop-up-reset').style.display = 'none'
    },
    // skip to the post page
    skipToPost () {
      this.$router.push({
        name: 'post',
        params: {
          username: this.username
        }
      })
    },
    // user select which partition the blog belongs to
    selectPartition (command) {
      this.partition = command
    },
    // user select which sub partition the blog belongs to
    selectSubPartition (command) {
      this.subPartition = command
    },
    // user submit the post
    submitPost () {
      if (this.answerText === '') {
        this.$message.error('Please write your answer!')
      } else {
        let sendData = {
          username: this.username,
          question_id: this.blog.id,
          father_answer_id: this.father_answer_id,
          content: this.answerText
        }
        axios({
          method: 'POST',
          url: 'http://175.178.34.84/api/Reply',
          data: Qs.stringify(sendData)
        }).then((response) => {
          if (response.data.ok) {
            this.$router.replace({
              path: '/blank',
              query: {
                question_id: this.blog.id,
                username: this.username,
                searchCondition: this.searchCondition,
                searchContent: this.searchContent,
                inSearch: this.inSearch
              }
            })
          }
        })
      }
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
            question_id: this.$route.query.question_id
          }
          axios.all([
            axios({
              method: 'POST',
              url: 'http://175.178.34.84/api/GetQuestions',
              data: Qs.stringify(sendData)
            }),
            axios({
              method: 'POST',
              url: 'http://175.178.34.84/api/GetAnswers',
              data: Qs.stringify(sendData)
            })
          ]).then((response) => {
            this.blog = response[0].data
            this.answers = response[1].data
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
      alert('Please click the back button to go back to the main page if you want to search!')
    },
    // User click to go back to main
    backToMain () {
      this.$router.push({
        name: 'home',
        params: {
          username: this.username,
          inSearch: this.inSearch,
          searchCondition: this.searchCondition,
          searchContent: this.searchContent
        }
      })
    },
    // User click to log out
    logout () {
      sessionStorage.clear()
      this.$router.push({
        path: '/'
      })
    },
    // User click to answer the blog
    answer (item) {
      document.getElementById('mask').style.display = 'block'
      document.getElementById('textcode').style.display = 'block'
      document.getElementById('textcode').classList.remove('fadeout')
      document.getElementById('textcode').classList.add('fadein')
      if (this.blog.id !== item.id) {
        this.father_answer_id = item.id
      } else {
        this.father_answer_id = ''
      }
    },
    // User click to close the answer pop up window
    closeAnwserBox () {
      document.getElementById('mask').style.display = 'none'
      document.getElementById('textcode').classList.remove('fadein')
      document.getElementById('textcode').classList.add('fadeout')
      setTimeout(function () {
        document.getElementById('textcode').style.display = 'none'
      }, 800)
    },
    // delete the blogs if the blog belongs to username
    deleteblog () {
      console.log(this.blog.id)
      let senddata = {
        id: this.blog.id
      }
      console.log('delete')
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/api/delete',
        data: Qs.stringify(senddata)
      }).then((response) => {
        if (response.data.ok) {
          console.log('delete success')
          this.$message.success('Delete Success!')
          this.$router.push({
            name: 'home',
            params: {
              username: this.username,
              inSearch: this.inSearch,
              searchCondition: this.searchCondition,
              searchContent: this.searchContent
            }
          })
        } else {
          this.$message.error('Delete failed! Please try again!')
        }
      })
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
#textcode{
  position: fixed;
  width: 60%;
  height: 40%;
  z-index: 9999;
  left: 20%;
  top: 20%;
  display: none;
  text-align: center;
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
  border: 0;
  padding: 0;
  padding-left: 15px;
  padding-right: 45px;
  /*  Do not let that box scale because of left padding*/
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  background-image: -webkit-linear-gradient(bottom, #fcfaf6 0%, #eae3cf 100%);
  background-image: linear-gradient(bottom, #fcfaf6 0%, #eae3cf 100%);
  background-image: -moz-linear-gradient(bottom, #fcfaf6 23%, #eae3cf 62%);
  background-image: -ms-linear-gradient(bottom, #fcfaf6 23%, #eae3cf 62%);
  background-image: -webkit-gradient(
  linear,
  left bottom,
  left top,
  color-stop(0, #fcfaf6),
  color-stop(1, #eae3cf));
  box-shadow: inset 0px 5px 6px rgba(205,190,165,0.75),
        inset 0px 0px 2px 1px rgba(205,190,165,0.75),
        0px 1px rgba(255,255,255,0.1);
  -webkit-box-shadow: inset 0px 5px 6px rgba(205,190,165,0.75),
        inset 0px 0px 2px 1px rgba(205,190,165,0.75),
        0px 1px rgba(255,255,255,0.1);
  -moz-box-shadow: inset 0px 5px 6px rgba(205,190,165,0.75),
        inset 0px 0px 2px 1px rgba(205,190,165,0.75),
        0px 1px rgba(255,255,255,0.1);
  border-radius: 30px;
  -moz-border-radius: 30px;
  height: 45px;
  width: 100%;
  color: #97917e;
  font-weight: bold;
  font-size: 14px;
  outline: none;
  line-height: 18px;
  -webkit-transition: all 1s;
}
#reset-title {
  position: relative;
  width: 60%;
  top: 5%;
}
.clickBtn {
  height: 12%;
  width: 60%;
  cursor: pointer;
  background-color: #b73104;
  background-image: -webkit-linear-gradient(top, rgba(255,185,145,0.8) 0%, rgba(255,215,190,0) 65%,rgba(255,185,145,0.2) 100%);
  background-image: -moz-linear-gradient(top, rgba(255,185,145,0.8) 0%, rgba(255,215,190,0) 65%,rgba(255,185,145,0.2) 100%);
  background-image: -ms-linear-gradient(top, rgba(255,185,145,0.8) 0%, rgba(255,215,190,0) 65%,rgba(255,185,145,0.2) 100%);
  background-image: -o-linear-gradient(top, rgba(255,185,145,0.8) 0%, rgba(255,215,190,0) 65%,rgba(255,185,145,0.2) 100%);
  background-image: linear-gradient(top, rgba(255,185,145,0.8) 0%, rgba(255,215,190,0) 65%,rgba(255,185,145,0.2) 100%);
  padding: 0px;
  border: none;
  margin: 0px;
  outline: none;
  display:inline-block;;
  font-size: 14px;
  text-transform: uppercase;
  font-family: Arial, Helvetica, sans-serif;
  font-weight: bold;
  padding-top: 12px;
  padding-bottom: 12px;
  color: white;
  text-shadow: 0px 1px 2px #660300;
  margin-top: 10px;
  width: 100%;
  text-align: center;
  cursor: pointer;
  border: 1px solid #a4381b;
  border-radius: 30px;
  -moz-border-radius: 30px;
  box-shadow: inset 0px 1px rgba(255,185,145,1),
        0px 2px 3px rgba(165,55,25,0.75);
  -webkit-box-shadow: inset 0px 1px rgba(255,185,145,1),
            0px 2px 3px rgba(165,55,25,0.75);
  -moz-box-shadow: inset 0px 1px rgba(255,185,145,1),
           0px 2px 3px rgba(165,55,25,0.75);
    -moz-transition: all 1s ease-in;
    /* WebKit */
    -webkit-transition: all 1s ease-in;
    /* Opera */
    -o-transition: all 1s ease-in;
    /* Standard */
    transition: all 1s ease-in;
}
.clickBtn:hover {
  background-color: #df620f;
  border: 1px solid #df620f;
  text-shadow: 0px 1px 3px #660300;
  box-shadow: inset 0px 1px rgba(245,180,107,1),
              0px 2px 3px rgba(165,55,25,0.75),
              0px 0px 15px 0px rgba(255,115,0,0.65);
  -webkit-box-shadow: inset 0px 1px rgba(245,180,107,1),
              0px 2px 3px rgba(165,55,25,0.75),
              0px 0px 15px 0px rgba(255,115,25,0.65);
  -moz-box-shadow:  inset 0px 1px rgba(245,180,107,1),
              0px 2px 3px rgba(165,55,25,0.75),
              0px 0px 15px 0px rgba(255,115,25,0.65);
}
.closeBtn {
  width: 5%;
  float: right;
  cursor: pointer;
}
#leftBox {
  position: fixed;
  width: 20%;
  height: 100%;
  left: 0;
  background: #2980b9 url('http://175.178.34.84/pics/blue.png') repeat 0 0;
  -webkit-animation: 10s linear 0s normal none infinite animate;
  -moz-animation: 10s linear 0s normal none infinite animate;
  -ms-animation: 10s linear 0s normal none infinite animate;
  -o-animation: 10s linear 0s normal none infinite animate;
  animation: 10s linear 0s normal none infinite animate;
  z-index: -9999;
}
@-moz-keyframes animate {
  from {background-position:0 0;}
  to {background-position: 500px 0;}
}
@-ms-keyframes animate {
  from {background-position:0 0;}
  to {background-position: 500px 0;}
}
@-o-keyframes animate {
  from {background-position:0 0;}
  to {background-position: 500px 0;}
}
@keyframes animate {
  from {background-position:0 0;}
  to {background-position: 500px 0;}
}
#rightBox {
  position: fixed;
  width: 20%;
  height: 100%;
  left: 80%;
  background: #2980b9 url('http://175.178.34.84/pics/blue.png') repeat 0 0;
  -webkit-animation: 10s linear 0s normal none infinite animate;
  -moz-animation: 10s linear 0s normal none infinite animate;
  -ms-animation: 10s linear 0s normal none infinite animate;
  -o-animation: 10s linear 0s normal none infinite animate;
  animation: 10s linear 0s normal none infinite animate;
  z-index: -9999;
}
.menu-item {
  margin-left: 50px !important;
}
.searchBox {
  position: fixed;
  width: 35%;
  top: 10px;
  left: 30%;
  border: 1.5px solid #9fbee4;
  border-radius: 6px;
  border-bottom-width: 2.5px;
}
.searchBox:hover {
  border-color: #388fe1;
}
.searchIcon {
  position: fixed;
  top: 10px;
  right: 27%;
}
.postIcon {
  position: fixed;
  top: 10px;
  right: 15%;
  width: 100px;
  height: 40px;
  font-size: 18px;
}
.userIcon {
  position: fixed;
  top: 10px;
  right: 8%;
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
.like, .follow, .follow-partition {
  box-sizing: border-box;
  width: 100px;
  height: 40px;
  padding-top: 5px;
  padding-left: 15px;
  font-size: 15px;
  line-height: 25px;
  border-color: transparent;
  border-radius: 3px;
  margin-right: 50px;
  margin-bottom: 25px;
}
.like img, .follow img, .follow-partition img{
  float: left;
}
.follow:hover, .follow-partition:hover{
  cursor: pointer;
  background-color: #eee685;
}
.like:hover {
  cursor: pointer;
  background-color: #ff9090;
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
.author-avatar, .comments-list .comment-avatar {
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
  margin: 0;
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
.my-editor {
  margin-top: 25px;
  margin-bottom: 25px;
  background-color: #201919;
  color: #ccc;
  border-left: 10px solid #656c70;
  font-family: Fira code, Fira Mono, Consolas, Menlo, Courier, monospace;
  font-size: 14px;
  line-height: 1.5;
  padding: 5px;
}
.height-300 {
  height: 300px;
}
.fadein {
  animation: fadein 1.5s ease 1;
  -webkit-animation: fadein 1.5s ease 1;
  -moz-animation: fadein 1.5s ease 1;
  -o-animation: fadein 1.5s ease 1;
}
@keyframes fadein {
  from {opacity: 0;}
  to {opacity: 1;}
}
@-moz-keyframes fadein {
  from {opacity: 0;}
  to {opacity: 1;}
}
@-webkit-keyframes fadein {
  from {opacity: 0;}
  to {opacity: 1;}
}
@-o-keyframes fadein {
  from {opacity: 0;}
  to {opacity: 1;}
}
.fadeout {
  animation: fadeout 1s ease 1;
  -webkit-animation: fadeout 1s ease 1;
  -moz-animation: fadeout 1s ease 1;
  -o-animation: fadeout 1s ease 1;
}
@keyframes fadeout {
  from {opacity: 1;}
  to {opacity: 0;}
}
@-moz-keyframes fadeout {
  from {opacity: 1;}
  to {opacity: 0;}
}
@-webkit-keyframes fadeout {
  from {opacity: 1;}
  to {opacity: 0;}
}
@-o-keyframes fadeout {
  from {opacity: 1;}
  to {opacity: 0;}
}
#deletion{
  z-index: 9999;
  top:4%;
  right:24%;
  font-size: 24px;
  position: absolute;
  cursor: pointer;
}
#frame {
  position: absolute;
  top: 30%;
  left: 40%;
  height: 15em;
  width: 15em;
  background-color: lightblue;
  border: 0.75em solid #864d18;
  border-radius: 50%;
  margin: 2em auto;
  overflow: hidden;
  z-index: 2;
}
#frame:after {
  content: "";
  height: 5em;
  width: 5em;
  background-color: rgba(255, 255, 0, 0.77);
  display: block;
  margin-top: -2em;
  border-radius: 50%;
  margin-left: 50%;
  box-shadow: -4px 5px 31px rgba(255, 255, 0, 1);
}
#wave {
  background: radial-gradient(#3b3b92 38%, #1269e6 100%);
  height: 23em;
  width: 23em;
  position: absolute;
  border-radius: 8.15em;
  bottom: -19em;
  left: -5em;
  transform: rotate(360deg);
  animation: wave 5s linear infinite;
}
#boat {
  width: 7.5em;
  height: 2.125em;
  background: linear-gradient(18deg, #457b96 29%, #62a6e4 100%);
  position: absolute;
  top: 8.5em;
  margin-left: 3.75em;
  margin-top: 0.25em;
  left: -1em;
  border-radius: 45%;
  border-top-left-radius: 0.5em;
  border-top-right-radius: 0.5em;
  transform: rotate(-4deg);
  animation: rockTheBoat 1.25s linear infinite;
  z-index: 2;
  border-bottom: 3px outset #6776bb;
}
#boat:before {
  content: "";
  display: block;
  width: 0;
  height: 0;
  border-left: 2em solid transparent;
  border-right: -0.25em solid transparent;
  border-bottom: 4em solid #eaeaea;
  position: absolute;
  top: -4em;
  left: 1.75em;
  z-index: 1;
  transform: rotateY(500px);
}
#boat:after {
  content: "";
  display: block;
  width: 0;
  height: 0;
  border-right: 2em solid transparent;
  border-left: -0.25em solid transparent;
  border-bottom: 4em solid #f5f0f0;
  position: absolute;
  top: -4em;
  left: 3.875em;
  z-index: 1;
}
@keyframes wave {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}
@keyframes rockTheBoat {
  0% {
    margin-top: 0.25em;
    transform: rotate(-4deg);
  }
  40% {
    transform: rotate(6deg);
    margin-top: -0.5em;
  }
  65% {
    transform: rotate(-8deg);
    margin-top: -0.125em;
  }
  100% {
    transform: rotate(-4deg);
    margin-top: 0.25em;
  }
}
.initbackground {
  background-size: cover;
  height: 100vh;
  width: 100vw;
  background-color: #007ced;
  background: linear-gradient(to bottom, #007ced 1%,#cce7ff 100%);
}
#cloud-intro{
  position: relative;
  height: 100%;
  background: url(http://175.178.34.84/pics/p1.png) 0 200px,
              url(http://175.178.34.84/pics/p2.png) 0 300px,
              url(http://175.178.34.84/pics/p3.png) 100px 250px;
  animation: wind 20s linear infinite;
}
@keyframes wind{
  0% {
    background-position: 0 200px, 0 300px, 100px 250px;
  }
  100% {
    background-position: 1000px 200px, 1200px 300px, 1100px 250px;
  }
}
.anitext {
  background-color: red;
  top: 10%;
  left: 35%;
  height: 0;
  position: fixed;
}
.loadtext{
  text-transform: uppercase;
  font-size: 4em;
  letter-spacing: 4px;
  overflow: hidden;
  background: linear-gradient(90deg, #000, rgb(65, 55, 55), #000);
  background-repeat: no-repeat;
  background-size: 80%;
  animation: animate 2s linear infinite;
  -webkit-background-clip: text;
  -webkit-text-fill-color: rgba(11, 0, 0, 0);
}
@keyframes animate {
  0% {
    background-position: -500%;
  }
  100% {
    background-position: 500%;
  }
}
.container {
  width: 300px;
  margin: 50px auto 0;
  text-align: center;
  position: fixed;
  top: 20%;
  left: 42%;
}
.bar-fill {
  border-radius: 5px;
  margin: auto;
  background:  #1269e6 100%;
  width: 200px;
  height: 40px;
  display: block;
  position: absolute;
  top: 0;
}
.bar-inside {
  border-radius: 5px;
  border-top-left-radius: 0px;
  border-bottom-left-radius: 0px;
  margin: auto;
  background: white;
  width: 190px;
  height: 30px;
  display: block;
  z-index: 3;
  position: absolute;
  top: 5px;
  left: 5px;
  transform-origin: 100% 50%;
  transform: scalex(1);
  animation: processing 2s infinite;
}
p {
  font-family: 'Roboto', sans-serif;
  letter-spacing: 2px;
}
@keyframes processing {
  0% {
    transform: scalex(1);
    border-top-left-radius: 5px;
    border-bottom-left-radius: 5px;
  }
  10%{
    border-top-left-radius: 0px;
    border-bottom-left-radius: 0px;
  }
  100% {
    transform: scalex(0);
  }
}
.logout {
  font-family: 'Georgia';
  position: fixed;
  top: 1px;
  height: 30px;
  right: 1%;
  cursor: pointer;
  margin: 1rem;
  background-color: #34bced;
  border: none;
  border-radius: 10px;
  text-align: center;
  -webkit-transition-duration: 0.4s;
  transition-duration: 0.4s;
  text-decoration: none;
  overflow: hidden;
}
.logout:hover{
   background:#fff;
   box-shadow:0px 2px 10px 5px #97B1BF;
   color:#000;
}
.logout:after {
    content: "";
    background: #f1c40f;
    display: block;
    position: absolute;
    padding-top: 300%;
    padding-left: 350%;
    margin-left: -20px !important;
    margin-top: -120%;
    opacity: 0;
    transition: all 0.8s
}
.logout:active:after {
    padding: 0;
    margin: 0;
    opacity: 1;
    transition: 0s
}
.bk-btn {
  height: 52px;
  width: 52px;
  background-color: rgb(26, 221, 133);
  border-radius: 50%;
  position: fixed;
  left: 81%;
  cursor: pointer;
}
.bk-btn .bk-btn-triangle {
  position: relative;
  top: 13px;
  left: 10.4px;
  width: 0;
  height: 0;
  border-top: 13px solid transparent;
  border-bottom: 13px solid transparent;
  border-right: 13px solid white;
}
.bk-btn .bk-btn-bar {
  position: relative;
  background-color: white;
  height: 7.8px;
  width: 13px;
  top: -3.64px;
  left: 22.88px;
}
</style>
