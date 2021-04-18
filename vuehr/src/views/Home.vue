<template>
    <el-container>
        <el-header class="homeHeader">
            <div class="title">微人事</div>
            <el-dropdown class="userInfo" @command="commandHandler">
                <span class="el-dropdown-link">
                    {{user.name}}
                    <i>
                        <img :src="user.userface">
                    </i>
                </span>
                <el-dropdown-menu slot="dropdown" >
                    <el-dropdown-item command="userInfo">个人中心</el-dropdown-item>
                    <el-dropdown-item command="setting">设置</el-dropdown-item>
                    <el-dropdown-item command="logout" divided>注销登录</el-dropdown-item>
                </el-dropdown-menu>
            </el-dropdown>
        </el-header>
        <el-container>
            <el-aside width="200px">
                <!-- unique-opened 每次只展开一个导航栏菜单    -->
                <el-menu router unique-opened>
                    <!--  this.$router.options.routes                  -->
                    <el-submenu :index="index+''" v-for="(item,index) in routes" v-if="!item.hidden" :key="index">
                        <template slot="title">
                            <i :class="item.iconCls" style="color:#409eff;margin-right: 5px;"></i>
                            <span>{{item.name}}</span>
                        </template>

                        <el-menu-item :index="child.path" v-for="(child,indexj) in item.children" :key="indexj">{{child.name}}</el-menu-item>

                    </el-submenu>

                </el-menu>
            </el-aside>
            <el-main>
                <router-view/>
            </el-main>
        </el-container>
    </el-container>
</template>

<script>
export default {

    name: "Home",
    data() {
        return {
            user: JSON.parse(window.sessionStorage.getItem("user"))
        }
    },
    computed:{
        routes() {
            return this.$store.state.routes;
        }
    },
    methods:{

        commandHandler(cmd) {
            if (cmd == 'logout') {
                this.$confirm('此操作将注销登录, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.getRequest("/logout");
                    window.sessionStorage.removeItem("user");
                    // 注销登录清空store存储的菜单数据
                    this.$store.commit('initRoutes', []);
                    this.$router.replace("/");

                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消'
                    });
                })
            }
        }
    }
}
</script>

<style scoped>
    .homeHeader {
        background: #109ce3;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0px 15px;
        box-sizing: border-box;
    }

    .homeHeader .title {
        font-size: 30px;
        font-family: 华文行楷;
        color: #ffffff;
    }
    .homeHeader .userInfo{
        cursor: pointer;
    }
    .el-dropdown-link{
        display: flex;
        align-items: center;        /*全局局中*/
    }
    .el-dropdown-link img{
        width: 48px;
        height: 48px;
        border-radius: 24px;
        margin-left: 8px;
    }

</style>
