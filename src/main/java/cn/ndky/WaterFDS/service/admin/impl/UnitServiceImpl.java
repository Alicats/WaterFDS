package cn.ndky.WaterFDS.service.admin.impl;

import cn.ndky.WaterFDS.common.Constance;
import cn.ndky.WaterFDS.common.PageUtil;
import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.mapper.UnitMapper;
import cn.ndky.WaterFDS.pojo.Unit;
import cn.ndky.WaterFDS.service.admin.UnitService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UnitServiceImpl implements UnitService {
    private Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    private UnitMapper unitMapper;

    /**
     * 初始化表格
     * @return
     */
    @Override
    public RespObj initTable(Integer page) {
        log.info("page："+page);

        if(page == 0)
            page = page + 1;

        List<Unit> units = unitMapper.queryUnits((page-1)*Constance.PAGE_SIZE,Constance.PAGE_SIZE);

        PageUtil pageUtil = new PageUtil();
        pageUtil.setPageSize(Constance.PAGE_SIZE);
        pageUtil.setCurrentPage(page);
        pageUtil.setTotalCount(unitMapper.queryUnitsCount());
        pageUtil.setTotalPage(
                pageUtil.getTotalCount()%pageUtil.getPageSize()==0 ?
                        pageUtil.getTotalCount()/pageUtil.getPageSize() :(pageUtil.getTotalCount()/pageUtil.getPageSize())+1);

        Map<String,Object> map = new HashMap<>();
        map.put("units",units);
        map.put("pageInfo",pageUtil);

        return RespObj.build(200,"请求数据表成功",map);
    }

    /**
     * 添加一条量纲信息
     * @param unit
     * @return
     */
    @Override
    public RespObj addUnit(Unit unit) {
        log.info("用户输入的量纲信息："+unit);

        unitMapper.addUnit(unit);

        return RespObj.build(200,"添加成功",null);
    }

    /**
     * 删除一条量纲信息
     * @param unitId
     * @return
     */
    @Override
    public RespObj delUnit(Integer unitId) {
        log.info("删除的量纲ID："+unitId);

        unitMapper.delUnitById(unitId);

//        int totalCount = unitMapper.queryUnitsCount();
//        int totalPage = totalCount%Constance.PAGE_SIZE == 0 ?
//                totalCount/Constance.PAGE_SIZE : (totalCount/Constance.PAGE_SIZE) + 1;

        return RespObj.build(200,"删除成功",null);
    }

    /**
     * 批量删除量纲信息
     * @param unitIds
     * @return
     */
    @Override
    public RespObj delUnitBatch(Integer[] unitIds) {
        log.info("批量删除的量纲ID："+unitIds);

        unitMapper.delUnitBatch(unitIds);

        return RespObj.build(200,"删除成功",null);
    }

    /**
     * 查询一条量纲信息
     * @param unitId
     * @return
     */
    @Override
    public RespObj viewUnit(Integer unitId) {
        log.info("要查询的量纲ID："+unitId);

        Unit unit = unitMapper.queryUnitById(unitId);

        return RespObj.build(200,"查询成功",unit);
    }

    /**
     * 编辑一条量纲信息
     * @param unitId
     * @param unit
     * @return
     */
    @Override
    public RespObj modifyUnit(Integer unitId, Unit unit) {
        log.info("编辑的量纲信息："+unit+"，它的ID："+unitId);

        unit.setUnitId(unitId);
        unitMapper.updateUnitById(unit);

        return RespObj.build(200,"编辑成功",null);
    }

    /**
     * 根据量纲名称搜索量纲信息
     * @param searchName
     * @return
     */
    @Override
    public RespObj searchUnit(String searchName,Integer page) {
        log.info("搜索的量纲名称："+searchName);

        searchName = "%"+searchName+"%";
        List<Unit> units = unitMapper.searchUnitBySearchName(searchName,(page-1)*Constance.PAGE_SIZE,Constance.PAGE_SIZE);

        PageUtil pageUtil = new PageUtil();
        pageUtil.setTotalCount(unitMapper.searchUnitCount(searchName));
        pageUtil.setCurrentPage(page);
        pageUtil.setPageSize(Constance.PAGE_SIZE);
        pageUtil.setTotalPage(pageUtil.getTotalCount()%pageUtil.getPageSize() == 0 ?
                pageUtil.getTotalCount()/pageUtil.getPageSize() : (pageUtil.getTotalCount()/pageUtil.getPageSize())+1);

        Map<String,Object> map = new HashMap<>();
        map.put("units",units);
        map.put("pageInfo",pageUtil);

        return RespObj.build(200,"搜索成功",map);
    }


}
