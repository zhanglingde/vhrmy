<template>
    <div>
        <div>
            <el-input
                    size="mini"
                    class="addPosInput"
                    placeholder="添加职位"
                    prefix-icon="el-icon-plus"
                    @keydown.enter.native="addPosition"
                    v-model="pos.name">
            </el-input>
            <el-button icon="el-icon-plus" size="small" type="primary"  @click="addPosition">添加</el-button>
        </div>
        <div class="posManaMain">
            <el-table
                    :data="positions"
                    border
                    script
                    @selection-change="handleSelectionChange"
                    size="small"
                    style="width: 50%">
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
                        label="职位名称"
                        width="180">
                </el-table-column>
                <el-table-column
                        prop="createDate"
                        width="150"
                        label="创建时间">
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
            <el-button size="small" type="danger" style="margin-top: 8px;" @click="batchDelete"
                       :disabled="multipleSelection.length == 0">批量删除
            </el-button>
        </div>
        <el-dialog
                title="修改职位"
                :visible.sync="dialogVisible"
                width="30%">
            <div>
                <el-tag>职位名称</el-tag>
                <el-input class="updatePosInput" size="small" v-model="updatePos.name"></el-input>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button size="small" @click="dialogVisible = false">取 消</el-button>
                <el-button size="small" type="primary" @click="doUpdate">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        name: "PosMana",
        data() {
            return {
                pos: {
                    name: ''
                },
                dialogVisible: false,
                updatePos: {
                    name: ''
                },
                // 多选参数，保存选中项
                multipleSelection: [],
                positions: []
            }
        },
        // vue生命周期
        mounted() {
            this.initPositions();
        },
        methods: {
            handleSelectionChange(val) {
                // 选中时触发回调，赋值
                this.multipleSelection = val;
            },
            // 初始化列表数据
            initPositions() {
                this.getRequest("/system/basic/pos/").then(resp => {
                    if (resp) {
                        this.positions = resp;
                    }
                })
            },
            showEditView(index, data) {
                // 变量拷贝，取消编辑的时候页面数据不变
                Object.assign(this.updatePos, data);
                this.dialogVisible = true;
            },
            doUpdate() {
                this.putRequest("/system/basic/pos/", this.updatePos).then(resp => {
                    this.initPositions();
                    this.updatePos.name = '';
                    this.dialogVisible = false;
                })
            },
            handleDelete(index, data) {
                this.$confirm('此操作将永久删除【' + data.name + '】职位, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.deleteRequest("/system/basic/pos/?id=" + data.id).then(resp => {
                        this.initPositions();
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });

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
                    this.deleteRequest("/system/basic/pos/batch" + ids).then(resp => {
                        this.initPositions();
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            addPosition() {
                if (this.pos.name) {
                    this.postRequest("/system/basic/pos/", this.pos).then(resp => {
                        if (resp) {
                            // 添加成功后刷新表格
                            this.initPositions();
                            this.pos.name = '';
                        }
                    })
                } else {
                    this.$message.error('职位名称不可以为空!');
                }
            }
        }
    }
</script>

<style>
    .updatePosInput {
        width: 300px;
        margin-left: 8px;
    }

    .addPosInput {
        width: 300px;
        margin-right: 8px;
    }

    .posManaMain {
        margin-top: 10px;
    }

</style>
