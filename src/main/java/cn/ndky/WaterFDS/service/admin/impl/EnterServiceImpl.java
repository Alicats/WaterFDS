package cn.ndky.WaterFDS.service.admin.impl;

import cn.ndky.WaterFDS.common.Constance;
import cn.ndky.WaterFDS.common.PageUtil;
import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.mapper.EnterMapper;
import cn.ndky.WaterFDS.pojo.Enter;
import cn.ndky.WaterFDS.service.admin.EnterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class EnterServiceImpl implements EnterService {
    @Autowired
    private EnterMapper enterMapper;


    /**
     * 初始化所有企业表格
     * @return
     */
    @Override
    public RespObj initEnterTable(String page) {
        Map<String,Object> map = new HashMap<>();

        PageUtil pageUtil = new PageUtil();

        // 每页显示多少数量 (自定义)
        pageUtil.setPageSize(Constance.PAGE_SIZE);
        // 当前页数
        pageUtil.setCurrentPage(Integer.parseInt(page));
        // 总页数
        int pageCount = 0;
        int enterListCount = enterMapper.getEnterListCount();
        if(enterListCount%pageUtil.getPageSize() == 0){
            pageCount = enterListCount/pageUtil.getPageSize();
        }else {
            pageCount = (enterListCount/pageUtil.getPageSize())+1;
        }
        pageUtil.setTotalPage(pageCount);

        List<Enter> enterList = enterMapper.getEnterList((pageUtil.getCurrentPage()-1)*pageUtil.getPageSize(),pageUtil.getPageSize());

        map.put("enterList",enterList);
        map.put("enterListCount",enterListCount);
        map.put("pageSize",pageUtil.getPageSize());
        map.put("totalPage",pageUtil.getTotalPage());

        return RespObj.build(200,"ok",map);
    }

    /**
     * 模糊搜索企业列表
     * @param name
     * @param page
     * @return
     */
    @Override
    public RespObj searchEnterTable(String name, String page) {
        Map<String,Object> map = new HashMap<>();

        PageUtil pageUtil = new PageUtil();

        // 每页显示多少数量 (自定义)
        pageUtil.setPageSize(Constance.PAGE_SIZE);
        // 当前页数
        pageUtil.setCurrentPage(Integer.parseInt(page));
        // 总页数
        int pageCount = 0;
        int enterListCount = enterMapper.searchEnterListCount(name);
        if(enterListCount%pageUtil.getPageSize() == 0){
            pageCount = enterListCount/pageUtil.getPageSize();
        }else {
            pageCount = (enterListCount/pageUtil.getPageSize())+1;
        }
        pageUtil.setTotalPage(pageCount);

        List<Enter> enterList = enterMapper.searchEnterList(name,(pageUtil.getCurrentPage()-1)*pageUtil.getPageSize(),pageUtil.getPageSize());

        map.put("enterList",enterList);
        map.put("enterListCount",enterListCount);
        map.put("pageSize",pageUtil.getPageSize());
        map.put("totalPage",pageUtil.getTotalPage());

        return RespObj.build(200,"ok",map);
    }

    /**
     * 根据企业编号获取该企业
     * @param enterId
     * @return
     */
    @Override
    public RespObj getEnter(int enterId) {
        Enter enter = enterMapper.getEnterByEnterId(enterId);
        return RespObj.build(200,"ok",enter);
    }

    /**
     * 修改企业信息
     * @param enter
     * @return
     */
    @Override
    public RespObj updateEnter(Enter enter) {
        enterMapper.updateEnterByEnterId(enter);
        return RespObj.build(200,"ok",null);
    }

    /**
     * 删除企业
     * @param enterId
     * @return
     */
    @Override
    public RespObj delEnter(int enterId) {
        enterMapper.delEnterByEnterId(enterId);
        return RespObj.build(200,"ok",null);
    }

    /**
     * 批量删除企业
     * @param enterIds
     * @return
     */
    @Override
    public RespObj delAllEnter(int[] enterIds) {
        enterMapper.delAllEnter(enterIds);
        return RespObj.build(200,"ok",null);
    }

    /**
     * 添加企业
     * @param enter
     * @return
     */
    @Override
    public RespObj addEnter(Enter enter) {
        enterMapper.addEnter(enter);
        return RespObj.build(200,"ok",null);
    }
}
