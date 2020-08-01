// 判断用户是否存在
var flag = false;
var currentPage = 1;
var userId;
var SEARCH_NAME;
var currentLength;
var roleId1;
var roleId2;


// 初始化
$(function () {
    initOtherUserTable(currentPage);
});

// 切换主题改变颜色
$("span[name='SKIN']").on('click',function () {
    if($("body").hasClass("theme-white")){
        $("#TOTAL").css('color','black');
    }else {
        $("#TOTAL").css('color','white');
    }
});

// 初始化加载其他用户表格
function initOtherUserTable(page){
    currentPage = page;
    $.ajax({
        url: baseUrl() + '/user/initOtherUserTable',
        type: 'post',
        data: {
            page: page,
            roleId1: roleId1,
            roleId2: roleId2,
            name: SEARCH_NAME
        },
        success: function (dt) {
            if(dt.code === 200){
                initOtherUserTableTbody(dt);
                // 左侧 第 1 到 2 条记录，共 4 条
                startToEndAndTotal(dt);

                pagination = new Pagination({
                    wrap: $('.am-pagination'), // 存放分页内容的容器
                    count: dt.data.totalPage, // 总页数
                    current: currentPage, // 当前的页数（默认为1）
                    callback: function (page) { // 每一个页数按钮的回调事件
                        // page 为当前点击的页数
                        currentPage = page;
                        // 换页时将checkbox设置为不选中
                        clearCheckbox();

                        $.ajax({
                            url: baseUrl() + '/user/initOtherUserTable',
                            type: 'post',
                            data: {
                                page: page,
                                roleId1: roleId1,
                                roleId2: roleId2,
                                name: SEARCH_NAME
                            },
                            success: function (dt) {
                                initOtherUserTableTbody(dt);
                                // 左侧 第 1 到 2 条记录，共 4 条
                                startToEndAndTotal(dt);
                            },
                            error: function (error) {
                                layer.msg(error_msg(),{icon: 5,time: 1000})
                            }
                        })
                    }
                });
            }
        }
    })
}

// 分页时动态改变其他用户表格数据
function initOtherUserTableTbody(dt){
    var otherTableTbody = $("#otherTableTbody");
    otherTableTbody.empty();
    for(var i=0;i<dt.data.userList.length;i++){
        currentLength = dt.data.userList.length;
        var xuhao = ((currentPage-1)*dt.data.pageSize+(1+i));
        var html = "<tr>" +
            "<td style='text-align: center;'><input type='checkbox' name='otherCheckbox' value='"+ dt.data.userList[i].userId +"'></td>" +
            "<td style='text-align: center;'>"+ xuhao +"</td>" +
            "<td style='text-align: center;'>"+ dt.data.userList[i].userId +"</td>" +
            "<td style='text-align: center;'>"+ dt.data.userList[i].username +"</td>" +
            "<td style='text-align: center;'>"+ dt.data.userList[i].address +"</td>" +
            "<td style='text-align: center;'>"+ dt.data.userList[i].email +"</td>" +
            "<td style='text-align: center;'>"+ dt.data.userList[i].telephone +"</td>" +
            "<td style='text-align: center;'>"+ dt.data.userList[i].registerTime +"</td>" +
            "<td style='text-align: center;'>"+ dt.data.userList[i].enterName +"</td>" +
            "<td style='text-align: center;'>" +
            "<div class='tpl-table-black-operation'>" +
            "<button type='button' onclick='reset(\""+ dt.data.userList[i].userId +"\")' class=\"am-btn am-btn-success am-round am-btn-xs\" ><i class='am-icon-cog'></i>重置密码</button>" +
            "<button type='button' onclick='view(\""+ dt.data.userList[i].userId +"\")' class=\"am-btn am-btn-secondary am-round am-btn-xs\"><i class='am-icon-cog'></i>查看</button>" +
            "<button type='button' onclick='del(\""+ dt.data.userList[i].userId +"\")' class=\"am-btn am-btn-danger am-round am-btn-xs\"><i class='am-icon-cog'></i>删除</button>" +
            "</div>" +
            "</td>" +
            "</tr>";

        otherTableTbody.append(html);
    }
}

