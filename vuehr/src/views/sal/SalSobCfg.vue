<template>
    <div>
        <div>
            <el-table
                    :data="emps"
                    border
                    style="width: 100%">
                <el-table-column
                        type="selection"
                        width="55">
                </el-table-column>
                <el-table-column align="center" prop="name" label="姓名"></el-table-column>
                <el-table-column align="center" prop="workId" label="工号"></el-table-column>
                <el-table-column align="center" prop="email" label="电子邮件"></el-table-column>
                <el-table-column align="center" prop="phone" label="电话号码"></el-table-column>
                <el-table-column align="center" prop="department.departmentName" label="所属部门"></el-table-column>
                <el-table-column align="center" label="工资账套">
                    <template slot-scope="scope">
                        <el-tooltip class="item" effect="dark" placement="right">
                            <div slot="content">
                                <table>
                                    <tr>
                                        <td>基本工资</td>
                                        <td>{{scope.row.salary.basicSalary}}</td>
                                    </tr>
                                    <tr>
                                        <td>交通补助</td>
                                        <td>{{scope.row.salary.trafficSalary}}</td>
                                    </tr>
                                    <tr>
                                        <td>午餐补助</td>
                                        <td>{{scope.row.salary.lunchSalary}}</td>
                                    </tr>
                                    <tr>
                                        <td>奖金</td>
                                        <td>{{scope.row.salary.bonus}}</td>
                                    </tr>
                                    <tr>
                                        <td>养老金比率</td>
                                        <td>{{scope.row.salary.pensionPer}}</td>
                                    </tr>
                                    <tr>
                                        <td>养老金基数</td>
                                        <td>{{scope.row.salary.pensionBase}}</td>
                                    </tr>
                                    <tr>
                                        <td>医疗保险比率</td>
                                        <td>{{scope.row.salary.medicalPer}}</td>
                                    </tr>
                                    <tr>
                                        <td>医疗保险基数</td>
                                        <td>{{scope.row.salary.medicalBase}}</td>
                                    </tr>
                                    <tr>
                                        <td>公积金比率</td>
                                        <td>{{scope.row.salary.accumulationFundPer}}</td>
                                    </tr>
                                    <tr>
                                        <td>公积金基数</td>
                                        <td>{{scope.row.salary.accumulationFundBase}}</td>
                                    </tr>
                                    <tr>
                                        <td>启用时间</td>
                                        <td>{{scope.row.salary.createDate}}</td>
                                    </tr>
                                </table>
                            </div>
                            <el-tag>{{scope.row.salary.name}}</el-tag>
                        </el-tooltip>
                    </template>
                </el-table-column>
                <el-table-column align="center" label="操作">
                    <template slot-scope="scope">
                        <el-popover
                                placement="left"
                                title="修改工资账套"
                                width="200"
                                @show="showPop(scope.row.salary)"
                                @hide="hidePop(scope.row)"
                                trigger="click">
                            <div>
                                <el-select v-model="currentSalary" placeholder="请选择">
                                    <el-option
                                            v-for="item in salaries"
                                            :key="item.id"
                                            :label="item.name"
                                            :value="item.id">
                                    </el-option>
                                </el-select>
                            </div>
                            <el-button slot="reference" type="danger">修改工资账套
                            </el-button>
                        </el-popover>
                    </template>
                </el-table-column>
            </el-table>
            <div style="display: flex;justify-content: flex-end;margin-top: 4px;">
                <el-pagination
                        background
                        @size-change="sizeChange"
                        @current-change="currentChange"
                        layout="sizes, prev, pager, next, jumper, ->, total, slot"
                        :total="total">
                </el-pagination>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "SalSob",
        data() {
            return {
                emps: [],
                salaries: [],
                currentPage: 1,
                currentSize: 10,
                total: 0,
                currentSalary: null

            }
        },
        mounted() {
            this.initEmps();
            this.initSalaries();
        },
        methods: {
            initSalaries() {
                this.getRequest("/salary/sobcfg/salaries").then(resp => {
                    if (resp) {
                        this.salaries = resp;
                    }
                })
            },
            initEmps() {
                this.getRequest("/salary/sobcfg/?page=" + this.currentPage + "&limit=" + this.currentSize).then(resp => {
                    if (resp) {
                        console.log(resp);
                        this.emps = resp.list;
                        this.total = resp.total;
                    }
                })
            },
            currentChange(currentPage) {
                this.currentPage = currentPage;
                this.initEmps();
            },
            sizeChange(pageSize) {
                console.log(pageSize);
                this.currentSize = pageSize;
                this.initEmps();
            },
            // 修改工资账套事件
            showPop(data) {
                this.currentSalary = data.id;
            },
            hidePop(data) {
                if (this.currentSalary) {
                    this.putRequest("/salary/sobcfg/?employeeId="+data.id+"&salaryId="+this.currentSalary).then(resp=>{
                        if (resp) {
                            this.initEmps();
                        }
                    });
                }
            }
        }
    }
</script>

<style>

</style>
