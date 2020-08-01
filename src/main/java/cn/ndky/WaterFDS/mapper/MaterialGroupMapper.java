package cn.ndky.WaterFDS.mapper;

import cn.ndky.WaterFDS.pojo.MaterialGroup;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MaterialGroupMapper {

    /**
     * 查询所有的材料群组信息
     * @param page
     * @param pageSize
     * @return
     */
    public List<MaterialGroup> queryMaterialGroups(Integer page, Integer pageSize);

    /**
     * 查询所有材料群组的条数
     * @return
     */
    public int queryMaterialGroupsCount();

    /**
     * 根据群组id查询群组信息
     * @param groupId
     * @return
     */
    public MaterialGroup queryMaterialGroupById(Integer groupId);

    /**
     * 根据群组名称查找群组信息
     * @param searchName
     * @param page
     * @param pageSize
     * @return
     */
    public List<MaterialGroup> searchMaterialGroupBySearchName(String searchName, Integer page, Integer pageSize);

    /**
     * 根据群组名称查找群组条数
     * @param searchName
     * @return
     */
    public int searchMaterialGroupCountBySearchName(String searchName);

    /**
     * 添加一条群组信息
     * @return
     */
    public int addMaterialGroup(MaterialGroup materialGroup);

    /**
     * 根据群组id删除一条群组信息
     * @param groupId
     * @return
     */
    public int delMaterialGroupById(Integer groupId);

    /**
     * 批量删除群组信息
     * @param groupIds
     * @return
     */
    public int delMaterialGroupBatch(Integer[] groupIds);

    /**
     * 根据群组id更新一条群组信息
     * @param materialGroup
     * @return
     */
    public int updateMaterialGroupById(MaterialGroup materialGroup);
}
