package cn.ndky.WaterFDS.service.admin;

import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.pojo.Enter;

public interface EnterService {

    /**
     * 初始化所有企业列表
     */
    public RespObj initEnterTable(String page);

    /**
     * 模糊搜索企业列表
     */
    public RespObj searchEnterTable(String name, String page);

    /**
     * 根据企业编号获取该企业
     */
    public RespObj getEnter(int enterId);

    /**
     * 修改企业信息
     */
    public RespObj updateEnter(Enter enter);

    /**
     * 删除企业
     */
    public RespObj delEnter(int enterId);

    /**
     * 批量删除企业
     */
    public RespObj delAllEnter(int[] enterIds);

    /**
     * 添加企业
     */
    public RespObj addEnter(Enter enter);
}
