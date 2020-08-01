package cn.ndky.WaterFDS.mapper;

import cn.ndky.WaterFDS.pojo.Enter;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EnterMapper {

    public List<Enter> getEnterList(int currentPage, int pageSize);

    public int getEnterListCount();

    public List<Enter> searchEnterList(String name, int currentPage, int pageSize);

    public int searchEnterListCount(String name);

    public Enter getEnterByEnterId(int enterId);

    public void updateEnterByEnterId(Enter enter);

    public void delEnterByEnterId(int enterId);

    public void delAllEnter(int[] enterIds);

    public void addEnter(Enter enter);
}
