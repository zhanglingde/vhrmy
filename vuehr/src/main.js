import Vue from 'vue'
import App from './App.vue'
// 引入ElementUI
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import router from './router'

Vue.config.productionTip = false

// 引入依赖并使用ElementUI
Vue.use(ElementUI);

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
