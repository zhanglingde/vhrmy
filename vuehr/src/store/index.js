// 存储数据

import Vue from "vue";
import Vuex from 'vuex';

Vue.use(Vuex);

export default new Vuex.Store({
    // state定义变量
    state:{
        // 数据库中查询的菜单存在routes数组中
        routes:[]
    },
    // mutations更改定义的属性
    mutations:{
        // 设置routes的值
        initRoutes(state, data) {
            state.routes = data;
        }
    },
    // action提交mutation，修改
    actions:{

    }
})
