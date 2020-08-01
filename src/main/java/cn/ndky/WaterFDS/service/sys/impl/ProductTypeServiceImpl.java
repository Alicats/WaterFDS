package cn.ndky.WaterFDS.service.sys.impl;

import cn.ndky.WaterFDS.common.Constance;
import cn.ndky.WaterFDS.common.PageUtil;
import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.mapper.ProductTypeMapper;
import cn.ndky.WaterFDS.pojo.ProductType;
import cn.ndky.WaterFDS.service.sys.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProductTypeServiceImpl implements ProductTypeService {

    @Autowired
    private ProductTypeMapper productTypeMapper;


    /**
     * 初始化加载产品类型列表
     * @param page
     * @param name
     * @return
     */
    @Override
    public RespObj initProductTypeTable(String page, String name) {
        Map<String,Object> map = new HashMap<>();
        PageUtil pageUtil = new PageUtil();

        // 每页显示多少数量 (自定义)
        pageUtil.setPageSize(Constance.PAGE_SIZE);
        // 当前页数
        pageUtil.setCurrentPage(Integer.parseInt(page));
        // 总页数
        int pageCount = 0;
        int productTypeCount = productTypeMapper.getProductTypeListCount(name);

        if(productTypeCount%pageUtil.getPageSize() == 0){
            pageCount = productTypeCount/pageUtil.getPageSize();
        }else {
            pageCount = (productTypeCount/pageUtil.getPageSize())+1;
        }
        pageUtil.setTotalPage(pageCount);

        List<ProductType> productTypeList = productTypeMapper.getProductTypeList((pageUtil.getCurrentPage()-1)*pageUtil.getPageSize(),pageUtil.getPageSize(),name);

        map.put("productTypeList",productTypeList);
        map.put("productTypeCount",productTypeCount);
        map.put("pageSize",pageUtil.getPageSize());
        map.put("totalPage",pageUtil.getTotalPage());

        return RespObj.build(200,"ok",map);
    }



    /**
     * 批量删除产品类型
     * @param typeIds
     * @return
     */
    @Override
    public RespObj delAllProductType(int[] typeIds) {
        productTypeMapper.delAllProductType(typeIds);
        return RespObj.build(200,"ok",null);
    }

    /**
     * 删除产品类型
     * @param typeId
     * @return
     */
    @Override
    public RespObj delProductType(int typeId) {
        productTypeMapper.delProductTypeByTypeId(typeId);
        return RespObj.build(200,"ok",null);
    }

    /**
     * 添加产品类型
     * @param productType
     * @return
     */
    @Override
    public RespObj addProductType(ProductType productType) {
        productTypeMapper.addProductType(productType);
        return RespObj.build(200,"ok",null);
    }

    /**
     * 获取产品类型
     * @param typeId
     * @return
     */
    @Override
    public RespObj getProductType(int typeId) {
        ProductType productType = productTypeMapper.getProductTypeByTypeId(typeId);
        return RespObj.build(200,"ok",productType);
    }

    /**
     * 修改产品类型
     * @param productType
     * @return
     */
    @Override
    public RespObj updateProductType(ProductType productType) {
        productTypeMapper.updateProductTypeByTypeId(productType);
        return RespObj.build(200,"ok",null);
    }
}
