package cn.ndky.WaterFDS.service.admin;

import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.pojo.Unit;

/**
 * 量纲业务接口
 */
public interface UnitService {

    /**
     * 初始化表格
     * @return
     */
    public RespObj initTable(Integer page);

    /**
     * 添加一条量纲信息
     * @param unit
     * @return
     */
    public RespObj addUnit(Unit unit);

    /**
     * 删除一条量纲信息
     * @param unitId
     * @return
     */
    public RespObj delUnit(Integer unitId);

    /**
     * 批量删除量纲信息
     * @param unitIds
     * @return
     */
    public RespObj delUnitBatch(Integer[] unitIds);

    /**
     * 查询一条量纲信息
     * @param unitId
     * @return
     */
    public RespObj viewUnit(Integer unitId);

    /**
     * 编辑一条量纲信息
     * @param unitId
     * @param unit
     * @return
     */
    public RespObj modifyUnit(Integer unitId, Unit unit);

    /**
     * 根据量纲名称搜索量纲信息
     * @param searchName
     * @return
     */
    public RespObj searchUnit(String searchName, Integer page);

}
