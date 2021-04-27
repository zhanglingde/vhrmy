<template>
    <div>
        <div style="display: flex;justify-content: space-between;margin-bottom: 10px;">
            <el-button icon="el-icon-plus" type="primary">添加工资账套</el-button>
            <el-button icon="el-icon-refresh" type="success"></el-button>
        </div>
        <div>
            <el-table
                :data="salaries"
                border
                style="width: 100%">
                <el-table-column
                    type="selection"
                    width="55">
                </el-table-column>
                <el-table-column align="center" prop="name" label="账套名称" width="120"></el-table-column>
                <el-table-column align="center" prop="basicSalary" label="基本工资" width="100"></el-table-column>
                <el-table-column align="center" prop="trafficSalary" label="交通补助" width="100"></el-table-column>
                <el-table-column align="center" prop="lunchSalary" label="午餐补助" width="100"></el-table-column>
                <el-table-column align="center" prop="bonus" label="奖金" width="120"></el-table-column>
                <el-table-column align="center" prop="createDate" label="启用时间" width="120"></el-table-column>
                <el-table-column align="center" label="养老金">
                    <el-table-column align="center" prop="pensionPer" label="比率" width="120"></el-table-column>
                    <el-table-column align="center" prop="pensionBase" label="基数" width="120"></el-table-column>
                </el-table-column>
                <el-table-column align="center" label="医疗保险">
                    <el-table-column align="center" prop="medicalPer" label="比率" width="120"></el-table-column>
                    <el-table-column align="center" prop="medicalBase" label="基数" width="120"></el-table-column>
                </el-table-column>
                <el-table-column align="center" label="公积金">
                    <el-table-column align="center" prop="accumulationFundPer" label="比率" width="120"></el-table-column>
                    <el-table-column align="center" prop="accumulationFundBase" label="基数"
                                     width="120"></el-table-column>
                </el-table-column>
                <el-table-column align="center" label="操作">
                    <el-table-column align="center" label="编辑" width="120">
                        <el-button>编辑</el-button>
                    </el-table-column>
                    <el-table-column align="center" label="删除" width="120">
                        <template slot-scope="scope">
                            <el-button type="danger" @click="deleteSalary(scope.row)">删除</el-button>
                        </template>
                    </el-table-column>
                </el-table-column>
            </el-table>
        </div>
    </div>
</template>

<script>
export default {
    name: "SalSob",
    data() {
        return {
            salaries: []
        }
    },
    mounted() {
        this.initSalaries();
    },
    methods: {
        initSalaries() {
            this.getRequest("/salary/sob/").then(resp => {
                if (resp) {
                    this.salaries = resp;
                }
            })
        },
        deleteSalary(data) {
            this.$confirm('此操作将永久删除【'+data.name+'】, 是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.deleteRequest("/salary/sob/"+data.id).then(resp=>{
                    if (resp) {
                        this.initSalaries();
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

</style>
