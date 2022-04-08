<template>
  <div id="app">
    <div class="stage">
      <div class="layer"></div>
      <div class="layer"></div>
      <div class="layer"></div>
      <div class="layer"></div>
      <div class="layer"></div>
      <div class="layer"></div>
      <div class="layer"></div>
      <div class="layer"></div>
      <div class="layer"></div>
      <div class="layer"></div>
      <div class="layer"></div>
      <div class="layer"></div>
      <div class="layer"></div>
      <div class="layer"></div>
      <div class="layer"></div>
      <div class="layer"></div>
      <div class="layer"></div>
      <div class="layer"></div>
      <div class="layer"></div>
      <div class="layer"></div>
    </div>
    <div class="codearea">
      <div class="language-js">
      <span class="copy-btn">复制</span>
      <prism-editor class="my-editor height-300" v-model="code" :lineNumbers=true :highlight="highlighter"></prism-editor>
      <div class="copy-tooltip">
        点击复制
      </div>
    </div>
    <div class="copy-success">
      <span class="right">&radic;</span>
      复制成功!
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
@import url("//fonts.googleapis.com/css?family=Pacifico&text=Pure");
@import url("//fonts.googleapis.com/css?family=Roboto:700&text=css");
@import url("//fonts.googleapis.com/css?family=Kaushan+Script&text=!");
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
  min-height: 450px;
  height: 150vh;
  margin: 0;
  background: radial-gradient(circle, #0077ea, #1f4f96, #1b2949, #000);
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
font-size: 0.75rem;
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
/*code area end*/
/*copy tooltip start*/
div.copy-tooltip {
opacity: 0;
position: absolute;
top: 2.5rem;
right: 0.5rem;
background: #bdbdbd;
padding: 0.5rem;
border-radius: 4px;
font-size: 0.8rem;
color: #333;
box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.3);
}
div.copy-tooltip::before {
content: "";
width: 0;
height: 0;
border: 0.5rem solid transparent;
border-bottom-color: #bdbdbd;
position: absolute;
top: -1rem;
left: 50%;
transition: opacity 1s ease-in-out;
}

/*copy tooltip end*/
/*copy success modal*/
.copy-success {
opacity: 0;
font-size: 1.2rem;
letter-spacing: 5px;
background: #27c93f;
color: white;
width: 20rem;
height: 6rem;
line-height: 6rem;
border-radius: 1rem;
text-align: center;
box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.3);
/*动画:借鉴Animate.css */
-webkit-animation-duration: 1s;
animation-duration: 1s;
-webkit-animation-fill-mode: both;
animation-fill-mode: both;
/*居中定位*/
position: fixed;
top: -20%;
left: 0;
bottom: 0;
right: 0;
margin: auto;
}
.copy-success .right {
border-radius: 50%;
border: 2px solid whitesmoke;
font-size: 1.5rem;
font-weight: 700;
width: 1.8rem;
height: 1.8rem;
line-height: 1.8rem;
text-align: center;
display: inline-block;
}
/*动画*/
@keyframes jackInTheBox {
from {
  opacity: 0;
  -webkit-transform: scale(0.1) rotate(30deg);
  transform: scale(0.1) rotate(30deg);
  -webkit-transform-origin: center bottom;
  transform-origin: center bottom;
}

50% {
  -webkit-transform: rotate(-10deg);
  transform: rotate(-10deg);
}

70% {
  -webkit-transform: rotate(3deg);
  transform: rotate(3deg);
}

to {
  opacity: 1;
  -webkit-transform: scale(1);
  transform: scale(1);
}
}
/*动画*/
.jackInTheBox {
  -webkit-animation-name: jackInTheBox;
  animation-name: jackInTheBox;
}

.stage {
  height: 300px;
  width: 500px;
  margin-top: 50px;
  margin-left: 250px ;
  position: absolute;
  top: 0px;
  right: 0px;
  bottom: 0;
  left: 0px;
  perspective: 9999px;
  transform-style: preserve-3d;
}

.layer {
  width: 100%;
  height: 100%;
  position: absolute;
  transform-style: preserve-3d;
  animation: ಠ_ಠ 7s infinite alternate ease-in-out -7.5s;
  animation-fill-mode: forwards;
  transform: rotateY(40deg) rotateX(33deg) translateZ(0);
}

.layer:after {
  font: 50px/0.65 "Pacifico", "Kaushan Script", Futura, "Roboto", "Trebuchet MS", Helvetica, sans-serif;
  content: "Post\a    here!";
  white-space: pre;
  text-align: center;
  height: 100%;
  width: 100%;
  position: absolute;
  top: 50px;
  color: whitesmoke;
  letter-spacing: -2px;
  text-shadow: 4px 0 10px rgba(0, 0, 0, 0.13);
}

.layer:nth-child(1):after {
  transform: translateZ(0px);
}

.layer:nth-child(2):after {
  transform: translateZ(-1.5px);
}

.layer:nth-child(3):after {
  transform: translateZ(-3px);
}

.layer:nth-child(4):after {
  transform: translateZ(-4.5px);
}

.layer:nth-child(5):after {
  transform: translateZ(-6px);
}

.layer:nth-child(6):after {
  transform: translateZ(-7.5px);
}

.layer:nth-child(7):after {
  transform: translateZ(-9px);
}

.layer:nth-child(8):after {
  transform: translateZ(-10.5px);
}

.layer:nth-child(9):after {
  transform: translateZ(-12px);
}

.layer:nth-child(10):after {
  transform: translateZ(-13.5px);
}

.layer:nth-child(11):after {
  transform: translateZ(-15px);
}

.layer:nth-child(12):after {
  transform: translateZ(-16.5px);
}

.layer:nth-child(13):after {
  transform: translateZ(-18px);
}

.layer:nth-child(14):after {
  transform: translateZ(-19.5px);
}

.layer:nth-child(15):after {
  transform: translateZ(-21px);
}

.layer:nth-child(16):after {
  transform: translateZ(-22.5px);
}

.layer:nth-child(17):after {
  transform: translateZ(-24px);
}

.layer:nth-child(18):after {
  transform: translateZ(-25.5px);
}

.layer:nth-child(19):after {
  transform: translateZ(-27px);
}

.layer:nth-child(20):after {
  transform: translateZ(-28.5px);
}

.layer:nth-child(n+10):after {
  -webkit-text-stroke: 3px rgba(0, 0, 0, 0.25);
}

.layer:nth-child(n+11):after {
  -webkit-text-stroke: 15px dodgerblue;
  text-shadow: 6px 0 6px #00366b, 5px 5px 5px #002951, 0 6px 6px #00366b;
}

.layer:nth-child(n+12):after {
  -webkit-text-stroke: 15px #0077ea;
}

.layer:last-child:after {
  -webkit-text-stroke: 17px rgba(0, 0, 0, 0.1);
}

.layer:first-child:after {
  color: #fff;
  text-shadow: none;
}

.codearea{
  width: 100%;
  height: 100%;
  position: absolute;
  top: 300px;
  left: 0;
}

@keyframes ಠ_ಠ {
  100% {
    transform: rotateY(-40deg) rotateX(-43deg);
  }
}
</style>
