<template>
  <div id="app">
    <div class="context">
      <div class="wrapper">
        <div class="typing-demo">
          Post Your Blog Here ...
        </div>
      </div>
    </div>
    <div class="area">
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
    </div>
    <div class="title-input">
      <input type="text"
             v-model="title"
             id="input1"
             placeholder="Typing your tilte in here!">
      <label for="input1">Title:</label>
    </div>
    <div class="editarea">
      <div class="text-area">
        <div class="textcode">
          <froala :tag="'textarea'"
                  :config="config"
                  v-model="blogtext"
                  class="mytexteditor height-400"></froala>
        </div>
      </div>
    </div>
    <div class="codearea">
      <div class="language-js">
        <el-dropdown @command="SelectLanguage"
                     class="dropdowns">
          <span style="color: white;">
            {{ Language }}<i class="el-icon-arrow-down el-icon--right"></i>
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item command="C++">C++</el-dropdown-item>
            <el-dropdown-item command="C">C</el-dropdown-item>
            <el-dropdown-item command="Java">Java</el-dropdown-item>
            <el-dropdown-item command="Python">Python</el-dropdown-item>
            <el-dropdown-item command="Javascript">Javascript</el-dropdown-item>
            <el-dropdown-item command="Go">Go</el-dropdown-item>
            <el-dropdown-item command="Bash">Bash</el-dropdown-item>
            <el-dropdown-item command="Rust">Rust</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
        <span class="copy-btn"
              v-if="!isloading"
              @click="runcode">Run</span>
        <span class="copy-btn"
              v-else>
          <vue-mzc-loading title="Code Running..."> </vue-mzc-loading>
        </span>
        <prism-editor class="my-editor height-300"
                      v-model="code"
                      :lineNumbers=true
                      :highlight="highlighter"></prism-editor>
      </div>
      <div class="result-area">
        <pre class="line-numbers"><code class="language-xml line-numbers" v-text="codeResult"></code></pre>
      </div>
    </div>
    <div class="chose">
      <section class="containers">
        <div class="dropdown">
          <select v-model="partition"
                  name="one"
                  class="dropdown-select">
            <option value="">Partition</option>
            <option value="CSC4001">CSC4001</option>
            <option value="CSC3150">CSC3150</option>
            <option value="CSC4005">CSC4005</option>
            <option value="CSC1001">CSC1001</option>
            <option value="CSC1002">CSC1002</option>
            <option value="CSC3001">CSC3001</option>
            <option value="CSC3100">CSC3100</option>
            <option value="CSC3170">CSC3170</option>
            <option value="CSC4160">CSC4160</option>
            <option value="EIE2050">EIE2050</option>
            <option value="EIE3080">EIE3080</option>
          </select>
        </div>
        <div class="dropdown dropdown-dark">
          <select v-model="subpartition"
                  name="two"
                  class="dropdown-select">
            <option value="">Sub-Partition</option>
            <option value="Project">Project</option>
            <option value="Project1">Project1</option>
            <option value="Project2">Project2</option>
            <option value="Project3">Project3</option>
            <option value="Project4">Project4</option>
            <option value="Homework1">Homework1</option>
            <option value="Homework2">Homework2</option>
            <option value="Homework3">Homework3</option>
            <option value="Homework4">Homework4</option>
            <option value="Midterm">Midterm</option>
            <option value="Final">Final</option>
          </select>
        </div>
      </section>
    </div>
    <div class="sendbtn">
      <button class="btn"
              @click="submit">POST</button>
    </div>
    <div class="goback">
      <button class="btnback"
              @click="goback">Go back</button>
    </div>
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
import VueFroala from 'vue-froala-wysiwyg'
import VueMzcLoading from 'vue-mzc-loading'
import axios from 'axios'
import Qs from 'qs'
export default {
  components: {
    PrismEditor,
    editor,
    VueFroala,
    VueMzcLoading
  },
  data: () => ({
    code: '// include any code you want to here',
    lineNumbers: true,
    Language: 'C++',
    partition: '',
    subpartition: '',
    codeResult: '// code result will be shown here',
    isloading: false,
    blogtext: '',
    title: '',
    username: '',
    link: '',
    config: {
      heightMax: 330,
      heightMin: 330,
      placeholderText: 'Type your blog...',
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
    }
  }),
  created () {
    this.username = this.$route.params['username']
    this.config.fileUploadParams.username = this.username
  },
  mounted () {
    Prism.highlightAll()
    document.body.style = 'overflow: auto;'
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
    SelectLanguage (command) {
      this.Language = command
      console.log(this.Language)
    },
    runcode () {
      console.log(this.partition)
      this.isloading = true
      var langchose = this.Language
      var codechose = this.code
      let sendData = {
        lang: langchose,
        source_code: codechose
      }
      console.log(langchose)
      console.log(codechose)
      axios({
        method: 'post',
        url: 'http://175.178.34.84/api/RunCode',
        data: Qs.stringify(sendData)
      }).then((response) => {
        console.log(response.data.result)
        this.codeResult = response.data.result
        this.isloading = false
      }).catch((error) => {
        console.log(error)
      })
    },
    goback () {
      this.$router.go(-1)
    },
    submit () {
      // console.log(sessionStorage.getItem('link'))
      this.link = sessionStorage.getItem('link')
      if (this.title === '') {
        this.$message.error('Please conclude your title!')
      } else if (this.partition === '') {
        this.$message.error('Please choose your partition!')
      } else if (this.subpartition === '') {
        this.$message.error('Please chose your sub-partition!')
      } else if (this.blogtext === '') {
        this.$message.error('Please write your blog!')
      } else {
        var mysendcode = this.code
        if (mysendcode === '// include any code you want to here') {
          mysendcode = ''
        }
        let senddata = {
          title: this.title,
          group_type: this.partition,
          sub_group_type: this.subpartition,
          code: mysendcode,
          content: this.blogtext,
          author_name: this.username,
          lang: this.Language,
          files_url: this.link
        }
        axios({
          method: 'post',
          url: 'http://175.178.34.84/SetQuestion',
          data: Qs.stringify(senddata)
        }).then((response) => {
          if (response.data.ok === 0) {
            this.$message.error('can not found the corresponding subpartition, please try again!')
          } else {
            this.$message.success('Post Successfully!')
            this.$router.go(-1)
            console.log(response)
          }
        }).catch((error) => {
          this.$message.error('Post Failed, try again!')
          console.log(error)
        })
      }
    }
  }
}
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css?family=Exo:400,700");
* {
  margin: 0px;
  padding: 0px;
}
.my-editor {
  margin-top: 30px;
  background-color: #201919;
  color: #ccc;
  border-left: 10px solid #656c70;
  font-family: Fira code, Fira Mono, Consolas, Menlo, Courier, monospace;
  font-size: 14px;
  line-height: 1.5;
  padding: 5px;
}
.prism-editor__textarea:focus {
  outline: none;
}
.height-300 {
  height: 300px;
}
/*background: -webkit-linear-gradient(to left, #8f94fb, #4e54c8);*/
#app {
  background: linear-gradient(253deg,  #3b69cd, #71a1eb);
  font-family: "Exo", sans-serif;
  min-height: 450px;
  height: 180vh;
  text-align: center;
  overflow-x: hidden;
}
.codearea {
  position: absolute;
  top: 45rem;
  width: 100%;
  margin-left: auto;
}
.editarea {
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
  max-width: 45rem;
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
  left: 25%;
  width: 50%;
  position: absolute;
  top: 3vh;
}

