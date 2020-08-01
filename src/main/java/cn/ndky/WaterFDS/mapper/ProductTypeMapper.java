package cn.ndky.WaterFDS.mapper;

import cn.ndky.WaterFDS.pojo.ProductType;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductTypeMapper {

    public List<ProductType> getProductTypeList(int currentPage, int pageSize, String name);

    public int getProductTypeListCount(String name);

    public void delAllProductType(int[] typeIds);

    public void delProductTypeByTypeId(int typeId);

    public void addProductType(ProductType productType);

    public ProductType getProductTypeByTypeId(int typeId);

    public void updateProductTypeByTypeId(ProductType productType);
}
