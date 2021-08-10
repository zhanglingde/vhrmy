<template>
    <div>
        <div>
            <el-table
                :data="lovs"
                height="600"
                border
                style="width: 100%">
                <el-table-column
                    type="selection"
                    width="55">
                </el-table-column>
                <el-table-column prop="lovCode"
                    label="值集编码"
                    width="180">
                </el-table-column>
                <el-table-column
                    prop="lovName"
                    label="值集名称"
                    width="180">
                </el-table-column>
                <el-table-column
                    prop="description"
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
            lovs:[]
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
