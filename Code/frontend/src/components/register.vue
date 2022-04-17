<template>
  <div id="app">
    <div class="wrapper">
      <h2>Registration</h2>
      <div class="formBox">
        <div class="input-box">
          <input type="text"
                 placeholder="Enter your username"
                 v-model="username"
                 @keyup.enter="submit"
                 required>
        </div>
        <div class="input-box">
          <input type="email"
                 placeholder="Enter your email"
                 v-model="email"
                 @keyup.enter="submit"
                 required>
        </div>
        <div class="input-box">
          <input type="password"
                 placeholder="Create password"
                 v-model="password1"
                 @keyup.enter="submit"
                 required>
        </div>
        <div class="input-box">
          <input type="password"
                 placeholder="Confirm password"
                 v-model="password2"
                 @keyup.enter="submit"
                 required>
        </div>
        <div class="policy">
          <input type="checkbox"
                 v-model="checkbox"
                 >
          <h3>I accept all terms & condition</h3>
        </div>
        <div class="input-box button">
          <input @click="submit"
                 type="Submit"
                 value="Register Now">
        </div>
        <div class="text">
          <h3>Already have an account? <router-link to="/">login in Now </router-link>
          </h3>
          <router-link to="/contact">contact us?</router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import Qs from 'qs'
import router from '../router'
// import bus from '../assets/bus.js'
export default {
  name: 'register',
  data () {
    return {
      username: '',
      email: '',
      password1: '',
      password2: '',
      checkbox: '',
      vari_code: ''
    }
  },
  methods: {
    submit () {
      var regExp = /[0-9]{9}@link\.cuhk\.edu\.cn/
      if (this.username === '') {
        this.$message.error('please input username')
      } else if (this.email === '' || !regExp.test(this.email)) {
        this.$message.error('please input the correct email')
      } else if (this.password1 === '') {
        this.$message.error('please set your password')
      } else if (this.password2 === '') {
        this.$message.error('please confirm your password')
      } else if (this.password1 !== this.password2) {
        this.$message.error('The passwords are not the same, please check it!')
      } else if (this.checkbox !== true) {
        this.$message.error('Please allow the condition to continue!')
      } else {
        let sendData = {
          username: this.username,
          email: this.email,
          password: this.password1
        }
        console.log(Qs.stringify(sendData))
        var url = 'http://175.178.34.84' + '/register/'
        axios({
          method: 'post',
          url: url,
          data: Qs.stringify(sendData)
        }).then((response) => {
          if (response.data.isRegister) {
            axios({
              method: 'post',
              url: 'http://175.178.34.84' + '/sendEmail/',
              data: Qs.stringify(sendData)
            }).then((response) => {
              this.veri_code = response.data.code
              router.push({
                path: '/design',
                query: {
                  username: this.username,
                  email: this.email,
                  password: this.password1,
                  code: this.veri_code
                }
              })
            })
          } else {
            this.$message.error('The username has been registered, please change another one!')
          }
        }).catch(error => {
          this.$message.error('It seems have some errors, please try it again')
          console.log(error)
        })
      }
    }
  }
}
</script>

<style scoped>
@import url("http://175.178.34.84/fs/googleapi.css");
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: "Poppins", sans-serif;
}
#app {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(-218deg, #206475 48%, #2f9aa8 75%);
  text-align: center;
}
.wrapper {
  position: relative;
  max-width: 430px;
  width: 100%;
  background: linear-gradient(-218deg, #3f92b3 70%, #abe7ff 92%);
  padding: 34px;
  border-radius: 6px;
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
  animation: box-login 3s;
}
@keyframes box-login {
  0% {
    transform: rotateX(100deg);
  }

  50%,
  100% {
    transform: rotateX(0deg);
  }
}
.wrapper h2 {
  position: relative;
  font-size: 22px;
  font-weight: 600;
  color: #333;
}
.wrapper h2::before {
  content: "";
  position: absolute;
  left: 0;
  bottom: 0;
  height: 3px;
  width: 28px;
  border-radius: 12px;
  background: #4070f4;
}
.wrapper .formBox {
  margin-top: 30px;
}
.wrapper .formBox .input-box {
  height: 52px;
  margin: 18px 0;
}
.formBox .input-box input {
  height: 100%;
  width: 100%;
  outline: none;
  padding: 0 15px;
  font-size: 17px;
  font-weight: 400;
  color: #333;
  border: 1.5px solid #c7bebe;
  border-bottom-width: 2.5px;
  border-radius: 6px;
  transition: all 0.3s ease;
  display: flex;
}
.input-box input:focus,
.input-box input:valid {
  border-color: #6083e4;
}
.formBox .policy {
  display: flex;
  align-items: center;
}
.formBox h3 {
  color: #160303;
  font-size: 14px;
  font-weight: 500;
  margin-left: 10px;
}
.input-box.button input {
  color: #fff;
  letter-spacing: 1px;
  border: none;
  background: linear-gradient(-218deg, #bfe7f3 50%, #a6dcf1 66%);
  cursor: pointer;
  display: inline-block;
}
.input-box.button input:hover {
  background: #4871e2;
}
.formBox .text h3 {
  color: #333;
  width: 100%;
  text-align: center;
}
.formBox .text h3 a {
  color: #4070f4;
  text-decoration: none;
}
.formBox .text h3 a:hover {
  text-decoration: underline;
}
.policy input{
  --s: 10px; /* adjust this to control the size*/
  --_g: radial-gradient(calc(var(--s)/2),#15202a 96%,#0000); /* the color of the circle here */
  height: var(--s);
  aspect-ratio: 2.5;
  width: auto; /* some browsers need this */
  border-radius: var(--s);
  padding: calc(var(--s)/10);
  margin: calc(var(--s)/2);
  display: grid;
  cursor: pointer;
  background:var(--_g) var(--_p,0%) 50%/var(--s) 33% no-repeat content-box, #ff7a7a; /* the red color */
  box-sizing: content-box;
  overflow: hidden;
  transition: .3s .1s;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
}
.policy input:before,
.policy input:after{
  content: "";
  grid-area: 1/1;
  clip-path: inset(0 0 65% 0);
  transition: .3s;
  background: var(--_g) var(--_p,0%)/var(--s) 100% no-repeat;
}
.policy input:after{
  transition: .3s .2s;
  clip-path: inset(65% 0 0 0);
}
.policy input:checked{
  background-color: #85ff7a; /* the green color */
  --_p: 100%;
}
</style>
