<template>
    <div>
        <div class="permissManaTool">
            <el-input size="small" placeholder="请输入角色英文名" v-model="role.name">
                <template slot="prepend">ROLE_</template>
            </el-input>
            <el-input size="small" placeholder="请输入角色中文名" v-model="role.nameZh"></el-input>
            <el-button size="small" icon="el-icon-plus" type="primary" @click="addRole">添加</el-button>
        </div>
        <div class="permissMain">
            <el-collapse v-model="activeName" accordion @change="change">
                <el-collapse-item :title="role.nameZh" :name="role.id" v-for="(role,index) in roles" :key="index">
                    <el-card class="box-card">
                        <div slot="header" class="clearfix">
                            <span>可访问的资源</span>
                            <el-button style="float: right; padding: 3px 0;color: #ff0000;" type="text"
                                       icon="el-icon-delete" @click="deleteRole(role)"></el-button>
                        </div>
                        <div>
                            <el-tree show-checkbox
                                     node-key="id"
                                     ref="tree"
                                     :key="index"
                                     :data="allMenus"
                                     :default-checked-keys="selectedMenus"
                                     :props="defaultProps">

                            </el-tree>
                            <div style="display: flex;justify-content: flex-end;margin-top: 5px;">
                                <el-button @click="cancelUpdate">取消修改</el-button>
                                <el-button type="primary" @click="doUpdate(role.id,index)">确认修改</el-button>
                            </div>
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
                activeName: '-1',
                roles: [],
                allMenus: [],
                selectedMenus: [],
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
            change(rid) {
                if (rid) {
                    this.initAllMenus();
                    this.initSelectedMenus(rid);
                }
            },
            doUpdate(rid, index) {
                let tree = this.$refs.tree[index];
                let selectedKeys = tree.getCheckedKeys(true);
                let url = '/system/basic/permiss/?rid=' + rid;
                selectedKeys.forEach(key => {
                    url += '&mids=' + key;
                })
                this.putRequest(url).then(resp => {
                    if (resp) {
                        this.activeName = -1;
                    }
                })
            },
            cancelUpdate() {
                this.activeName = -1;
            },
            initAllMenus() {
                this.getRequest("/system/basic/permiss/menus").then(resp => {
                    if (resp) {
                        this.allMenus = resp;
                    }
                })
            },
            initSelectedMenus(rid) {
                this.getRequest("/system/basic/permiss/mids/" + rid).then(resp => {
                    if (resp) {
                        this.selectedMenus = resp;
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
            addRole() {
                if (this.role.name && this.role.nameZh) {
                    this.postRequest("/system/basic/permiss/role", this.role).then(resp => {
                        if (resp) {
                            this.initRoles();
                            this.role.name = '';
                            this.role.nameZh = '';
                        }
                    });
                } else {
                    this.$message.error('参数不能为空！');
                }

            },
            deleteRole(role) {
                this.$confirm('此操作将永久删除【'+role.nameZh+'】角色, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.deleteRequest("/system/basic/permiss/role/"+role.id).then(resp=>{
                        if (resp) {
                            this.initRoles();
                        }
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
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
