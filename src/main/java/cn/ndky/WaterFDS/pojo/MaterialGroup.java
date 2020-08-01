package cn.ndky.WaterFDS.pojo;

import lombok.Data;

/**
 * @author lcx
 * @create 2020-07-12 17:56
 * @desc 材料群组实体类
 */
@Data
public class MaterialGroup {
    
    /**
     * @desc 群组ID
     */
    private int groupId;
    
    /**
     * @desc 群组名称
     */
    private String name;
    
    /**
     * @desc 群组介绍
     */
    private String introduce;
    
}
