<template>
  <div id="app">
    <div class="wrapper">
      <h2>Password Reset</h2>
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
                 placeholder="Reset password"
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
        <div class="input-box">
          <input type="password"
                 placeholder="Verification Code"
                 v-model="veri_code"
                 @keyup.enter="submit"
                 required>
        </div>
        <div class="input-box button1">
          <input @click="send"
                 type="Submit"
                 value="Send">
        </div>
        <div class="input-box button">
          <input @click="submit"
                 type="Submit"
                 value="Reset Now">
        </div>
        <div class="text">
          <h3>Don't have an account? <router-link to="/register">Resiter Now </router-link>
          </h3>
          <router-link to="/contact">contact us?</router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Qs from 'qs'
import axios from 'axios'
export default {
  name: 'register',
  data () {
    return {
      username: '',
      email: '',
      password1: '',
      password2: '',
      veri_code: '',
      correct_code: ''
    }
  },
  methods: {
    send () {
      var check = /[0-9]{9}@link\.cuhk\.edu\.cn/
      if (this.email === '' || !check.test(this.email)) {
        this.$message.error('Please enter your correct email')
      } else {
        let mysendData = {
          email: this.email
        }
        axios({
          method: 'post',
          url: 'http://175.178.34.84' + '/sendEmail/',
          data: Qs.stringify(mysendData)
        }).then((response) => {
          this.correct_code = response.data.code
        }).catch((error) => {
          console.log(error)
        })
        this.$message.success('Verification code has been sent to your account')
      }
    },
    submit () {
      var regExp = /[0-9]{9}@link\.cuhk\.edu\.cn/
      if (this.email === '' || !regExp.test(this.email)) {
        this.$message.error('please input the correct email')
      } else if (this.password1 === '') {
        this.$message.error('please set your password')
      } else if (this.password2 === '') {
        this.$message.error('please confirm your password')
      } else if (this.password1 !== this.password2) {
        this.$message.error('The passwords are not the same, please check it!')
      } else if (this.veri_code !== this.correct_code) {
        this.$message.error('The verication code is not correct, please try again !')
      } else {
        let senddata = {
          type: 'Reset Password',
          username: this.username,
          newVal: this.password1
        }
        axios({
          method: 'POST',
          url: 'http://175.178.34.84' + '/updateInformation/',
          data: Qs.stringify(senddata)
        }).then((response) => {
          if (response.data === 'Password Reset successfully!') {
            this.$message.success('Reset Successfully')
            sessionStorage.setItem('isLogin', true)
            this.$router.push({
              path: '/home/:username',
              name: 'home',
              params: {
                username: this.username
              }
            })
          } else {
            this.$message.error('Reset Failed, please try again !')
          }
        }).catch(error => {
          this.$message.error('Reset Failed!')
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
.input-box.button1 input {
  height: 40px;
  width: 80px;
  color: rgb(88, 85, 85);
  letter-spacing: 1px;
  border-radius: 30px;
  background: linear-gradient(-218deg, #bff3d3 50%, #a6f1ce 66%);
  cursor: pointer;
  display: flex;
}
.input-box.button1 input:hover {
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
</style>
