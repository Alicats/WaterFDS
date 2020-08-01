package cn.ndky.WaterFDS.mapper;

import cn.ndky.WaterFDS.pojo.LifeCycle;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LifecycleMapper {

    /**
     * 查询所有生命周期的父节点信息
     * @param page
     * @param pageSize
     * @return
     */
    public List<LifeCycle> queryLifeCyclesParent(Integer page, Integer pageSize);

    /**
     * 查询所有生命周期的父节点信息，不进行分页查询
     * @return
     */
    public List<LifeCycle> queryLifeCycleParentsWithoutLimit();

    /**
     * 查询所有生命周期的子节点信息
     * @return
     */
    public List<LifeCycle> queryLifeCycleChildren();

    /**
     * 查询父节点生命周期信息条数
     * @return
     */
    public int queryLifeCyclesParentCount();

    /**
     * 查询生命周期信息条数
     * @return
     */
    public int queryLifeCycleCount();

    /**
     * 根据id查询生命周期信息
     * @param lifeId
     * @return
     */
    public LifeCycle queryLifeCycleById(Integer lifeId);

    /**
     * 搜索父节点生命周期信息
     * @param searchName
     * @param page
     * @param pageSize
     * @return
     */
    public List<LifeCycle> searchLifeCycleParentBySearchName(String searchName, Integer page, Integer pageSize);

    /**
     * 搜索子节点生命周期信息
     * @param searchName
     * @return
     */
    public List<LifeCycle> searchLifeCycleChildrenBySearchName(String searchName);

    /**
     * 查询搜索生命周期信息条数
     * @param searchName
     * @return
     */
    public int searchLifeCycleCountBySearchName(String searchName);

    /**
     * 查询搜索父节点生命周期信息条数
     * @param searchName
     * @return
     */
    public int searchParentLifeCycleCountBySearchName(String searchName);

    /**
     * 添加一条生命周期信息
     * @param lifeCycle
     * @return
     */
    public int addLifeCycle(LifeCycle lifeCycle);

    /**
     * 删除一条生命周期信息
     * @param lifeId
     * @return
     */
    public int delLifeCycleById(Integer lifeId);

    /**
     * 批量删除生命周期信息
     * @param lifeIds
     * @return
     */
    public int delLifeCycleBatch(Integer[] lifeIds);

    /**
     * 更新一条生命周期信息
     * @param lifeCycle
     * @return
     */
    public int updateLifeCycleById(LifeCycle lifeCycle);


}
