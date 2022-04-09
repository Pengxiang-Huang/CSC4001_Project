<template>
  <div id="app">
    <div class="context">
        <h1>Post Your Blog Here</h1>
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
    <div class="codearea">
      <div class="language-js">
      <span class="copy-btn">Run</span>
      <prism-editor class="my-editor height-300" v-model="code" :lineNumbers=true :highlight="highlighter"></prism-editor>
      </div>
    </div>
    <!-- <pre class="line-numbers" ><code class="language-xml line-numbers" v-text="html"></code></pre> -->
    <!-- <prism-editor class="my-editor height-300" v-model="code" :lineNumbers=true :highlight="highlighter"></prism-editor> -->
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
export default {
  components: {
    PrismEditor
  },
  data: () => ({
    code: 'printf("Hello World")\n\n',
    lineNumbers: true
  }),
  mounted () {
    Prism.highlightAll()
  },
  methods: {
    highlighter (code) {
      return highlight(code, languages.cpp)
    }
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
  border-left: 10px solid #d5dfe5;
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
#app {
  font-family: 'Exo', sans-serif;
  min-height: 450px;
  height: 150vh;
  text-align: center;
  overflow-x: hidden;
}
.codearea{
  position: absolute;
  top: 20rem;
  width: 100%;
  margin-left: auto;
}
div[class^="language-"] {
position: relative;
background: #282c34;
padding: 1.25rem 1.5rem;
margin: 0.85rem auto;
border-radius: 16px;
max-width: 40rem;
}
div[class$="js"]::before {
content: "cpp";
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
.area{
    background: #4e54c8;
    background: -webkit-linear-gradient(to left, #8f94fb, #4e54c8);
    width: 100%;
    height:100%;
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
</style>
