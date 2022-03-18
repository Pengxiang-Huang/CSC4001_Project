<template>
    <div>
        <el-menu default-active='1' class="el-menu-demo" mode="horizontal" @select="handleSelect" background-color="#545c64" text-color="#fff" active-text-color="#ffd04b" >
            <el-menu-item index="1" class="menu-item">Main</el-menu-item>
            <el-menu-item index="2" class="menu-item">Partitions</el-menu-item>
            <el-input v-model="input" placeholder="请输入内容" class="searchBox"></el-input>
            <el-button class="searchIcon" icon="el-icon-search" circle></el-button>
            <el-button class="postIcon" round>Post</el-button>
            <el-avatar class="userIcon" icon="el-icon-user-solid"></el-avatar>
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
                <el-tab-pane label="Concerned questions" name="second">concerned questions</el-tab-pane>
                <el-tab-pane label="Concerned partitions" name="third">concerned partitions</el-tab-pane>
                <el-tab-pane label="Excellent answers" name="fourth">excellent answers</el-tab-pane>
            </el-tabs>
        </div>
        <div v-if="index === 'Partitions'" id="tab">
            <div id="leftBox"></div>
            <div id="rightBox"></div>
        </div>
    </div>
</template>

<script>
export default {
  data () {
    return {
      input: '',
      index: 'Main',
      activeName: 'first'
    }
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
    }
  }
}
</script>

<style scoped>
  #leftBox{
      position: fixed;
      width: 20%;
      height: 100%;
      left: 0;
      background-color: #bfbfbf;
  }
  #rightBox{
      position: fixed;
      width: 20%;
      height: 100%;
      left: 80%;
      background-color: #bfbfbf;
  }
  .menu-item{
      margin-left: 50px;
  }
  .searchBox{
    position: fixed;
    width: 400px;
    top: 10px;
    left: 410px;
  }
  .searchIcon{
    position: fixed;
    top: 10px;
    left: 830px;
  }
  .postIcon{
    position: fixed;
    top: 10px;
    left: 900px;
    width: 100px;
    height: 40px;
    font-size: 18px;
  }
  .userIcon{
    position: fixed;
    top: 10px;
    left: 1280px;
  }
  .userIcon:hover{
    cursor: pointer;
  }
  #tab{
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
</style>
