<template>
  <div id="body">
    <div class="profile-card">
      <header>
        <h1>Welcome to our community!</h1>
        <h2>created by CSC4001 group</h2>
      </header>
      <div class="profile-bio">
        <p>
          We have send your a confirmation email, please check you email box. You can also click below to see our source code.
        </p>
      </div>
      <div class="verify-box">
        <input type="text"
               placeholder="Verification Code"
               v-model="code"
               @keyup.enter="confirm"
               required>
      </div>
      <div class="confirm-box">
        <input @click="confirm"
               type="Submit"
               value="Confirm your account">
      </div>
      <div class="profile-social-links">
        <li>
          <a target="_blank"
             href="https://github.com/Demario-Huang/CSC4001_Project.git">
            <i class="fa fa-github"></i>
            <!-- <h1> Remember you need to run command 'npm i font-awesome -S' to intall the fa-github icon or you can not see it</h1> -->
          </a>
        </li>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
// import bus from '../assets/bus.js'
import router from '../router'
import Qs from 'qs'
export default {
  name: 'design',
  data () {
    return {
      code: '',
      correct_code: '',
      username: '',
      email: '',
      password: ''
    }
  },
  created () {
    this.correct_code = this.$route.query.code
    this.username = this.$route.query.username
    this.email = this.$route.query.email
    this.password = this.$route.query.password
  },
  methods: {
    confirm () {
      let senddata = {
        username: this.username,
        email: this.email,
        password: this.password
      }
      if (this.code !== this.correct_code) {
        this.$message.error('The Verification Code is wrong, please try again')
      } else {
        axios({
          method: 'post',
          url: 'http://175.178.34.84/api/verify',
          data: Qs.stringify(senddata)
        }).then(response => {
          sessionStorage.setItem('isLogin', true)
          this.$message.success(' Welcome to our community !')
          router.push({
            path: '/home/:username',
            name: 'home',
            params: {
              username: this.username
            }
          })
        }).catch(error => {
          this.$message.error('It seems like Something wrong here, please register again.')
          router.push('/register')
          console.log(error)
        })
      }
    }
  }
}
</script>

<style scoped>
@import url("http://175.178.34.84/fs/googleapi.css");
html {
  height: 100%;
}

#body {
  overflow: hidden;
  background: linear-gradient(-218deg, #206475 48%, #2f9aa8 75%);
  background-size: cover;
  position: fixed;
  padding: 0px;
  margin: 0px;
  width: 100%;
  height: 100%;
  font: normal 14px/1.618em "Poppins", sans-serif;
  -webkit-font-smoothing: antialiased;
  text-align: center;
}

#body:before {
  content: "";
  height: 0px;
  padding: 0px;
  border: 130em solid #6990bd;
  position: absolute;
  left: 50%;
  top: 100%;
  z-index: 2;
  display: block;
  -webkit-border-radius: 50%;
  border-radius: 50%;
  -webkit-transform: translate(-50%, -50%);
  transform: translate(-50%, -50%);
  -webkit-animation: puff 0.5s 1.8s cubic-bezier(0.55, 0.055, 0.675, 0.19)
      forwards,
    borderRadius 0.2s 2.3s linear forwards;
  animation: puff 0.5s 1.8s cubic-bezier(0.55, 0.055, 0.675, 0.19) forwards,
    borderRadius 0.2s 2.3s linear forwards;
}

h1,
h2 {
  font-weight: 500;
  margin: 0px 0px 5px 0px;
}

h1 {
  font-size: 24px;
}

h2 {
  font-size: 16px;
}

h5 {
  font-size: 10px;
}

p {
  margin: 0px;
}

.profile-card {
  background: #ffb300;
  width: 56px;
  height: 106vh;
  position: absolute;
  left: 50%;
  top: 50%;
  z-index: 2;
  overflow: hidden;
  opacity: 0;
  margin-top: 70px;
  -webkit-transform: translate(-50%, -50%);
  transform: translate(-50%, -50%);
  -webkit-border-radius: 50%;
  border-radius: 50%;
  -webkit-box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.16),
    0px 3px 6px rgba(0, 0, 0, 0.23);
  box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.16), 0px 3px 6px rgba(0, 0, 0, 0.23);
  -webkit-animation: init 0.5s 0.2s cubic-bezier(0.55, 0.055, 0.675, 0.19)
      forwards,
    moveDown 1s 0.8s cubic-bezier(0.6, -0.28, 0.735, 0.045) forwards,
    moveUp 1s 1.8s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards,
    materia 0.5s 2.7s cubic-bezier(0.86, 0, 0.07, 1) forwards;
  animation: init 0.5s 0.2s cubic-bezier(0.55, 0.055, 0.675, 0.19) forwards,
    moveDown 1s 0.8s cubic-bezier(0.6, -0.28, 0.735, 0.045) forwards,
    moveUp 1s 1.8s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards,
    materia 0.5s 2.7s cubic-bezier(0.86, 0, 0.07, 1) forwards;
}

