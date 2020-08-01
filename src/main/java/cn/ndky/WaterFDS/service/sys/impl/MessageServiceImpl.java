package cn.ndky.WaterFDS.service.sys.impl;

import cn.ndky.WaterFDS.common.Constance;
import cn.ndky.WaterFDS.common.PageUtil;
import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.common.Utils;
import cn.ndky.WaterFDS.common.status.MessageStatus;
import cn.ndky.WaterFDS.mapper.MessageMapper;
import cn.ndky.WaterFDS.mapper.UserMapper;
import cn.ndky.WaterFDS.pojo.Message;
import cn.ndky.WaterFDS.pojo.User;
import cn.ndky.WaterFDS.service.sys.MessageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
public class MessageServiceImpl implements MessageService {
    private Logger log = LoggerFactory.getLogger(getClass());


    @Autowired
    private MessageMapper messageMapper;
    @Autowired
    private UserMapper userMapper;


    /**
     * 初始化数据表
     *
     * @param page
     * @return
     */
    @Override
    public RespObj initMessageReceivedTable(Integer page, HttpSession session) {

        if(page == 0)
            page += 1;

        String receiverId = Utils.getSessionUser(session).getUserId();

        List<Message> messages = messageMapper.queryMessagesByReceiverId(receiverId, (page - 1) * Constance.PAGE_SIZE, Constance.PAGE_SIZE);
        for (Message message : messages) {
            message.setMessageStatus(MessageStatus.getStatusName(message.getIsRead()));
        }

        PageUtil pageUtil = new PageUtil();
        pageUtil.setTotalCount(messageMapper.queryMessageCountByReceiverId(receiverId));
        pageUtil.setCurrentPage(page);
        pageUtil.setPageSize(Constance.PAGE_SIZE);
        pageUtil.setTotalPage(pageUtil.getTotalCount()%pageUtil.getPageSize() == 0 ?
                pageUtil.getTotalCount()/pageUtil.getPageSize() : (pageUtil.getTotalCount()/pageUtil.getPageSize())+1);

        Map<String,Object> map = new HashMap<>();
        map.put("messages",messages);
        map.put("pageInfo",pageUtil);


        return RespObj.build(200,"请求数据表成功",map);
    }

    /**
     * 初始化header处未读消息条数
     *
     * @param session
     * @return
     */
    @Override
    public RespObj initHeaderMessageCount(HttpSession session) {

        String receiverId = Utils.getSessionUser(session).getUserId();
        List<Message> messages = messageMapper.queryReceiverMessageByIsRead(MessageStatus.UNREAD.getStatusCode(), receiverId);

        return RespObj.build(200,"请求未读邮件数据成功",messages);
    }

    /**
     * 查看一条消息信息
     *
     * @param messageId
     * @return
     */
    @Override
    public RespObj viewMessage(Integer messageId) {
        log.info("要查看的消息ID："+messageId);

        Message message = messageMapper.queryMessageById(messageId);
        messageMapper.updateIsReadStatusById(MessageStatus.READ.getStatusCode(),messageId);

        return RespObj.build(200,"获取消息信息成功",message);
    }

    /**
     * 删除一条消息
     *
     * @param messageId
     * @return
     */
    @Override
    public RespObj delMessage(Integer messageId) {
        log.info("要删除的消息ID："+messageId);

        messageMapper.delMessageById(messageId);

        return RespObj.build(200,"删除成功",null);
    }

    /**
     * 批量删除消息
     *
     * @param messageIds
     * @return
     */
    @Override
    public RespObj delMessageBatch(Integer[] messageIds) {
        log.info("要批量删除的消息ids："+ Arrays.toString(messageIds));

        messageMapper.delMessageBatch(messageIds);

        return RespObj.build(200,"删除成功",null);
    }

    /**
     * 根据搜索关键词查找消息列表的消息
     *
     * @param searchName
     * @param page
     * @return
     */
    @Override
    public RespObj searchReceivedMessage(String searchName, Integer page,HttpSession session) {
        log.info("搜索的消息的关键词："+searchName);

        if(page == 0)
            page += 1;

        searchName = "%" + searchName + "%";

        String receiverId = Utils.getSessionUser(session).getUserId();
        List<Message> messages = messageMapper.searchMessageBySearchNameWithReceiver(receiverId, searchName, (page - 1) * Constance.PAGE_SIZE, Constance.PAGE_SIZE);
        for (Message message : messages) {
            message.setMessageStatus(MessageStatus.getStatusName(message.getIsRead()));
        }

        PageUtil pageUtil = new PageUtil();
        pageUtil.setTotalCount(messageMapper.searchMessageCountBySearchNameWithReceiver(receiverId,searchName));
        pageUtil.setCurrentPage(page);
        pageUtil.setPageSize(Constance.PAGE_SIZE);
        pageUtil.setTotalPage(pageUtil.getTotalCount()%pageUtil.getPageSize() == 0 ?
                pageUtil.getTotalCount()/pageUtil.getPageSize() : (pageUtil.getTotalCount()/pageUtil.getPageSize()) + 1);

        Map<String,Object> map = new HashMap<>();
        map.put("messages",messages);
        map.put("pageInfo",pageUtil);

        return RespObj.build(200,"搜索成功",map);
    }

