package cn.ndky.WaterFDS.service.sys.impl;

import cn.ndky.WaterFDS.common.Constance;
import cn.ndky.WaterFDS.common.PageUtil;
import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.common.Utils;
import cn.ndky.WaterFDS.mapper.UserMapper;
import cn.ndky.WaterFDS.pojo.Enter;
import cn.ndky.WaterFDS.pojo.User;
import cn.ndky.WaterFDS.service.sys.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    /**
     * 用户登录
     * @param userId
     * @param password
     * @param session
     * @return
     */
    @Override
    public RespObj login(String userId, String password, String checkCode, HttpSession session) {
        if(checkCode==null||!checkCode.toLowerCase().equals(session.getAttribute("checkCode").toString().toLowerCase())){
            return RespObj.build(500,"验证码错误",null);
        }

        Subject subject = SecurityUtils.getSubject();
        if(!subject.isAuthenticated()){
            UsernamePasswordToken token = new UsernamePasswordToken(userId,password);
            try{
                subject.login(token);
                session.setAttribute("currentUser",(User)subject.getPrincipal());
                return RespObj.build(200,"ok",null);
            }catch (LockedAccountException lae){
                return RespObj.build(500,lae.getMessage(),null);
            }catch (Exception e){
                return RespObj.build(500,"用户名或密码错误",null);
            }
        }

        return RespObj.build(200,"ok",null);
    }

    /**
     * 用户注销
     * @return
     */
    @Override
    public RespObj logout() {
        SecurityUtils.getSubject().logout();
        return RespObj.build(200,"注销成功",null);
    }


    /*******************************************/

    // 企业负责人

    /**
     * 初始化所有企业负责人列表
     * @param page
     * @return
     */
    @Override
    public RespObj initEnterpriseUserTable(String page) {
        Map<String,Object> map = new HashMap<>();

        PageUtil pageUtil = new PageUtil();

        // 每页显示多少数量 (自定义)
        pageUtil.setPageSize(Constance.PAGE_SIZE);
        // 当前页数
        pageUtil.setCurrentPage(Integer.parseInt(page));
        // 总页数
        int pageCount = 0;
        int userCount = userMapper.getUserListCountByRoleId("enterprise");

        if(userCount%pageUtil.getPageSize() == 0){
            pageCount = userCount/pageUtil.getPageSize();
        }else {
            pageCount = (userCount/pageUtil.getPageSize())+1;
        }
        pageUtil.setTotalPage(pageCount);

        List<User> userList = userMapper.getUserListByRoleId("enterprise",(pageUtil.getCurrentPage()-1)*pageUtil.getPageSize(),pageUtil.getPageSize());

        map.put("userList",userList);
        map.put("userCount",userCount);
        map.put("pageSize",pageUtil.getPageSize());
        map.put("totalPage",pageUtil.getTotalPage());


        return RespObj.build(200,"ok",map);
    }


    /**
     * 模糊搜索企业负责人列表
     * @param name
     * @param page
     * @return
     */
    @Override
    public RespObj searchUserTable(String name, String page) {
        Map<String,Object> map = new HashMap<>();
        PageUtil pageUtil = new PageUtil();

        // 每页显示多少数量 (自定义)
        pageUtil.setPageSize(Constance.PAGE_SIZE);
        // 当前页数
        pageUtil.setCurrentPage(Integer.parseInt(page));
        // 总页数
        int pageCount = 0;
        int userCount = userMapper.searchUserListCountByRoleId("enterprise",name);
        if(userCount%pageUtil.getPageSize() == 0){
            pageCount = userCount/pageUtil.getPageSize();
        }else {
            pageCount = (userCount/pageUtil.getPageSize())+1;
        }
        pageUtil.setTotalPage(pageCount);

        List<User> userList = userMapper.searchUserListByRoleId("enterprise",name,(pageUtil.getCurrentPage()-1)*pageUtil.getPageSize(),pageUtil.getPageSize());

        map.put("userList",userList);
        map.put("userCount",userCount);
        map.put("pageSize",pageUtil.getPageSize());
        map.put("totalPage",pageUtil.getTotalPage());

        return RespObj.build(200,"ok",map);
    }

    /**
     * 批量删除用户
     * @param userIds
     * @param session
     * @return
     */
    @Override
    public RespObj delAllUser(String[] userIds, HttpSession session) {
        userMapper.delAllUser(userIds);
        return RespObj.build(200,"ok",null);
    }

    /**
     * 删除用户根据用户编号
     * @param userId
     * @return
     */
    @Override
    public RespObj delUser(String userId) {
        userMapper.delUser(userId);
        return RespObj.build(200,"ok",null);
    }

    /**
     * 重置用户密码（企业负责人 666666，供应商 111111，内部协作人  222222）
     * @param userId
     * @return
     */
    @Override
    public RespObj resetPassword(String userId) {
        User user = userMapper.getUserByUserId(userId);
        String password = "";
        String pwd = "";
        if(user.getRoleId().equals("enterprise")){
            pwd = Constance.ENTERPRISE;
            password = new SimpleHash("MD5", Constance.ENTERPRISE,userId,1024).toString();
        }else if(user.getRoleId().equals("supplier")){
            pwd = Constance.SUPPLIER;
            password = new SimpleHash("MD5", Constance.SUPPLIER,userId,1024).toString();
        }else if(user.getRoleId().equals("collaborator")){
            pwd = Constance.COLLABORATOR;
            password = new SimpleHash("MD5", Constance.COLLABORATOR,userId,1024).toString();
        }
        userMapper.resetPassword(userId,password);
        return RespObj.build(200,pwd,null);
    }

    /**
     * 获取用户信息
     * @param userId
     * @return
     */
    @Override
    public RespObj getUser(String userId) {
        User user = userMapper.getUserByUserId(userId);
        System.out.println(user);
        String enterName = "";

        if(user == null){
            return RespObj.build(400,"fail",null);
        }else {
            if(user.getRoleId().equals("enterprise")){
                enterName = userMapper.getEnterNameByUserId(userId);
                user.setEnterName(enterName);
            }else if(user.getRoleId().equals("supplier")){
                enterName = userMapper.getEnterNameByUserId(userId);
                user.setEnterName(enterName);
                user.setRoleName("供应商");
            }else if(user.getRoleId().equals("collaborator")){
                enterName = userMapper.getEnterNameByUserId(userId);
                user.setEnterName(enterName);
                user.setRoleName("内部协作人");
            }
        }
        return RespObj.build(200,"ok",user);
    }



    /**
     * 添加用户
     * @param user
     * @return
     */
    @Override
    public RespObj addUser(User user, HttpSession session)  {
        System.out.println("roleId "+user.getRoleId());
        if(user.getRoleId().equals("enterprise")){
            user.setPassword(new SimpleHash("MD5",Constance.ENTERPRISE,user.getUserId(),1024).toString());
        }else if(user.getRoleId().equals("supplier")){
            user.setPassword(new SimpleHash("MD5",Constance.SUPPLIER,user.getUserId(),1024).toString());
        }else if(user.getRoleId().equals("collaborator")){
            user.setPassword(new SimpleHash("MD5",Constance.COLLABORATOR,user.getUserId(),1024).toString());
        }
        User currentUser = Utils.getSessionUser(session);
        if(currentUser.getRoleId().equals("enterprise")){
            user.setEnterId(currentUser.getEnterId());
        }

        user.setStatus(1);
        user.setRegisterTime(new Date());
        userMapper.addUser(user);
        return RespObj.build(200,"ok",null);
    }

    /**
     * 更新用户
     * @param user
     * @return
     */
    @Override
    public RespObj updateUser(User user, HttpSession session) {
        User currentUser = Utils.getSessionUser(session);
        if(currentUser.getRoleId().equals("enterprise")){
            user.setEnterId(currentUser.getEnterId());
        }

        userMapper.updateUserByUserId(user);
        return RespObj.build(200,"ok",null);
    }

    /**
     * 剩余可选企业
     * @param roleId
     * @return
     */
    @Override
    public RespObj optionEnters(String roleId) {
        List<Enter> optionEnterList = userMapper.optionEnterList(roleId);
        return RespObj.build(200,"ok",optionEnterList);
    }


    /*******************************************/

    // 其他用户


    /**
     * 初始化所有供应商，内部协作人列表
     * @param page
     * @return
     */
    @Override
    public RespObj initOtherUserTable(String page, String roleId1, String roleId2, String name, HttpSession session) {
        User currentUser = Utils.getSessionUser(session);
        int enterId = -1;
        if(currentUser.getRoleId().equals("enterprise")){
            enterId = currentUser.getEnterId();
        }

        if(roleId1 == null && roleId2 == null){
            roleId1 = "collaborator";
            roleId2 = "supplier";
        }
        Map<String,Object> map = new HashMap<>();

        PageUtil pageUtil = new PageUtil();

        // 每页显示多少数量 (自定义)
        pageUtil.setPageSize(Constance.PAGE_SIZE);
        // 当前页数
        pageUtil.setCurrentPage(Integer.parseInt(page));
        // 总页数
        int pageCount = 0;
        int userCount = userMapper.getOtherUserListCountByRoleIds(roleId1,roleId2,name,enterId);

        if(userCount%pageUtil.getPageSize() == 0){
            pageCount = userCount/pageUtil.getPageSize();
        }else {
            pageCount = (userCount/pageUtil.getPageSize())+1;
        }
        pageUtil.setTotalPage(pageCount);

        List<User> userList = userMapper.getOtherUserListByRoleIds(roleId1,roleId2,(pageUtil.getCurrentPage()-1)*pageUtil.getPageSize(),pageUtil.getPageSize(),name,enterId);

        map.put("userList",userList);
        map.put("userCount",userCount);
        map.put("pageSize",pageUtil.getPageSize());
        map.put("totalPage",pageUtil.getTotalPage());


        return RespObj.build(200,"ok",map);
    }

    /**
     * 修改个人信息
     * @param user
     * @param session
     * @return
     */
    @Override
    public RespObj updateUserInfo(User user, HttpSession session) {
        User currentUser = Utils.getSessionUser(session);
        if (!currentUser.getPassword().equals(user.getPassword())){
            user.setPassword(new SimpleHash("MD5",user.getPassword().trim(),user.getUserId(),1024).toString());
        }
        userMapper.updateUserInfoByUserId(user);
        session.setAttribute("currentUser",user);
        return RespObj.build(200,"ok",null);
    }

    /**
     * 检查密码是否修改
     * @param session
     * @return
     */
    @Override
    public RespObj checkPwd(HttpSession session) {
        User currentUser = Utils.getSessionUser(session);
        boolean flag = false;
        if(currentUser.getRoleId().equals("admin")){
            flag = true;
        }else if(currentUser.getRoleId().equals("enterprise")){
            String pwd = new SimpleHash("MD5",Constance.ENTERPRISE,currentUser.getUserId(),1024).toString();
            if(!pwd.equals(currentUser.getPassword())){
                flag = true;
            }
        }else if(currentUser.getRoleId().equals("supplier")){
            String pwd = new SimpleHash("MD5",Constance.SUPPLIER,currentUser.getUserId(),1024).toString();
            if(!pwd.equals(currentUser.getPassword())){
                flag = true;
            }
        }else if(currentUser.getRoleId().equals("collaborator")){
            String pwd = new SimpleHash("MD5",Constance.COLLABORATOR,currentUser.getUserId(),1024).toString();
            if(!pwd.equals(currentUser.getPassword())){
                flag = true;
            }
        }
        if(flag == true){
            return RespObj.build(200,"密码已修改",null);
        }else {
            return RespObj.build(400,"密码未修改",null);
        }
    }
}
