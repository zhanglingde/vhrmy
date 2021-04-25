<template>
    <div style="width: 500px;margin-bottom: 8px;">
        <el-input
            prefix-icon="el-icon-search"
            placeholder="请输入部门名称"
            v-model="filterText">
        </el-input>

        <el-tree
            class="filter-tree"
            :data="deps"
            :props="defaultProps"
            :filter-node-method="filterNode"
            :expand-on-click-node="false"
            ref="tree">
            <span class="custom-tree-node" style="display: flex;justify-content: space-between;width: 100%;"
                  slot-scope="{ node, data }">
                <span>{{ node.label }}</span>
                <span>
                  <el-button
                      class="depBtn"
                      type="primary"
                      size="mini"
                      @click="() => showAddDepView(data)">
                    添加部门
                  </el-button>
                  <el-button
                      class="depBtn"
                      type="danger"
                      size="mini"
                      @click="() => deleteDep(data)">
                    删除部门
                  </el-button>
                </span>
            </span>
        </el-tree>

        <el-dialog
            title="添加部门"
            :visible.sync="dialogVisible"
            width="30%">
            <div>
                <table>
                    <tr>
                        <td>
                            <el-tag>上级部门</el-tag>
                        </td>
                        <td>
                            <span>{{ pname }}</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <el-tag>部门名称</el-tag>
                        </td>
                        <td>
                            <el-input v-model="dep.departmentName" placeholder="请输入需要添加的部门名称"></el-input>
                        </td>
                    </tr>
                </table>

            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="doAddDep">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
export default {
    name: "DepMana",
    data() {
        return {
            filterText: '',
            deps: [],
            dep: {
                departmentName: '',
                parentId: -1
            },
            pname: '',
            defaultProps: {
                children: 'children',
                label: 'departmentName'
            },
            dialogVisible: false
        }
    },
    mounted() {
        this.initDeps();
    },
    watch: {
        // filterText发生变化时，触发该监控方法
        filterText(val) {
            // 调用树中 配置的 :filter-node-method 方法
            this.$refs.tree.filter(val);
        }
    },
    methods: {
        /**
         * 该方法会一次次被调用，每次调用更新data的json对象,将json对象中的值和输入框输入的value进行比较
         * @param value 输入框输入的值
         * @param data json对象 一行和比较
         * @returns {boolean} 返回匹配的值
         */
        filterNode(value, data) {
            if (!value) return true;
            return data.departmentName.indexOf(value) !== -1;
        },
        initDeps() {
            this.getRequest("/system/basic/department/").then(resp => {
                if (resp) {
                    this.deps = resp;
                }
            })
        },
        // 初始化变量
        initDep() {
            this.dep = {
                departmentName: '',
                parentId: -1
            };
            this.pname = '';
        },
        showAddDepView(data) {
            this.pname = data.departmentName;
            this.dep.parentId = data.id;
            this.dialogVisible = true;
        },
        doAddDep() {
            this.postRequest("/system/basic/department/", this.dep).then(resp => {
                if (resp) {
                    console.log(this.deps);
                    this.addDep2Deps(this.deps, resp.data);
                    this.dialogVisible = false;
                    this.initDep();

                }
            })
        },
        // 将新添加的部门，动态加入部门树中，不需要合并刷新整个树
        addDep2Deps(deps, dep) {
            for (let i = 0; i < deps.length; i++) {
                let d = deps[i];
                if (d.id == dep.parentId) {
                    // concat数组拼接函数
                    d.children = d.children.concat(dep);
                    d.isParent = 1;
                    return;
                } else {
                    // 递归
                    this.addDep2Deps(d.children, dep);
                }
            }
        },
        deleteDep(data) {
            if (data.isParent) {    // 前端判断是否是父目录
                this.$message.error("该目录下有子目录，父目录删除失败！");
            } else {
                this.$confirm('此操作将永久删除【' + data.departmentName + '】部门, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.deleteRequest("/system/basic/department/" + data.id).then(resp => {
                        if (resp) {
                            // 动态从树中移除对象
                            this.removeDepFromDeps(null, this.deps, data.id);
                        }
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            }
        },
        removeDepFromDeps(p, deps, id) {
            for (let i = 0; i < deps.length; i++) {
                let d = deps[i];
                if (d.id == id) {
                    deps.splice(i, 1);
                    if (deps.length == 0) {
                        p.isParent = 0;
                    }
                    return;
                } else {
                    this.removeDepFromDeps(d, d.children, id);
                }
            }
        }
    }
}
</script>

<style>
.depBtn {
    padding: 2px;
}
</style>
