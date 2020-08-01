package cn.ndky.WaterFDS.pojo;

import lombok.Data;

/**
 * @author lcx
 * @create 2020-07-11 13:38
 * @desc 量纲实体类
 */
@Data
public class Unit {
    
    /**
     * @desc id
     */
    private Integer unitId;

    /**
     * @desc 名称
     */
    private String name;
    
    /**
     * @desc 描述
     */
    private String remark;

    
}
