package cn.ndky.WaterFDS.service.admin;


import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.pojo.LifeCycle;

/**
 * 生命周期管理业务接口
 */
public interface LifecycleService {

    /**
     * 初始化生命周期数据表
     * @param page
     * @return
     */
    public RespObj initTable(Integer page);

    /**
     * 初始化生命周期下拉框
     * @return
     */
    public RespObj initSelect();

    /**
     * 添加一条生命周期信息
     * @param lifeCycle
     * @return
     */
    public RespObj addLifeCycles(LifeCycle lifeCycle);

    /**
     * 删除一条生命周期信息
     * @param lifeId
     * @return
     */
    public RespObj delLifeCycle(Integer lifeId);

    /**
     * 查询一条生命周期信息
     * @param lifeId
     * @return
     */
    public RespObj viewLifeCycle(Integer lifeId);

    /**
     * 编辑一条生命周期信息
     * @param lifeId
     * @param lifeCycle
     * @return
     */
    public RespObj modifyLifeCycle(Integer lifeId, LifeCycle lifeCycle);

    /**
     * 搜索依赖生命周期信息
     * @param searchName
     * @param page
     * @return
     */
    public RespObj searchLifeCycle(String searchName, Integer page);

    /**
     * 批量删除生命周期信息
     * @param lifeIds
     * @return
     */
    public RespObj delLifeCycleBatch(Integer[] lifeIds);
}
