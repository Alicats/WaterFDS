package cn.ndky.WaterFDS.pojo;

import lombok.Data;

/**
 * @author lcx
 * @create 2020-07-15 15:47
 * @desc 消息实体
 */
@Data
public class Message {

    /**
     * @desc 消息id
     */
    private int messageId;

    /**
     * @desc 标题
     */
    private String title;
    
    /**
     * @desc 内容
     */
    private String content;

    /**
     * @desc 发送者id
     */
    private String senderId;

    /**
     * @desc 发送者用户名
     */
    private String senderName;

    /**
     * @desc 接收者用户名
     */
    private String receiverName;

    /**
     * @desc 接收者id
     */
    private String receiverId;

    /**
     * @desc 发送时间
     */
    private String sendTime;
    
    /**
     * @desc 是否已读
     */
    private int isRead;

    /**
     * @desc 消息状态
     */
    private String messageStatus;

}
