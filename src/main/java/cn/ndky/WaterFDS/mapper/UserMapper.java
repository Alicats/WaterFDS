package cn.ndky.WaterFDS.mapper;

import cn.ndky.WaterFDS.pojo.Enter;
import cn.ndky.WaterFDS.pojo.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper {


    public User getUserByUserId(String userId);

    public String getEnterNameByUserId(String userId);

    public List<User> getUserListByRoleId(String roleId, int currentPage, int pageSize);

    public int getUserListCountByRoleId(String roleId);

    public List<User> searchUserListByRoleId(String roleId, String name, int currentPage, int pageSize);

    public int searchUserListCountByRoleId(String roleId, String name);

    public void delAllUser(String[] userIds);

    public void delUser(String userId);

    public void resetPassword(String userId, String password);

    public void addUser(User user);

    public void updateUserByUserId(User user);

    public List<Enter> optionEnterList(String roleId);

    public List<User> getOtherUserListByRoleIds(String roleId1, String roleId2, int currentPage, int pageSize, String name, int enterId);

    public int getOtherUserListCountByRoleIds(String roleId1, String roleId2, String name, int enterId);

    public void updateUserInfoByUserId(User user);

//    ---------------------------------------分割线---------------------------------------------------

    List<User> queryReceivers(String userId);

    String queryUsernameByUserId(String userId);

}