// 模糊搜索其他用户
$("#SEARCHUSER").click(function () {
    var searchName = $("#USER_SEARCH").val();
    if(searchName === ''){
        SEARCH_NAME = undefined;
        initOtherUserTable(1);
    }else{
        SEARCH_NAME = searchName;
        $.ajax({
            url: baseUrl() + '/user/initOtherUserTable',
            type: 'post',
            data: {
                roleId1: roleId1,
                roleId2: roleId2,
                name: searchName,
                page: 1
            },
            success: function (dt) {
                if(dt.code === 200){
                    currentPage = 1;
                    initOtherUserTableTbody(dt);
                    // 左侧 第 1 到 2 条记录，共 4 条
                    startToEndAndTotal(dt);

                    pagination = new Pagination({
                        wrap: $('.am-pagination'), // 存放分页内容的容器
                        count: dt.data.totalPage, // 总页数
                        current: 1, // 当前的页数（默认为1）
                        callback: function (page) { // 每一个页数按钮的回调事件
                            // page 为当前点击的页数
                            currentPage = page;
                            // 换页时将checkbox设置为不选中
                            clearCheckbox();

                            $.ajax({
                                url: baseUrl() + '/user/initOtherUserTable',
                                type: 'post',
                                data: {
                                    roleId1: roleId1,
                                    roleId2: roleId2,
                                    name: searchName,
                                    page: page
                                },
                                success: function (dt) {
                                    initOtherUserTableTbody(dt);
                                    // 左侧 第 1 到 2 条记录，共 4 条
                                    startToEndAndTotal(dt);
                                },
                                error: function (error) {
                                    layer.msg(error_msg(),{icon: 5,time: 1000})
                                }
                            })
                        }
                    });

                }
            }
        })
    }
    return false;
});

// 下拉选择不同角色
$("#ROLE").change(function () {
    var roleId = $("#ROLE").find("option:selected").val();
    if(roleId === "none"){
        roleId1 = undefined;
        roleId2 = undefined;
        initOtherUserTable(currentPage);
    }else {
        roleId1 = roleId;
        currentPage = 1;
        initOtherUserTable(currentPage);
    }

});


// 左侧 第 1 到 2 条记录，共 4 条
function startToEndAndTotal(dt){
    if(dt.data.userCount === 0){
        $("#start").text(0);
        $("#end").text(0);
        // 总数量
        $("#totalNum").text(0);
    }else {
        var startXuhao = ((currentPage - 1) * dt.data.pageSize + (1));
        var endXuhao = ((currentPage - 1) * dt.data.pageSize + (1) + (dt.data.userList.length - 1));
        $("#start").text(startXuhao);
        $("#end").text(endXuhao);
        // 总数量
        $("#totalNum").text(dt.data.userCount);
    }
}

// checkbox 全选和全不选
$("input[name='otherCheckboxs']").click(function () {
    if(this.checked){
        $("input[name='otherCheckbox']").prop('checked','checked');
    }else {
        $("input[name='otherCheckbox']").removeAttr('checked');
    }
});

// 初始化checkbox不选
function clearCheckbox(){
    // 换页时将根checkbox设置为不选中
    if($("input[name='otherCheckboxs']").prop('checked')){
        $("input[name='otherCheckboxs']").removeAttr('checked');
        $("input[name='otherCheckbox']").removeAttr('checked');
    }
}

