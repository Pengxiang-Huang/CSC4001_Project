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
      <el-menu default-active="Main"
               class="el-menu-demo"
               mode="horizontal"
               @select="handleSelect"
               background-color="rgb(32, 129, 181)"
               text-color="#ffffff"
               active-text-color="#d3c90a">
        <el-menu-item index="Main"
                      class="menu-item">主页面</el-menu-item>
        <el-menu-item index="Partitions"
                      class="menu-item">分区</el-menu-item>
        <h3 class="mytext">cuhksz OVerflow</h3>
        <el-button class="searchIcon"
                   icon="el-icon-search"
                   @click="search"
                   circle></el-button>
        <button class="postIcon" @click="skipToPost" ><span>Click!</span><span>Post Blog</span></button>
        <el-dropdown trigger="click"
                     placement="bottom"
                     @command="selectUserFunctions"
                     class="userIcon">
          <el-avatar v-if="profileURL"
                     :src="profileURL"></el-avatar>
          <el-avatar v-else
                     icon="el-icon-user-solid"></el-avatar>
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
        <div class="bk-btn" v-show="inSearch === true" src="../assets/back.png" @click="backToMain" ><div class="bk-btn-triangle"></div><div class="bk-btn-bar"></div></div>
        <el-tabs :value="activeTab" @tab-click="handleClick">
          <el-tab-pane></el-tab-pane>
          <el-tab-pane name="first">
            <button slot="label" class="fontClass btn-1"><span>热点话题</span></button>
            <div class="blog animate__animated animate__slideInUp"
                 v-for="(item,index) in hotBlogs"
                 :key="index+'_hot'">
              <h3 @click="skipToBlog(item)"
                  v-html="item.title"></h3>
              <p @click="skipToBlog(item)"
                 v-html="item.content"></p>
              <button v-if="item.isliked"
                      class="like"
                      @click="like($event,item,0,false)" style="background-color: #ff3300;">
                <img src="../assets/like.png"/>
                <span style="color: white;">{{ item.like }}</span>
              </button>
              <button v-else class="like" @click="like($event,item,0,false)">
                <img src="../assets/like.png"/>
                <span style="color: #8a8a8a;">{{ item.like }}</span>
              </button>
              <button v-if="item.isfollowed" class="follow" @click="follow($event,item,false)" style="background-color: #ffcc00;">
                <img src="../assets/follow.png" />
                <span style="color: white;">{{ item.follow }}</span>
              </button>
              <button v-else class="follow" @click="follow($event,item,false)">
                <img src="../assets/follow.png" />
                <span style="color: #8a8a8a;">{{ item.follow }}</span>
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
          </el-tab-pane>
          <el-tab-pane name="second">
            <button slot="label" class="fontClass btn-2"><span>关注话题</span></button>
            <div class="blog animate__animated animate__slideInUp"
                 v-for="(item,index) in followedBlogs"
                 :key="index+'_followedBlogs'">
              <h3 @click="skipToBlog(item)"
                  v-html="item.title"></h3>
              <p @click="skipToBlog(item)"
                 v-html="item.content"></p>
              <button v-if="item.isliked"
                      class="like"
                      @click="like($event,item,0,false)" style="background-color: #ff3300;">
                <img src="../assets/like.png" />
                <span style="color: white;">{{ item.like }}</span>
              </button>
              <button v-else class="like" @click="like($event,item,0,false)">
                <img src="../assets/like.png" />
                <span style="color: #8a8a8a;">{{ item.like }}</span>
              </button>
              <button v-if="item.isfollowed" class="follow" @click="follow($event,item,false)" style="background-color: #ffcc00;">
                <img src="../assets/follow.png" />
                <span style="color: white;">{{ item.follow }}</span>
              </button>
              <button v-else class="follow" @click="follow($event,item,false)">
                <img src="../assets/follow.png" />
                <span style="color: #8a8a8a;">{{ item.follow }}</span>
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
          </el-tab-pane>
          <el-tab-pane name="third">
            <button slot="label" class="fontClass btn-3"><span>关注分区</span></button>
            <div class="bk-btn" v-show="p_type === false" src="../assets/back.png" @click="back"><div class="bk-btn-triangle"></div><div class="bk-btn-bar"></div></div>
            <div v-if="p_type"
                 class="partition animate__animated animate__slideInUp"
                 v-for="(item,index) in followedPartitions"
                 :key="'followedPartitions_'+index">
              <img :src="item.url"
                   class="partition-icon" />
              <h3>{{ item.group_name + ' - ' + item.description }}</h3>
              <div id="sub-container">
                <el-button type="primary" class="sub-partitions" round>Sub Partitions:</el-button>
                <el-button type="primary" class="sub-partitions" @click="skipToSub($event,item)" v-for="(subitem,subindex) in item.sub_groups" :key="'subpartition_'+subindex" round>{{ subitem }}</el-button>
              </div>
              <button v-if="item.isFollowed" class="follow-partition" @click="followGroup(item)" style="float: right;background-color: #ffcc00;">
                <img src="../assets/follow.png" />
                <span style="color: white;">{{ item.amount_of_follows }}</span>
              </button>
              <button v-else class="follow-partition" @click="followGroup(item)" style="float: right;">
                <img src="../assets/follow.png" />
                <span style="color: #8a8a8a;">{{ item.amount_of_follows }}</span>
              </button>
            </div>
            <div v-if="p_type === false" class="blog animate__animated animate__slideInUp" v-for="(item,index) in subBlogs" :key="index+'_sub'">
              <h3 @click="skipToBlog(item)" v-html="item.title"></h3>
              <p @click="skipToBlog(item)" v-html="item.content"></p>
              <button v-if="item.isliked" class="like" @click="like($event,item,0,true)" style="background-color: #ff3300;">
                <img src="../assets/like.png" />
                <span style="color: white;">{{ item.like }}</span>
              </button>
              <button v-else class="like" @click="like($event,item,0,true)">
                <img src="../assets/like.png" />
                <span style="color: #8a8a8a;">{{ item.like }}</span>
              </button>
              <button v-if="item.isfollowed" class="follow" @click="follow($event,item,true)" style="background-color: #ffcc00;">
                <img src="../assets/follow.png" />
                <span style="color: white;">{{ item.follow }}</span>
              </button>
              <button v-else class="follow" @click="follow($event,item,true)">
                <img src="../assets/follow.png" />
                <span style="color: #8a8a8a;">{{ item.follow }}</span>
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
          </el-tab-pane>
          <el-tab-pane name="fourth">
            <button slot="label" class="fontClass btn-4"><span>我的提问</span></button>
            <div class="blog animate__animated animate__slideInUp"
                 v-for="(item,index) in myBlogs"
                 :key="index+'_my'">
              <h3 @click="skipToBlog(item)"
                  v-html="item.title"></h3>
              <p @click="skipToBlog(item)"
                 v-html="item.content"></p>
              <button v-if="item.isliked"
                      class="like"
                      @click="like($event,item,0,false)" style="background-color: #ff3300;">
                <img src="../assets/like.png" />
                <span style="color: white;">{{ item.like }}</span>
              </button>
              <button v-else class="like" @click="like($event,item,0,false)">
                <img src="../assets/like.png" />
                <span style="color: #8a8a8a;">{{ item.like }}</span>
              </button>
              <button v-if="item.isfollowed" class="follow" @click="follow($event,item,false)" style="background-color: #ffcc00;">
                <img src="../assets/follow.png" />
                <span style="color: white;">{{ item.follow }}</span>
              </button>
              <button v-else class="follow" @click="follow($event,item,false)">
                <img src="../assets/follow.png" />
                <span style="color: #8a8a8a;">{{ item.follow }}</span>
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
          </el-tab-pane>
          <el-tab-pane name="fifth">
            <button slot="label" class="fontClass btn-5"><span>未解决的问题</span></button>
            <div class="blog animate__animated animate__slideInUp"
                 v-for="(item,index) in unAnsweredBlogs"
                 :key="index+'_unAnswer'">
              <h3 @click="skipToBlog(item)"
                  v-html="item.title"></h3>
              <p @click="skipToBlog(item)"
                 v-html="item.content"></p>
              <button v-if="item.isliked"
                      class="like"
                      @click="like($event,item,0,false)" style="background-color: #ff3300;">
                <img src="../assets/like.png" />
                <span style="color: white;">{{ item.like }}</span>
              </button>
              <button v-else class="like" @click="like($event,item,0,false)">
                <img src="../assets/like.png" />
                <span style="color: #8a8a8a;">{{ item.like }}</span>
              </button>
              <button v-if="item.isfollowed" class="follow" @click="follow($event,item,false)" style="background-color: #ffcc00;">
                <img src="../assets/follow.png" />
                <span style="color: white;">{{ item.follow }}</span>
              </button>
              <button v-else class="follow" @click="follow($event,item,false)">
                <img src="../assets/follow.png" />
                <span style="color: #8a8a8a;">{{ item.follow }}</span>
              </button>
              <div class="noclick_icon">
                <i class="el-icon-collection-tag"></i>
                <span>{{ item.group_type }}</span>
              </div>
              <div class="noclick_icon">
                <i class="el-icon-chat-line-round"></i>
                <span>0</span>
              </div>
              <div class="noclick_icon">
                <i class="el-icon-view"></i>
                <span>{{ item.views }}</span>
              </div>
            </div>
            <div style="height: 200px;"></div> <!-- Used to leave some blank -->
          </el-tab-pane>
          <el-tab-pane v-for="(obj,index) in srPage" :key="index" :name="obj.name" class="animate__animated animate__fadeInUp">
            <button slot="label" class="fontClass btn-6"><span>{{ obj.label }}</span></button>
            <p v-show="JSON.stringify(srBlogs) === '{}'" style="width: 100%;text-align: center;">There are no results that satisfies the search conditions!</p>
            <div class="blog animate__animated animate__slideInUp" v-for="(item,index) in srBlogs" :key="index+'_sr'">
              <h3 @click="skipToBlog(item)"><text-highlight :queries="searchContent.split(' ')">{{ item.title }}</text-highlight></h3>
              <p @click="skipToBlog(item)" v-html="item.content"></p>
              <button v-if="item.isliked" class="like" @click="like($event,item,0,false)" style="background-color: #ff3300;">
                <img src="../assets/like.png" />
                <span style="color: white;">{{ item.like }}</span>
              </button>
              <button v-else class="like" @click="like($event,item,0,false)">
                <img src="../assets/like.png" />
                <span style="color: #8a8a8a;">{{ item.like }}</span>
              </button>
              <button v-if="item.isfollowed" class="follow" @click="follow($event,item,false)" style="background-color: #ffcc00;">
                <img src="../assets/follow.png" />
                <span style="color: white;">{{ item.follow }}</span>
              </button>
              <button v-else class="follow" @click="follow($event,item,false)">
                <img src="../assets/follow.png" />
                <span style="color: #8a8a8a;">{{ item.follow }}</span>
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
          </el-tab-pane>
        </el-tabs>
      </div>
      <div v-if="index === 'Partitions'" class="tab">
        <div id="leftBox"></div>
        <div id="rightBox"></div>
        <div class="bk-btn" v-show="p_type === false" src="../assets/back.png" @click="back"><div class="bk-btn-triangle"></div><div class="bk-btn-bar"></div></div>
        <div v-if="p_type" class="partition animate__animated animate__slideInUp" v-for="(item,index) in partitions" :key="'partition_'+index">
          <img :src="item.url" class="partition-icon"/>
          <h3>{{ item.group_name + ' - ' + item.description }}</h3>
          <div id="sub-container">
            <el-button type="primary" class="sub-partitions" round>Sub Partitions:</el-button>
            <el-button type="primary" class="sub-partitions" @click="skipToSub($event,item)" v-for="(subitem,subindex) in item.sub_groups" :key="'subpartition_'+subindex" round>{{ subitem }}</el-button>
          </div>
          <button v-if="item.isFollowed" class="follow-partition" @click="followGroup(item)" style="float: right;background-color: #ffcc00;">
            <img src="../assets/follow.png" />
            <span style="color: white;">{{ item.amount_of_follows }}</span>
          </button>
          <button v-else class="follow-partition" @click="followGroup(item)" style="float: right;">
            <img src="../assets/follow.png" />
            <span style="color: #8a8a8a;">{{ item.amount_of_follows }}</span>
          </button>
        </div>
        <div v-if="p_type === false" class="blog animate__animated animate__slideInUp" v-for="(item,index) in subBlogs" :key="index+'_sub'">
          <h3 @click="skipToBlog(item)" v-html="item.title"></h3>
              <p @click="skipToBlog(item)" v-html="item.content"></p>
          <button v-if="item.isliked" class="like" @click="like($event,item,0,true)" style="background-color: #ff3300;">
            <img src="../assets/like.png" />
            <span style="color: white;">{{ item.like }}</span>
          </button>
          <button v-else class="like" @click="like($event,item,0,true)">
            <img src="../assets/like.png" />
            <span style="color: #8a8a8a;">{{ item.like }}</span>
          </button>
          <button v-if="item.isfollowed" class="follow" @click="follow($event,item,true)" style="background-color: #ffcc00;">
            <img src="../assets/follow.png" />
            <span style="color: white;">{{ item.follow }}</span>
          </button>
          <button v-else class="follow" @click="follow($event,item,true)">
            <img src="../assets/follow.png" />
            <span style="color: #8a8a8a;">{{ item.follow }}</span>
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

