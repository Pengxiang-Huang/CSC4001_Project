<template>
  <div id="app">
     <div class="container">
      <span class="text1">Welcome To CUHKSZ-StackOverflow</span>
    </div>
    <div class="circle"><div class="wave"> </div> </div>
    <div id="login">
      <div id="description">
        <h1>Login</h1>
        <p>don't have an account? sign up to join us!</p>
        <p>        </p>
        <router-link to="/register">Create your own account/</router-link>
      </div>
      <div id="form">
        <form @submit.prevent="doLogin">
          <label for="email">Email</label>
          <input type="email" class="form-control" placeholder="Email Address" v-model="email" @keyup.enter="submit" />
          <div class="field has-addons">
            <label for="password">
              Password
              <font-awesome-icon v-if = "showPassword" icon="fa-solid fa-eye"  @click="toggleShow"/>
              <font-awesome-icon v-if = "!showPassword" icon="fa-solid fa-eye-slash"  @click="toggleShow"/>
            </label>&nbsp;
              <div class="control is-expanded">
                <input v-if="showPassword" type="text" class="input" v-model="password" />
                <input v-else type="password" class="input" v-model="password" placeholder="Password">
              </div>
          </div>
          <el-button :plain="true" @click="submit">Log in</el-button>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
export default{
  name: 'login',
  data () {
    return {
      showPassword: false,
      email: '',
      password: ''
    }
  },
  computed: {
    buttonLabel () {
      return (this.showPassword) ? 'Hide' : 'Show'
    }
  },
  methods: {
    toggleShow () {
      this.showPassword = !this.showPassword
    },
    submit () {
      var reg = /[0-9]{9}@link\.cuhk\.edu\.cn/
      if (this.email === '' || !reg.test(this.email)) {
        this.$message.error('please input the correct email')
      }
    }
  }
}
</script>

<style>
* {
  box-sizing: border-box;
  font-family: Verdana, sans-serif;
}

html,
body {
  height: 100vh;
  margin: 0;
  padding: 0;
  width: 100%;
  background-color: #DCDDDF url(https://cssdeck.com/uploads/media/items/7/7AF2Qzt.png);
}

div#app {
  width: 100%;
  height: 100%;
}

div#app .container{
  text-align: center;
  position: absolute;
  top: 20%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 100%;
}

div#app .container span {
  display: block;
}
div#app .container .text1{
  color: white;
  font-size: 60px;
  font-weight: 700;
  letter-spacing: 8px;
  margin-bottom: 20px;
  position: relative;
  animation: text 2.5s 1;
}
@keyframes text {
  0%{
    color: black;
    margin-bottom: -40px;
  }
  30%{
    letter-spacing: 25px;
    margin-bottom: -40px;
  }
}
div #app .circle {
  position: absolute;
  top:20%;
  left: 10%;
  transform: translate(-50%,-50%);
  width: 150px;
  height: 150px;
  background: #000;
  border: 5px solid 4985s;
  box-shadow: 0 3px 10px 5px #4973ff;
  border-radius: 50%;
  overflow: hidden;
}
div#app .wave {
  position: relative;
  height: 100%;
  width: 100%;
  background: #4973ff;
  border-radius: 50%;
  box-shadow: inset 0 0 50px rgba(0,0,0,.50);
  box-shadow: 0 0 0 4px  #353535, 0 0 0 5px #3e3e3e,inset 0 0 10px rgba(0,0,0,1), 0 5px 20px rgba(0,0,0,5), inset 0 0 15px rgba(0,0,0,.2);
}
.wave:before,
.wave:after
{
content: '';
position: absolute;
width: 200%;
height:200%;
top: 0;
left: 50%;
transform: translate(-50%,-75%);

}
.wave:before
{
border-radius: 45%;
background: rgba(255,255,255,1);
animation: animate 5s linear infinite;
box-shadow: 0 0 2px #6dd1ff,0 0 0 4px  #353535, 0 0 0 5px #3e3e3e,inset 0 0 10px rgba(0,0,0,1), 0 5px 20px rgba(0,0,0,5), inset 0 0 15px rgba(0,0,0,.2);

}
.wave:after
{
border-radius: 40%;
background: rgba(255,255,255,.5);
animation: animate 5s linear infinite;
}

@keyframes animate
 {
0%
{
transform: translate(-50%,-75%) rotate(100deg);
}
100%
{
transform: translate(-50%,-75%) rotate(360deg);
}
}
div#app div#login {
  align-items: center;
  background-color: #53c0f7;
  display: flex;
  justify-content: center;
  width: 100%;
  height: 100%;
}

div#app div#login div#description {
  background-color: #ffffff;
  width: 380px;
  height: 200px;
  padding: 35px;
}

div#app div#login div#description h1,
div#app div#login div#description p {
  margin: 0;
}

div#app div#login div#description p {
  font-size: 0.8em;
  color: #95a5a6;
  margin-top: 20px;
}

div#app div#login div#form {
  background-color: #34495e;
  border-radius: 5px;
  box-shadow: 0px 0px 30px 0px #666;
  color: #ecf0f1;
  width: 360px;
  height: 300px;
  padding: 35px;
}

div#app div#login div#form label,
div#app div#login div#form input {
  outline: none;
  width: 100%;
  margin-top: 30px;
}

div#app div#login div#form label {
  color: #95a5a6;
  font-size: 0.8em;
}

div#app div#login div#form input {
  background-color: transparent;
  border: none;
  color: #ecf0f1;
  font-size: 1em;
  margin-bottom: 20px;
}

div#app div#login div#form ::placeholder {
  color: #ecf0f1;
  opacity: 1;
}

div#app div#login div#form button {
  background-color: #ffffff;
  cursor: pointer;
  border: none;
  padding: 10px;
  transition: background-color 0.2s ease-in-out;
  width: 100%;
}

div#app div#login div#form button:hover {
  background-color: #eeeeee;
}

@media screen and (max-width: 600px) {
  div#app div#login {
    align-items: unset;
    background-color: unset;
    display: unset;
    justify-content: unset;
  }

  div#app div#login div#description {
    margin: 0 auto;
    max-width: 350px;
    width: 100%;
  }

  div#app div#login div#form {
    border-radius: unset;
    box-shadow: unset;
    width: 100%;
  }

  div#app div#login div#form form {
    margin: 0 auto;
    max-width: 280px;
    width: 100%;
  }
}
</style>
