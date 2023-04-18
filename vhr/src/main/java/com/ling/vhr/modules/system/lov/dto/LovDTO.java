package com.ling.vhr.modules.system.lov.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.experimental.Accessors;

import javax.validation.constraints.Size;
import java.util.List;

/**
 * 值集头DTO
 *
 * @author zhangling
 * @since 2020-07-27 16:43:28
 */
@Data
@Accessors(chain = true)
@ApiModel("值集头DTO")
public class LovDTO {
    
    @ApiModelProperty("值集ID")
    private Integer lovId;

    @Size(max = 30)
    @ApiModelProperty("值集代码")
    private String lovCode;

    @ApiModelProperty("Lov类型")
    private String lovTypeCode;

    @ApiModelProperty("值集名称")
    private String lovName;

    @ApiModelProperty("值集描述")
    private String description;

    @ApiModelProperty("值字段")
    private String valueField;
    @ApiModelProperty("显示字段")
    private String displayField;

    @ApiModelProperty("独立值集")
    private List<LovValueDTO> lovValueDTOList;
}
