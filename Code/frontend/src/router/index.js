import Vue from 'vue'
import Router from 'vue-router'
import login from '@/components/login'
import register from '@/components/register'
import design from '@/components/design'
import contact from '@/components/contact'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'login',
      component: login
    },
    {
      path: '/register',
      name: 'register',
      component: register
    },
    {
      path: '/design',
      name: 'design',
      component: design
    },
    {
      path: '/contact',
      name: 'contact',
      component: contact
    }
  ]
})
