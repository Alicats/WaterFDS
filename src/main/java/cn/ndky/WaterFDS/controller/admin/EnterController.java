package cn.ndky.WaterFDS.controller.admin;

import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.pojo.Enter;
import cn.ndky.WaterFDS.service.admin.EnterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("enter")
public class EnterController {
    @Autowired
    private EnterService enterService;

    /**
     * 初始化所有企业负责人列表
     * @return
     */
    @GetMapping("/initEnterTable/{page}")
    public RespObj initEnterTable(@PathVariable("page")String page){
        return enterService.initEnterTable(page);
    }

    /**
     * 模糊搜索企业名称
     */
    @PostMapping("/searchEnterTable")
    public RespObj searchEnterTable(String name, String page){
        return enterService.searchEnterTable(name,page);
    }

    /**
     * 获取企业信息
     * @param enterId
     * @return
     */
    @GetMapping("/getEnter/{enterId}")
    public RespObj getEnter(@PathVariable("enterId")int enterId){
        return enterService.getEnter(enterId);
    }

    /**
     * 修改企业信息
     * @param enter
     * @return
     */
    @PostMapping("/updateEnter")
    public RespObj updateEnter(@RequestBody Enter enter){
        return enterService.updateEnter(enter);
    }

    /**
     * 删除企业
     * @param enterId
     * @return
     */
    @DeleteMapping("/delEnter/{enterId}")
    public RespObj delEnter(@PathVariable("enterId")int enterId){
        return enterService.delEnter(enterId);
    }

    /**
     * 批量删除企业
     * @param enterIds
     * @return
     */
    @PostMapping("/delAllEnter")
    public RespObj delAllEnter(@RequestParam("enterIds[]")int[] enterIds){
        return enterService.delAllEnter(enterIds);
    }


    @PostMapping("/addEnter")
    public RespObj addEnter(@RequestBody Enter enter){
        return enterService.addEnter(enter);
    }
}
