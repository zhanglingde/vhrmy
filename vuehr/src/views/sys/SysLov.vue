<template>
    <div>
        <div>
            <el-table
                :data="lovs"
                height="250"
                border
                style="width: 100%">
                <el-table-column
                    type="selection"
                    width="55">
                </el-table-column>
                <el-table-column prop="date"
                    label="值集编码"
                    width="180">
                </el-table-column>
                <el-table-column
                    prop="name"
                    label="值集名称"
                    width="180">
                </el-table-column>
                <el-table-column
                    prop="address"
                    label="描述">
                </el-table-column>
            </el-table>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {


            : []
        }
    },
    mounted() {
        this.initLovs();
    },
    methods:{
        initLovs(){
            this.getRequest("/system/lov/").then(resp=>{
                if (resp) {
                    this.lovs = resp;
                }
            })
        }
    }
}
</script>

<style scoped>

</style>
