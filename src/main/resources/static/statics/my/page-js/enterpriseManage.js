// 判断用户是否存在
var flag = false;
var currentPage = 1;
var userId;
var SEARCH_NAME;
var currentLength;


// 初始化
$(function () {
    initEnterpriseUserTable(currentPage);
});

// 切换主题改变颜色
$("span[name='SKIN']").on('click',function () {
    if($("body").hasClass("theme-white")){
        $("#TOTAL").css('color','black');
    }else {
        $("#TOTAL").css('color','white');
    }
});


// 初始化加载企业负责人表格
function initEnterpriseUserTable(page){
    currentPage = page;
    $.ajax({
        url: baseUrl() + '/user/admin/initEnterpriseUserTable/'+page,
        type: 'get',
        success: function (dt) {
            if(dt.code === 200){
                initEnterpriseUserTableTbody(dt);
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
                            url: baseUrl() + '/user/admin/initEnterpriseUserTable/' + page,
                            type: 'get',
                            success: function (dt) {
                                initEnterpriseUserTableTbody(dt);
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

// 分页时动态改变企业负责人表格数据
function initEnterpriseUserTableTbody(dt){
    var enterpriseTableTbody = $("#enterpriseTableTbody");
    enterpriseTableTbody.empty();
    for(var i=0;i<dt.data.userList.length;i++){
        currentLength = dt.data.userList.length;
        var xuhao = ((currentPage-1)*dt.data.pageSize+(1+i));
        var html = "<tr>" +
            "<td style='text-align: center;'><input type='checkbox' name='enterpriseCheckbox' value='"+ dt.data.userList[i].userId +"'></td>" +
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
            "<button type='button' onclick='edit(\""+ dt.data.userList[i].userId +"\")' class=\"am-btn am-btn-warning am-round am-btn-xs\"><i class='am-icon-cog'></i>编辑</button>" +
            "<button type='button' onclick='del(\""+ dt.data.userList[i].userId +"\")' class=\"am-btn am-btn-danger am-round am-btn-xs\"><i class='am-icon-cog'></i>删除</button>" +
            "</div>" +
            "</td>" +
            "</tr>";

        enterpriseTableTbody.append(html);
    }
}

// 重新加载已搜索的企业负责人表格
function initSearchEnterpriseUserTable(page,name){
    currentPage = page;
    $.ajax({
        url: baseUrl() + '/user/searchUserTable',
        type: 'post',
        data: {
            name: name,
            page: page
        },
        success: function (dt) {
            if(dt.code === 200){
                initEnterpriseUserTableTbody(dt);
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
                            url: baseUrl() + '/user/searchUserTable',
                            type: 'post',
                            data: {
                                name: name,
                                page: page
                            },
                            success: function (dt) {
                                initEnterpriseUserTableTbody(dt);
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

// 模糊搜索企业负责人
$("#SEARCHUSER").click(function () {
    var searchName = $("#USER_SEARCH").val();
    if(searchName === ''){
        initEnterpriseUserTable(1);
    }else{
        SEARCH_NAME = searchName;
        $.ajax({
            url: baseUrl() + '/user/admin/searchUserTable',
            type: 'post',
            data: {
                name: searchName,
                page: 1
            },
            success: function (dt) {
                if(dt.code === 200){
                    currentPage = 1;
                    initEnterpriseUserTableTbody(dt);
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
                                url: baseUrl() + '/user/admin/searchUserTable',
                                type: 'post',
                                data: {
                                    name: searchName,
                                    page: page
                                },
                                success: function (dt) {
                                    initEnterpriseUserTableTbody(dt);
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
$("input[name='enterpriseCheckboxs']").click(function () {
    if(this.checked){
        $("input[name='enterpriseCheckbox']").prop('checked','checked');
    }else {
        $("input[name='enterpriseCheckbox']").removeAttr('checked');
    }
});

// 初始化checkbox不选
function clearCheckbox(){
    // 换页时将根checkbox设置为不选中
    if($("input[name='enterpriseCheckboxs']").prop('checked')){
        $("input[name='enterpriseCheckboxs']").removeAttr('checked');
        $("input[name='enterpriseCheckbox']").removeAttr('checked');
    }
}

// 批量删除企业负责人
$("#delAllUser").click(function () {
    var userIds=[];
    $("input[name='enterpriseCheckbox']:checked").each(function () {
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
                                    initSearchEnterpriseUserTable(currentPage,searchName);
                                }else {
                                    initSearchEnterpriseUserTable(currentPage - 1,searchName);
                                }
                                // initEnterpriseUserTable(1);
                                // $("#USER_SEARCH").val('');
                            } else {
                                if(Number(currentPage)===1){
                                    initEnterpriseUserTable(currentPage);
                                }else {
                                    initEnterpriseUserTable(currentPage - 1);
                                }
                            }
                            $("input[name='enterpriseCheckboxs']").removeAttr('checked');
                        });
                    }
                }
            })
        })
    }
});

// 监听用户编号input焦点失去事件
$("input[name='userId']").on('blur',function () {
    if($("#userId").val() !== '') {
        $.ajax({
            url: baseUrl() + '/user/getUser/' + $("#userId").val(),
            type: 'get',
            success: function (dt) {
                if (dt.code === 200) {
                    flag = true;
                    $("#result").text("用户已注册");
                    $("#result").css('color', 'red');
                } else {
                    flag = false;
                    $("#result").text("用户未注册");
                    $("#result").css('color', 'green');
                }
            }
        })
    }
});


// 点击添加负责人按钮，打开模态框
function addModal(){
    $("#enterpriseForm")[0].reset();
    $("#result").text("");
    $("#USERIDS").css('display','block');
    $("#USERPWDS").css('display','block');
    $("#ADDUSER").css('display','block');
    $("#EDITUSER").css('display','none');
    $("#user-add-edit-modal").modal({closeViaDimmer: false,dimmer: false });//点击遮罩不关闭modal
    $("#user-add-edit-modal").modal("open");
    clearCheckbox();
    getOptionEnters();
}

// 获取企业未具有企业负责人
function getOptionEnters(){
    var optionEnters = $("#optionEnters");
    optionEnters.empty();
    $.ajax({
        url: baseUrl() + '/user/admin/optionEnters',
        type: 'post',
        data:{
            roleId: 'enterprise'
        },
        success: function (dt) {
            if(dt.code === 200){
                for(var i=0;i<dt.data.length;i++){
                    var option = "<option value='"+ dt.data[i].enterId +"'>"+ dt.data[i].name +"</option>";
                    optionEnters.append(option);
                }
            }
        },
        error: function () {
            layer.msg(error_msg(),{icon: 5,time: 1000});
        }
    })
}

// 添加企业负责人
$("#ADDUSER").click(function () {
    var userId = $("#userId").val();
    var username = $("#username").val();
    var address = $("#address").val();
    var email = $("#email").val();
    var telephone = $("#telephone").val();
    var remark = $("#remark").val();
    var enterId = $("#optionEnters").find("option:selected").val();

    if(userId === ''){
        layer.msg('用户编号为空',{icon: 5,time: 1000});
    }else if(username === ''){
        layer.msg('用户名为空',{icon: 5,time: 1000});
    }else if(address === ''){
        layer.msg('地址为空',{icon: 5,time: 1000});
    }else if(email === ''){
        layer.msg('邮箱为空',{icon: 5,time: 1000});
    }else if(telephone === ''){
        layer.msg('号码为空',{icon: 5,time: 1000});
    }else if(enterId === undefined){
        layer.msg('企业为空',{icon: 5,time: 1000});
    }else{
        if(flag === true){
            layer.msg('用户已存在',{icon: 5,time: 1000});
        }else{
            var data = {"userId": userId,"password":null,"username":username,"address":address,"email":email,"telephone":telephone,"roleId":"enterprise","enterId":enterId,"registerTime":null,"status":null,"remark":remark};

            $.ajax({
                url: baseUrl() + '/user/addUser',
                type: 'post',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function (dt) {
                    if(dt.code === 200){
                        layer.msg('添加成功',{icon: 6, time: 1000},function () {
                            $("#user-add-edit-modal").modal("close");

                            var searchName = $("#USER_SEARCH").val();
                            if(searchName !== ''){
                                initSearchEnterpriseUserTable(currentPage,searchName);

                                // initEnterpriseUserTable(1);
                                // $("#USER_SEARCH").val('');
                            }else {
                                initEnterpriseUserTable(currentPage);
                            }
                        })
                    }
                },
                error: function () {
                    layer.msg(error_msg(),{icon: 5, time: 1000});
                }

            })
        }
    }

    return false;
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
            if (dt.code === 200){
                $("#USERID").val(dt.data.userId);
                $("#USERNAME").val(dt.data.username);
                $("#ADDRESS").val(dt.data.address);
                $("#EMAIL").val(dt.data.email);
                $("#TELEPHONE").val(dt.data.telephone);
                $("#REMARK").val(dt.data.remark);
                var option = "<option value='"+ dt.data.enterId +"'>"+ dt.data.enterName +"</option>";
                BELONG_ENTER.append(option);
            }
        }
    });

}

// 编辑用户信息
function edit(value) {
    userId = value;

    $("#enterpriseForm")[0].reset();
    $("#USERIDS").css('display','none');
    $("#USERPWDS").css('display','none');
    $("#ADDUSER").css('display','none');
    $("#EDITUSER").css('display','block');
    $("#user-add-edit-modal").modal({closeViaDimmer: false,dimmer: false });//点击遮罩不关闭modal
    $("#user-add-edit-modal").modal("open");

    var optionEnters = $("#optionEnters");
    optionEnters.empty();

    $.ajax({
        url: baseUrl() + '/user/getUser/'+value,
        type: 'get',
        success: function (dt) {
            if (dt.code === 200){
                $("#userId").val(dt.data.userId);
                $("#password").val(dt.data.password);
                $("#username").val(dt.data.username);
                $("#address").val(dt.data.address);
                $("#email").val(dt.data.email);
                $("#telephone").val(dt.data.telephone);
                $("#remark").val(dt.data.remark);

                getOptionEnters();
                var option = "<option value='"+ dt.data.enterId +"'>"+ dt.data.enterName +"</option>";
                optionEnters.append(option);
            }
        }
    });
}

// 修改用户信息
$("#EDITUSER").click(function () {
    var userId = $("#userId").val();
    var password = $("#password").val();
    var username = $("#username").val();
    var address = $("#address").val();
    var email = $("#email").val();
    var telephone = $("#telephone").val();
    var remark = $("#remark").val();
    var enterId = $("#optionEnters").find("option:selected").val();

    if(userId === ''){
        layer.msg('用户编号为空',{icon: 5,time: 1000});
    }else if(password === ''){
        layer.msg('用户密码为空',{icon: 5,time: 1000});
    }else if(username === ''){
        layer.msg('用户名为空',{icon: 5,time: 1000});
    }else if(address === ''){
        layer.msg('地址为空',{icon: 5,time: 1000});
    }else if(email === ''){
        layer.msg('邮箱为空',{icon: 5,time: 1000});
    }else if(telephone === ''){
        layer.msg('号码为空',{icon: 5,time: 1000});
    }else{
        if(flag === true){
            layer.msg('用户已存在',{icon: 5,time: 1000});
        }else{
            var data = {"userId": userId,"password":null,"username":username,"address":address,"email":email,"telephone":telephone,"roleId":null,"enterId":enterId,"registerTime":null,"status":null,"remark":remark};

            $.ajax({
                url: baseUrl() + '/user/updateUser',
                type: 'post',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function (dt) {
                    if(dt.code === 200){
                        layer.msg('修改成功',{icon: 6, time: 1000},function () {
                            $("#user-add-edit-modal").modal("close");

                            var searchName = $("#USER_SEARCH").val();
                            if(searchName !== ''){
                                initSearchEnterpriseUserTable(currentPage,searchName);
                                // initEnterpriseUserTable(1);
                                // $("#USER_SEARCH").val('');
                            }else {
                                initEnterpriseUserTable(currentPage);
                            }
                        })
                    }
                },
                error: function () {
                    layer.msg(error_msg(),{icon: 5, time: 1000});
                }

            })
        }
    }

    return false;
});

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
                        console.log('删除 当前页时 ' + currentPage);
                        var searchName = $("#USER_SEARCH").val();
                        if (searchName !== '') {
                            if (Number(currentPage) === 1) {
                                initSearchEnterpriseUserTable(currentPage, searchName);
                            } else {
                                if (currentLength === 1) {
                                    initSearchEnterpriseUserTable(currentPage - 1, searchName);
                                } else {
                                    initSearchEnterpriseUserTable(currentPage, searchName);
                                }
                            }
                            // initEnterpriseUserTable(1);
                            // $("#USER_SEARCH").val('');
                        } else {
                            if (Number(currentPage) === 1) {
                                initEnterpriseUserTable(currentPage);
                            } else {
                                if (currentLength === 1) {
                                    initEnterpriseUserTable(currentPage - 1);
                                } else {
                                    initEnterpriseUserTable(currentPage);
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
