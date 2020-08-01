var clickPage = 1;
var pageSize = 2;

/**
 * 点击搜索按钮
 */
$("#BTN_SEARCH").click(function () {
    clickPage = 1;
    searchMessage($("#SEARCH_NAME").val(),clickPage);
});

/**
 * 点击复选框全选/全不选
 */
$("#CKBOX_SELECT_ALL").click(function () {
    if($(this).is(':checked')){
        $('input[name="ckbox"]').each(function(){
            $(this).prop("checked",true);
        });
    }else{
        $('input[name="ckbox"]').each(function(){
            $(this).prop("checked",false);
        });
    };
});

/**
 * 点击批量删除按钮
 */
$("#BTN_DEL_ALL").click(function () {
    delMessageBatch();
});


/**
 * 初始化消息数据表
 */
$(function () {
    $.ajax({
        url: baseUrl() + '/message/initReceivedTable?page=1',
        type: 'get',
        success: function (dt) {
            console.log(dt)
            if (dt.code == 200) {
                initTable(dt.data.messages);
                initPage(dt.data.pageInfo,clickPage);
            } else {
                layer.msg(error_msg(), {icon: 5})
            }

        },
        error: function (error) {
            layer.msg(error_msg(),{icon:5});
        }
    })
});

/**
 * 初始化表格
 * @param dt
 */
function initTable(dt) {
    $("#MESSAGE_TABLE_BODY").empty();

    for (var i = 0; i < dt.length; i++) {

        var read_icon;
        if(dt[i].isRead == 0)
            read_icon = "<i class='fa fa-envelope-o' id='Read_Status_Icon_"+dt[i].messageId+"'></i>";
        else
            read_icon = "<i class='fa fa-envelope-open-o' id='Read_Status_Icon_"+dt[i].messageId+"'></i>";


        var item = "<tr>" +
            "<td><input type='checkbox' name='ckbox' value='"+dt[i].messageId+"'></td>" +
            "<td>" + ((clickPage-1)*pageSize+(i+1)) + "</td>" +
            "<td><a href='javascript:;' onclick=viewMessage("+dt[i].messageId+") >" + dt[i].title + "</a></td>" +
            "<td>" + dt[i].senderName + "</td>" +
            "<td>" + dt[i].sendTime + "</td>" +
            "<td>" + read_icon + "</td>" +
            "<td>" +
                "<div class='tpl-table-black-operation'>" +
                    "<a href='javascript:;' onclick=viewMessage("+dt[i].messageId+")><i class='am-icon-pencil'></i> 查看</a>&emsp;" +
                    "<a href='javascript:;' onclick=delMessage("+dt[i].messageId+","+dt.length+") class='tpl-table-black-operation-del'><i class='am-icon-trash'></i> 删除</a>" +
                "</div>" +
            "</td>" +
            "</tr>";

        $("#MESSAGE_TABLE_BODY").append(item);
    }
}

/**
 * 刷新数据表
 */
function refreshTable(page) {
    $("#UNIT_TABLE_BODY").empty();

    var searchName = $("#SEARCH_NAME").val();

    if(searchName === ''){
        $.ajax({
            url: baseUrl() + '/message/initReceivedTable?page='+page,
            type: 'get',
            success: function (dt) {
                console.log(dt);
                if (dt.code == 200) {
                    initTable(dt.data.messages);
                    initPage(dt.data.pageInfo,page);

                } else {
                    layer.msg(error_msg(), {icon: 5})
                }
            },
            error: function (error) {
                console.log(error)
            }
        })
    }else{
        searchMessage(searchName,page);
    }

}


/**
 * 删除一条消息
 * @param messageId
 */
function delMessage(messageId,count) {
    var index = layer.confirm("是否删除该条信息？",{
        title:'提示',
        icon:2
    },function () {
        $.ajax({
            url: baseUrl() + '/message/del/'+messageId,
            type:'delete',
            success:function (dt) {
                console.log(dt)
                if(dt.code == 200){
                    layer.msg(dt.message,{icon:6});
                    if(count == 1){
                        clickPage = clickPage - 1;
                        refreshTable(clickPage);
                    }
                    else
                        refreshTable(clickPage);
                }
            },
            error:function (error) {
                layer.msg(error_msg(),{icon:5});
            }
        })
    });

}

/**
 * 批量删除消息
 */
