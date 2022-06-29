package com.ling.vhr.modules.system.basic.controller;

import com.ling.vhr.common.utils.CommonResult;
import com.ling.vhr.modules.system.basic.model.JobLevel;
import com.ling.vhr.modules.system.basic.service.JobLevelService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
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


    @ApiOperation(value = "职称列表", notes = "职称列表")
    @GetMapping(name = "职称列表", value = "/")
    public List<JobLevel> list() {
        return jobLevelService.list();
    }

    @ApiOperation(value = "添加职称", notes = "添加职称")
    @PostMapping(name = "添加职称", value = "/")
    public CommonResult addJobLevel(@RequestBody JobLevel jobLevel) {
        if (jobLevelService.addJobLevel(jobLevel) == 1) {
            return CommonResult.success(null, "添加成功!");
        }
        return CommonResult.error(null, "添加失败!");
    }

    @ApiOperation(value = "修改职称", notes = "修改职称")
    @PutMapping(name = "修改职称", value = "/")
    public CommonResult updateJobLevel(@RequestBody JobLevel jobLevel) {
        if (jobLevelService.updateJobLevel(jobLevel) == 1) {
            return CommonResult.success(null, "修改成功!");
        }
        return CommonResult.error(null, "修改失败!");
    }

    @ApiOperation(value = "删除职称", notes = "删除职称")
    @DeleteMapping(name = "删除职称", value = "/{id}")
    public CommonResult deleteJobLevel(@PathVariable("id") Integer id) {
        if (jobLevelService.deleteJobLevel(id) == 1) {
            return CommonResult.success(null, "删除成功!");
        }
        return CommonResult.error(null, "删除失败!");
    }

    @ApiOperation(value = "批量删除职称", notes = "批量删除职称")
    @DeleteMapping(name = "批量删除职称",value = "/batch")
    public CommonResult batchDelete(Integer[] ids) {
        if (jobLevelService.batchDelete(ids) == ids.length) {
            return CommonResult.success(null, "批量删除成功!");
        }
        return CommonResult.error(null, "批量删除失败!");
    }


}