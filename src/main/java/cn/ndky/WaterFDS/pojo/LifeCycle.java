package cn.ndky.WaterFDS.pojo;

import lombok.Data;

/**
 * @author lcx
 * @create 2020-07-13 13:45
 * @desc 产品生命周期实体类
 */
@Data
public class LifeCycle {

    /**
     * @desc 生命周期id
     */
    private int lifeId;
    
    /**
     * @desc 生命周期名称
     */
    private String name;

    /**
     * @desc 生命周期介绍
     */
    private String introduce;
    
    /**
     * @desc 备注
     */
    private String remark;

    /**
     * @desc 父节点
     */
    private int pid;

}
