package com.ling.vhr.modules.emp.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;
import java.util.Objects;

import lombok.*;


/**
 * 民族
 *
 * @author zhangling 2021-04-24 12:42:34
 */
@Data
@ApiModel("民族实体")
public class Nation implements Serializable {

    private static final long serialVersionUID = 827325570394716029L;

    private Integer id;

    private String name;

    public Nation() {
    }

    public Nation(String name) {
        this.name = name;
    }

    /**
     * name相同对象就相同
     * @param o
     * @return
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Nation nation = (Nation) o;
        return name.equals(nation.name);
    }

}