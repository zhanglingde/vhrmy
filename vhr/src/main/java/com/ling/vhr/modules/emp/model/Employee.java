package com.ling.vhr.modules.emp.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ling.vhr.modules.salary.model.Salary;
import com.ling.vhr.modules.system.basic.domain.Department;
import com.ling.vhr.modules.system.basic.model.JobLevel;
import com.ling.vhr.modules.system.basic.model.Position;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.experimental.Accessors;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotEmpty;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;


/**
 * 实体类
 *
 * @author zhangling 2021-04-24 11:05:29
 */
@Data
@Accessors(chain = true)
@ApiModel("员工基本信息表DTO")
public class Employee implements Serializable {

    private static final long serialVersionUID = 200441884710369780L;


    @ApiModelProperty("员工编号")
    private Integer id;

    @ApiModelProperty("员工姓名")
    @NotEmpty(message = "员工姓名不能为空")
    private String name;

    @ApiModelProperty("性别")
    private String gender;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Shanghai")
    @ApiModelProperty("出生日期")
    private Date birthday;

    @ApiModelProperty("身份证号")
    private String idCard;

    @ApiModelProperty("婚姻状况")
    private String wedlock;

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
    private String tiptopDegree;

    @ApiModelProperty("所属专业")
    private String specialty;

    @ApiModelProperty("毕业院校")
    private String school;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Shanghai")
    @ApiModelProperty("入职日期")
    private Date beginDate;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime issueDate;

    @ApiModelProperty("在职状态")
    private String workState;

    @ApiModelProperty("工号")
    private String workId;

    @ApiModelProperty("合同期限")
    private Double contractTerm;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Shanghai")
    @ApiModelProperty("转正日期")
    private Date conversionTime;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Shanghai")
    @ApiModelProperty("离职日期")
    private Date notWorkDate;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Shanghai")
    @ApiModelProperty("合同起始日期")
    private Date beginContract;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Shanghai")
    @ApiModelProperty("合同终止日期")
    private Date endContract;

    @ApiModelProperty("工龄")
    private Integer workAge;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Shanghai")
    @ApiModelProperty("入职日期从")
    private Date beginDateFrom;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Shanghai")
    @ApiModelProperty("入职日期至")
    private Date beginDateTo;

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

    @ApiModelProperty("员工账套")
    private Salary salary;


}