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
                <el-button type="primary" icon="el-icon-plus" @click="showAddEmpView">添加员工</el-button>
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
                        <el-tag>{{ scope.row.contractTerm }}</el-tag>
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
        <el-dialog
            title="添加员工"
            :visible.sync="dialogVisible"
            width="80%">
            <div>
                <el-form>
                    <el-row>
                        <el-col :span="6">
                            <el-form-item label="姓名:" prop="name">
                                <el-input size="mini" style="width: 150px;" prefix-icon="el-icon-edit"
                                          v-model="emp.name" placeholder="请输入员工姓名"></el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="5">
                            <el-form-item label="性别:" prop="gender">
                                <el-radio-group v-model="emp.gender">
                                    <el-radio label="男">男</el-radio>
                                    <el-radio label="女" style="margin-left: 0px;">女</el-radio>
                                </el-radio-group>
                            </el-form-item>
                        </el-col>
                        <el-col :span="6">
                            <el-form-item label="出生日期:" prop="birthday">
                                <div class="block">
                                    <el-date-picker
                                        v-model="emp.birthday"
                                        type="date"
                                        size="mini"
                                        style="width: 150px;"
                                        value-format="yyyy-MM-dd"
                                        placeholder="出生日期">
                                    </el-date-picker>
                                </div>
                            </el-form-item>
                        </el-col>
                        <el-col :span="7">
                            <el-form-item v-model="emp.politicId" label="政治面貌:" prop="politicId" size="mini">
                                <el-select v-model="value" placeholder="请选择">
                                    <el-option
                                        v-for="item in options"
                                        :key="item.value"
                                        :label="item.label"
                                        :value="item.value">
                                    </el-option>
                                </el-select>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="6">
                            <el-form-item label="民族:" prop="nationId">
                                <el-select v-model="emp.nationId" placeholder="民族" size="mini" style="width: 150px;">
                                    <el-option
                                        v-for="item in options"
                                        :key="item.id"
                                        :label="item.name"
                                        :value="item.id">
                                    </el-option>
                                </el-select>
                            </el-form-item>
                        </el-col>
                        <el-col :span="5">
                            <el-form-item label="籍贯:" prop="nativePlace">
                                <el-input size="mini" style="width: 120px" prefix-icon="el-icon-edit"
                                          v-model="emp.nativePlace" placeholder="请输入籍贯"></el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="6">
                            <el-form-item label="电子邮箱:" prop="email">
                                <el-input size="mini" style="width: 150px" prefix-icon="el-icon-message"
                                          v-model="emp.email" placeholder="请输入电子邮箱"></el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="7">
                            <el-form-item label="联系地址:" prop="address">
                                <el-input size="mini" style="width: 200px" prefix-icon="el-icon-edit"
                                          v-model="emp.address" placeholder="请输入联系地址"></el-input>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="6">
                            <el-form-item label="职位:" prop="posId">
                                <el-select v-model="emp.posId" placeholder="职位" size="mini" style="width: 150px;">
                                    <el-option
                                        v-for="item in options"
                                        :key="item.id"
                                        :label="item.name"
                                        :value="item.id">
                                    </el-option>
                                </el-select>
                            </el-form-item>
                        </el-col>
                        <el-col :span="5">
                            <el-form-item label="职称:" prop="jobLevelId">
                                <el-select v-model="emp.jobLevelId" placeholder="职称" size="mini" style="width: 150px;">
                                    <el-option
                                        v-for="item in options"
                                        :key="item.id"
                                        :label="item.name"
                                        :value="item.id">
                                    </el-option>
                                </el-select>
                            </el-form-item>
                        </el-col>
                        <el-col :span="6">
                            <el-form-item label="所属部门:" prop="departmentId">
                                <el-popover
                                    placement="right"
                                    title="请选择部门"
                                    width="200"
                                    trigger="manual"
                                    v-model="popVisible">
                                    <el-tree default-expand-all :data="allDeps" :props="defaultProps"
                                             @node-click="handleNodeClick"></el-tree>
                                    <div slot="reference"
                                         style="width: 150px;display: inline-flex;font-size: 13px;border: 1px solid #dedede;height: 26px;border-radius: 5px;cursor: pointer;align-items: center;padding-left: 8px;box-sizing: border-box"
                                         @click="showDepView">{{ inputDepName }}
                                    </div>
                                </el-popover>
                            </el-form-item>
                        </el-col>
                        <el-col :span="7">
                            <el-form-item label="电话号码:" prop="phone">
                                <el-input size="mini" style="width: 200px" prefix-icon="el-icon-phone"
                                          v-model="emp.phone" placeholder="电话号码"></el-input>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="6">
                            <el-form-item label="工号:" prop="workID">
                                <el-input size="mini" style="width: 150px" prefix-icon="el-icon-edit"
                                          v-model="emp.workId" placeholder="工号" disabled></el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="5">
                            <el-form-item label="学历:" prop="tiptopDegree">
                                <el-select v-model="emp.tiptopDegree" placeholder="学历" size="mini"
                                           style="width: 150px;">
                                    <el-option
                                        v-for="item in options"
                                        :key="item"
                                        :label="item"
                                        :value="item">
                                    </el-option>
                                </el-select>
                            </el-form-item>
                        </el-col>
                        <el-col :span="6">
                            <el-form-item label="毕业院校:" prop="school">
                                <el-input size="mini" style="width: 150px" prefix-icon="el-icon-edit"
                                          v-model="emp.school" placeholder="毕业院校名称"></el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="7">
                            <el-form-item label="专业名称:" prop="specialty">
                                <el-input size="mini" style="width: 200px" prefix-icon="el-icon-edit"
                                          v-model="emp.specialty" placeholder="请输入专业名称"></el-input>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="6">
                            <el-form-item label="入职日期:" prop="beginDate">
                                <el-date-picker
                                    v-model="emp.beginDate"
                                    size="mini"
                                    type="date"
                                    value-format="yyyy-MM-dd"
                                    style="width: 130px;"
                                    placeholder="入职日期">
                                </el-date-picker>
                            </el-form-item>
                        </el-col>
                        <el-col :span="5">
                            <el-form-item label="转正日期:" prop="conversionTime">
                                <el-date-picker
                                    v-model="emp.conversionTime"
                                    size="mini"
                                    type="date"
                                    value-format="yyyy-MM-dd"
                                    style="width: 130px;"
                                    placeholder="转正日期">
                                </el-date-picker>
                            </el-form-item>
                        </el-col>
                        <el-col :span="6">
                            <el-form-item label="合同起始日期:" prop="beginContract">
                                <el-date-picker
                                    v-model="emp.beginContract"
                                    size="mini"
                                    type="date"
                                    value-format="yyyy-MM-dd"
                                    style="width: 130px;"
                                    placeholder="合同起始日期">
                                </el-date-picker>
                            </el-form-item>
                        </el-col>
                        <el-col :span="7">
                            <el-form-item label="合同终止日期:" prop="endContract">
                                <el-date-picker
                                    v-model="emp.endContract"
                                    size="mini"
                                    type="date"
                                    value-format="yyyy-MM-dd"
                                    style="width: 150px;"
                                    placeholder="合同终止日期">
                                </el-date-picker>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="8">
                            <el-form-item label="身份证号码:" prop="idCard">
                                <el-input size="mini" style="width: 180px" prefix-icon="el-icon-edit"
                                          v-model="emp.idCard" placeholder="请输入身份证号码"></el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="8">
                            <el-form-item label="聘用形式:" prop="engageForm">
                                <el-radio-group v-model="emp.engageForm">
                                    <el-radio label="劳动合同">劳动合同</el-radio>
                                    <el-radio label="劳务合同">劳务合同</el-radio>
                                </el-radio-group>
                            </el-form-item>
                        </el-col>
                        <el-col :span="8">
                            <el-form-item label="婚姻状况:" prop="wedlock">
                                <el-radio-group v-model="emp.wedlock">
                                    <el-radio label="已婚">已婚</el-radio>
                                    <el-radio label="未婚">未婚</el-radio>
                                    <el-radio label="离异">离异</el-radio>
                                </el-radio-group>
                            </el-form-item>
                        </el-col>
                    </el-row>
                </el-form>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
            </span>
        </el-dialog>
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
            keyword: '',
            dialogVisible: false,
            emp: {
                name: "张灵",
                gender: "男",
                birthday: "1996-01-01",
                idCard: "610122199001011256",
                wedlock: "已婚",
                nationId: 1,
                nativePlace: "陕西",
                politicId: 13,
                email: "laowang@qq.com",
                phone: "18565558897",
                address: "深圳市南山区",
                departmentId: 5,
                jobLevelId: 9,
                posId: 29,
                engageForm: "劳务合同",
                tiptopDegree: "本科",
                specialty: "信息管理与信息系统",
                school: "深圳大学",
                beginDate: "2018-01-01",
                workState: "在职",
                workId: "00000001",
                contractTerm: 2,
                conversionTime: "2018-04-01",
                notWorkDate: null,
                beginContract: "2018-01-01",
                endContract: "2020-01-01",
                workAge: null
            },
            options: [{
                value: '选项1',
                label: '黄金糕'
            }, {
                value: '选项2',
                label: '双皮奶'
            }, {
                value: '选项3',
                label: '蚵仔煎'
            }, {
                value: '选项4',
                label: '龙须面'
            }, {
                value: '选项5',
                label: '北京烤鸭'
            }],
        }
    },
    mounted() {
        this.initEmps();
    },
    methods: {
        initEmps() {
            this.loading = true;
            this.getRequest("/emp/basic/?page=" + this.page + "&limit=" + this.size + "&keyword=" + this.keyword).then(resp => {
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
        },
        showAddEmpView() {
            this.dialogVisible = true;
        }
    }
}
</script>

<style scoped>

</style>
