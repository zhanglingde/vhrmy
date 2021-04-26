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
                <el-button type="success" @click="exportData">
                    <i class="fa fa-level-up" aria-hidden="true"></i>
                    导出数据
                </el-button>
                <el-button type="success">
                    <i class="fa fa-level-down" aria-hidden="true"></i>
                    导入数据
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
                        prop="gender"
                        label="性别"
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
                        <el-button style="padding: 3px;" size="mini" @click="showEditEmpView(scope.row)">编辑</el-button>
                        <el-button style="padding: 3px;" size="mini" type="primary">查看高级资料</el-button>
                        <el-button style="padding: 3px;" size="mini" type="danger" @click="deleteEmp(scope.row)">删除
                        </el-button>
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
                :title="title"
                :visible.sync="dialogVisible"
                width="80%">
            <div>
                <el-form :model="emp" :rules="rules" ref="empForm">
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
                            <el-form-item label="政治面貌:" prop="politicId" size="mini">
                                <el-select v-model="emp.politicId" placeholder="政治面貌">
                                    <el-option
                                            v-for="item in politicsStatus"
                                            :key="item.id"
                                            :label="item.name"
                                            :value="item.id">
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
                                            v-for="item in nations"
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
                                            v-for="item in positions"
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
                                            v-for="item in jobLevels"
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
                                            v-for="item in tiptopDegrees"
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
                <el-button type="primary" @click="doAddEmp">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        name: "EmpBasic",
        data() {
            return {
                title: '',
                emps: [],
                loading: false,
                total: 0,
                page: 1,
                size: 10,
                keyword: '',
                inputDepName: '',
                dialogVisible: false,
                popVisible: false,
                nations: [],
                jobLevels: [],
                politicsStatus: [],
                positions: [],
                allDeps: [],
                tiptopDegrees: ['博士', '硕士', '本科', '大专', '高中', '初中', '小学', '其他'],
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
                    departmentId: null,
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
                defaultProps: {
                    children: 'children',
                    label: 'departmentName'
                },
                rules: {
                    name: [{required: true, message: '请输入用户名', trigger: 'blur'}],
                    gender: [{required: true, message: '请输入性别', trigger: 'blur'}],
                    birthday: [{required: true, message: '请输入出生日期', trigger: 'blur'}],
                    idCard: [{required: true, message: '请输入身份证号码', trigger: 'blur'}, {
                        pattern: /(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}$)/,
                        message: '身份证号码格式不正确',
                        trigger: 'blur'
                    }],
                    wedlock: [{required: true, message: '请输入婚姻状况', trigger: 'blur'}],
                    nationId: [{required: true, message: '请输入民族', trigger: 'blur'}],
                    nativePlace: [{required: true, message: '请输入籍贯', trigger: 'blur'}],
                    politicId: [{required: true, message: '请输入政治面貌', trigger: 'blur'}],
                    email: [{required: true, message: '请输入电子邮箱', trigger: 'blur'}, {
                        type: 'email',
                        message: '邮箱格式不正确',
                        trigger: 'blur'
                    }],
                    phone: [{required: true, message: '请输入电话号码', trigger: 'blur'}],
                    address: [{required: true, message: '请输入联系地址', trigger: 'blur'}],
                    jobLevelId: [{required: true, message: '请输入职称', trigger: 'blur'}],
                    departmentId: [{required: true, message: '请输入部门', trigger: 'blur'}],
                    posId: [{required: true, message: '请输入职位', trigger: 'blur'}],
                    engageForm: [{required: true, message: '请输入聘用形式', trigger: 'blur'}],
                    tiptopDegree: [{required: true, message: '请输入最高学历', trigger: 'blur'}],
                    specialty: [{required: true, message: '请输入所属专业', trigger: 'blur'}],
                    school: [{required: true, message: '请输入毕业院校', trigger: 'blur'}],
                    beginDate: [{required: true, message: '请输入入职日期', trigger: 'blur'}],
                    contractTerm: [{required: true, message: '请输入合同期限', trigger: 'blur'}],
                    conversionTime: [{required: true, message: '请输入转正日期', trigger: 'blur'}],
                    beginContract: [{required: true, message: '请输入合同起始日期', trigger: 'blur'}],
                    endContract: [{required: true, message: '请输入合同终止日期', trigger: 'blur'}],
                }
            }
        },
        mounted() {
            this.initData();
            this.initEmps();

        },
        methods: {
            emptyEmp() {
                this.emp = {
                    name: "",
                    gender: "",
                    birthday: "",
                    idCard: "",
                    wedlock: "",
                    nationId: 1,
                    nativePlace: "",
                    politicId: 13,
                    email: "",
                    phone: "",
                    address: "",
                    departmentId: null,
                    jobLevelId: 9,
                    posId: 29,
                    engageForm: "",
                    tiptopDegree: "",
                    specialty: "",
                    school: "",
                    beginDate: "",
                    workState: "",
                    workId: "",
                    contractTerm: 2,
                    conversionTime: "",
                    notWorkDate: null,
                    beginContract: "",
                    endContract: "",
                    workAge: null
                }
            },
            initPositions() {
                this.getRequest("/employee/basic/positions").then(resp => {
                    if (resp) {
                        this.positions = resp;
                    }
                })
            },
            initData() {
                if (!window.sessionStorage.getItem("nations")) {
                    this.getRequest("/employee/basic/nations").then(resp => {
                        if (resp) {
                            this.nations = resp;
                            window.sessionStorage.setItem("nations", JSON.stringify(resp));
                        }
                    })
                } else {
                    this.nations = JSON.parse(window.sessionStorage.getItem("nations"));
                }
                if (!window.sessionStorage.getItem("jobLevels")) {
                    this.getRequest("/employee/basic/joblevels").then(resp => {
                        if (resp) {
                            this.jobLevels = resp;
                            window.sessionStorage.setItem("jobLevels", JSON.stringify(resp));
                        }
                    })
                } else {
                    this.jobLevels = JSON.parse(window.sessionStorage.getItem("jobLevels"));
                }
                if (!window.sessionStorage.getItem("politicsStatus")) {
                    this.getRequest("/employee/basic/politicsstatus").then(resp => {
                        if (resp) {
                            this.politicsStatus = resp;
                            window.sessionStorage.setItem("politicsStatus", JSON.stringify(resp));
                        }
                    })
                } else {
                    this.politicsStatus = JSON.parse(window.sessionStorage.getItem("politicsStatus"));
                }
                if (!window.sessionStorage.getItem("departments")) {
                    this.getRequest("/employee/basic/departments").then(resp => {
                        if (resp) {
                            this.allDeps = resp;
                            window.sessionStorage.setItem("departments", JSON.stringify(resp));
                        }
                    })
                } else {
                    this.allDeps = JSON.parse(window.sessionStorage.getItem("departments"));
                }
            },
            initEmps() {
                this.loading = true;
                this.getRequest("/employee/basic/?page=" + this.page + "&limit=" + this.size + "&keyword=" + this.keyword).then(resp => {
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
                this.title = "添加员工";
                this.emptyEmp();
                this.initPositions();
                this.getMaxWorkId();

                this.dialogVisible = true;
            },
            showEditEmpView(data) {
                this.initPositions();
                this.title = '编辑员工信息';
                this.emp = data;
                this.inputDepName = data.department.departmentName;
                this.dialogVisible = true;
            },
            getMaxWorkId() {
                this.getRequest("/employee/basic/maxWorkId").then(resp => {
                    if (resp) {
                        this.emp.workId = resp.data;
                    }
                })
            },
            showDepView() {                         // 选择部门
                this.popVisible = true;
            },
            handleNodeClick(data) {                 // 部门树选择事件
                this.inputDepName = data.departmentName;
                this.emp.departmentId = data.id;
                this.popVisible = !this.popVisible;
            },
            doAddEmp() {
                if (this.emp.id) {  // 更新
                    this.$refs['empForm'].validate(valid => {
                        if (valid) {        // 校验成功再登录
                            this.putRequest("/employee/basic/", this.emp).then(resp => {
                                if (resp) {
                                    this.dialogVisible = false;
                                    this.initEmps();
                                }
                            })
                        }
                    });
                } else {
                    this.$refs['empForm'].validate(valid => {
                        if (valid) {        // 校验成功再登录
                            this.postRequest("/employee/basic/", this.emp).then(resp => {
                                if (resp) {
                                    this.dialogVisible = false;
                                    this.initEmps();
                                }
                            })
                        }
                    });
                }
            },
            deleteEmp(data) {
                this.$confirm('此操作将永久删除【' + data.name + '】, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.deleteRequest("/employee/basic/" + data.id).then(resp => {
                        if (resp) {
                            this.initEmps();
                        }
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            exportData() {
                let url = '/employee/basic/export'
                window.open(url,'_parent');
            }

        }
    }
</script>

<style scoped>

</style>
