<template>
  <div id =  "app" >
     <div class="wrapper">
    <h2>Registration</h2>
    <form action="#">
      <div class="input-box">
        <input type="text" placeholder="Enter your username"  v-model="username"  @keyup.enter="submit" required>
      </div>
      <div class="input-box">
        <input type="email" placeholder="Enter your email" v-model="email"  @keyup.enter="submit" required>
      </div>
      <div class="input-box">
        <input type="password" placeholder="Create password"  v-model="password1"  @keyup.enter="submit" required>
      </div>
      <div class="input-box">
        <input type="password" placeholder="Confirm password" v-model="password2" @keyup.enter="submit" required>
      </div>
      <div class="policy">
        <input type="checkbox">
        <h3>I accept all terms & condition</h3>
      </div>
      <div class="input-box button">
        <input @click="submit"  type="Submit" value="Register Now">
      </div>
      <div class="text">
        <h3>Already have an account? <router-link to="/">login in Now </router-link></h3>
         <router-link to="/contact">contact us?</router-link>
      </div>
    </form>
  </div>
  </div>
</template>

<script>
import axios from 'axios'
import Qs from 'qs'
import router from '../router'
export default{
  name: 'register',
  data () {
    return {
      username: '',
      email: '',
      password1: '',
      password2: ''
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
      } else {
        let sendData = {
          username: this.username,
          email: this.email,
          password: this.password1
        }
        console.log(Qs.stringify(sendData))
        var url = this.GLOBAL.BASE_URL + '/register/'
        axios({
          method: 'post',
          url: url,
          data: Qs.stringify(sendData)
        }).then((response) => {
          if (response.data.isRegister) {
            this.$message('A verfication email has been sent to your mailbox according to the eamil address. Please go to check it!')
            router.push({ path: '/' })
          } else {
            alert('The username has already been used, please change it and register again!')
          }
        }).catch((error) => {
          console.log(error)
        })
      }
      this.$router.push('/design')
    }
  }
}
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700&display=swap');
*{
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Poppins', sans-serif;
}
#app{
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(-218deg, #206475 48%, #2f9aa8 75%);
}
.wrapper{
  position: relative;
  max-width: 430px;
  width: 100%;
  background: linear-gradient(-218deg, #3f92b3 70%, #abe7ff 92%);
  padding: 34px;
  border-radius: 6px;
  box-shadow: 0 5px 10px rgba(0,0,0,0.2);
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
.wrapper h2{
  position: relative;
  font-size: 22px;
  font-weight: 600;
  color: #333;
}
.wrapper h2::before{
  content: '';
  position: absolute;
  left: 0;
  bottom: 0;
  height: 3px;
  width: 28px;
  border-radius: 12px;
  background: #4070f4;
}
.wrapper form{
  margin-top: 30px;
}
.wrapper form .input-box{
  height: 52px;
  margin: 18px 0;
}
form .input-box input{
  height: 100%;
  width: 100%;
  outline: none;
  padding: 0 15px;
  font-size: 17px;
  font-weight: 400;
  color: #333;
  border: 1.5px solid #C7BEBE;
  border-bottom-width: 2.5px;
  border-radius: 6px;
  transition: all 0.3s ease;
}
.input-box input:focus,
.input-box input:valid{
  border-color: #6083e4;
}
form .policy{
  display: flex;
  align-items: center;
}
form h3{
  color: #160303;
  font-size: 14px;
  font-weight: 500;
  margin-left: 10px;
}
.input-box.button input{
  color: #fff;
  letter-spacing: 1px;
  border: none;
  background: linear-gradient(-218deg, #bfe7f3 50%, #a6dcf1 66%);
  cursor: pointer;
}
.input-box.button input:hover{
  background: #4871e2;
}
form .text h3{
 color: #333;
 width: 100%;
 text-align: center;
}
form .text h3 a{
  color: #4070f4;
  text-decoration: none;
}
form .text h3 a:hover{
  text-decoration: underline;
}
</style>