.context h1 {
  text-align: center;
  color: #fff;
  font-size: 50px;
}
.circles {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}

.circles li {
  position: absolute;
  display: block;
  list-style: none;
  width: 20px;
  height: 20px;
  background: rgba(255, 255, 255, 0.2);
  animation: animate 25s linear infinite;
  bottom: -250px;
}

.circles li:nth-child(1) {
  left: 25%;
  width: 80px;
  height: 80px;
  animation-delay: 0s;
}

.circles li:nth-child(2) {
  left: 10%;
  width: 20px;
  height: 20px;
  animation-delay: 2s;
  animation-duration: 12s;
}

.circles li:nth-child(3) {
  left: 70%;
  width: 20px;
  height: 20px;
  animation-delay: 4s;
}

.circles li:nth-child(4) {
  left: 40%;
  width: 60px;
  height: 60px;
  animation-delay: 0s;
  animation-duration: 18s;
}

.circles li:nth-child(5) {
  left: 65%;
  width: 20px;
  height: 20px;
  animation-delay: 0s;
}

.circles li:nth-child(6) {
  left: 75%;
  width: 110px;
  height: 110px;
  animation-delay: 3s;
}

.circles li:nth-child(7) {
  left: 35%;
  width: 150px;
  height: 150px;
  animation-delay: 7s;
}

