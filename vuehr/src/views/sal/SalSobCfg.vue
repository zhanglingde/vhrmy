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
                <el-table-column align="center" prop="workId" label="工号" ></el-table-column>
                <el-table-column align="center" prop="email" label="电子邮件" ></el-table-column>
                <el-table-column align="center" prop="phone" label="电话号码" ></el-table-column>
                <el-table-column align="center" prop="department.departmentName" label="所属部门" ></el-table-column>
                <el-table-column align="center" prop="salary.name" label="工资账套" ></el-table-column>
                <el-table-column align="center" label="操作" >
                    <template slot-scope="scope">
                        <el-button type="danger" @click="deleteSalary(scope.row)">修改账套</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <div style="display: flex;justify-content: flex-end;margin-top: 4px;">
                <el-pagination
                    background
                    layout="sizes, prev, pager, next, jumper, ->, total, slot"
                    :total="1000">
                </el-pagination>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "SalSob",
        data() {
            return{
                emps:[]
            }
        },
        mounted() {
            this.initEmps();
        },
        methods:{
            initEmps() {
                this.getRequest("/salary/sobcfg/").then(resp=>{
                    if (resp) {
                        console.log(resp);
                        this.emps = resp.list;
                    }
                })
            }
        }
    }
</script>

<style>

</style>
