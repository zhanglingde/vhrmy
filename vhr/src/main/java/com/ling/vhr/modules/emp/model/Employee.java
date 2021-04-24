package com.ling.vhr.modules.emp.model;

import java.util.Date;

import com.ling.vhr.modules.system.basic.model.Department;
import com.ling.vhr.modules.system.basic.model.JobLevel;
import com.ling.vhr.modules.system.basic.model.Position;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;

import lombok.*;


/**
 * 实体类
 *
 * @author zhangling 2021-04-24 11:05:29
 */
@Data
@ApiModel("员工基本信息表DTO")
public class Employee implements Serializable {

    private static final long serialVersionUID = 200441884710369780L;


    @ApiModelProperty("员工编号")
    private Integer id;

    @ApiModelProperty("员工姓名")
    private String name;

    @ApiModelProperty("性别")
    private String gender;

    @ApiModelProperty("出生日期")
    private Date birthday;

    @ApiModelProperty("身份证号")
    private String idCard;

    @ApiModelProperty("婚姻状况")
    private Object wedlock;

    @ApiModelProperty("民族")
    private Integer nationId;

    @ApiModelProperty("籍贯")
    private String nativePlace;

    @ApiModelProperty("政治面貌")
    private Integer politicId;

    @ApiModelProperty("邮箱")
    private String email;

    @ApiModelProperty("电话号码")
    private String phone;

    @ApiModelProperty("联系地址")
    private String address;

    @ApiModelProperty("所属部门")
    private Integer departmentId;

    @ApiModelProperty("职称ID")
    private Integer jobLevelId;

    @ApiModelProperty("职位ID")
    private Integer posId;

    @ApiModelProperty("聘用形式")
    private String engageForm;

    @ApiModelProperty("最高学历")
    private Object tiptopDegree;

    @ApiModelProperty("所属专业")
    private String specialty;

    @ApiModelProperty("毕业院校")
    private String school;

    @ApiModelProperty("入职日期")
    private Date beginDate;

    @ApiModelProperty("在职状态")
    private Object workState;

    @ApiModelProperty("工号")
    private String workId;

    @ApiModelProperty("合同期限")
    private Object contractTerm;

    @ApiModelProperty("转正日期")
    private Date conversionTime;

    @ApiModelProperty("离职日期")
    private Date notWorkDate;

    @ApiModelProperty("合同起始日期")
    private Date beginContract;

    @ApiModelProperty("合同终止日期")
    private Date endContract;

    @ApiModelProperty("工龄")
    private Integer workAge;

    @ApiModelProperty("部门")
    private Department department;
    @ApiModelProperty("民族")
    private Nation nation;
    @ApiModelProperty("政治面貌")
    private PoliticsStatus politicsStatus;
    @ApiModelProperty("职称")
    private JobLevel jobLevel;
    @ApiModelProperty("职位")
    private Position position;


}