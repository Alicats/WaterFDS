package cn.ndky.WaterFDS.service.sys;

import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.pojo.ProductType;

public interface ProductTypeService {
    /**
     * 初始化加载产品类型列表
     */
    public RespObj initProductTypeTable(String page, String name);

    /**
     * 批量删除产品类型
     */
    public RespObj delAllProductType(int[] typeIds);

    /**
     * 删除产品类型
     */
    public RespObj delProductType(int typeId);

    /**
     * 添加产品类型
     */
    public RespObj addProductType(ProductType productType);

    /**
     * 获取产品类型
     */
    public RespObj getProductType(int typeId);

    /**
     * 修改产品类型
     */
    public RespObj updateProductType(ProductType productType);
}
