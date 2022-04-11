<template>
  <div id="app">
    <div class="context">
        <!-- <h1>Post Your Blog Here</h1> -->
        <div class="wrapper">
          <div class="typing-demo">
            Encode Your Blog Here.
          </div>
        </div>
    </div>
    <div class="area" >
      <ul class="circles">
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
      </ul>
    </div >
    <div class="editarea">
      <div class="text-area">
        <div class="textcode">
          <froala :tag="'textarea'" :config="config" v-model="model" class="mytexteditor height-400"></froala>
        </div>
      </div>
      <div class="select-area">
        <el-dropdown @command="SelectPartition">
          <span style="color: white;">
                {{ partition }}<i class="el-icon-arrow-down el-icon--right"></i>
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item command="CSC4001">CSC4001</el-dropdown-item>
            <el-dropdown-item command="CSC3050">CSC3050</el-dropdown-item>
            <el-dropdown-item command="partition3">Partition 3</el-dropdown-item>
            <el-dropdown-item command="partition4">Partition 4</el-dropdown-item>
            <el-dropdown-item command="partition5">Partition 5</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
      <div class="subselect-area">
        <el-dropdown @command="SubSelectPartition">
          <span style="color: white;">
                {{ subpartition }}<i class="el-icon-arrow-down el-icon--right"></i>
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item command="Proejct">Project</el-dropdown-item>
            <el-dropdown-item command="Homework">Homeworkd</el-dropdown-item>
            <el-dropdown-item command="partition3">Partition 3</el-dropdown-item>
            <el-dropdown-item command="partition4">Partition 4</el-dropdown-item>
            <el-dropdown-item command="partition5">Partition 5</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </div>
    <div class="codearea">
      <div class="language-js">
      <el-dropdown @command="SelectLanguage" class="dropdown">
        <span style="color: white;">
              {{ Language }}<i class="el-icon-arrow-down el-icon--right"></i>
        </span>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item command="cpp">cpp</el-dropdown-item>
          <el-dropdown-item command="c">c</el-dropdown-item>
          <el-dropdown-item command="java">java</el-dropdown-item>
          <el-dropdown-item command="python">python</el-dropdown-item>
          <el-dropdown-item command="html">html</el-dropdown-item>
          <el-dropdown-item command="css">css</el-dropdown-item>
          <el-dropdown-item command="javascript">javascript</el-dropdown-item>
          <el-dropdown-item command="markdown">markdown</el-dropdown-item>
          <el-dropdown-item command="bash">bash</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
      <span class="copy-btn" @click="runcode">Run</span>
      <prism-editor class="my-editor height-300" v-model="code" :lineNumbers=true :highlight="highlighter"></prism-editor>
      </div>
      <div class="result-area"></div>
    </div>

    <div class="sendbtn">
      <button class="btn">POST</button>
    </div>
    <!-- <pre class="line-numbers" ><code class="language-xml line-numbers" v-text="html"></code></pre> -->
  </div>
</template>

<script>
import { PrismEditor } from 'vue-prism-editor'
import Prism from 'prismjs'
import 'vue-prism-editor/dist/prismeditor.min.css'
import { highlight, languages } from 'prismjs/components/prism-core'
import 'prismjs/components/prism-clike'
import 'prismjs/components/prism-javascript'
import 'prismjs/themes/prism-okaidia.css'
import editor from '@/components/editor.vue'
import VueUeditorWrap from 'vue-ueditor-wrap'
import VueFroala from 'vue-froala-wysiwyg'

