package cn.ndky.WaterFDS.common.status;

import lombok.Getter;

/**
 * @author lcx
 * @create 2020-07-15 15:51
 * @desc 消息状态
 */
@Getter
public enum  MessageStatus {

    UNREAD(0,"未读"),
    READ(1,"已读");

    private int statusCode;
    private String statusName;

    MessageStatus(int statusCode,String statusName){
        this.statusCode = statusCode;
        this.statusName = statusName;
    }


    public static String getStatusName(int statusCode){

        for (MessageStatus status : MessageStatus.values()) {
            if(status.statusCode == statusCode)
                return status.statusName;
        }

        return null;
    }
}


