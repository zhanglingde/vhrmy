<template>
    <div>
        <el-form v-bind:rules="rules" ref="loginForm" :model="loginForm" class="loginContainer">
            <h3 class="loginTitle">系统登录</h3>
            <el-form-item prop="username">
                <el-input type="text" v-model="loginForm.username" auto-complete="off" aria-placeholder="请输入用户名"></el-input>
            </el-form-item>
            <el-form-item prop="password">
                <el-input type="text" v-model="loginForm.password" auto-complete="off" aria-placeholder="请输入用户密码"></el-input>
            </el-form-item>
            <!--    勾选记住密码       -->
            <el-checkbox class="loginRemember" v-model="checked"></el-checkbox>
            <el-button type="primary" style="width:100%" @click="submitLogin">登录</el-button>
        </el-form>
    </div>
</template>

<script>
    import {postKeyValueRequest} from "@/utils/api";

    export default {
        name: "Login",
        data() {
            return {
                loginForm:{
                    username: 'admin',
                    password: '123'
                },
                checked:true,
                // 定义校验规则,用户名和密码不能为空
                rules:{
                    username:[{required:true,message:'请输入用户名',trigger:'blur'}],
                    password:[{required:true,message:'请输入密码',trigger:'blur'}]
                },

            }
        },
        methods:{
            submitLogin(){
                // 获取到表单组件并校验
                this.$refs.loginForm.validate((valid) => {
                    if (valid) {
                        postKeyValueRequest("/doLogin",this.loginForm).then(resp=>{
                          if (resp) {
                            // 登录用户数据保存在session中
                            window.sessionStorage.setItem("user",JSON.stringify(resp));
                            // 页面跳转有push(放到堆栈中，可以后退)
                            this.$router.replace('/home');
                          }
                        })
                    } else {
                        this.$message({
                            showClose: true,
                            message: '请输入用户名或密码',
                            type: 'error'
                        });
                        return false;
                    }
                });
            }
        }
    }
</script>

<style scoped>
    .loginContainer{
        border-radius:15px;
        background-clip: padding-box;
        margin: 180px auto;
        width: 350px;
        padding: 35px 35px 15px 35px;
        background: #fff;
        border:1px solid #eaeaea;
        box-shadow: 0 0 25px #cac6c6;       /*边框阴影*/
    }
    .loginTitle{
        margin: 20px auto 20px auto;
        text-align: center;
        color: #505458;
    }
    .loginRemember{
        text-align: left;
        margin: 0px 0px 15px 0px;
    }
</style>
