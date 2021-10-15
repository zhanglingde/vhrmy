package com.ling.vhr.common.exception;

import com.ling.vhr.common.utils.CommonResult;
import com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

/**
 * @author zhangling  2021/4/19 21:53
 */
@RestControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

//    @Value("${spring.profiles.active}")
//    private String active;

    /**
     * 参数校验异常，将校验失败的所有异常组合成一条错误信息(@Valid 校验)
     *
     * @param e 异常
     * @return 异常结果
     */
    @ExceptionHandler(value = MethodArgumentNotValidException.class)
    public CommonResult handleValidException(HttpServletRequest req, HttpServletResponse resp, MethodArgumentNotValidException e) {
        logger.error("Catch a MethodArgumentNotValidException（参数绑定校验异常） in API【 {} 】", req.getRequestURL().toString(), e);
        return wrapperBindingResult(e.getBindingResult());
    }

    /**
     * 包装绑定异常结果
     *
     * @param bindingResult 绑定结果
     * @return 异常结果
     */
    private CommonResult wrapperBindingResult(BindingResult bindingResult) {
        StringBuilder msg = new StringBuilder();
        for (ObjectError error : bindingResult.getAllErrors()) {
            msg.append(", ");
            if (error instanceof FieldError) {
                msg.append(((FieldError) error).getField()).append(": ");
            }
            msg.append(error.getDefaultMessage() == null ? "" : error.getDefaultMessage());
        }

        return CommonResult.error(500, msg.substring(2));
    }


    /**
     * sql异常
     *
     * @param e 数据访问异常
     * @return 异常结果
     */
    @ExceptionHandler(value = DataAccessException.class)
    public CommonResult handleSQLException(HttpServletRequest req, HttpServletResponse resp, DataAccessException e) {
        logger.error("Catch a DataAccessException in API【 {} 】", req.getRequestURL().toString(), e);
//        if ("prod".equals(active)) {
//            return CommonResult.error(500, "服务错误");
//        }
        return CommonResult.error(500, "sql错误：" + e.getMessage());
    }

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
