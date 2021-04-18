import Vue from 'vue'
import App from './App.vue'
// 引入ElementUI
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
// 引入store存储菜单
import store from './store';
// 导入图标
import 'font-awesome/css/font-awesome.min.css';

import router from './router'

import {postRequest} from "@/utils/api";
import {postKeyValueRequest} from "@/utils/api";
import {putRequest} from "@/utils/api";
import {getRequest} from "@/utils/api";
import {deleteRequest} from "@/utils/api";
import {initMenu} from "./utils/menus";

Vue.prototype.postRequest = postRequest;
Vue.prototype.postKeyValueRequest = postKeyValueRequest;
Vue.prototype.putRequest = putRequest;
Vue.prototype.getRequest = getRequest;
Vue.prototype.deleteRequest = deleteRequest;

Vue.config.productionTip = false

// 引入依赖并使用ElementUI
Vue.use(ElementUI);

/**
 * 路由全局前置守卫：相当于后端过滤器
 * to：到哪个路由去
 * from：从哪个路由请求
 * next：执行方法
 */
router.beforeEach((to, from, next) => {
  if (to.path == '/') {
    // 登录页
    next();
  }else{
    initMenu(router,store);
    next();
  }
})

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
