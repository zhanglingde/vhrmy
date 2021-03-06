// 存储数据

import Vue from "vue";
import Vuex from 'vuex';
// 导入请求方法
import {getRequest} from "@/utils/api";
import '../utils/stomp';
import {Notification} from 'element-ui';
// import '../utils/sockjs';
import SockJS from 'sockjs-client';
import {valueEquals} from "element-ui/src/utils/util";


Vue.use(Vuex);

const now = new Date();

const store = new Vuex.Store({
    // state定义变量
    state: {
        // 数据库中查询的菜单存在routes数组中
        routes: [],
        // chat相关状态存储
        // 存储聊天记录格式{ admin#libai:[{}] }
        sessions: {},
        isDot: {},
        currentSession: null,
        currentHr: JSON.parse(window.sessionStorage.getItem("user")),
        stomp: null,
        hrs: [],
        filterKey: ''
    },
    // mutations更改定义的属性
    mutations: {
        initCurrentHr(state, hr) {
            state.currentHr = hr;
        },
        // 设置routes的值
        initRoutes(state, data) {
            state.routes = data;
        },
        // chat相关
        changeCurrentSession(state, currentSession) {
            Vue.set(state.isDot, state.currentHr.username + '#' + currentSession.username, false);
            state.currentSession = currentSession;
        },
        /**
         * 发送消息，将聊天消息存储在前端store的sessions数组中
         * @param state
         * @param msg
         */
        addMessage(state, msgObj) {
            // 定义消息存储数组对象   格式：发送人#接收人
            let msg = state.sessions[state.currentHr.username + '#' + msgObj.to];
            if (!msg) {
                // state.sessions[state.currentHr.username + '#' + msgObj.to] = [];
                // 消息自动刷新，vue不能监测不是先定义好的属性，后面订单的属性不能实时刷新
                Vue.set(state.sessions, state.currentHr.username + '#' + msgObj.to, []);
                // Vue.set(state.sessions, "msgObj", []);
            }
            // 存放一行消息对象 msg.push({});
            state.sessions[state.currentHr.username + '#' + msgObj.to].push({
                content: msgObj.content,
                date: new Date(),
                self: !msgObj.notSelf
            })
        },
        INIT_DATA(state) {
            // 浏览器本地的历史聊天记录可以在这里完成（恢复本地聊天记录）
            let data = localStorage.getItem('vue-chat-session');
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
                    //4.接收消息
                    let reveiveMsg = JSON.parse(message.body);
                    if (!context.state.currentSession || reveiveMsg.from != context.state.currentSession.username) {
                        Notification.info({
                            title: '【' + reveiveMsg.fromNickName + '】发来一条消息',
                            message: reveiveMsg.content.length > 10 ? reveiveMsg.content.substr(0, 10) : reveiveMsg.content,
                            position: 'bottom-right'
                        })
                        Vue.set(context.state.isDot, context.state.currentHr.username + '#' + reveiveMsg.from, true);
                    }
                    reveiveMsg.notSelf = true;
                    reveiveMsg.to = reveiveMsg.from;
                    context.commit('addMessage', reveiveMsg);
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

/**
 * 监听state.sessions，当session发生变化，自动存到localStorage
 */
store.watch(function (state) {
    return state.sessions;
}, function (val) {
    // 当sessions发生变化，将sessions存到localStorage中
    localStorage.setItem('vue-chat-session', JSON.stringify(val));
}, {
    deep: true/*这个貌似是开启watch监测的判断,官方说明也比较模糊*/
})


export default store;
