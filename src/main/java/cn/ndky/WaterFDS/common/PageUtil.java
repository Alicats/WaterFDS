package cn.ndky.WaterFDS.common;

import lombok.Data;

/**
 * @author lcx
 * @create 2020-07-11 18:46
 * @desc 分页工具类
 */
@Data
public class PageUtil {

    /**
     * @desc 每页显示的条数
     */
    private int pageSize;

    /**
     * @desc 当前页
     */
    private int currentPage;

    /**
     * @desc 总页数
     */
    private int totalPage;

    /**
     * @desc 总条数
     */
    private int totalCount;

}
