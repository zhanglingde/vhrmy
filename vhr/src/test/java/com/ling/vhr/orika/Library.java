package com.ling.vhr.orika;

import lombok.Data;

import java.util.List;

/**
 * @author zhangling
 * @date 2021/10/19 4:09 下午
 */
@Data
public class Library {
    private String name;
    private List<Book> books;
}
