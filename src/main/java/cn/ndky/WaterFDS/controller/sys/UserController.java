package cn.ndky.WaterFDS.controller.sys;

import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.common.ValidateCode;
import cn.ndky.WaterFDS.pojo.User;
import cn.ndky.WaterFDS.service.sys.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;


@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    /***********************************************/


    // 企业负责人
    /**
     * 初始化所有企业负责人列表
     * @return
     */
    @GetMapping("/admin/initEnterpriseUserTable/{page}")
    public RespObj initEnterpriseUserTable(@PathVariable("page")String page){
        return userService.initEnterpriseUserTable(page);
    }

    /**
     * 模糊搜索企业负责人名称
     */
    @PostMapping("/admin/searchUserTable")
    public RespObj searchUserTable(String name, String page){
        return userService.searchUserTable(name,page);
    }

    /**
     * 批量删除用户
     * @param userIds
     * @param session
     * @return
     */
    @PostMapping("/delAllUser")
    public RespObj delAllUser(@RequestParam("userIds[]")String[] userIds, HttpSession session){
        return userService.delAllUser(userIds,session);
    }

    /**
     * 删除用户
     * @param userId
     * @return
     */
    @DeleteMapping("/delUser/{userId}")
    public RespObj delUser(@PathVariable("userId")String userId){
        return userService.delUser(userId);
    }

    /**
     * 重置用户密码
     * @param userId
     * @return
     */
    @GetMapping("/resetPassword/{userId}")
    public RespObj resetPassword(@PathVariable("userId")String userId){
        return userService.resetPassword(userId);
    }

    /**
     * 获取用户信息
     * @param userId
     * @return
     */
    @GetMapping("/getUser/{userId}")
    public RespObj getUser(@PathVariable("userId")String userId){
        return userService.getUser(userId);
    }

    /**
     * 添加用户
     * @param user
     * @return
     */
    @PostMapping("/addUser")
    public RespObj addEnter(@RequestBody User user, HttpSession session){
        return userService.addUser(user,session);
    }

    @PostMapping("/updateUser")
    public RespObj updateUser(@RequestBody User user, HttpSession session){
        return userService.updateUser(user,session);
    }

    /**
     * 添加负责人可以选择的企业
     * @param roleId
     * @return
     */
    @PostMapping("/admin/optionEnters")
    public RespObj optionEnters(String roleId){
        return userService.optionEnters(roleId);
    }

    /************************************************/

    // 其他用户

    /**
     * 初始化所有供应商，内部协作人列表
     * @return
     */
    @PostMapping("/initOtherUserTable")
    public RespObj initOtherUserTable(String page, String roleId1, String roleId2, String name, HttpSession session){
        return userService.initOtherUserTable(page,roleId1,roleId2,name,session);
    }

    /**
     * 修改个人信息
     * @param user
     * @param session
     * @return
     */
    @PostMapping("/updateUserInfo")
    public RespObj updateUserInfo(@RequestBody User user,HttpSession session){
        return userService.updateUserInfo(user,session);
    }


    @GetMapping("/checkPwd")
    public RespObj checkPwd(HttpSession session){
        return userService.checkPwd(session);
    }

}
