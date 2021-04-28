<template>
    <div>
        <div style="display: flex;justify-content: space-between;margin-bottom: 10px;">
            <el-button icon="el-icon-plus" type="primary" @click="showAddSalaryView">添加工资账套</el-button>
            <el-button icon="el-icon-refresh" type="success" @click="initSalaries"></el-button>
            <el-dialog
                :title="dialogTitle"
                :visible.sync="dialogVisible"
                width="50%">
                <div style="display: flex;justify-content: space-around;align-items: center;">
                    <el-steps direction="vertical" :active="activeItemIndex">
                        <el-step :title="itemName" v-for="(itemName,index) in salaryItemName" :key="index"></el-step>
                    </el-steps>
                    <el-input v-show="activeItemIndex == index"
                              v-model="salary[title]"
                              v-for="(value,title,index) in salary"
                              :placeholder="'请输入'+salaryItemName[index]+'...'"
                              :key="index" style="width: 300px;"></el-input>
                </div>
                <span slot="footer" class="dialog-footer">
                    <el-button @click="preStep">{{ this.activeItemIndex == 0 ? '取消' : '上一步' }}</el-button>
                    <el-button type="primary"
                               @click="nextStep">{{ this.activeItemIndex == 10 ? '确定' : '下一步' }}</el-button>
                </span>
            </el-dialog>
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
                        <template slot-scope="scope">
                            <el-button @click="showEditSalaryView(scope.row)">编辑</el-button>
                        </template>
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
            salaries: [],
            dialogVisible: false,
            dialogTitle: '',
            activeItemIndex: 0,
            salaryItemName: [
                '基本工资',
                '交通补助',
                '午餐补助',
                '奖金',
                '养老金比率',
                '养老金基数',
                '医疗保险比率',
                '医疗保险基数',
                '公积金比率',
                '公积金基数',
                '账套名称'
            ],
            salary: {
                basicSalary: 0,
                trafficSalary: 0,
                lunchSalary: 0,
                bonus: 0,
                pensionPer: 0,
                pensionBase: 0,
                medicalPer: 0,
                medicalBase: 0,
                accumulationFundPer: 0,
                accumulationFundBase: 0,
                name: ''
            }
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
            this.$confirm('此操作将永久删除【' + data.name + '】, 是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.deleteRequest("/salary/sob/" + data.id).then(resp => {
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
        },
        showAddSalaryView() {
            //数据初始化
            this.salary = {
                basicSalary: 0,
                trafficSalary: 0,
                lunchSalary: 0,
                bonus: 0,
                pensionPer: 0,
                pensionBase: 0,
                medicalPer: 0,
                medicalBase: 0,
                accumulationFundPer: 0,
                accumulationFundBase: 0,
                name: '默认名称'
            };
            this.activeItemIndex = 0;
            this.dialogTitle = '添加工资账套';
            this.dialogVisible = true;
        },
        nextStep() {
            if (this.activeItemIndex == 10) {
                if (this.salary.id) {
                    this.putRequest("/salary/sob/", this.salary).then(resp => {
                        if (resp) {
                            this.dialogVisible = false;
                            this.initSalaries();
                            return;
                        }
                    })
                }else{
                    this.postRequest("/salary/sob/", this.salary).then(resp => {
                        if (resp) {
                            this.dialogVisible = false;
                            this.initSalaries();
                            return;
                        }
                    })
                }
            }
            this.activeItemIndex++;
        },
        preStep() {
            console.log(this.activeItemIndex);
            if (this.activeItemIndex == 0) {
                this.dialogVisible = false;
                return;
            }
            this.activeItemIndex--;
        },
        showEditSalaryView(data) {
            this.salary.id = data.id;
            this.salary.basicSalary = data.basicSalary;
            this.salary.trafficSalary = data.trafficSalary;
            this.salary.lunchSalary = data.lunchSalary;
            this.salary.bonus = data.bonus;
            this.salary.pensionPer = data.pensionPer;
            this.salary.pensionBase = data.pensionBase;
            this.salary.medicalPer = data.medicalPer;
            this.salary.medicalBase = data.medicalBase;
            this.salary.accumulationFundPer = data.accumulationFundPer;
            this.salary.accumulationFundBase = data.accumulationFundBase;
            this.salary.name = data.name;

            this.activeItemIndex = 0;
            this.dialogTitle = '编辑工资账套';
            this.dialogVisible = true;
        }
    }
}
</script>

<style>

</style>
