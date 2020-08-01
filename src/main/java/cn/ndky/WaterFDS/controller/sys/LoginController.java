package cn.ndky.WaterFDS.controller.sys;

import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.service.sys.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;

@RestController
public class LoginController {

    @Autowired
    private UserService userService;


    /**
     * @Description 登录
     * @date 2018年7月24日下午3:25:46
     */
    @PostMapping("/login")
    public RespObj login(String userId, String password, String checkCode,HttpSession session) {
        return userService.login(userId,password,checkCode,session);
    }

    /**
     * @Description 退出
     * @date 2018年7月24日下午3:25:52
     */
    @PostMapping("/logout")
    public RespObj logout() {
        return userService.logout();

    }


}
