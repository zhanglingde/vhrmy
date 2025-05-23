package com.ling.vhr.modules.system.lov.domain.dto;

import com.ling.vhr.modules.system.lov.domain.vo.LovValueVO;
import io.github.linpeilie.annotations.AutoMapper;
import io.github.linpeilie.annotations.AutoMapping;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 值集值DTO
 *
 * @author zhangling
 * @since 2020/7/27 10:41
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("值集值DTO")
@AutoMapper(target = LovValueVO.class, reverseConvertGenerate = true)
public class LovValueDTO {

    @ApiModelProperty("主键id")
    private Integer lovValueId;

    @ApiModelProperty("关联值集头")
    private Integer lovId;

    @ApiModelProperty("值集代码")
    private String lovCode;

    @ApiModelProperty("值集值")
    private String value;

    @ApiModelProperty("含义")
    private String meaning;

    @AutoMapping(source = "desc", target = "description")
    @ApiModelProperty("描述")
    private String desc;

    @ApiModelProperty("备注")
    private String remark;

    @ApiModelProperty("排序")
    public Integer orderSeq;

    @ApiModelProperty("启用标识：0禁用，1启用")
    private Integer enabledFlag;
}
