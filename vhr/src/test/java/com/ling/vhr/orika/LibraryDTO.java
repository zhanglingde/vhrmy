package com.ling.vhr.orika;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

/**
 * @author zhangling
 * @date 2021/10/19 4:10 下午
 */
@Data
@Accessors(chain = true)
public class LibraryDTO {
    private String name;
    private List<BookDTO> bookDTOList;
}
