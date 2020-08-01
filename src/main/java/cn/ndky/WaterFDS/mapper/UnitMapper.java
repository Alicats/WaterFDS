package cn.ndky.WaterFDS.mapper;

import cn.ndky.WaterFDS.pojo.Unit;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UnitMapper {

    /**
     * 查询所有的量纲信息
     * @return
     */
    public List<Unit> queryUnits(Integer page, Integer pageSize);

    /**
     * 查询所有量纲信息的条数
     * @return
     */
    public int queryUnitsCount();

    /**
     * 根据id查询一条量纲信息
     * @param unitId
     * @return
     */
    public Unit queryUnitById(Integer unitId);

    /**
     * 根据搜索名称查询量纲信息
     * @param searchName
     * @return
     */
    public List<Unit> searchUnitBySearchName(String searchName, Integer page, Integer pageSize);

    /**
     * 根据搜索名称查询量纲信息的条数
     * @param searchName
     * @return
     */
    public int searchUnitCount(String searchName);

    /**
     * 添加一条量纲信息
     * @param unit
     * @return
     */
    public int addUnit(Unit unit);

    /**
     * 删除一条量纲信息
     * @param unitId
     * @return
     */
    public int delUnitById(Integer unitId);

    /**
     * 批量删除量纲信息
     * @param unitIds
     * @return
     */
    public int delUnitBatch(Integer[] unitIds);


    /**
     * 更新一条量纲信息
     * @param unit
     * @return
     */
    public int updateUnitById(Unit unit);

}
