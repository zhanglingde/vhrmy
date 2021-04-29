<template>
    <div id="app">
        <div class="sidebar">
            <card></card>
            <list></list>
        </div>
        <div class="main">
            <message></message>
            <usertext></usertext>
        </div>
    </div>
</template>

<script>
// 导入四个组件：card：用户信息；list：用户列表；message：消息显示框；usertext：消息输入框；
import card from '../../components/chat/card.vue'
import list from '../../components/chat/list.vue'
import message from '../../components/chat/message.vue'
import usertext from '../../components/chat/usertext.vue'


export default {
    name: 'FriendChat',
    data() {
        return {}
    },
    mounted: function () {
        // 初始化store中的数据
        this.$store.dispatch('initData');
    },
    components: {
        card,
        list,
        message,
        usertext
    }
}
</script>

<style lang="scss" scoped>
#app {
    margin: 20px auto;
    width: 800px;
    height: 600px;
    overflow: hidden;
    border-radius: 10px;
    .sidebar, .main {
        height: 100%;
    }
    .sidebar {
        float: left;
        color: #f4f4f4;
        background-color: #2e3238;
        width: 200px;
    }
    .main {
        position: relative;
        overflow: hidden;
        background-color: #eee;
    }
}
</style>
