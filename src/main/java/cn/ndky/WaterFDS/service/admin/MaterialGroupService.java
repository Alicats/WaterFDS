package cn.ndky.WaterFDS.service.admin;

import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.pojo.MaterialGroup;

/**
 * @author lcx
 * @create 2020-07-12 18:34
 * @desc 材料群组业务接口
 */
public interface MaterialGroupService {

    /**
     * 初始化表格
     * @return
     */
    public RespObj initTable(Integer page);

    /**
     * 添加一条材料群组信息
     * @param materialGroup
     * @return
     */
    public RespObj addMaterialGroup(MaterialGroup materialGroup);

    /**
     * 删除一条材料群组信息
     * @param groupId
     * @return
     */
    public RespObj delMaterialGroup(Integer groupId);

    /**
     * 批量删除材料群组信息
     * @param groupIds
     * @return
     */
    public RespObj delMaterialGroupBatch(Integer[] groupIds);

    /**
     * 查询一条群组信息
     * @param groupId
     * @return
     */
    public RespObj viewMaterialGroup(Integer groupId);

    /**
     * 编辑一条群组信息
     * @param groupId
     * @return
     */
    public RespObj modifyMaterialGroup(Integer groupId, MaterialGroup materialGroup);

    /**
     * 根据群组名名称查找群组信息
     * @param searchName
     * @param page
     * @return
     */
    public RespObj searchMaterialGroup(String searchName, Integer page);
}
