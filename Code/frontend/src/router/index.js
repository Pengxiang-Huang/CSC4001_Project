import Vue from 'vue'
import Router from 'vue-router'
import login from '@/components/login'
import register from '@/components/register'
import design from '@/components/design'
import contact from '@/components/contact'
import forgot from '@/components/forgot'
import home from '@/components/home'
import blog from '@/components/blog'
import blank from '@/components/blank'
import post from '@/components/post'

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
    },
    {
      path: '/forgot',
      name: 'forgot',
      component: forgot
    },
    {
      path: '/home/:username',
      name: 'home',
      component: home
    },
    {
      path: '/blank',
      name: 'blank',
      component: blank
    },
    {
      path: '/post/:username',
      name: 'post',
      component: post
    },
    {
      path: '/blog',
      name: 'blog',
      component: blog
    }
  ]
})