export default {
  components: {
    PrismEditor,
    editor,
    VueUeditorWrap,
    VueFroala
  },
  data: () => ({
    code: '#! /bin/bash \n# You can write and test your code here\necho "hello world"',
    lineNumbers: true,
    Language: 'bash',
    content: 'dsa',
    partition: 'partition',
    subpartition: 'subpartition',
    html: '<text></text>',
    config: {
      heightMax: 330,
      heightMin: 330,
      placeholderText: 'Type your blog...'
    }
  }),
  mounted () {
    Prism.highlightAll()
  },
  methods: {
    highlighter (code) {
      var lang = this.Language
      if (lang === 'cpp') {
        return highlight(code, languages.cpp)
      } else if (lang === 'c') {
        return highlight(code, languages.c)
      } else if (lang === 'java') {
        return highlight(code, languages.java)
      } else if (lang === 'python') {
        return highlight(code, languages.python)
      } else if (lang === 'html') {
        return highlight(code, languages.html)
      } else if (lang === 'css') {
        return highlight(code, languages.css)
      } else if (lang === 'javascript') {
        return highlight(code, languages.javascript)
      } else if (lang === 'markdown') {
        return highlight(code, languages.markdown)
      } else {
        return highlight(code, languages.bash)
      }
    },
    SelectLanguage (command) {
      this.Language = command
      console.log(this.Language)
    },
    SelectPartition (command) {
      this.partition = command
      console.log(this.partition)
    },
    SubSelectPartition (command) {
      this.subpartition = command
      console.log(this.subpartition)
    },
    runcode () {
      console.log(this.code)
      console.log(this.Language)
    },
    onEditorBlur () {
      console.log('onEditorBlur')
    },
    onEditorFocus () {},
    onEditorChange () {}
  }
}
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css?family=Exo:400,700');
*{
    margin: 0px;
    padding: 0px;
}
.my-editor {
  margin-top: 30px;
  background-color: #201919;
  color: #ccc;
  border-left: 10px solid #656c70;
  font-family: Fira code, Fira Mono, Consolas, Menlo,Courier, monospace;
  font-size: 14px;
  line-height: 1.5;
  padding: 5px;
}
.prism-editor__textarea:focus {
 outline: none;
}
.height-300{
  height: 300px;
}
/*background: -webkit-linear-gradient(to left, #8f94fb, #4e54c8);*/
#app {
 background: linear-gradient(253deg, #0cc898, #1797d2, #864fe1);  font-family: 'Exo', sans-serif;
  min-height: 450px;
  height: 180vh;
  text-align: center;
  overflow-x: hidden;
}
.codearea{
  position: absolute;
  top: 45rem;
  width: 100%;
  margin-left: auto;
}
.editarea{
  position: absolute;
  top: 10rem;
  width: 100%;
  margin-left: auto;
}
div[class^="language-"] {
position: relative;
width: 100%;
background: #282c34;
padding: 1.25rem 1.5rem;
margin: 0.85rem auto;
border-radius: 16px;
max-width: 40rem;
}
div[class$="js"]::before {
display: block;
position: absolute;
top: 1rem;
left: 4.5rem;
font-size: 0.75rem;
color: rgba(255, 255, 255, 0.4);
}
div[class^="language"]::after {
position: absolute;
top: 1rem;
left: 1rem;
content: "";
width: 11px;
height: 11px;
border-radius: 50%;
background-color: #ff5f56;
/*后面两个小圆点 */
-webkit-box-shadow: 18px 0 0 0 #ffbd2e, 36px 0 0 0 #27c93f;
box-shadow: 18px 0 0 0 #ffbd2e, 36px 0 0 0 #27c93f;
}
span.copy-btn {
position: absolute;
z-index: 3;
top: 1rem;
right: 1rem;
font-size: 1rem;
cursor: pointer;
color: rgba(255, 255, 255, 0.4);
}
span.copy-btn:hover {
color: rgba(255, 255, 255, 0.6);
}
div.copy-code {
width: 100%;
background: #282c34;
margin-top: 1.5rem;
border: none;
outline: none;
font-size: 1rem;
line-height: 1.5;
font-weight: normal;
color: rgba(255, 255, 255, 0.6);
}
/*Background begin here*/
.context {
    width: 100%;
    position: absolute;
    top:3vh;
}

.context h1{
    text-align: center;
    color: #fff;
    font-size: 50px;
}
.circles{
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
}

.circles li{
    position: absolute;
    display: block;
    list-style: none;
    width: 20px;
    height: 20px;
    background: rgba(255, 255, 255, 0.2);
    animation: animate 25s linear infinite;
    bottom: -250px;
}

.circles li:nth-child(1){
    left: 25%;
    width: 80px;
    height: 80px;
    animation-delay: 0s;
}

.circles li:nth-child(2){
    left: 10%;
    width: 20px;
    height: 20px;
    animation-delay: 2s;
    animation-duration: 12s;
}

.circles li:nth-child(3){
    left: 70%;
    width: 20px;
    height: 20px;
    animation-delay: 4s;
}

.circles li:nth-child(4){
    left: 40%;
    width: 60px;
    height: 60px;
    animation-delay: 0s;
    animation-duration: 18s;
}