.profile-card header {
  width: 179px;
  height: 180px;
  padding: 40px 20px 30px 20px;
  display: inline-block;
  border-right: 2px dashed #eeeeee;
  background: #ffffff;
  color: #000000;
  margin-top: 50px;
  opacity: 0;
  text-align: center;
  -webkit-animation: moveIn 1s 3.1s ease forwards;
  animation: moveIn 1s 3.1s ease forwards;
}

.profile-card header h1 {
  color: #ff5722;
}

.profile-card header a {
  display: inline-block;
  text-align: center;
  position: relative;
  margin: 25px 30px;
}

.profile-card header a:after {
  position: absolute;
  content: "";
  bottom: 3px;
  right: 3px;
  width: 20px;
  height: 20px;
  border: 4px solid #ffffff;
  -webkit-transform: scale(0);
  transform: scale(0);
  background: -webkit-linear-gradient(
    top,
    #2196f3 0%,
    #2196f3 50%,
    #ffc107 50%,
    #ffc107 100%
  );
  background: linear-gradient(
    #2196f3 0%,
    #2196f3 50%,
    #ffc107 50%,
    #ffc107 100%
  );
  -webkit-border-radius: 50%;
  border-radius: 50%;
  -webkit-box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.1);
  box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.1);
  -webkit-animation: scaleIn 0.3s 3.5s ease forwards;
  animation: scaleIn 0.3s 3.5s ease forwards;
}

.profile-card header a > img {
  width: 120px;
  max-width: 100%;
  -webkit-border-radius: 50%;
  border-radius: 50%;
  -webkit-transition: -webkit-box-shadow 0.3s ease;
  transition: box-shadow 0.3s ease;
  -webkit-box-shadow: 0px 0px 0px 8px rgba(0, 0, 0, 0.06);
  box-shadow: 0px 0px 0px 8px rgba(0, 0, 0, 0.06);
}

.profile-card header a:hover > img {
  -webkit-box-shadow: 0px 0px 0px 12px rgba(0, 0, 0, 0.1);
  box-shadow: 0px 0px 0px 12px rgba(0, 0, 0, 0.1);
}

.profile-card .profile-bio {
  width: 175px;
  height: 180px;
  display: inline-block;
  float: right;
  padding: 50px 20px 30px 20px;
  background: #ffffff;
  color: #333333;
  margin-top: 50px;
  text-align: center;
  opacity: 0;
  -webkit-animation: moveIn 1s 3.1s ease forwards;
  animation: moveIn 1s 3.1s ease forwards;
}

.profile-social-links {
  width: 218px;
  display: inline-block;
  float: right;
  margin: 0px;
  padding: 15px 20px;
  background: #ffffff;
  margin-top: 50px;
  text-align: center;
  opacity: 0;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  -webkit-animation: moveIn 1s 3.1s ease forwards;
  animation: moveIn 1s 3.1s ease forwards;
}

.profile-social-links li {
  list-style: none;
  margin: -5px 0px 0px 0px;
  padding: 0px;
  float: left;
  width: 95%;
  text-align: center;
}

.profile-social-links li a {
  display: inline-block;
  color: rgb(21, 20, 20);
  width: 24px;
  height: 24px;
  padding: 16px;
  position: relative;
  -webkit-border-radius: 50%;
  border-radius: 50%;
}

.profile-social-links li a i {
  position: relative;
  z-index: 1;
  font-size: 30px;
}

.profile-social-links li a img,
.profile-social-links li a svg {
  width: 24px;
}

@-webkit-keyframes init {
  0% {
    width: 0px;
    height: 0px;
  }
  100% {
    width: 56px;
    height: 56px;
    margin-top: 0px;
    opacity: 1;
  }
}

@keyframes init {
  0% {
    width: 0px;
    height: 0px;
  }
  100% {
    width: 56px;
    height: 56px;
    margin-top: 0px;
    opacity: 1;
  }
}

@-webkit-keyframes puff {
  0% {
    top: 100%;
    height: 0px;
    padding: 0px;
  }
  100% {
    top: 50%;
    height: 100%;
    padding: 0px 100%;
  }
}

@keyframes puff {
  0% {
    top: 100%;
    height: 0px;
    padding: 0px;
  }
  100% {
    top: 50%;
    height: 100%;
    padding: 0px 100%;
  }
}

@-webkit-keyframes borderRadius {
  0% {
    -webkit-border-radius: 50%;
  }
  100% {
    -webkit-border-radius: 0px;
  }
}

@keyframes borderRadius {
  0% {
    -webkit-border-radius: 50%;
  }
  100% {
    border-radius: 0px;
  }
}

