package com.ling.vhr.modules.system.lov.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ling.vhr.modules.system.lov.domain.vo.LovValueVO;
import io.swagger.annotations.ApiModelProperty;
import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Transient;

import java.io.Serializable;
import java.util.List;


/**
 * 返回值VO
 *
 * @author zhangling
 * @since 2020-09-14 13:31:44
 */
@Data
@Builder
@TableName(value = "au_lov")
public class LovEntity implements Serializable {

    private static final long serialVersionUID = -89999311604615802L;


    @TableId(value = "lov_id",type = IdType.AUTO)
    private Integer lovId;

    @ApiModelProperty("LOV代码")
    private String lovCode;

    @ApiModelProperty("值集名称")
    private String lovName;

    @ApiModelProperty("描述")
    private String description;

    public LovEntity() {
    }

    public LovEntity(Integer lovId, String lovCode, String lovName, String description) {
        this.lovId = lovId;
        this.lovCode = lovCode;
        this.lovName = lovName;
        this.description = description;
    }
}