package cn.ndky.WaterFDS.pojo;

import lombok.Data;

@Data
public class Product {

    private int productId;
    private String name;
    private String introduce;
    private int status;
    private Data createTime;
    private String userId;
    private int enterId;
    private int typeId;
}
