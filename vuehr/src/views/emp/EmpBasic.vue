<template>
    <div>
        <div style="display: flex;justify-content: space-between">
            <div>
                <el-input placeholder="通过员工名搜索员工，回车搜索..." prefix-icon="el-icon-search"
                          clearable
                          @clear="initEmps"
                          v-model="keyword"
                          @keydown.enter.native="initEmps"
                          style="width: 300px;margin-right: 10px;"></el-input>
                <el-button icon="el-icon-search" type="primary" @click="initEmps">搜索</el-button>
                <el-button type="primary">
                    <i class="fa fa-angle-double-down" aria-hidden="true"></i>
                    高级搜索
                </el-button>
            </div>
            <div>
                <el-button type="success">
                    <i class="fa fa-level-up" aria-hidden="true"></i>
                    导入数据
                </el-button>
                <el-button type="success">
                    <i class="fa fa-level-down" aria-hidden="true"></i>
                    导出数据
                </el-button>
                <el-button type="primary" icon="el-icon-plus">添加员工</el-button>
            </div>
        </div>
        <div style="margin-top: 10px;">
            <el-table
                    v-loading="loading"
                    element-loading-text="拼命加载中"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(0, 0, 0, 0.8)"
                    :data="emps"
                    border
                    style="width: 100%">
                <el-table-column
                        type="selection"
                        width="55">
                </el-table-column>
                <el-table-column
                        prop="name"
                        fixed
                        align="left"
                        label="姓名"
                        width="90">
                </el-table-column>
                <el-table-column
                        align="left"
                        prop="workId"
                        label="工号"
                        width="85">
                </el-table-column>
                <el-table-column
                        align="left"
                        prop="birthday"
                        width="90px"
                        label="出生日期">
                </el-table-column>
                <el-table-column
                        align="left"
                        prop="idCard"
                        width="160px"
                        label="身份证号">
                </el-table-column>
                <el-table-column
                        align="center"
                        prop="nation.name"
                        width="60px"
                        label="民族">
                </el-table-column>
                <el-table-column
                        align="center"
                        prop="nativePlace"
                        width="90px"
                        label="籍贯">
                </el-table-column>
                <el-table-column
                        align="center"
                        prop="wedlock"
                        width="60px"
                        label="婚姻">
                </el-table-column>
                <el-table-column
                        align="left"
                        prop="politicsStatus.name"
                        width="90px"
                        label="政治面貌">
                </el-table-column>
                <el-table-column
                        align="left"
                        prop="email"
                        width="150px"
                        label="电子邮件">
                </el-table-column>
                <el-table-column
                        align="left"
                        prop="phone"
                        width="100px"
                        label="电话号码">
                </el-table-column>
                <el-table-column
                        align="left"
                        prop="address"
                        width="220px"
                        label="联系地址">
                </el-table-column>
                <el-table-column
                        align="left"
                        prop="department.departmentName"
                        width="90px"
                        label="所属部门">
                </el-table-column>
                <el-table-column
                        align="left"
                        prop="position.name"
                        width="90px"
                        label="职位">
                </el-table-column>
                <el-table-column
                        align="left"
                        prop="jobLevel.name"
                        width="120px"
                        label="职称">
                </el-table-column>
                <el-table-column
                        align="left"
                        prop="engageForm"
                        width="90px"
                        label="聘用形式">
                </el-table-column>
                <el-table-column
                        align="left"
                        prop="beginDate"
                        width="90px"
                        label="入职日期">
                </el-table-column>
                <el-table-column
                        align="left"
                        prop="conversionTime"
                        width="90px"
                        label="转正日期">
                </el-table-column>
                <el-table-column
                        align="left"
                        prop="beginContract"
                        width="90px"
                        label="合同起始日期">
                </el-table-column>
                <el-table-column
                        align="left"
                        prop="endContract"
                        width="90px"
                        label="合同终止日期">
                </el-table-column>
                <el-table-column
                        align="left"
                        width="90px"
                        label="合同期限">
                    <template slot-scope="scope">
                        <el-tag>{{scope.row.contractTerm}}</el-tag>
                        年
                    </template>
                </el-table-column>
                <el-table-column
                        align="left"
                        prop="tiptopDegree"
                        width="90px"
                        label="最高学历">
                </el-table-column>
                <el-table-column
                        fixed="right"
                        width="200px"
                        label="操作">
                    <template slot-scope="scope">
                        <el-button style="padding: 3px;" size="mini">编辑</el-button>
                        <el-button style="padding: 3px;" size="mini" type="primary">查看高级资料</el-button>
                        <el-button style="padding: 3px;" size="mini" type="danger">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <div style="display: flex;justify-content: flex-end">
                <el-pagination
                        @size-change="sizeChange"
                        @current-change="currentChange"
                        background
                        layout="sizes, prev, pager, next, jumper, ->, total, slot"
                        :total="total">
                </el-pagination>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "EmpBasic",
        data() {
            return {
                emps: [],
                loading: false,
                total: 0,
                page: 1,
                size: 10,
                keyword: ''
            }
        },
        mounted() {
            this.initEmps();
        },
        methods: {
            initEmps() {
                this.loading = true;
                this.getRequest("/emp/basic/?page=" + this.page + "&limit=" + this.size+"&keyword="+this.keyword).then(resp => {
                    if (resp) {
                        this.loading = false;
                        this.emps = resp.list;
                        this.total = resp.total;
                    }
                })
            },
            currentChange(currentPage) {
                this.page = currentPage;
                this.initEmps();
            },
            sizeChange(currentSize) {
                this.size = currentSize;
                this.initEmps();
            }
        }
    }
</script>

<style scoped>

</style>