function delMessageBatch() {

    var checkIds = [];//定义一个空数组
    $("input[name='ckbox']:checked").each(function(i){//把所有被选中的复选框的值存入数组
        checkIds[i] =$(this).val();
    });

    if(checkIds.length == 0){
        layer.msg("请选中删除项",{icon:5});
        return false;
    }

    var index = layer.confirm("是否删除所选项？",{
        title:'提示',
        icon:2,
    },function () {
        $.ajax({
            url: baseUrl() + '/message/del',
            type:'delete',
            data:{
                messageIds:checkIds
            },
            success:function (dt) {
                console.log(dt);
                if(dt.code == 200){
                    layer.msg(dt.message,{icon:6});
                    clickPage = clickPage - 1;
                    refreshTable(clickPage);
                    $("#CKBOX_SELECT_ALL").attr("checked",false);
                }
            },
            error:function (error) {
                layer.msg(error_msg(),{icon:5});
            }
        })
    });

}

/**
 * 查看一条消息
 * @param messageId
 */
function viewMessage(messageId) {
    $.ajax({
        url:baseUrl() + '/message/view/'+messageId,
        type:'get',
        success:function (dt) {
            console.log(dt);
            if(dt.code == 200){
                $("#Message_Title").text(dt.data.title);
                $("#Message_Content").text(dt.data.content);
                $("#Message_Sender").text(dt.data.senderName);
                $("#Message_SendTime").text(dt.data.sendTime);
                $("#Read_Status_Icon_"+messageId).removeClass('fa fa-envelope-o').addClass('fa fa-envelope-open-o');

                var count = $("#UNREAD_MESSAGE_COUNT").text();
                if(count > 0 && dt.data.isRead == 0){
                    $("#UNREAD_MESSAGE_COUNT").text(count-1);
                }

                var index = layer.open({
                    title: '消息内容',
                    type: '1',
                    area: '800px',
                    content: $('#MESSAGE_DIV'),
                });
            }
        },
        error:function (error) {
            layer.msg(error_msg(),{icon:5});
        }
    })
}

/**
 * 根据搜索关键词查找消息列表消息
 */
function searchMessage(searchName,page) {
    $.ajax({
        url:baseUrl() + '/message/search/received?searchName='+searchName+'&page='+page,
        type:'get',
        success:function (dt) {
            console.log(dt);
            if(dt.code == 200){
                initTable(dt.data.messages);
                initSearchPage(dt.data.pageInfo,page);
            }
        },
        error:function (error) {
            layer.msg(error_msg(),{icon:5});
        }
    })
}

/**
 * 初始化分页
 * @param totalPage
 * @param currentPage
 */
function initPage(pageInfo,currentPage) {
    $("#DATA_TOTAL_COUNT").text(' '+pageInfo.totalCount+' ');
    pagination = new Pagination({
        wrap: $('.am-pagination'), // 存放分页内容的容器
        count: pageInfo.totalPage, // 总页数
        current: currentPage, // 当前的页数（默认为1）
        callback: function (page) { // 每一个页数按钮的回调事件
            // page 为当前点击的页数
            clickPage = page;
            $.ajax({
                url: baseUrl() + '/message/initReceivedTable?page='+page,
                type: 'get',
                success: function (dt) {
                    initTable(dt.data.messages);
                    $("#CKBOX_SELECT_ALL").attr("checked",false);
                },
                error: function (error) {
                    layer.msg(error_msg(),{icon:5});
                }
            })
        }
    });
}

/**
 * 初始化搜索分页
 * @param totalPage
 * @param currentPage
 */
function initSearchPage(pageInfo,currentPage) {
    $("#DATA_TOTAL_COUNT").text(' '+pageInfo.totalCount+' ');
    pagination = new Pagination({
        wrap: $('.am-pagination'), // 存放分页内容的容器
        count: pageInfo.totalPage, // 总页数
        current: currentPage, // 当前的页数（默认为1）
        callback: function (page) { // 每一个页数按钮的回调事件
            // page 为当前点击的页数
            clickPage = page;
            $.ajax({
                url:baseUrl() + '/message/search/received?searchName='+$("#SEARCH_NAME").val()+'&page='+page,
                type: 'get',
                success: function (dt) {
                    initTable(dt.data.messages);
                    $("#CKBOX_SELECT_ALL").attr("checked",false);
                },
                error: function (error) {
                    layer.msg(error_msg(),{icon:5});
                }
            })
        }
    });
}


