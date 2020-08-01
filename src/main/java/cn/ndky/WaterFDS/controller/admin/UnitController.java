package cn.ndky.WaterFDS.controller.admin;

import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.pojo.Unit;
import cn.ndky.WaterFDS.service.admin.UnitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author lcx
 * @create 2020-07-11 12:48
 * @desc 量纲管理
 */
@RestController
@RequestMapping("/unit")
public class UnitController {

    @Autowired
    private UnitService unitService;

    @GetMapping("/initTable")
    public RespObj initTable(Integer page){
        return unitService.initTable(page);
    }

    @PostMapping("/add")
    public RespObj addUnit(Unit unit){
        return unitService.addUnit(unit);
    }

    @DeleteMapping("/del/{unitId}")
    public RespObj delUnit(@PathVariable("unitId") Integer unitId){
        return unitService.delUnit(unitId);
    }

    @DeleteMapping("/del")
    public RespObj delUnitBatch(@RequestParam("unitIds[]") Integer[] unitIds){
        return unitService.delUnitBatch(unitIds);
    }

    @GetMapping("/view/{unitId}")
    public RespObj viewUnit(@PathVariable("unitId") Integer unitId){
        return unitService.viewUnit(unitId);
    }

    @PutMapping("/modify/{unitId}")
    public RespObj modifyUnit(@PathVariable("unitId") Integer unitId,Unit unit){
        return unitService.modifyUnit(unitId,unit);
    }

    @GetMapping("/search")
    public RespObj searchUnit(String searchName,Integer page){
        return unitService.searchUnit(searchName,page);
    }
}
