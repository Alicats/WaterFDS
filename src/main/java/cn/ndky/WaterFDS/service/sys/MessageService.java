package cn.ndky.WaterFDS.service.sys;

import cn.ndky.WaterFDS.common.RespObj;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface MessageService {

    /**
     * 初始化消息列表数据表
     * @param page
     * @return
     */
    RespObj initMessageReceivedTable(Integer page, HttpSession session);

    /**
     * 初始化header处未读消息条数
     * @param session
     * @return
     */
    RespObj initHeaderMessageCount(HttpSession session);

    /**
     * 查看一条消息
     * @param messageId
     * @return
     */
    RespObj viewMessage(Integer messageId);

    /**
     * 删除一条消息
     * @param messageId
     * @return
     */
    RespObj delMessage(Integer messageId);

    /**
     * 批量删除消息
     * @param messageIds
     * @return
     */
    RespObj delMessageBatch(Integer[] messageIds);

    /**
     * 根据搜索关键词查找消息列表的消息
     * @param searchName
     * @param page
     * @return
     */
    RespObj searchReceivedMessage(String searchName, Integer page, HttpSession session);

    /**
     * 初始化已发消息数据表
     * @param page
     * @param session
     * @return
     */
    RespObj initSentTable(Integer page, HttpSession session);

    /**
     * 根据搜索关键词查找已发消息列表的消息
     * @param searchName
     * @param page
     * @param session
     * @return
     */
    RespObj searchSentMessage(String searchName, Integer page, HttpSession session);

    /**
     * 初始化收件人数据表
     * @return
     */
    List initReceiversTable(HttpSession session);

    /**
     * 发送消息
     * @param session
     * @param title
     * @param content
     * @param receiverIds
     * @return
     */
    RespObj sendMessage(HttpSession session, String title, String content, String receiverIds);
}
