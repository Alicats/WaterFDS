package cn.ndky.WaterFDS.common;

import cn.ndky.WaterFDS.pojo.User;
import org.apache.shiro.crypto.hash.SimpleHash;

import javax.servlet.http.HttpSession;

public class Utils {

    /**
     * 获取session域里存储的用户
     * @param session
     * @return
     */
    public static User getSessionUser(HttpSession session){
        return (User)session.getAttribute("currentUser");
    }

    /**
     * 密码加密
     */
    public static String encryptPwd(String password,String salt ){
        return new SimpleHash("MD5",password,salt,1024).toString();
    }

}
