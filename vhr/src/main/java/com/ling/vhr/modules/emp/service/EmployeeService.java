package com.ling.vhr.modules.emp.service;

import com.ling.vhr.common.exception.RrException;
import com.ling.vhr.common.utils.CommonParams;
import com.ling.vhr.common.utils.POIUtils;
import com.ling.vhr.common.utils.PageUtils;
import com.ling.vhr.mapper.EmployeeMapper;
import com.ling.vhr.modules.emp.model.Employee;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.AmqpException;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import javax.lang.model.element.VariableElement;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 员工基本信息表(Employee)表服务实现类
 *
 * @author zhangling 2021-04-24 11:05:31
 */
@Slf4j
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    RabbitTemplate rabbitTemplate;

    SimpleDateFormat yearDateFormat = new SimpleDateFormat("yyyy");
    SimpleDateFormat monthDateFormat = new SimpleDateFormat("MM");
    DecimalFormat decimalFormat = new DecimalFormat("##.00");


    /**
     * 分页查询员工基础信息
     *
     * @param params
     * @return
     */
    public PageUtils<Employee> getEmployeeByPage(Employee employee, CommonParams params) {
        if (params.getPage() == null || params.getLimit() == null) {
            throw new RrException("分页参数不能为空！");
        }
        Integer page = (params.getPage() - 1) * params.getLimit();

        List<Employee> list = employeeMapper.selectEmployeeByPage(employee, page, params.getLimit());
        Long total = employeeMapper.getTotal(employee);
        PageUtils<Employee> pageUtils = new PageUtils<>(list, total, params.getLimit(), page);
        return pageUtils;
    }

    /**
     * 添加员工
     *
     * @param employee
     * @return
     */
    public Integer addEmployee(Employee employee) {
        // 计算合同期限
        Date beginContract = employee.getBeginContract();
        Date endContract = employee.getEndContract();
        Double month = (Double.valueOf(yearDateFormat.format(endContract)) - Double.valueOf(yearDateFormat.format(beginContract))) * 12 +
                (Double.valueOf(monthDateFormat.format(endContract)) - Double.valueOf(monthDateFormat.format(beginContract)));
        employee.setContractTerm(Double.valueOf(decimalFormat.format(month / 12)));
        Integer result = employeeMapper.insertSelective(employee);
        if (result == 1) {
            Employee emp = employeeMapper.selectByPrimaryKey(employee.getId());
            // TODO 存储消息日志
            try {
                rabbitTemplate.convertAndSend("ling-direct-exchange", "direct", emp);
            } catch (AmqpException e) {
                log.error("发送 mq 消息错误", e);
            }
        }
        return result;
    }

    /**
     * @return 最大员工号
     */
    public Integer maxWorkId() {
        return employeeMapper.maxWorkId();
    }

    /**
     * 删除员工
     *
     * @param employeeId
     * @return
     */
    public Integer deleteEmployee(Integer employeeId) {
        return employeeMapper.deleteByPrimaryKey(employeeId);
    }

    /**
     * 更新员工信息
     *
     * @param employee
     * @return
     */
    public Integer updateEmployee(Employee employee) {
        return employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 导出数据
     * @return
     */
    public ResponseEntity<byte[]> exportData() {
        List<Employee> list = employeeMapper.selectEmployeeByPage(new Employee(), null, null);
        return POIUtils.employee2Excel(list);
    }

    /**
     * 批量添加导入员工
     * @param list
     */
    public void batchAddEmployee(List<Employee> list) {
        employeeMapper.batchInsert(list);
    }

    /**
     * 获取员工账套
     * @param params
     * @return
     */
    public PageUtils<List<Employee>> getEmployeesByPageWithSalary(CommonParams params) {
        if (params.getPage() == null || params.getLimit() == null) {
            throw new RrException("分页参数不能为空!");
        }
        Integer offset = (params.getPage() - 1) * params.getLimit();
        List<Employee> list = employeeMapper.getEmployeesByPageWithSalary(offset, params.getLimit());
        Long total = employeeMapper.getTotal(null);
        PageUtils pageUtils = new PageUtils(list, total, params.getLimit(), params.getPage());
        return pageUtils;
    }

    /**
     * 更新员工工资套账
     * @param employeeId
     * @param salaryId
     * @return
     */
    public Integer updateEmployeeSalaryById(Integer employeeId, Integer salaryId) {
        return employeeMapper.updateEmployeeSalaryById(employeeId, salaryId);
    }
}