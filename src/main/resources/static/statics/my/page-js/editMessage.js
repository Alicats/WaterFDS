/**
 * 选择收件人
 */
function selectAddressee() {
    //弹出层
    var index = layer.open({
        title:'收件人',
        type:'1',
        area:  ['800px', '480px'],
        offset: '100px',
        maxmin: true,
        content:$("#DIV_ADDRESSEE"),
        btn: ["取消", "确定"],
        btn1: function () {
            layer.close(index);
        },
        btn2: function () {

            //获取选中的数据
            var receiver = $('#Receiver_Table') .bootstrapTable('getAllSelections');
            var receiver_str = new Array();

            for (var i=0;i<receiver.length;i++){
                receiver_str.push(receiver[i].id);
            }

            $("#Message_Receiver").val(receiver_str.toString());
            layer.close(index);
        }
    });

    //收件人数据表
    $('#Receiver_Table').bootstrapTable({
        url: baseUrl() + '/message/receivers',//请求url
        striped : true, //是否显示行间隔色
        pageNumber : 1, //初始化加载第一页
        pagination : true,//是否分页
        sidePagination : 'client',//server:服务器端分页|client：前端分页
        pageSize : 5,//单页记录数
        pageList : [5,10,20,30],//可选择单页记录数
        // showRefresh : true,//刷新按钮
        search : true,
        columns: [{
            field : 'checked',
            checkbox : true,
            // //跟据返回每行的数据
            // formatter :function(value,row,index){
            //     return row.id;
            // }
        },{
            field: 'id',
            title: '用户ID',
            align: 'center'
        }, {
            field: 'username',
            title: '用户名称',
            align: 'center'
        }, {
            field: 'role',
            title: '角色',
            align: 'center'
        }]
    });
}

/**
 * 点击发送按钮
 */
$("#Submit_Message").click(function () {
    sendMessage();
});

/**
 * 发送消息
 */
function sendMessage() {
    $.ajax({
        url:baseUrl() + '/message/send',
        type:'post',
        data:{
            title:$("#Message_Title").val(),
            content:$("#Message_Content").val(),
            receiverIds:$("#Message_Receiver").val()
        },
        success:function (dt) {
            console.log(dt)
            if(dt.code == 200){
                layer.msg(dt.message,{icon:6});
                $("#Message_Send_Form")[0].reset();
                $("#table").bootstrapTable('refresh');
            }
        },
        error:function (error) {
            layer.msg(error_msg(),{icon:5});
        }
    })
}
