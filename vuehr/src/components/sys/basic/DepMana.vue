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
            ref="tree">
        </el-tree>
    </div>
</template>

<script>
export default {
    name: "DepMana",
    data() {
        return {
            filterText: '',
            deps: [],
            defaultProps: {
                children: 'children',
                label: 'departmentName'
            }
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
         * 该方法会一次次被调用，每次调用更新data的json对象
         * @param value 输入框输入的值
         * @param data json对象 一行和比较
         * @returns {boolean}
         */
        filterNode(value, data) {
            if (!value) return true;
            return data.label.indexOf(value) !== -1;
        },
        initDeps() {
            this.getRequest("/system/basic/department/").then(resp => {
                if (resp) {
                    this.deps = resp;
                }
            })
        }
    }
}
</script>

<style scoped>

</style>
