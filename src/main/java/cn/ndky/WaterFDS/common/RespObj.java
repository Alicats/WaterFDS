package cn.ndky.WaterFDS.common;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RespObj {

    private int code;
    private String message;
    private Object data;

    public static RespObj build(int code,String message,Object data){
        return new RespObj(code,message,data);
    }

}