export default {
  data () {
    return {
      input: '',
      searchContent: '',
      searchCondition: 'All',
      srPage: [], // used to show the search results page
      srBlogs: {}, // used to store the blogs resulting from the search
      inSearch: false, // true => show the search results, false => not show
      index: 'Main',
      activeTab: 'first',
      profileURL: '',
      hotBlogs: {},
      followedBlogs: {},
      partitions: {},
      followedPartitions: {},
      myBlogs: {},
      unAnsweredBlogs: {},
      partition: 'Partitions', // used in selecting the partition when posting a question
      subPartition: 'Sub Partitions', // used in selecting the partition when posting a question
      p_type: true, // true => partition, false => sub-partition
      subBlogs: {},
      username: '',
      newVal: '',
      value: 0
    }
  },
  computed: {
    filterCondition: function () {
      var arr = []
      for (let item in this.partitions) {
        for (let subitem in this.partitions[item].sub_groups) {
          arr.push(this.partitions[item].group_name + '|' + this.partitions[item].sub_groups[subitem])
        }
      }
      return arr
    }
  },
  created () {
    if (!sessionStorage.getItem('isLogin')) {
      alert('You do not log in, click OK to skip to the login page!')
      this.logout()
    }
    this.username = this.$route.params['username']
    if (this.$route.params['searchContent'] !== undefined) {
      this.searchContent = this.$route.params['searchContent']
    }
    if (this.$route.params['searchCondition'] !== undefined) {
      this.searchCondition = this.$route.params['searchCondition']
    }
    if (this.$route.params['inSearch'] !== undefined) {
      this.inSearch = this.$route.params['inSearch']
      if (this.inSearch === 'true') {
        this.search()
      }
    }
    let sendData = {
      username: this.username
    }
    axios.all([
      // Initialized the profile
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/api/getProfile/',
        data: Qs.stringify(sendData)
      }),
      // Initialize the hot blogs
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/mainpage/',
        data: Qs.stringify(sendData)
      }),
      // Initialize the followed blogs
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/myFollow/',
        data: Qs.stringify(sendData)
      }),
      // Initialize the partitions
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/api/Groups/',
        data: Qs.stringify(sendData)
      }),
      // Initialize the followed partitions
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/api/MyGroups/',
        data: Qs.stringify(sendData)
      }),
      // Initialize the self-post blogs
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/api/MyBlogs',
        data: Qs.stringify(sendData)
      }),
      // Initialize the highly followed blogs but not be answered
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/unAnswered/',
        data: Qs.stringify(sendData)
      })
    ]).then((response) => {
      if (response[0].data.url !== '') {
        this.profileURL = response[0].data.url
      }
      this.hotBlogs = response[1].data
      this.followedBlogs = response[2].data
      this.partitions = response[3].data
      this.followedPartitions = response[4].data
      this.myBlogs = response[5].data
      this.unAnsweredBlogs = response[6].data
    })
  },
  mounted: function () {
    document.body.style = 'overflow: hidden;'
    this.timer = setInterval(this.get, 1000)
  },
  beforeDestroy () {
    clearInterval(this.timer)
  },
  methods: {
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
      tips = tips.substscale(0, tips.length - 2)
      if (tips.length > 40) {
        tips = tips.substscale(0, 40) + '...'
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
    handleClick (tab, event) {
      console.log(tab, event)
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
      var type = document.getElementById('reset-title').innerHTML
      if (type === 'Reset Password' && document.getElementById('inputBox1').value !== this.newVal) {
        this.$message.error('The passwords are not the same, please check it!')
      } else if (this.newVal === '') {
        this.$message.error('You have not set your new ' + type.substring(6))
      } else {
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
            this.$message.error('The username has already been used, please change it again!')
          } else {
            this.$message.success((response.data))
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
              this.$message('You need to log in again!')
              this.$router.push({
                path: '/login',
                name: 'login'
              })
            }
          }
        })
      }
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
      e.currentTarget.classList.add('on')
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
            username: this.username
          }
          axios.all([
            axios({
              method: 'POST',
              url: 'http://175.178.34.84/mainpage/',
              data: Qs.stringify(sendData)
            }),
            axios({
              method: 'POST',
              url: 'http://175.178.34.84/myFollow/',
              data: Qs.stringify(sendData)
            }),
            axios({
              method: 'POST',
              url: 'http://175.178.34.84/api/MyBlogs',
              data: Qs.stringify(sendData)
            }),
            axios({
              method: 'POST',
              url: 'http://175.178.34.84/unAnswered/',
              data: Qs.stringify(sendData)
            })
          ]).then((response) => {
            this.hotBlogs = response[0].data
            this.followedBlogs = response[1].data
            this.myBlogs = response[2].data
            this.unAnsweredBlogs = response[3].data
          })
          if (this.inSearch) {
            let sendData = {
              scope: this.searchCondition,
              content: this.searchContent,
              username: this.username
            }
            axios({
              method: 'POST',
              url: 'http://175.178.34.84/search',
              data: Qs.stringify(sendData)
            }).then((response) => {
              this.srBlogs = response.data
            })
          }
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
            username: this.username
          }
          axios.all([
            axios({
              method: 'POST',
              url: 'http://175.178.34.84/mainpage/',
              data: Qs.stringify(sendData)
            }),
            axios({
              method: 'POST',
              url: 'http://175.178.34.84/myFollow/',
              data: Qs.stringify(sendData)
            }),
            axios({
              method: 'POST',
              url: 'http://175.178.34.84/api/MyBlogs',
              data: Qs.stringify(sendData)
            }),
            axios({
              method: 'POST',
              url: 'http://175.178.34.84/unAnswered/',
              data: Qs.stringify(sendData)
            })
          ]).then((response) => {
            this.hotBlogs = response[0].data
            this.followedBlogs = response[1].data
            this.myBlogs = response[2].data
            this.unAnsweredBlogs = response[3].data
          })
          if (this.inSearch) {
            let sendData = {
              scope: this.searchCondition,
              content: this.searchContent,
              username: this.username
            }
            axios({
              method: 'POST',
              url: 'http://175.178.34.84/search',
              data: Qs.stringify(sendData)
            }).then((response) => {
              this.srBlogs = response.data
            })
          }
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
        sub_group_name: event.target.innerText
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
    // User click to back to the partition
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
    // User click to get the search results
    search () {
      if (this.searchContent === '') {
        this.$message.error('Please type something you want to search!')
        return
      }
      if (this.srPage.length) {
        this.srPage.pop()
        this.activeTab = 'first'
      }
      this.srPage.push({
        label: '搜索结果',
        name: 'sixth'
      })
      let sendData = {
        scope: this.searchCondition,
        content: this.searchContent,
        username: this.username
      }
      axios({
        method: 'POST',
        url: 'http://175.178.34.84/search',
        data: Qs.stringify(sendData)
      }).then((response) => {
        this.srBlogs = response.data
        this.activeTab = 'sixth'
        this.inSearch = true
      })
      if (this.index === 'Partitions') {
        this.$message('Please go to the Main page to see the results!')
      }
    },
    // User click to go back to the main page
    backToMain () {
      this.srPage.pop()
      this.inSearch = false
      this.activeTab = 'first'
      this.searchContent = ''
      this.searchCondition = 'All'
    },
    // User click to skip to the blog page
    skipToBlog (item) {
      this.$router.push({
        path: '/blog',
        query: {
          question_id: item.id,
          username: this.username,
          searchCondition: this.searchCondition,
          searchContent: this.searchContent,
          inSearch: this.inSearch
        }
      })
    },
    // User click to log out
    logout () {
      sessionStorage.clear()
      this.$router.push({
        path: '/'
      })
    }
  }
}
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css?family=Roboto:400,400i,700");
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
  /*  Don't let that box scale because of left padding*/
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
  font-family: 'myfont2' !important;
  margin-left: 2% !important;
}
.searchBox {
  position: fixed;
  width: 35%;
  top: 10px;
  left: 31%;
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
.mytext{
  position: relative;
  font-family: 'myfont';
  color: white;
  left: 1%;
}
.postIcon {
  position: fixed;
  top: 10px;
  right: 23%;
  width: 0;
  height: 0;
  font-size: 18px;
  -webkit-perspective: 230px;
  perspective: 230px;
  border:none;
  box-shadow: none;
  background-color: rgb(32, 129, 181);
  cursor: pointer;
  font-family: 'myfont';
}
.postIcon span {
  background: rgb(0,172,238);
  background: linear-gradient(0deg, rgba(0,172,238,1) 0%, rgba(2,126,251,1) 100%);
  display: block;
  position: absolute;
  width: 130px;
  height: 40px;
  border-radius: 5px;
  margin:0;
  line-height: 40px;
  padding: auto 0;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  -webkit-transition: all .3s;
  transition: all .3s;
}
.postIcon span:nth-child(1) {
  -webkit-transform: rotateX(90deg);
  -moz-transform: rotateX(90deg);
  transform: rotateX(90deg);
  -webkit-transform-origin: 50% 50% -20px;
  -moz-transform-origin: 50% 50% -20px;
  transform-origin: 50% 50% -20px;
}
.postIcon span:nth-child(2) {
  -webkit-transform: rotateX(0deg);
  -moz-transform: rotateX(0deg);
  transform: rotateX(0deg);
  -webkit-transform-origin: 50% 50% -20px;
  -moz-transform-origin: 50% 50% -20px;
  transform-origin: 50% 50% -20px;
}
.postIcon:hover span:nth-child(1) {
  -webkit-transform: rotateX(0deg);
  -moz-transform: rotateX(0deg);
  transform: rotateX(0deg);
}
.postIcon:hover span:nth-child(2) {
  color: transparent;
  -webkit-transform: rotateX(-90deg);
  -moz-transform: rotateX(-90deg);
  transform: rotateX(-90deg);
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
.fontClass {
  font-family: 'myfont2';
  width: 100px;
  height: 40px;
  color: #fff;
  border-radius: 5px;
  padding: 10px 25px;
  font-weight: 500;
  background: transparent;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  display: inline-block;
  box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5),
  7px 7px 20px 0px rgba(0,0,0,.1),
  4px 4px 5px 0px rgba(0,0,0,.1);
  outline: none;
}
.btn-1 {
  background: rgb(0,172,238);
  background: linear-gradient(0deg, rgba(0,172,238,1) 0%, rgba(2,126,251,1) 100%);
  line-height: 42px;
  padding: 0;
  border: none;
}
.btn-1 span {
  position: relative;
  display: block;
  width: 100%;
  height: 100%;
}
.btn-1:before,
.btn-1:after {
  position: absolute;
  content: "";
  right: 0;
  top: 0;
  background: rgba(2,126,251,1);
  transition: all 0.3s ease;
}
.btn-1:before {
  height: 0%;
  width: 2px;
}
.btn-1:after {
  width: 0%;
  height: 2px;
}
.btn-1:hover{
  background: transparent;
  box-shadow: none;
}
.btn-1:hover:before {
  height: 100%;
}
.btn-1:hover:after {
  width: 100%;
}
.btn-1 span:hover{
  color: rgba(2,126,251,1);
}
.btn-1 span:before,
.btn-1 span:after {
  position: absolute;
  content: "";
  left: 0;
  bottom: 0;
  background: rgba(2,126,251,1);
  transition: all 0.3s ease;
}
.btn-1 span:before {
  width: 2px;
  height: 0%;
}
.btn-1 span:after {
  width: 0%;
  height: 2px;
}
.btn-1 span:hover:before {
  height: 100%;
}
.btn-1 span:hover:after {
  width: 100%;
}
.btn-2 {
  background: rgb(247,150,192);
  background: radial-gradient(circle, rgba(247,150,192,1) 0%, rgba(118,174,241,1) 100%);
  line-height: 42px;
  padding: 0;
  border: none;
}
.btn-2 span {
  position: relative;
  display: block;
  width: 100%;
  height: 100%;
}
.btn-2:before,
.btn-2:after {
  position: absolute;
  content: "";
  height: 0%;
  width: 1px;
  box-shadow:
  -1px -1px 20px 0px rgba(255,255,255,1),
  -4px -4px 5px 0px rgba(255,255,255,1),
  7px 7px 20px 0px rgba(0,0,0,.4),
  4px 4px 5px 0px rgba(0,0,0,.3);
}
.btn-2:before {
  right: 0;
  top: 0;
  transition: all 500ms ease;
}
.btn-2:after {
  left: 0;
  bottom: 0;
  transition: all 500ms ease;
}
.btn-2:hover{
  background: transparent;
  color: #76aef1;
  box-shadow: none;
}
.btn-2:hover:before {
  transition: all 500ms ease;
  height: 100%;
}
.btn-2:hover:after {
  transition: all 500ms ease;
  height: 100%;
}
.btn-2 span:before,
.btn-2 span:after {
  position: absolute;
  content: "";
  box-shadow:
  -1px -1px 20px 0px rgba(255,255,255,1),
  -4px -4px 5px 0px rgba(255,255,255,1),
  7px 7px 20px 0px rgba(0,0,0,.4),
  4px 4px 5px 0px rgba(0,0,0,.3);
}
.btn-2 span:before {
  left: 0;
  top: 0;
  width: 0%;
  height: .5px;
  transition: all 500ms ease;
}
.btn-2 span:after {
  right: 0;
  bottom: 0;
  width: 0%;
  height: .5px;
  transition: all 500ms ease;
}
.btn-2 span:hover:before {
  width: 100%;
}
.btn-2 span:hover:after {
  width: 100%;
}
.btn-3 {
  line-height: 42px;
  padding: 0;
  border: none;
  background: rgb(255,27,0);
  background: linear-gradient(0deg, rgba(255,27,0,1) 0%, rgba(251,75,2,1) 100%);
}
.btn-3:hover {
  color: #f0094a;
  background: transparent;
  box-shadow:none;
}
.btn-3:before,
.btn-3:after{
  content:'';
  position:absolute;
  top:0;
  right:0;
  height:2px;
  width:0;
  background: #f0094a;
  box-shadow:
  -1px -1px 5px 0px #fff,
  7px 7px 20px 0px #0003,
  4px 4px 5px 0px #0002;
  transition:400ms ease all;
}
.btn-3:after{
  right:inherit;
  top:inherit;
  left:0;
  bottom:0;
}
.btn-3:hover:before,
.btn-3:hover:after{
  width:100%;
  transition:800ms ease all;
}
.btn-4 {
  background: rgb(22,9,240);
  background: linear-gradient(0deg, rgba(22,9,240,1) 0%, rgba(49,110,244,1) 100%);
  color: #fff;
  border: none;
  transition: all 0.3s ease;
  overflow: hidden;
}
.btn-4:after {
  position: absolute;
  content: " ";
  top: 0;
  left: 0;
  z-index: -1;
  width: 100%;
  height: 100%;
  transition: all 0.3s ease;
  -webkit-transform: scale(.1);
  transform: scale(.1);
}
.btn-4:hover {
  color: #fff;
  border: none;
  background: transparent;
}
.btn-4:hover:after {
  background: rgb(0,3,255);
  background: linear-gradient(0deg, rgba(2,126,251,1) 0%,  rgba(0,3,255,1)100%);
  -webkit-transform: scale(1);
  transform: scale(1);
}
.btn-5 {
  border: none;
  transition: all 0.3s ease;
  overflow: hidden;
  padding: 0;
}
.btn-5:after {
  position: absolute;
  content: " ";
  z-index: -1;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: #1fd1f9;
  background-image: linear-gradient(315deg, #1fd1f9 0%, #b621fe 74%);
  transition: all 0.3s ease;
}
.btn-5:hover {
  background: transparent;
  box-shadow:  4px 4px 6px 0 rgba(255,255,255,.5),
  -4px -4px 6px 0 rgba(116, 125, 136, .2),
  inset -4px -4px 6px 0 rgba(255,255,255,.5),
  inset 4px 4px 6px 0 rgba(116, 125, 136, .3);
  color: #fff;
}
.btn-5:hover:after {
  -webkit-transform: scale(2) rotate(180deg);
  transform: scale(2) rotate(180deg);
  box-shadow:  4px 4px 6px 0 rgba(255,255,255,.5),
  -4px -4px 6px 0 rgba(116, 125, 136, .2),
  inset -4px -4px 6px 0 rgba(255,255,255,.5),
  inset 4px 4px 6px 0 rgba(116, 125, 136, .3);
}
.btn-6 {
  border: none;
  background: rgb(251,33,117);
  background: linear-gradient(0deg, rgba(251,33,117,1) 0%, rgba(234,76,137,1) 100%);
  color: #fff;
  overflow: hidden;
}
.btn-6:hover {
  text-decoration: none;
  color: #fff;
}
.btn-6:before {
  position: absolute;
  content: '';
  display: inline-block;
  top: -180px;
  left: 0;
  width: 30px;
  height: 100%;
  background-color: #fff;
  animation: shiny-btn1 3s ease-in-out infinite;
}
.btn-6:hover{
  opacity: 0.7;
}
.btn-6:active{
  box-shadow:  4px 4px 6px 0 rgba(255,255,255,.3),
  -4px -4px 6px 0 rgba(116, 125, 136, .2),
  inset -4px -4px 6px 0 rgba(255,255,255,.2),
  inset 4px 4px 6px 0 rgba(0, 0, 0, .2);
}
@-webkit-keyframes shiny-btn1 {
  0% { -webkit-transform: scale(0) rotate(45deg); opacity: 0; }
  80% { -webkit-transform: scale(0) rotate(45deg); opacity: 0.5; }
  81% { -webkit-transform: scale(4) rotate(45deg); opacity: 1; }
  100% { -webkit-transform: scale(50) rotate(45deg); opacity: 0; }
}
.blog {
  border-bottom: 2px solid gray;
  border-top: 2px solid gray;
  border-left: 3px solid gray;
  border-right: 3px solid gray;
  border-radius:30px;
  margin-left: 30px;
  padding: 0 50px;
  font-size: 20px;
  line-height: 30px;
}
.blog:hover {
  background-color: #eaeaead5;
}
.blog>h3:hover, .blog>p:hover {
  cursor: pointer;
  color: #2e60c4;
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
  background-color: #e6e6e6;
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
  width: 100px;
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
  background-color: #007ced;
  color: rgb(249, 245, 245);
  border-color: transparent;
  width: 100px;
  padding: 10px 0 !important;
  margin: 10px 15px;
}
.sub-partitions:hover {
  background-color: #2073b3;
}
.sub-partitions:first-child:hover {
  background-color: #095c9c;
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
.pop-up {
  background-image: linear-gradient(bottom, #F0E9D7 23%, #F5F1E5 62%);
  background-image: -o-linear-gradient(bottom, #F0E9D7 23%, #F5F1E5 62%);
  background-image: -moz-linear-gradient(bottom, #F0E9D7 23%, #F5F1E5 62%);
  background-image: -webkit-linear-gradient(bottom, #F0E9D7 23%, #F5F1E5 62%);
  background-image: -ms-linear-gradient(bottom, #F0E9D7 23%, #F5F1E5 62%);
  background-image: -webkit-gradient(linear, left bottom, left top,
  color-stop(0.33, #F0E9D7),
  color-stop(0.67, #F5F1E5));
  border-radius: 5px;
  -moz-border-radius: 5px;
  /*  height: 155px;*/
  margin: 0px;
  border-top: 1px solid white;
  border-bottom: 1px solid #f5f1e4;
  box-shadow: 0px 1px 2px rgba(100,0,0,0.10),
        0px -1px 2px rgba(100,0,0,0.10);
  -webkit-box-shadow: 0px 1px 2px rgba(100,0,0,0.10),
            0px -1px 2px rgba(100,0,0,0.10);
  padding-left: 25px;
  padding-right: 25px;
  padding-top: 35px;
  padding-bottom: 25px;
  margin-bottom: 0px;
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
