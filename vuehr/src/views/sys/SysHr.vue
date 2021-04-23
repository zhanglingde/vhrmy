<template>
    <div>
        <div style="margin-top: 10px;display: flex;justify-content: center;">
            <el-input v-model="keywords" placeholder="通过用户名搜索用户..." style="width: 400px;margin-right: 10px;" @keydown.enter.native="doSearch"></el-input>
            <el-button icon="el-icon-search" type="primary" @click="doSearch">搜索</el-button>
        </div>
        <div class="hr-container">
            <el-card class="hr-card" v-for="(hr,index) in hrs" :key="index">
                <div slot="header" class="clearfix">
                    <span>{{ hr.name }}</span>
                    <el-button style="float: right; padding: 3px 0;color: #ee3300;" type="text"
                               icon="el-icon-delete"></el-button>
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
                                    @change="enabledChange(hr)"
                                    active-text="启用"
                                    inactive-text="禁用">
                            </el-switch>
                        </div>
                        <div>用户角色：
                            <el-tag type="success" style="margin-right: 4px;" v-for="(role,indexj) in hr.roles"
                                    :key="indexj">
                                {{role.nameZh}}
                            </el-tag>
                            <el-popover
                                    placement="right"
                                    title="角色列表"
                                    width="200"
                                    @show="showPop(hr)"
                                    @hide="hidePop(hr)"
                                    trigger="click">
                                <el-select v-model="selectedRoles" multiple placeholder="请选择">
                                    <el-option
                                            v-for="(r,indexk) in allRoles"
                                            :key="indexk"
                                            :label="r.nameZh"
                                            :value="r.id">
                                    </el-option>
                                </el-select>
                                <el-button slot="reference" type="text" icon="el-icon-more"></el-button>
                            </el-popover>
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
                hrs: [],
                allRoles: [],
                selectedRoles: []
            }
        },
        mounted() {
            this.initHrs();
        },
        methods: {
            doSearch() {
                this.initHrs();
            },
            initHrs() {
                this.getRequest("/system/hr/?keywords=" + this.keywords).then(resp => {
                    if (resp) {
                        this.hrs = resp;
                    }
                })
            },
            enabledChange(hr) {
                console.log(hr);
                this.putRequest("/system/hr/", hr).then(resp => {
                    if (resp) {
                        this.initHrs();
                    }
                })
            },
            initAllRoles() {
                this.getRequest("/system/hr/roles").then(resp => {
                    if (resp) {
                        this.allRoles = resp;
                    }
                })
            },
            showPop(hr) {
                this.initAllRoles();
                let roles = hr.roles;
                this.selectedRoles = [];
                roles.forEach(role => {
                    this.selectedRoles.push(role.id);
                })
            },
            hidePop(hr) {
                // 当选中角色与默认角色一样时不修改
                let roles = [];
                Object.assign(roles, hr.roles);
                let flag = false;
                if (roles.length != this.selectedRoles.length) {
                    flag = true
                } else {
                    for (let i = 0; i < roles.length; i++) {
                        let role = roles[i];
                        for (let j = 0; j < this.selectedRoles.length; j++) {
                            if (role.id == this.selectedRoles[j]) {
                                // 从数组中移除
                                roles.splice(i, 1);
                                i--;
                                break;
                            }
                        }
                    }
                    if (roles.length != 0) {
                        flag = true;
                    }
                }
                if (flag) {
                    let roles = hr.roles;
                    let url = "/system/hr/hr-role?hrId=" + hr.id;
                    let roleIds = this.selectedRoles;
                    roleIds.forEach(roleId => {
                        url += "&roleIds=" + roleId;
                    })
                    this.putRequest(url).then(resp => {
                        if (resp) {
                            this.initHrs();
                        }
                    })
                }
            }
        }

    }
</script>

<style>
    .img-container {
        width: 100%;
        display: flex;
        justify-content: center;
    }

    .userface-img {
        width: 72px;
        height: 72px;
        border-radius: 72px;
    }

    .userinfo-container {
        margin-top: 20px;
    }

    .userinfo-container div {
        font-size: 12px;
        color: #409eff;
    }

    .hr-container {
        margin-top: 10px;
        display: flex;
        /*自动换行*/
        flex-wrap: wrap;
        /*平均分配*/
        justify-content: space-around;
    }

    .hr-card {
        width: 350px;
        margin-bottom: 20px;
    }
</style>
