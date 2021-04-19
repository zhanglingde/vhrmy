package com.ling.vhr.common.exception;

import com.ling.vhr.common.utils.CommonResult;
import com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.sql.SQLException;

/**
 * @author zhangling  2021/4/19 21:53
 */
@RestControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);


    @ExceptionHandler(value = SQLException.class)
    public CommonResult sqlException(SQLException e) {
        logger.error("数据库错误：{}", e.getMessage());
        if (e instanceof MySQLIntegrityConstraintViolationException) {
            // 外键关联
            return CommonResult.error("该数据有关联数据，操作失败");
        }
        return CommonResult.error("数据库错误！");
    }
}
