package cn.ndky.WaterFDS.controller.sys;

import cn.ndky.WaterFDS.common.RespObj;
import cn.ndky.WaterFDS.service.sys.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @author lcx
 * @create 2020-07-15 14:20
 * @desc 消息管理
 */
@RestController
@RequestMapping("/message")
public class MessageController {

    @Autowired
    private MessageService messageService;


    @GetMapping("/initReceivedTable")
    public RespObj initMessageReceivedTable(Integer page, HttpSession session){
        return messageService.initMessageReceivedTable(page,session);
    }

    @GetMapping("/initHeaderMessageCount")
    public RespObj initUnReadMessageCount(HttpSession session){
        return messageService.initHeaderMessageCount(session);
    }

    @GetMapping("/view/{messageId}")
    public RespObj viewMessage(@PathVariable("messageId") Integer messageId){
        return messageService.viewMessage(messageId);
    }

    @DeleteMapping("/del/{messageId}")
    public RespObj delMessage(@PathVariable("messageId") Integer messageId){
        return messageService.delMessage(messageId);
    }

    @DeleteMapping("/del")
    public RespObj delMessageBatch(@RequestParam("messageIds[]") Integer[] messageIds){
        return messageService.delMessageBatch(messageIds);
    }

    @GetMapping("/search/received")
    public RespObj searchReceivedMessage(String searchName,Integer page,HttpSession session){
        return messageService.searchReceivedMessage(searchName,page,session);
    }

    @GetMapping("/initSentTable")
    public RespObj initSentTable(Integer page,HttpSession session){
        return messageService.initSentTable(page,session);
    }

    @GetMapping("/search/sent")
    public RespObj searchSentMessage(String searchName,Integer page,HttpSession session){
        return messageService.searchSentMessage(searchName,page,session);
    }

    @GetMapping("/receivers")
    public List initReceiversTable(HttpSession session){
        return messageService.initReceiversTable(session);
    }

    @PostMapping("/send")
    public RespObj sendMessage(HttpSession session,String title,String content,String receiverIds){
        return messageService.sendMessage(session,title,content,receiverIds);
    }
}
