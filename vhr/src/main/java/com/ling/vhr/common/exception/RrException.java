package com.ling.vhr.common.exception;

/**
 * 自定义异常
 * @author zhangling  2021/4/17 14:15
 */
public class RrException extends RuntimeException{

    private final transient Object[] parameters;

    private String msg;
    private int code = 500;

    public RrException(String msg) {
        super(msg);
        this.msg = msg;
        this.parameters = new Object[]{};
    }

    public RrException(Throwable cause, Object... parameters) {
        super(cause);
        this.parameters = parameters;
    }

    public RrException(String msg, Throwable e) {
        super(msg, e);
        this.msg = msg;
        this.parameters = new Object[]{};
    }

    public RrException(String msg, int code) {
        super(msg);
        this.msg = msg;
        this.code = code;
        this.parameters = new Object[]{};
    }

    public RrException(String msg, int code, Throwable e) {
        super(msg, e);
        this.msg = msg;
        this.code = code;
        this.parameters = new Object[]{};
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }
}
