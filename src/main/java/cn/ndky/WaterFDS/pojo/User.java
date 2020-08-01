package cn.ndky.WaterFDS.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class User {
    private String userId;
    private String password;
    private String username;
    private String address;
    private String email;
    private String telephone;
    private String roleId;
    private int enterId;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date registerTime;
    private int status;
    private String remark;


    private String enterName;
    private String roleName;

}
