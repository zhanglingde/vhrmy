package com.ling.vhr.modules.system.basic.controller;

import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.modules.system.basic.model.JobLevel;
import com.ling.vhr.modules.system.basic.service.JobLevelService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * (JobLevel)表控制层
 *
 * @author zhangling 2021-04-20 16:35:40
 */
@RestController
@RequestMapping("/system/basic/joblevel")
@Api(tags = "职称管理")
public class JobLevelController {

    @Autowired
    JobLevelService jobLevelService;


    @GetMapping("/")
    public List<JobLevel> list() {
        return jobLevelService.list();
    }

    @PostMapping("/")
    public CommonResult addJobLevel(@RequestBody JobLevel jobLevel) {
        if (jobLevelService.addJobLevel(jobLevel) == 1) {
            return CommonResult.success(null,"添加成功!");
        }
        return CommonResult.error(null,"添加失败!");
    }

    @PutMapping("/")
    public CommonResult updateJobLevel(@RequestBody JobLevel jobLevel) {
        if (jobLevelService.updateJobLevel(jobLevel) == 1) {
            return CommonResult.success(null,"修改成功!");
        }
        return CommonResult.error(null,"修改失败!");
    }

    @DeleteMapping("/{id}")
    public CommonResult deleteJobLevel(@PathVariable("id") Integer id) {
        if (jobLevelService.deleteJobLevel(id) == 1) {
            return CommonResult.success(null,"删除成功!");
        }
        return CommonResult.error(null,"删除失败!");
    }

    @DeleteMapping("/batch")
    public CommonResult batchDelete(Integer[] ids) {
        if (jobLevelService.batchDelete(ids) == ids.length) {
            return CommonResult.success(null,"批量删除成功!");
        }
        return CommonResult.error(null,"批量删除失败!");
    }


}