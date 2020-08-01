package cn.ndky.WaterFDS.controller.admin;

import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.pojo.LifeCycle;
import cn.ndky.WaterFDS.service.admin.LifecycleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author lcx
 * @create 2020-07-11 12:48
 * @desc 生命周期管理
 */
@RestController
@RequestMapping("/lifecycle")
public class LifeCycleController {

    @Autowired
    private LifecycleService lifecycleService;

    @GetMapping("/initTable")
    public RespObj initTable(Integer page){
        return lifecycleService.initTable(page);
    }

    @GetMapping("/initSelect")
    public RespObj initSelect(){
        return lifecycleService.initSelect();
    }

    @PostMapping("/add")
    public RespObj addLifeCycle(LifeCycle lifeCycle){
        return lifecycleService.addLifeCycles(lifeCycle);
    }

    @DeleteMapping("/del/{lifeId}")
    public RespObj delLifeCycle(@PathVariable("lifeId")Integer lifeId){
        return lifecycleService.delLifeCycle(lifeId);
    }

    @GetMapping("/view/{lifeId}")
    public RespObj viewLifeCycle(@PathVariable("lifeId")Integer lifeId){
        return lifecycleService.viewLifeCycle(lifeId);
    }

    @PutMapping("/modify/{lifeId}")
    public RespObj modifyLifeCycle(@PathVariable("lifeId")Integer lifeId,LifeCycle lifeCycle){
        return lifecycleService.modifyLifeCycle(lifeId,lifeCycle);
    }

    @GetMapping("/search")
    public RespObj searchLifeCycle(String searchName,Integer page){
        return lifecycleService.searchLifeCycle(searchName,page);
    }

    @DeleteMapping("/del")
    public RespObj delLifeCycleBatch(@RequestParam("lifeIds[]") Integer[] lifeIds){
        return lifecycleService.delLifeCycleBatch(lifeIds);
    }

}
