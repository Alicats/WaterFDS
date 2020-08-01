package cn.ndky.WaterFDS.service.admin.impl;

import cn.ndky.WaterFDS.common.Constance;
import cn.ndky.WaterFDS.common.PageUtil;
import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.mapper.LifecycleMapper;
import cn.ndky.WaterFDS.pojo.LifeCycle;
import cn.ndky.WaterFDS.service.admin.LifecycleService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class LifecycleServiceImpl implements LifecycleService {
    private Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    private LifecycleMapper lifecycleMapper;

    /**
     * 初始化生命周期数据表
     *
     * @param page
     * @return
     */
    @Override
    public RespObj initTable(Integer page) {

        if (page == 0)
            page = page + 1;

        List<LifeCycle> lifeCycles = lifecycleMapper.queryLifeCyclesParent((page - 1) * Constance.PAGE_SIZE, Constance.PAGE_SIZE);
        List<LifeCycle> cycleChildren = lifecycleMapper.queryLifeCycleChildren();
        List<LifeCycle> resultLifeCycles = new ArrayList<>();

        for (LifeCycle cycleParent : lifeCycles) {
            resultLifeCycles.add(cycleParent);
            for (LifeCycle cycleChild : cycleChildren) {
                if (cycleChild.getPid() == cycleParent.getLifeId())
                    resultLifeCycles.add(cycleChild);
            }
        }

        int parentCycleCount = lifecycleMapper.queryLifeCyclesParentCount();
        PageUtil pageUtil = new PageUtil();
        pageUtil.setTotalCount(lifecycleMapper.queryLifeCycleCount());
        pageUtil.setCurrentPage(page);
        pageUtil.setPageSize(Constance.PAGE_SIZE);
        pageUtil.setTotalPage(parentCycleCount % pageUtil.getPageSize() == 0 ?
                parentCycleCount / pageUtil.getPageSize() : (parentCycleCount / pageUtil.getPageSize()) + 1);

        Map<String, Object> map = new HashMap<>();
        map.put("lifeCycles", resultLifeCycles);
        map.put("pageInfo", pageUtil);

        return RespObj.build(200, "请求数据表成功", map);
    }

    /**
     * 初始化生命周期下拉框
     *
     * @return
     */
    @Override
    public RespObj initSelect() {

        List<LifeCycle> lifeCycles = lifecycleMapper.queryLifeCycleParentsWithoutLimit();

        return RespObj.build(200, "获取下拉框内容成功", lifeCycles);
    }

    /**
     * 添加一条生命周期信息
     *
     * @param lifeCycle
     * @return
     */
    @Override
    public RespObj addLifeCycles(LifeCycle lifeCycle) {
        log.info("要添加的生命周期信息：" + lifeCycle);

        lifecycleMapper.addLifeCycle(lifeCycle);

        return RespObj.build(200, "添加成功", null);
    }

    /**
     * 删除一条生命周期信息
     *
     * @param lifeId
     * @return
     */
    @Override
    public RespObj delLifeCycle(Integer lifeId) {
        log.info("要删除的生命周期ID：" + lifeId);

        lifecycleMapper.delLifeCycleById(lifeId);

        return RespObj.build(200, "删除成功", null);
    }

    /**
     * 查询一条生命周期信息
     *
     * @param lifeId
     * @return
     */
    @Override
    public RespObj viewLifeCycle(Integer lifeId) {
        log.info("要查询的生命周期ID：" + lifeId);

        LifeCycle lifeCycle = lifecycleMapper.queryLifeCycleById(lifeId);

        return RespObj.build(200, "查询成功", lifeCycle);
    }

    /**
     * 编辑一条生命周期信息
     *
     * @param lifeId
     * @return
     */
    @Override
    public RespObj modifyLifeCycle(Integer lifeId, LifeCycle lifeCycle) {
        log.info("要编辑的生命周期ID：" + lifeId);

        lifeCycle.setLifeId(lifeId);
        lifecycleMapper.updateLifeCycleById(lifeCycle);

        return RespObj.build(200, "编辑成功", null);
    }

    /**
     * 搜索依赖生命周期信息
     *
     * @param searchName
     * @param page
     * @return
     */
    @Override
    public RespObj searchLifeCycle(String searchName, Integer page) {
        log.info("要搜索的生命周期名称：" + searchName);

        if (page == 0)
            page = page + 1;
        searchName = "%" + searchName + "%";

        List<LifeCycle> lifeCycleParents = lifecycleMapper.searchLifeCycleParentBySearchName(searchName, (page - 1) * Constance.PAGE_SIZE, Constance.PAGE_SIZE);
        List<LifeCycle> lifeCycleChildren = lifecycleMapper.searchLifeCycleChildrenBySearchName(searchName);
        List<LifeCycle> resultLifeCycles = new ArrayList<>();

        if (lifeCycleParents.size() != 0) {
            for (LifeCycle cycleParent : lifeCycleParents) {
                resultLifeCycles.add(cycleParent);
                for (LifeCycle cycleChild : lifeCycleChildren) {
                    if (cycleChild.getPid() == cycleParent.getLifeId())
                        resultLifeCycles.add(cycleChild);
                }
            }
        } else {
            resultLifeCycles.addAll(lifeCycleChildren);
        }



        PageUtil pageUtil = new PageUtil();
        pageUtil.setTotalCount(lifecycleMapper.searchLifeCycleCountBySearchName(searchName));
        pageUtil.setPageSize(Constance.PAGE_SIZE);
        pageUtil.setCurrentPage(page);

        int parentCycleCount = lifecycleMapper.searchParentLifeCycleCountBySearchName(searchName);
        if(parentCycleCount == 0 && pageUtil.getTotalCount() != 0)
            parentCycleCount += 1;

        pageUtil.setTotalPage(parentCycleCount % pageUtil.getPageSize() == 0 ?
                parentCycleCount / pageUtil.getPageSize() : (parentCycleCount / pageUtil.getPageSize()) + 1);

        Map<String, Object> map = new HashMap<>();
        map.put("lifeCycles", resultLifeCycles);
        map.put("pageInfo", pageUtil);

        return RespObj.build(200, "搜索成功", map);
    }

    /**
     * 批量删除生命周期信息
     *
     * @param lifeIds
     * @return
     */
    @Override
    public RespObj delLifeCycleBatch(Integer[] lifeIds) {
        log.info("批量删除的ID："+ Arrays.toString(lifeIds));

        lifecycleMapper.delLifeCycleBatch(lifeIds);

        return RespObj.build(200,"删除成功",null);
    }


}