.circles li:nth-child(5){
    left: 65%;
    width: 20px;
    height: 20px;
    animation-delay: 0s;
}

.circles li:nth-child(6){
    left: 75%;
    width: 110px;
    height: 110px;
    animation-delay: 3s;
}

.circles li:nth-child(7){
    left: 35%;
    width: 150px;
    height: 150px;
    animation-delay: 7s;
}

.circles li:nth-child(8){
    left: 50%;
    width: 25px;
    height: 25px;
    animation-delay: 15s;
    animation-duration: 45s;
}
.circles li:nth-child(9){
    left: 20%;
    width: 15px;
    height: 15px;
    animation-delay: 2s;
    animation-duration: 35s;
}
.circles li:nth-child(10){
    left: 85%;
    width: 150px;
    height: 150px;
    animation-delay: 0s;
    animation-duration: 11s;
}
@keyframes animate {
  0%{
      transform: translateY(0) rotate(0deg);
      opacity: 1;
      border-radius: 0;
  }
  100%{
      transform: translateY(-1000px) rotate(720deg);
      opacity: 0;
      border-radius: 50%;
  }
}
.dropdown{
  font-family: Menlo;
  display: block;
  position: absolute;
  top: 1rem;
  left: 4.5rem;
  font-size: 0.75rem;
  color: #ccc;
}
div[class^="text-"] {
position: relative;
background: #dee1e6;
padding: 2rem 1.5rem;
margin: 0.85rem auto;
border-radius: 16px;
max-width: 80rem;
height: 25rem;
}
div[class$="area"]::before {
display: block;
position: absolute;
top: 1rem;
left: 4.5rem;
font-size: 0.75rem;
color: rgba(255, 255, 255, 0.4);
}
div[class^="text"]::after {
position: absolute;
top: 1rem;
left: 1rem;
content: "";
width: 11px;
height: 11px;
border-radius: 50%;
background-color: #ff5f56;
/*后面两个小圆点 */
-webkit-box-shadow: 18px 0 0 0 #ffbd2e, 36px 0 0 0 #27c93f;
box-shadow: 18px 0 0 0 #ffbd2e, 36px 0 0 0 #27c93f;
}
.textcode{
  height: 20rem;
}
.fr-toolbar .fr-command.fr-btn{
  width: auto !important;
}
.fr-toolbar .fr-command.fr-btn i{
  width: auto !important;
}
.wrapper {
  /*This part is important for centering*/
  display: flex;
  align-items: center;
  justify-content: center;
}

.typing-demo {
  width: 22ch;
  animation: typing 3s steps(22), blink .5s step-end infinite alternate;
  white-space: nowrap;
  overflow: hidden;
  border-right: 3px solid;
  font-family: Courier;
  font-size: 50px;;
  color: white;
}
@keyframes typing {
  from {
    width: 0
  }
}
@keyframes blink {
  50% {
    border-color: transparent
  }
}
.sendbtn {
  height: 190%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.btn {
  width: 140px;
  height: 45px;
  font-family: 'Roboto', sans-serif;
  font-size: 11px;
  text-transform: uppercase;
  letter-spacing: 2.5px;
  font-weight: 500;
  color: #000;
  background-color: #fff;
  border: none;
  border-radius: 45px;
  box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease 0s;
  cursor: pointer;
}

.btn:hover {
  background-color: #227aff;
  box-shadow: 0px 15px 20px rgba(0, 91, 119, 0.73);
  color: #fff;
  transform: translateY(-7px);
}

div[class^="result-"] {
position: relative;
background: #dee1e6;
padding: 2rem 1.5rem;
margin: 0.85rem auto;
border-radius: 16px;
max-width: 40rem;
height: 10rem;
}
div[class$="area"]::before {
display: block;
position: absolute;
top: 1rem;
left: 4.5rem;
font-size: 0.75rem;
color: rgba(255, 255, 255, 0.4);
}
div[class^="result"]::after {
position: absolute;
top: 1rem;
left: 1rem;
content: "";
width: 11px;
height: 11px;
border-radius: 50%;
background-color: #ff5f56;
/*后面两个小圆点 */
-webkit-box-shadow: 18px 0 0 0 #ffbd2e, 36px 0 0 0 #27c93f;
box-shadow: 18px 0 0 0 #ffbd2e, 36px 0 0 0 #27c93f;
}
</style>
