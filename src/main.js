import Vue from 'vue'

import '@/styles/index.scss' // global css

import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

import echarts from "echarts";

import App from './App'
import store from './store'
import router from './router'

import Vant from 'vant'
import 'vant/lib/index.css'
Vue.use(Vant)

Vue.use(ElementUI);

Vue.config.productionTip = false
Vue.prototype.$echarts = echarts

Vue.config.devtools = true

new Vue({
  el: '#app',
  router,
  store,
  render: h => h(App)
})