// 批量删除供应商或内部协作人
$("#delAllUser").click(function () {
    var userIds=[];
    $("input[name='otherCheckbox']:checked").each(function () {
        userIds.push($(this).val());
    });

    if(userIds.length === 0){
        layer.msg("请选择用户", {icon: 5, time: 1000});
    }else {
        var index = layer.confirm("是否删除",{
            title:'提示',
            icon:3
        },function () {
            layer.close(index);
            $.ajax({
                url: baseUrl() + '/user/delAllUser',
                type: 'post',
                data: {
                    userIds: userIds
                },
                success: function (dt) {
                    if(dt.code === 200){
                        layer.msg("删除成功",{icon: 6,time: 1000},function () {
                            $("#user-add-edit-modal").modal("close");

                            var searchName = $("#USER_SEARCH").val();
                            if (searchName !== '') {
                                if(Number(currentPage)===1){
                                    initOtherUserTable(currentPage);
                                }else {
                                    initOtherUserTable(currentPage - 1);
                                }
                            } else {
                                if(Number(currentPage)===1){
                                    initOtherUserTable(currentPage);
                                }else {
                                    initOtherUserTable(currentPage - 1);
                                }
                            }
                            $("input[name='otherCheckboxs']").removeAttr('checked');
                        });
                    }
                }
            })
        })
    }
});

// 重置用户密码
function reset(value) {
    $.ajax({
        url: baseUrl() + '/user/resetPassword/'+value,
        type: 'get',
        success: function (dt) {
            if (dt.code === 200){
                layer.msg("密码为"+dt.message,{icon: 6,time: 1000})
            }
        }
    });
}

// 查看用户信息
function view(value) {
    $("#user-view-modal").modal({closeViaDimmer: false,dimmer: false });//点击遮罩不关闭modal
    $("#user-view-modal").modal("open");

    var BELONG_ENTER = $("#BELONG_ENTER");

    $.ajax({
        url: baseUrl() + '/user/getUser/'+value,
        type: 'get',
        success: function (dt) {
            console.log(dt);
            if (dt.code === 200){
                $("#USERID").val(dt.data.userId);
                $("#USERNAME").val(dt.data.username);
                $("#ADDRESS").val(dt.data.address);
                $("#EMAIL").val(dt.data.email);
                $("#TELEPHONE").val(dt.data.telephone);
                $("#ROLENAME").val(dt.data.roleName);
                $("#REMARK").val(dt.data.remark);
                var option = "<option value='"+ dt.data.enterId +"'>"+ dt.data.enterName +"</option>";
                BELONG_ENTER.append(option);
            }
        }
    });

}

// 删除用户信息
function del(value) {
    var index = layer.confirm("是否删除",{
        title:'提示',
        icon:3
    },function () {
        layer.close(index);
        $.ajax({
            url: baseUrl() + '/user/delUser/' + value,
            type: 'delete',
            success: function (dt) {
                if (dt.code === 200) {
                    layer.msg("删除成功", {icon: 6, time: 1000}, function () {
                        var roleId = $("#ROLE").find("option:selected").val();
                        var searchName = $("#USER_SEARCH").val();


                        if (searchName !== '') {
                            if (Number(currentPage) === 1) {
                                initOtherUserTable(currentPage);
                            } else {
                                if (currentLength === 1) {
                                    initOtherUserTable(currentPage - 1);
                                } else {
                                    initOtherUserTable(currentPage);
                                }
                            }
                        } else if(roleId !== "none"){
                            // 不包含搜索时
                            roleId1 = roleId;
                            if(Number(currentPage) === 1) {
                                initOtherUserTable(currentPage);
                            }else {
                                if (currentLength === 1){
                                    initOtherUserTable(currentPage - 1);
                                }else {
                                    initOtherUserTable(currentPage);
                                }
                            }

                        } else {
                            if (Number(currentPage) === 1) {
                                initOtherUserTable(currentPage);
                            } else {
                                if (currentLength === 1) {
                                    initOtherUserTable(currentPage - 1);
                                } else {
                                    initOtherUserTable(currentPage);
                                }
                            }
                        }
                    })
                }
            },
            error: function () {
                layer.msg(error_msg(),{icon: 5,time: 1000});
            }
        });
    });
}




