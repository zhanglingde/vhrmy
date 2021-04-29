// 存储数据

import Vue from "vue";
import Vuex from 'vuex';
// 导入请求方法
import {getRequest} from "@/utils/api";
import '../utils/stomp';
// import '../utils/sockjs';
import SockJS from 'sockjs-client';


Vue.use(Vuex);

const now = new Date();

const store = new Vuex.Store({
    // state定义变量
    state: {
        // 数据库中查询的菜单存在routes数组中
        routes: [],
        // chat相关状态存储
        sessions: [],
        stomp: null,
        hrs: [],
        currentSessionId: -1,
        filterKey: ''
    },
    // mutations更改定义的属性
    mutations: {
        // 设置routes的值
        initRoutes(state, data) {
            state.routes = data;
        },
        // chat相关
        changeCurrentSessionId(state, id) {
            state.currentSessionId = id;
        },
        addMessage(state, msg) {
            state.sessions[state.currentSessionId - 1].messages.push({
                content: msg,
                date: new Date(),
                self: true
            })
        },
        INIT_DATA(state) {
            // 浏览器本地的历史聊天记录可以在这里完成
            let data = localStorage.getItem('vue-chat-session');
            //console.log(data)
            if (data) {
                state.sessions = JSON.parse(data);
            }
        },
        INIT_HR(state, data) {
            state.hrs = data;
        }
    },
    // action提交mutation，修改
    // 异步操作在actions中操作，否则在mutations中操作即可
    actions: {
        /**
         * 连接webSocket
         * @param context
         */
        connect(context) {
            console.log('连接websocket');
            //1. 初始化stomp对象
            context.state.stomp = Stomp.over(new SockJS('/ws/ep'));
            //2. 连接Socket连接
            context.state.stomp.connect({}, success => {
                // 连接成功回调
                // 3.订阅消息
                context.state.stomp.subscribe('/user/queue/chat', message => {
                    console.log('messgae>>>>>' + message);
                })
            }, error => {

            })
        },
        /**
         * 初始化在线聊天用户列表
         * @param context
         */
        initData(context) {
            context.commit('INIT_DATA')
            getRequest("/chat/hrs").then(resp => {
                if (resp) {
                    context.commit('INIT_HR', resp);
                }
            })
        },

    }
})

// chat监控
store.watch(function (state) {
    return state.sessions
}, function (val) {
    console.log('CHANGE: ', val);
    localStorage.setItem('vue-chat-session', JSON.stringify(val));
}, {
    deep: true/*这个貌似是开启watch监测的判断,官方说明也比较模糊*/
})


export default store;
