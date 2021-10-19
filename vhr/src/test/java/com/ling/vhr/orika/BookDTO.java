package com.ling.vhr.orika;

import lombok.Data;
import lombok.experimental.Accessors;

/**
 * @author zhangling
 * @date 2021/10/19 3:48 下午
 */
@Data
@Accessors(chain = true)
public class BookDTO {
    private String name;
    private String authorZh;
}
