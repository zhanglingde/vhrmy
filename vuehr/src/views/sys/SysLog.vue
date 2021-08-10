<template>
    <div>
        <div>
            <el-table
                    :data="logs"
                    height="730"
                    border
                    fit="true"
                    style="width: 100%">
                <el-table-column
                        type="selection"
                        width="55">
                </el-table-column>
                <el-table-column prop="host"
                                 label="客户端"
                                 width="180">
                </el-table-column>
                <el-table-column prop="level"
                                 label="等级"
                                 width="180">
                </el-table-column>
                <el-table-column prop="loggerName"
                                 label="位置"
                                 width="180">
                </el-table-column>
                <el-table-column
                        prop="message"
                        label="消息"
                        height="80"
                        width="180">
                </el-table-column>
                <el-table-column
                        prop="threadName"
                        label="线程">
                </el-table-column>
            </el-table>
        </div>
    </div>
</template>

<script>
    export default {
        name: "SysBasic",
        data(){
            return{
                logs:[]
            }
        },
        mounted() {
            this.initLogs();
        },
        methods:{
            initLogs(){
                this.getRequest("/system/log/").then(resp=>{
                    if(resp){
                        this.logs = resp.data;
                    }
                })
            }
        }
    }
</script>

<style scoped>

</style>