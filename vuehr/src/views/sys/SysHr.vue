<template>
    <div>
        <div style="margin-top: 10px;display: flex;justify-content: center;">
            <el-input v-model="keywords" placeholder="通过用户名搜索用户..." style="width: 400px;margin-right: 10px;"></el-input>
            <el-button icon="el-icon-search" type="primary">搜索</el-button>
        </div>
        <div class="hr-container">
            <el-card class="hr-card" v-for="(hr,index) in hrs" :key="index">
                <div slot="header" class="clearfix">
                    <span>{{ hr.name }}</span>
                    <el-button style="float: right; padding: 3px 0;color: #ee3300;" type="text" icon="el-icon-delete"></el-button>
                </div>
                <div>
                    <div class="img-container">
                        <img :src="hr.userface" :alt="hr.name" :title="hr.name" class="userface-img">
                    </div>
                    <div class="userinfo-container">
                        <div>用户名：{{hr.name}}</div>
                        <div>手机号码：{{hr.phone}}</div>
                        <div>电话号码：{{hr.telephone}}</div>
                        <div>地址：{{hr.address}}</div>
                        <div>用户状态：
                            <el-switch
                                v-model="hr.enabled"
                                active-text="启用" :active-value="1"
                                inactive-text="禁用" :inactive-value="0">
                            </el-switch>
                        </div>
                        <div>用户角色：
                            <el-tag type="success" style="margin-right: 4px;" v-for="(role,indexj) in hr.roles" :key="index" >
                                {{role.nameZh}}
                            </el-tag>
                            <el-button type="text" icon="el-icon-more"></el-button>
                        </div>
                        <div>备注：{{hr.remark}}</div>
                    </div>
                </div>

            </el-card>
        </div>
    </div>
</template>

<script>
export default {
    name: "SysBasic",
    data() {
        return {
            keywords: '',
            hrs: []
        }
    },
    mounted() {
        this.initHrs();
    },
    methods: {
        initHrs() {
            this.getRequest("/system/hr/").then(resp => {
                if (resp) {
                    this.hrs = resp;
                }
            })
        }
    }

}
</script>

<style>
.img-container{
    width: 100%;
    display: flex;
    justify-content: center;
}
.userface-img{
    width: 72px;
    height: 72px;
    border-radius: 72px;
}
.userinfo-container{
    margin-top: 20px;
}
.userinfo-container div{
    font-size: 12px;
    color: #409eff;
}
.hr-container{
    margin-top: 10px;
    display: flex;
    /*自动换行*/
    flex-wrap: wrap;
    /*平均分配*/
    justify-content: space-around;
}
.hr-card{
    width: 350px;
    margin-bottom: 20px;
}
</style>
