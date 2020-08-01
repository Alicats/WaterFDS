package cn.ndky.WaterFDS.service.sys;

import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.pojo.User;

import javax.servlet.http.HttpSession;

public interface UserService {

    /**
     * 用户登录
     * @param userId
     * @param password
     * @param session
     * @return
     */
    public RespObj login(String userId, String password, String checkCode, HttpSession session);

    /**
     * 用户注销
     * @return
     */
    public RespObj logout();

    /*******************************************/

    // 企业负责人

    /**
     * 初始化所有企业负责人列表
     */
    public RespObj initEnterpriseUserTable(String page);

    /**
     * 模糊搜索用户列表
     */
    public RespObj searchUserTable(String name, String page);

    /**
     * 批量删除用户
     */
    public RespObj delAllUser(String[] userIds, HttpSession session);

    /**
     * 除用户根据用户编号
     */
    public RespObj delUser(String userId);

    /**
     * 重置用户密码
     */
    public RespObj resetPassword(String userId);

    /**
     * 获取该用户信息
     */
    public RespObj getUser(String userId);

    /**
     * 添加用户
     */
    public RespObj addUser(User user, HttpSession session);

    /**
     * 更新用户
     */
    public RespObj updateUser(User user, HttpSession session);

    /**
     * 剩余可选企业
     */
    public RespObj optionEnters(String roleId);


    /*******************************************/

    // 其他用户

    /**
     * 初始化所有供应商或内部协作人列表
     */
    public RespObj initOtherUserTable(String page, String roleId1, String roleId2, String name, HttpSession session);

    /**
     * 修改个人信息
     */
    public RespObj updateUserInfo(User user, HttpSession session);

    /**
     * 检查密码是否修改
     */
    public RespObj checkPwd(HttpSession session);
}
