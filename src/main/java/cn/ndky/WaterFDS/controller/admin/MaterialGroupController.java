package cn.ndky.WaterFDS.controller.admin;

import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.pojo.MaterialGroup;
import cn.ndky.WaterFDS.service.admin.MaterialGroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author lcx
 * @create 2020-07-12 18:33
 * @desc 材料群组管理
 */
@RestController
@RequestMapping("/materialGroup")
public class MaterialGroupController {

    @Autowired
    private MaterialGroupService materialGroupService;


    @GetMapping("/initTable")
    public RespObj initTable(Integer page){
        return materialGroupService.initTable(page);
    }

    @PostMapping("/add")
    public RespObj addMaterialGroup(MaterialGroup materialGroup){
        return materialGroupService.addMaterialGroup(materialGroup);
    }

    @DeleteMapping("/del/{groupId}")
    public RespObj delMaterialGroup(@PathVariable("groupId") Integer groupId){
        return materialGroupService.delMaterialGroup(groupId);
    }

    @DeleteMapping("/del")
    public RespObj delMaterialGroupBatch(@RequestParam("groupIds[]") Integer[] groupIds){
        return materialGroupService.delMaterialGroupBatch(groupIds);
    }

    @GetMapping("/view/{groupId}")
    public RespObj viewMaterialGroup(@PathVariable("groupId")Integer groupId){
        return materialGroupService.viewMaterialGroup(groupId);
    }

    @PutMapping("/modify/{groupId}")
    public RespObj modifyMaterialGroup(@PathVariable("groupId")Integer groupId,MaterialGroup materialGroup){
        return materialGroupService.modifyMaterialGroup(groupId,materialGroup);
    }

    @GetMapping("/search")
    public RespObj searchMaterialGroup(String searchName,Integer page){
        return materialGroupService.searchMaterialGroup(searchName,page);
    }

}