.circles li:nth-child(8) {
  left: 50%;
  width: 25px;
  height: 25px;
  animation-delay: 15s;
  animation-duration: 45s;
}
.circles li:nth-child(9) {
  left: 20%;
  width: 15px;
  height: 15px;
  animation-delay: 2s;
  animation-duration: 35s;
}
.circles li:nth-child(10) {
  left: 85%;
  width: 150px;
  height: 150px;
  animation-delay: 0s;
  animation-duration: 11s;
}
@keyframes animate {
  0% {
    transform: translateY(0) rotate(0deg);
    opacity: 1;
    border-radius: 0;
  }
  100% {
    transform: translateY(-1000px) rotate(720deg);
    opacity: 0;
    border-radius: 50%;
  }
}
.dropdowns {
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
  max-width: 60rem;
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
.textcode {
  height: 20rem;
}
.fr-toolbar .fr-command.fr-btn {
  width: auto !important;
}
.fr-toolbar .fr-command.fr-btn i {
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
  animation: typing 3s steps(22), blink 0.5s step-end infinite alternate;
  white-space: nowrap;
  overflow: hidden;
  border-right: 3px solid;
  font-family: 'myfont';
  font-size: 50px;
  color: white;
}
@keyframes typing {
  from {
    width: 0;
  }
}
@keyframes blink {
  50% {
    border-color: transparent;
  }
}
.sendbtn {
  position: absolute;
  height: 10rem;
  top: 160%;
  left: 45%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.btn {
  width: 140px;
  height: 45px;
  font-family: "Roboto", sans-serif;
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
  background: #282c34;
  padding: 2rem 1.5rem;
  margin: 0.85rem auto;
  border-radius: 16px;
  max-width: 45rem;
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
.containers {
  width: 400px;
  text-align: center;
}

.containers > .dropdown {
  margin: 0 20px;
  vertical-align: top;
}

.dropdown {
  display: inline-block;
  position: relative;
  overflow: hidden;
  height: 28px;
  width: 150px;
  background: #f2f2f2;
  border: 1px solid;
  border-color: white #f7f7f7 whitesmoke;
  border-radius: 3px;
  background-image: -webkit-linear-gradient(
    top,
    transparent,
    rgba(0, 0, 0, 0.06)
  );
  background-image: -moz-linear-gradient(top, transparent, rgba(0, 0, 0, 0.06));
  background-image: -o-linear-gradient(top, transparent, rgba(0, 0, 0, 0.06));
  background-image: linear-gradient(
    to bottom,
    transparent,
    rgba(0, 0, 0, 0.06)
  );
  -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.08);
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.08);
}

.dropdown:before,
.dropdown:after {
  content: "";
  position: absolute;
  z-index: 2;
  top: 9px;
  right: 10px;
  width: 0;
  height: 0;
  border: 4px dashed;
  border-color: #888888 transparent;
  pointer-events: none;
}

.dropdown:before {
  border-bottom-style: solid;
  border-top: none;
}

.dropdown:after {
  margin-top: 7px;
  border-top-style: solid;
  border-bottom: none;
}

.dropdown-select {
  position: relative;
  width: 130%;
  margin: 0;
  padding: 6px 8px 6px 10px;
  height: 28px;
  line-height: 14px;
  font-size: 12px;
  color: #62717a;
  text-shadow: 0 1px white;
  background: #f2f2f2; /* Fallback for IE 8 */
  background: rgba(
    0,
    0,
    0,
    0
  ) !important; /* "transparent" doesn't work with Opera */
  border: 0;
  border-radius: 0;
  -webkit-appearance: none;
}

.dropdown-select:focus {
  z-index: 3;
  width: 100%;
  color: #394349;
  outline: 2px solid #49aff2;
  outline: 2px solid -webkit-focus-ring-color;
  outline-offset: -2px;
}

.dropdown-select > option {
  margin: 3px;
  padding: 6px 8px;
  text-shadow: none;
  background: #f2f2f2;
  border-radius: 3px;
  cursor: pointer;
}

/* Fix for IE 8 putting the arrows behind the select element. */

.lt-ie9 .dropdown {
  z-index: 1;
}

.lt-ie9 .dropdown-select {
  z-index: -1;
}

.lt-ie9 .dropdown-select:focus {
  z-index: 3;
}

/* Dirty fix for Firefox adding padding where it shouldn't. */

@-moz-document url-prefix() {
  .dropdown-select {
    padding-left: 6px;
  }
}

.dropdown-dark {
  background: #444;
  border-color: #111111 #0a0a0a black;
  background-image: -webkit-linear-gradient(
    top,
    transparent,
    rgba(0, 0, 0, 0.4)
  );
  background-image: -moz-linear-gradient(top, transparent, rgba(0, 0, 0, 0.4));
  background-image: -o-linear-gradient(top, transparent, rgba(0, 0, 0, 0.4));
  background-image: linear-gradient(to bottom, transparent, rgba(0, 0, 0, 0.4));
  -webkit-box-shadow: inset 0 1px rgba(255, 255, 255, 0.1),
    0 1px 1px rgba(0, 0, 0, 0.2);
  box-shadow: inset 0 1px rgba(255, 255, 255, 0.1), 0 1px 1px rgba(0, 0, 0, 0.2);
}

.dropdown-dark:before {
  border-bottom-color: #aaa;
}

.dropdown-dark:after {
  border-top-color: #aaa;
}

.dropdown-dark .dropdown-select {
  color: #aaa;
  text-shadow: 0 1px black;
  background: #444; /* Fallback for IE 8 */
}

.dropdown-dark .dropdown-select:focus {
  color: #ccc;
}

.dropdown-dark .dropdown-select > option {
  background: #444;
  text-shadow: 0 1px rgba(0, 0, 0, 0.4);
}
.chose {
  position: absolute;
  top: 80%;
  left: 35%;
  margin: 0 auto;
  width: 400px;
  text-align: center;
}
.line-numbers {
  height: 140px;
}
.title-input {
  position: absolute;
  top: 8rem;
  left: 52%;
  width: 50%;
  transform: translate(-50%, -50%);
}
.title-input input {
  display: inline-block;
  left: 50%;
  width: 480px;
  height: 40px;
  box-sizing: border-box;
  outline: none;
  border: 1px solid lightgray;
  border-radius: 10px;
  padding: 10px 10px 10px 100px;
  font-family: "PingFang SC";
  font-size: 16px;
}
.title-input input + label {
  position: absolute;
  top: 0;
  left: 10%;
  bottom: 0;
  height: 40px;
  line-height: 40px;
  color: white;
  border-radius: 15px;
  padding: 0 50px;
  background: linear-gradient(253deg, #2eb8d3, #40afe2, #3b69cd);
}
.title-input input[type="text"]:focus + label {
  border-radius: 10px;
}
.goback {
  position: absolute;
  height: 10rem;
  top: 2%;
  left: 90%;
  display: flex;
  align-items: center;
  justify-content: center;
}
.btnback {
  width: 80px;
  height: 30px;
  font-family: "Roboto", sans-serif;
  font-size: 11px;
  text-transform: uppercase;
  letter-spacing: 2.5px;
  font-weight: 500;
  color: #000;
  background-color: rgb(113, 170, 223);
  border: none;
  border-radius: 45px;
  box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease 0s;
  cursor: pointer;
}

.btnback:hover {
  background-color: #1797ce;
  box-shadow: 0px 15px 20px rgba(56, 90, 163, 0.73);
  color: #fff;
  transform: translateY(-7px);
}
.fr-wrapper > div[style*="z-index: 9999"] {
  position: absolute;
  top: -10000px;
  opacity: 0;
  display: none;
}
</style>
