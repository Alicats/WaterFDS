package cn.ndky.WaterFDS.common.status;

import lombok.Getter;

@Getter
public enum AccountStatus {

    LOCKED(0,"禁用"),
    NORMAL(1,"正常");


    private int code;
    private String desc;

    AccountStatus(int code,String desc){
        this.code = code;
        this.desc = desc;
    }

}