    /**
     * 初始化已发消息数据表
     *
     * @param page
     * @param session
     * @return
     */
    @Override
    public RespObj initSentTable(Integer page, HttpSession session) {
        if(page == 0)
            page += 1;

        String senderId = Utils.getSessionUser(session).getUserId();

        List<Message> messages = messageMapper.queryMessagesBySenderId(senderId, (page - 1) * Constance.PAGE_SIZE, Constance.PAGE_SIZE);
        for (Message message : messages) {
            message.setMessageStatus(MessageStatus.getStatusName(message.getIsRead()));
        }

        PageUtil pageUtil = new PageUtil();
        pageUtil.setTotalCount(messageMapper.queryMessageCountBySenderId(senderId));
        pageUtil.setCurrentPage(page);
        pageUtil.setPageSize(Constance.PAGE_SIZE);
        pageUtil.setTotalPage(pageUtil.getTotalCount()%pageUtil.getPageSize() == 0 ?
                pageUtil.getTotalCount()/pageUtil.getPageSize() : (pageUtil.getTotalCount()/pageUtil.getPageSize())+1);

        Map<String,Object> map = new HashMap<>();
        map.put("messages",messages);
        map.put("pageInfo",pageUtil);


        return RespObj.build(200,"请求数据表成功",map);
    }

    /**
     * 根据搜索关键词查找已发消息列表的消息
     *
     * @param searchName
     * @param page
     * @param session
     * @return
     */
    @Override
    public RespObj searchSentMessage(String searchName, Integer page, HttpSession session) {
        log.info("搜索的消息的关键词："+searchName);

        if(page == 0)
            page += 1;

        searchName = "%" + searchName + "%";

        String senderId = Utils.getSessionUser(session).getUserId();
        List<Message> messages = messageMapper.searchMessageBySearchNameWithSender(senderId, searchName,(page - 1) * Constance.PAGE_SIZE, Constance.PAGE_SIZE);
        for (Message message : messages) {
            message.setMessageStatus(MessageStatus.getStatusName(message.getIsRead()));
        }

        PageUtil pageUtil = new PageUtil();
        pageUtil.setTotalCount(messageMapper.searchMessageCountBySearchNameWithSender(senderId,searchName));
        pageUtil.setCurrentPage(page);
        pageUtil.setPageSize(Constance.PAGE_SIZE);
        pageUtil.setTotalPage(pageUtil.getTotalCount()%pageUtil.getPageSize() == 0 ?
                pageUtil.getTotalCount()/pageUtil.getPageSize() : (pageUtil.getTotalCount()/pageUtil.getPageSize()) + 1);

        Map<String,Object> map = new HashMap<>();
        map.put("messages",messages);
        map.put("pageInfo",pageUtil);

        return RespObj.build(200,"搜索成功",map);
    }

    /**
     * 初始化收件人数据表
     *
     * @return
     */
    @Override
    public List initReceiversTable(HttpSession session) {

        String userId = Utils.getSessionUser(session).getUserId();
        List<User> users = userMapper.queryReceivers(userId);

        List<Map<String,Object>> receivers = new ArrayList<>();
        for (User user : users) {
            Map<String,Object> map = new HashMap<>();
            map.put("id",user.getUserId());
            map.put("username",user.getUsername());
            map.put("role",user.getRoleName());

            receivers.add(map);
        }

        return receivers;
    }

    /**
     * 发送消息
     *
     * @param session
     * @param title
     * @param content
     * @param receiverIds
     * @return
     */
    @Override
    public RespObj sendMessage(HttpSession session, String title, String content, String receiverIds) {
        log.info("消息的标题："+title+"\n消息的内容："+content+"\n收件人："+receiverIds);

        String senderId = Utils.getSessionUser(session).getUserId();
        String username = Utils.getSessionUser(session).getUsername();
        LocalDateTime dateTime = LocalDateTime.now();
        String formatDateTime = dateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        String[] ids = receiverIds.split(",");
        List<Message> messages = new ArrayList<>();
        for (String id : ids) {
            Message message = new Message();
            message.setTitle(title);
            message.setContent(content);
            message.setSenderId(senderId);
            message.setReceiverId(id);
            message.setSendTime(formatDateTime);
            message.setIsRead(MessageStatus.UNREAD.getStatusCode());
            message.setSenderName(username);
            message.setReceiverName(userMapper.queryUsernameByUserId(id));

            messages.add(message);
        }

        if(messages.size() != 0)
            messageMapper.addMessageBatch(messages);
        else
            return RespObj.build(500,"发送失败,请稍后再试",null);

        return RespObj.build(200,"发送成功",null);
    }
}
