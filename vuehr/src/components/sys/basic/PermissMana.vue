<template>
    <div>
        <div class="permissManaTool">
            <el-input size="small" placeholder="请输入角色英文名" v-model="role.name">
                <template slot="prepend">ROLE_</template>
            </el-input>
            <el-input size="small" placeholder="请输入角色中文名" v-model="role.nameZh"></el-input>
            <el-button size="small" icon="el-icon-plus" type="primary" @click="addPermiss">添加</el-button>
        </div>
        <div class="permissMain">
            <el-collapse v-model="activeName" accordion @change="change">
                <el-collapse-item :title="role.nameZh" :name="role.id" v-for="(role,index) in roles" :key="index">
                    <el-card class="box-card">
                        <div slot="header" class="clearfix">
                            <span>可访问的资源</span>
                            <el-button style="float: right; padding: 3px 0;color: #ff0000;" type="text"
                                       icon="el-icon-delete"></el-button>
                        </div>
                        <div>
                            <el-tree show-checkbox :data="allMenus" :props="defaultProps"></el-tree>
                        </div>
                    </el-card>
                </el-collapse-item>
            </el-collapse>
        </div>
    </div>
</template>

<script>
    export default {
        name: "PermissMana",
        data() {
            return {
                role: {
                    name: '',
                    nameZh: ''
                },
                activeName: '2',
                roles: [],
                allMenus: [],
                defaultProps: {
                    children: 'children',
                    label: 'name'
                }
            }
        },
        mounted() {
            this.initRoles();
        },
        methods: {
            change(name){
                if (name) {
                    this.initAllMenus();
                }
            },
            initAllMenus() {
                this.getRequest("/system/basic/permiss/menus").then(resp=>{
                    if (resp) {
                        this.allMenus = resp;
                    }
                })
            },
            initRoles() {
                this.getRequest("/system/basic/permiss/").then(resp => {
                    if (resp) {
                        this.roles = resp;
                    }
                })
            },
            addPermiss() {

            }
        }
    }
</script>

<style>
    .permissManaTool {
        display: flex;
        justify-content: flex-start;
    }

    .permissManaTool .el-input {
        width: 300px;
        margin-right: 8px;
    }

    .permissMain {
        margin-top: 8px;
        width: 600px;
    }
</style>
