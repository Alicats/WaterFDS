package cn.ndky.WaterFDS.mapper;

import cn.ndky.WaterFDS.pojo.Message;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessageMapper {

    /**
     * 根据接收者id查询所有的消息
     * @param receiverId
     * @param page
     * @param pageSize
     * @return
     */
    List<Message> queryMessagesByReceiverId(String receiverId, Integer page, Integer pageSize);

    /**
     * 根据接收者id查询所有的消息的数据条数
     * @param receiverId
     * @return
     */
    int queryMessageCountByReceiverId(String receiverId);

    /**
     * 根据发送者id查询所有的消息
     * @param senderId
     * @param page
     * @param pageSize
     * @return
     */
    List<Message> queryMessagesBySenderId(String senderId, Integer page, Integer pageSize);

    /**
     * 根据发送者id查询所有的消息的数据条数
     * @param senderId
     * @return
     */
    int queryMessageCountBySenderId(String senderId);

    /**
     * 查询一条消息
     * @param messageId
     * @return
     */
    Message queryMessageById(Integer messageId);

    /**
     * 根据已读状态查询消息数据条数
     * @param isRead
     * @return
     */
    List<Message> queryReceiverMessageByIsRead(Integer isRead, String receiverId);

    /**
     * 根据搜索关键词查找消息列表消息
     * @param receiverId
     * @param searchName
     * @param page
     * @param pageSize
     * @return
     */
    List<Message> searchMessageBySearchNameWithReceiver(String receiverId, String searchName, Integer page, Integer pageSize);


    /**
     * 根据搜索关键词查找消息列表消息的数量
     * @param receiverId
     * @param searchName
     * @return
     */
    int searchMessageCountBySearchNameWithReceiver(String receiverId, String searchName);

    /**
     * 根据搜索关键词查找已发消息列表消息
     * @param senderId
     * @param searchName
     * @param page
     * @param pageSize
     * @return
     */
    List<Message> searchMessageBySearchNameWithSender(String senderId, String searchName, Integer page, Integer pageSize);


    /**
     * 根据搜索关键词查找已发消息列表消息的数量
     * @param senderId
     * @param searchName
     * @return
     */
    int searchMessageCountBySearchNameWithSender(String senderId, String searchName);

    /**
     * 批量添加消息
     * @param messages
     * @return
     */
    int addMessageBatch(List<Message> messages);

    /**
     * 删除一条消息
     * @param messageId
     * @return
     */
    int delMessageById(Integer messageId);

    /**
     * 批量删除消息
     * @param messageIds
     * @return
     */
    int delMessageBatch(Integer[] messageIds);

    /**
     * 修改消息已读状态
     * @param isRead
     * @param messageId
     * @return
     */
    int updateIsReadStatusById(Integer isRead, Integer messageId);
}
