package cn.ndky.WaterFDS.controller.sys;

import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.pojo.ProductType;
import cn.ndky.WaterFDS.service.sys.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/productType")
public class ProductTypeController {

    @Autowired
    private ProductTypeService productTypeService;

    /**
     * 初始化加载产品类型列表
     * @param page
     * @param name
     * @return
     */
    @PostMapping("/initProductTypeTable")
    public RespObj initProductTypeTable(String page, String name){
        return productTypeService.initProductTypeTable(page,name);
    }

    /**
     * 批量删除产品类型
     * @param typeIds
     * @return
     */
    @PostMapping("/delAllProductType")
    public RespObj delAllProductType(@RequestParam("typeIds[]")int[] typeIds){
        return productTypeService.delAllProductType(typeIds);
    }

    /**
     * 删除产品类型
     * @param typeId
     * @return
     */
    @DeleteMapping("/delProductType/{typeId}")
    public RespObj delProductType(@PathVariable("typeId")int typeId){
        return productTypeService.delProductType(typeId);
    }

    /**
     * 添加产品类型
     * @param productType
     * @return
     */
    @PostMapping("/addProductType")
    public RespObj addProductType(@RequestBody ProductType productType){
        return productTypeService.addProductType(productType);
    }

    /**
     * 获取产品类型根据id
     * @param typeId
     * @return
     */
    @GetMapping("/getProductType/{typeId}")
    public RespObj getProductType(@PathVariable("typeId")int typeId){
        return productTypeService.getProductType(typeId);
    }

    /**
     * 修改产品类型根据id
     * @param productType
     * @return
     */
    @PostMapping("/updateProductType")
    public RespObj updateProductType(@RequestBody ProductType productType){
        return productTypeService.updateProductType(productType);
    }
}