@-webkit-keyframes moveDown {
  0% {
    top: 50%;
  }
  50% {
    top: 40%;
  }
  100% {
    top: 100%;
  }
}

@keyframes moveDown {
  0% {
    top: 50%;
  }
  50% {
    top: 40%;
  }
  100% {
    top: 100%;
  }
}

@-webkit-keyframes moveUp {
  0% {
    background: #ffb300;
    top: 100%;
  }
  50% {
    top: 40%;
  }
  100% {
    top: 50%;
    background: #e0e0e0;
  }
}

@keyframes moveUp {
  0% {
    background: #ffb300;
    top: 100%;
  }
  50% {
    top: 40%;
  }
  100% {
    top: 50%;
    background: #e0e0e0;
  }
}

@-webkit-keyframes materia {
  0% {
    background: #e0e0e0;
  }
  50% {
    -webkit-border-radius: 4px;
  }
  100% {
    width: 440px;
    height: 280px;
    background: #ffffff;
    -webkit-border-radius: 4px;
  }
}

@keyframes materia {
  0% {
    background: #e0e0e0;
  }
  50% {
    border-radius: 4px;
  }
  100% {
    width: 440px;
    height: 280px;
    background: #ffffff;
    border-radius: 4px;
  }
}

@-webkit-keyframes moveIn {
  0% {
    margin-top: 50px;
    opacity: 0;
  }
  100% {
    opacity: 1;
    margin-top: -20px;
  }
}

@keyframes moveIn {
  0% {
    margin-top: 50px;
    opacity: 0;
  }
  100% {
    opacity: 1;
    margin-top: -20px;
  }
}

@-webkit-keyframes scaleIn {
  0% {
    -webkit-transform: scale(0);
  }
  100% {
    -webkit-transform: scale(1);
  }
}

@keyframes scaleIn {
  0% {
    transform: scale(0);
  }
  100% {
    transform: scale(1);
  }
}

@-webkit-keyframes ripple {
  0% {
    transform: scale3d(0, 0, 0);
  }
  50%,
  100% {
    -webkit-transform: scale3d(1, 1, 1);
  }
  100% {
    opacity: 0;
  }
}

@keyframes ripple {
  0% {
    transform: scale3d(0, 0, 0);
  }
  50%,
  100% {
    transform: scale3d(1, 1, 1);
  }
  100% {
    opacity: 0;
  }
}

@media screen and (min-aspect-ratio: 4/3) {
  body {
    background-size: cover;
  }
  body:before {
    width: 0px;
  }
  @-webkit-keyframes puff {
    0% {
      top: 100%;
      width: 0px;
      padding-bottom: 0px;
    }
    100% {
      top: 50%;
      width: 100%;
      padding-bottom: 100%;
    }
  }
  @keyframes puff {
    0% {
      top: 100%;
      width: 0px;
      padding-bottom: 0px;
    }
    100% {
      top: 50%;
      width: 100%;
      padding-bottom: 100%;
    }
  }
}

@media screen and (min-height: 480px) {
  .profile-card header {
    width: auto;
    height: auto;
    padding: 30px 20px;
    display: block;
    float: none;
    border-right: none;
  }
  .profile-card .profile-bio {
    width: auto;
    height: auto;
    padding: 15px 20px 30px 20px;
    display: block;
    float: none;
  }
  .profile-social-links {
    width: 100%;
    display: block;
    float: none;
  }
  @-webkit-keyframes materia {
    0% {
      background: #e0e0e0;
    }
    50% {
      -webkit-border-radius: 4px;
    }
    100% {
      width: 280px;
      height: 440px;
      background: #ffffff;
      -webkit-border-radius: 4px;
    }
  }
  @keyframes materia {
    0% {
      background: #e0e0e0;
    }
    50% {
      border-radius: 4px;
    }
    100% {
      width: 280px;
      height: 440px;
      background: #ffffff;
      border-radius: 4px;
    }
  }
}
.verify-box input {
  height: 32px;
  margin: 18px 0;
  outline: none;
  padding: 5px 15px;
  font-size: 17px;
  font-weight: 400;
  color: #333;
  border: 1.5px solid #c7bebe;
  border-bottom-width: 2.5px;
  border-radius: 6px;
  transition: all 0.3s ease;
  display: inline-block;
}
.verifyt-box input:focus,
.verify-box input:valid {
  border-color: #6083e4;
}
.confirm-box input {
  font: "Poppins", sans-serif;
  font-style: italic;
  height: 40px;
  margin: 20px 0;
  color: rgb(34, 32, 32);
  letter-spacing: 1px;
  border: 1.5px solid #c7bebe;
  border-radius: 8px;
  background: linear-gradient(-218deg, #bfe7f3 50%, #a6dcf1 66%);
  cursor: pointer;
  display: inline-block;
}
.confirm-box input:hover {
  background: #4871e2;
}
</style>
