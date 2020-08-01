package cn.ndky.WaterFDS.service.admin.impl;

import cn.ndky.WaterFDS.common.Constance;
import cn.ndky.WaterFDS.common.PageUtil;
import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.mapper.MaterialGroupMapper;
import cn.ndky.WaterFDS.pojo.MaterialGroup;
import cn.ndky.WaterFDS.service.admin.MaterialGroupService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author lcx
 * @create 2020-07-12 18:34
 * @desc 材料群组业务接口实现类
 */
@Service
public class MaterialGroupServiceImpl implements MaterialGroupService {
    private Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    private MaterialGroupMapper materialGroupMapper;

    /**
     * 初始化表格
     * @param page
     * @return
     */
    @Override
    public RespObj initTable(Integer page) {

        if(page == 0)
            page = page + 1;

        List<MaterialGroup> materialGroups = materialGroupMapper.queryMaterialGroups((page-1)*Constance.PAGE_SIZE, Constance.PAGE_SIZE);

        PageUtil pageUtil = new PageUtil();
        pageUtil.setTotalCount(materialGroupMapper.queryMaterialGroupsCount());
        pageUtil.setCurrentPage(page);
        pageUtil.setPageSize(Constance.PAGE_SIZE);
        pageUtil.setTotalPage(pageUtil.getTotalCount()%pageUtil.getPageSize() == 0 ?
                pageUtil.getTotalCount()/pageUtil.getPageSize() : (pageUtil.getTotalCount()/pageUtil.getPageSize())+1);

        Map<String,Object> map = new HashMap<>();
        map.put("materialGroups",materialGroups);
        map.put("pageInfo",pageUtil);

        return RespObj.build(200,"初始化数据表成功",map);
    }

    /**
     * 添加一条材料群组信息
     *
     * @param materialGroup
     * @return
     */
    @Override
    public RespObj addMaterialGroup(MaterialGroup materialGroup) {
        log.info("添加的材料群组信息："+materialGroup);

        materialGroupMapper.addMaterialGroup(materialGroup);

        return RespObj.build(200,"添加成功",null);
    }

    /**
     * 删除一条材料群组信息
     *
     * @param groupId
     * @return
     */
    @Override
    public RespObj delMaterialGroup(Integer groupId) {
        log.info("要删除的群组信息："+groupId);

        materialGroupMapper.delMaterialGroupById(groupId);

        return RespObj.build(200,"删除成功",null);
    }

    /**
     * 批量删除材料群组信息
     *
     * @param groupIds
     * @return
     */
    @Override
    public RespObj delMaterialGroupBatch(Integer[] groupIds) {
        log.info("要批量删除的IDS："+groupIds);

        materialGroupMapper.delMaterialGroupBatch(groupIds);

        return RespObj.build(200,"删除成功",null);
    }

    /**
     * 查询一条群组信息
     *
     * @param groupId
     * @return
     */
    @Override
    public RespObj viewMaterialGroup(Integer groupId) {
        log.info("要查询的群组ID："+groupId);

        MaterialGroup materialGroup = materialGroupMapper.queryMaterialGroupById(groupId);

        return RespObj.build(200,"查询群组信息成功",materialGroup);
    }

    /**
     * 编辑一条群组信息
     *
     * @param groupId
     * @param materialGroup
     * @return
     */
    @Override
    public RespObj modifyMaterialGroup(Integer groupId,MaterialGroup materialGroup) {
        log.info("要编辑的群组ID："+groupId+",群组信息："+materialGroup);

        materialGroup.setGroupId(groupId);
        materialGroupMapper.updateMaterialGroupById(materialGroup);

        return RespObj.build(200,"编辑成功",null);
    }

    /**
     * 根据群组名名称查找群组信息
     *
     * @param searchName
     * @param page
     * @return
     */
    @Override
    public RespObj searchMaterialGroup(String searchName, Integer page) {
        log.info("要查找的群组名称："+searchName);

        searchName = "%"+searchName+"%";
        List<MaterialGroup> materialGroups = materialGroupMapper.searchMaterialGroupBySearchName(searchName, (page-1) * Constance.PAGE_SIZE, Constance.PAGE_SIZE);
        PageUtil pageUtil = new PageUtil();
        pageUtil.setTotalCount(materialGroupMapper.searchMaterialGroupCountBySearchName(searchName));
        pageUtil.setPageSize(Constance.PAGE_SIZE);
        pageUtil.setCurrentPage(page);
        pageUtil.setTotalPage(pageUtil.getTotalCount()%pageUtil.getPageSize() == 0 ?
                pageUtil.getTotalCount()/pageUtil.getPageSize() : (pageUtil.getTotalCount()/pageUtil.getPageSize())+1);

        Map<String,Object> map = new HashMap<>();
        map.put("materialGroups",materialGroups);
        map.put("pageInfo",pageUtil);

        return RespObj.build(200,"查找成功",map);
    }


}
