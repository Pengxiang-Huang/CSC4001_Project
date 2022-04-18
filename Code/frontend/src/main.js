// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import 'babel-polyfill'
import router from './router'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import { library } from '@fortawesome/fontawesome-svg-core'
import 'font-awesome/css/font-awesome.min.css'
import { faEye, faEyeSlash, faArrowLeft, faArrowRight } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import global from '../config/global'
import Prism from 'prismjs'
import { PrismEditor } from 'vue-prism-editor'
import 'vue-prism-editor/dist/prismeditor.min.css'
import VueQuillEditor from 'vue-quill-editor'
import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import 'quill/dist/quill.bubble.css'
import 'froala-editor/js/plugins.pkgd.min.js'
import 'froala-editor/js/third_party/embedly.min'
import 'froala-editor/js/third_party/spell_checker.min'
import 'froala-editor/js/third_party/font_awesome.min'
import 'froala-editor/js/third_party/image_tui.min'
import 'froala-editor/css/froala_editor.pkgd.min.css'
import VueFroala from 'vue-froala-wysiwyg'
import 'animate.css'
import TextHighlight from 'vue-text-highlight'
import '../static/font/font.css'
Prism.highlightAll()
Vue.prototype.GLOBAL = global
library.add(faEye)
library.add(faEyeSlash)
library.add(faArrowLeft)
library.add(faArrowRight)
Vue.component('font-awesome-icon', FontAwesomeIcon)
Vue.component('PrismEditor', PrismEditor)
Vue.component('text-highlight', TextHighlight)
Vue.use(VueFroala)
Vue.use(ElementUI)
Vue.use(VueQuillEditor)

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
