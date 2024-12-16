package com.ling.vhr.modules.invoice;


import lombok.Data;
import org.dromara.easyes.annotation.IndexName;

@Data
@IndexName("t_book2")
public class Book {

    private String code;

    private String name;
}
