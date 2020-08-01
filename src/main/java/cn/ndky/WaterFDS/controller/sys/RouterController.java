package cn.ndky.WaterFDS.controller.sys;

import cn.ndky.WaterFDS.common.ValidateCode;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;

@Controller
public class RouterController {

    @GetMapping("/index")
    public String index(){
        return "index";
    }

    @GetMapping("/welcome")
    public String login(){
        return "login";
    }

    @GetMapping("/admin/enterpriseManage")
    public String enterpriseManage(){
        return "admin/user/enterpriseManage";
    }

    @GetMapping("/admin/otheruserManage")
    public String otheruserManage(){
        return "admin/user/otheruserManage";
    }

    @GetMapping("/admin/enterManage")
    public String enterManage(){
        return "admin/basic/enterManage";
    }

    @GetMapping("/admin/unitManage")
    public String unitManager(){
        return "admin/basic/unitManage";
    }

    @GetMapping("/admin/materialGroupManage")
    public String materialGroupManage(){
        return "admin/basic/materialGroupManage";
    }


    @GetMapping("/enterprise/supplierManage")
    public String supplierManage(){
        return "enterprise/user/supplierManage";
    }

    @GetMapping("/enterprise/collaboratorManage")
    public String collaboratorManage(){
        return "enterprise/user/collaboratorManage";
    }

    @GetMapping("/userInfo")
    public String userInfo(){
        return "userInfo";
    }


    @GetMapping("/admin/lifeCycleManage")
    public String lifeCycleMange(){
        return "admin/basic/lifeCycleManage";
    }

    @GetMapping("/message/sendList")
    public String sendList(){
        return "message/send";
    }

    @GetMapping("/message/receiveList")
    public String receiveList(){
        return "message/receive";
    }

    @GetMapping("/message/edit")
    public String editMessage(){
        return "message/edit";
    }


    @GetMapping("/productTypeManage")
    public String productTypeManage(){
        return "common/productTypeManage";
    }

}
