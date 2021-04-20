<template>
    <div>
        <div>
            <el-input v-model="jl.name" prefix-icon="el-icon-plus" size="small" style="width: 300px;"
                      placeholder="添加职称..."></el-input>
            <el-select v-model="jl.titleLevel" size="small" placeholder="职称等级" style="margin-left: 8px;">
                <el-option
                        v-for="item in titleLevel"
                        :key="item"
                        :label="item"
                        :value="item">
                </el-option>
            </el-select>
            <el-button icon="el-icon-plus" size="small" type="primary" style="margin-left: 8px;" @click="addJobLevel">
                添加
            </el-button>
        </div>
        <div class="jobLevelMain">
            <el-table
                    :data="jls"
                    border
                    script
                    @selection-change="handleSelectionChange"
                    size="small"
                    style="width: 80%">
                <el-table-column
                        type="selection"
                        width="55">
                </el-table-column>
                <el-table-column
                        prop="id"
                        label="编号"
                        width="55">
                </el-table-column>
                <el-table-column
                        prop="name"
                        label="职称名称"
                        width="150">
                </el-table-column>
                <el-table-column
                        prop="titleLevel"
                        width="150"
                        label="职称级别">
                </el-table-column>
                <el-table-column
                        prop="createDate"
                        width="150"
                        label="创建时间">
                </el-table-column>
                <el-table-column width="150" label="是否启用">
                    <template slot-scope="scope">
                        <el-tag type="success" v-if="scope.row.enabled">已启用</el-tag>
                        <el-tag type="danger" v-else>未启用</el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="操作">
                    <template slot-scope="scope">
                        <el-button
                                size="mini"
                                @click="showEditView(scope.$index, scope.row)">编辑
                        </el-button>
                        <el-button
                                size="mini"
                                type="danger"
                                @click="handleDelete(scope.$index, scope.row)">删除
                        </el-button>
                    </template>
                </el-table-column>
            </el-table>
            <el-button size="small" type="danger" style="margin-top: 8px;" :disabled="this.multipleSelection == 0"
                       @click="batchDelete">批量删除
            </el-button>
        </div>
        <el-dialog
                title="修改职称"
                :visible.sync="dialogVisible"
                width="30%">
            <div>
                <table>
                    <tr>
                        <td>
                            <el-tag>职称名称</el-tag>
                        </td>
                        <td>
                            <el-input class="updateJLInput" size="small" v-model="updateJL.name"></el-input>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <el-tag>职称等级</el-tag>
                        </td>
                        <td>
                            <el-select v-model="updateJL.titleLevel" size="small" placeholder="职称等级"
                                       style="margin-left: 8px;">
                                <el-option
                                        v-for="item in titleLevel"
                                        :key="item"
                                        :label="item"
                                        :value="item">
                                </el-option>
                            </el-select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <el-tag>是否启用</el-tag>
                        </td>
                        <td>
                            <el-switch
                                    v-model="updateJL.enabled"
                                    active-text="启用" active-value="1"
                                    inactive-text="禁用" inactive-value="0">
                            </el-switch>
                        </td>
                    </tr>
                </table>


            </div>
            <span slot="footer" class="dialog-footer">
            <el-button @click="dialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="doUpdate">确 定</el-button>
          </span>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        name: "joblevelmana",
        data() {
            return {
                jl: {
                    name: '',
                    titleLevel: ''
                },
                updateJL: {
                    name: '',
                    titleLevel: '',
                    enabled: 1
                },
                jls: [],
                multipleSelection: [],
                dialogVisible: false,
                titleLevel: [
                    '正高级',
                    '副高级',
                    '初级',
                    '中级',
                    '员级'
                ]
            }
        },
        mounted() {
            this.initJobLevel();
        },
        methods: {
            initJobLevel() {
                this.getRequest("/system/basic/joblevel/").then(resp => {
                    this.jls = resp;
                })
            },
            addJobLevel() {
                if (this.jl.name && this.jl.titleLevel) {

                    this.postRequest("/system/basic/joblevel/", this.jl).then(resp => {
                        if (resp) {     // resp有数据，添加成功
                            this.initJobLevel();
                            this.jl.name = '';
                            this.jl.titleLevel = '';
                        }
                    });
                } else {
                    this.$message.error("参数不能为空!");
                }
            },
            showEditView(index, data) {
                // this.updateJL = data;
                Object.assign(this.updateJL, data);
                console.log('updateJL:' + this.updateJL.enabled);
                this.dialogVisible = true;
            },
            doUpdate() {
                this.putRequest("/system/basic/joblevel/", this.updateJL).then(resp => {
                    this.initJobLevel();
                    this.dialogVisible = false;
                })
            },
            handleDelete(index, data) {
                this.$confirm('此操作将永久删除【' + data.name + '】职称, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.deleteRequest("/system/basic/joblevel/" + data.id).then(resp => {
                        this.initJobLevel();
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            handleSelectionChange(val) {
                this.multipleSelection = val;
            },
            batchDelete() {
                this.$confirm('此操作将永久删除【' + this.multipleSelection.length + '】条记录, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    let ids = '?';
                    this.multipleSelection.forEach(item => {
                        ids += 'ids=' + item.id + '&';
                    })
                    this.deleteRequest("/system/basic/joblevel/batch" + ids).then(resp => {
                        this.initJobLevel();
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
    .jobLevelMain {
        margin-top: 8px;
    }

    .updateJLInput {
        width: 300px;
        margin-left: 8px;
    }
</style>
