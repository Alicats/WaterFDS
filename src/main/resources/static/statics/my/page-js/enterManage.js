var enterId;
var pagination;
var currentPage = 1;
var currentLength;
// 初始化
$(function () {
    initEnterTable(currentPage);
});

// 切换主题改变颜色
$("span[name='SKIN']").on('click',function () {
    if($("body").hasClass("theme-white")){
        $("#TOTAL").css('color','black');
    }else {
        $("#TOTAL").css('color','white');
    }
});

// 分页时动态改变企业表格数据
function initEnterTableTbody(dt){

    var enterTableTbody = $("#enterTableTbody");
    enterTableTbody.empty();
    for(var i=0;i<dt.data.enterList.length;i++){
        var xuhao = ((currentPage-1)*dt.data.pageSize+(1+i));
        currentLength = dt.data.enterList.length;
        var html = "<tr>" +
            "<td style='text-align: center;'><input type='checkbox' name='enterCheckbox' value='"+ dt.data.enterList[i].enterId +"'></td>" +
            "<td style='text-align: center;'>"+ xuhao +"</td>" +
            "<td style='text-align: center;display: none;'>"+ dt.data.enterList[i].enterId +"</td>" +
            "<td style='text-align: center;'>"+ dt.data.enterList[i].name +"</td>" +
            "<td style='text-align: center;'>"+ dt.data.enterList[i].address +"</td>" +
            "<td style='text-align: center;'>"+ dt.data.enterList[i].contact +"</td>" +
            "<td style='text-align: center;display: none;'>"+ dt.data.enterList[i].introduce +"</td>" +
            "<td style='text-align: center;'>" +
            "<div class='tpl-table-black-operation'>" +
            "<button type='button' onclick='view("+ dt.data.enterList[i].enterId +")' class=\"am-btn am-btn-secondary am-round am-btn-xs\" data-am-modal=\"{target: '#enter-view-modal', closeViaDimmer: 0, width: 400, height: 225,dimmer: false}\"><i class='am-icon-cog'></i>查看</button>" +
            "<button type='button' onclick='edit("+ dt.data.enterList[i].enterId +")' class=\"am-btn am-btn-warning am-round am-btn-xs\"><i class='am-icon-cog'></i>编辑</button>" +
            "<button type='button' onclick='del("+ dt.data.enterList[i].enterId +")' class=\"am-btn am-btn-danger am-round am-btn-xs\"><i class='am-icon-cog'></i>删除</button>" +
            "</div>" +
            "</td>" +
            "</tr>";

        enterTableTbody.append(html);
    }


}

// 初始化加载企业表格
function initEnterTable(page){
    currentPage = page;
    $.ajax({
        url: baseUrl() + '/enter/initEnterTable/'+page,
        type: 'get',
        success: function (dt) {
            if(dt.code === 200){
                initEnterTableTbody(dt);
                // 左侧 第 1 到 2 条记录，共 4 条
                startToEndAndTotal(dt);

                pagination = new Pagination({
                    wrap: $('.am-pagination'), // 存放分页内容的容器
                    count: dt.data.totalPage, // 总页数
                    current: currentPage, // 当前的页数（默认为1）
                    callback: function (page) { // 每一个页数按钮的回调事件
                        // page 为当前点击的页数
                        currentPage = page;
                        // 换页时将根checkbox设置为不选中
                        if($("input[name='enterCheckboxs']").prop('checked')){
                            $("input[name='enterCheckboxs']").removeAttr('checked');
                        }

                        $.ajax({
                            url: baseUrl() + '/enter/initEnterTable/' + page,
                            type: 'get',
                            success: function (dt) {
                                initEnterTableTbody(dt);
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



// 模糊搜索企业
$("#SEARCHENTER").click(function () {
    var searchName = $(".am-form-field").val();
    if(searchName === ''){
        initEnterTable(1);
    }else{
        $.ajax({
            url: baseUrl() + '/enter/searchEnterTable',
            type: 'post',
            data: {
                name: searchName,
                page: 1
            },
            success: function (dt) {
                if(dt.code === 200){
                    currentPage = 1;
                    initEnterTableTbody(dt);
                    // 左侧 第 1 到 2 条记录，共 4 条
                    startToEndAndTotal(dt);

                    pagination = new Pagination({
                        wrap: $('.am-pagination'), // 存放分页内容的容器
                        count: dt.data.totalPage, // 总页数
                        current: 1, // 当前的页数（默认为1）
                        callback: function (page) { // 每一个页数按钮的回调事件
                            // page 为当前点击的页数
                            currentPage = page;
                            // 换页时将根checkbox设置为不选中
                            if($("input[name='enterCheckboxs']").prop('checked')){
                                $("input[name='enterCheckboxs']").removeAttr('checked');
                            }

                            $.ajax({
                                url: baseUrl() + '/enter/searchEnterTable',
                                type: 'post',
                                data: {
                                    name: searchName,
                                    page: page
                                },
                                success: function (dt) {
                                    initEnterTableTbody(dt);
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
    if(dt.data.enterListCount === 0){
        $("#start").text(0);
        $("#end").text(0);
        // 总数量
        $("#totalNum").text(0);
    }else {
        var startXuhao = ((currentPage - 1) * dt.data.pageSize + (1));
        var endXuhao = ((currentPage - 1) * dt.data.pageSize + (1) + (dt.data.enterList.length - 1));
        $("#start").text(startXuhao);
        $("#end").text(endXuhao);
        // 总数量
        $("#totalNum").text(dt.data.enterListCount);
    }
}

// checkbox 全选或全不选
$("input[name='enterCheckboxs']").click(function () {
    if(this.checked){
        $("input[name='enterCheckbox']").prop('checked','checked');
    }else {
        $("input[name='enterCheckbox']").removeAttr('checked');
    }
});

// 初始化checkbox不选
function clearCheckbox(){
    // 换页时将根checkbox设置为不选中
    if($("input[name='enterCheckboxs']").prop('checked')){
        $("input[name='enterCheckboxs']").removeAttr('checked');
        $("input[name='enterCheckbox']").removeAttr('checked');
    }
}

// 批量删除企业
$("#delAllEnter").click(function () {
    var enterIds = [];

    $("input[name='enterCheckbox']:checked").each(function () {
        enterIds.push($(this).val());
    });

    if(enterIds.length === 0){
        layer.msg("请选择企业", {icon: 5, time: 1000});
    }else {
        var index = layer.confirm("是否删除",{
            title:'提示',
            icon:3
        },function () {
            layer.close(index);
            $.ajax({
                url: baseUrl() + '/enter/delAllEnter',
                type: 'post',
                data: {
                    enterIds: enterIds
                },
                success: function (dt) {
                    if (dt.code === 200){
                        layer.msg("删除成功",{icon: 6,time: 1000},function () {
                            var searchName = $(".am-form-field").val();
                            if(searchName !== ''){
                                initEnterTable(1);
                                $(".am-form-field").val('');
                            }else {
                                if(Number(currentPage)===1){
                                    initEnterTable(currentPage);
                                }else {
                                    initEnterTable(currentPage - 1);
                                }
                            }
                            $("input[name='enterCheckboxs']").removeAttr('checked');
                        })
                    }
                },
                error: function (error) {
                    layer.msg(error_msg(),{icon: 5,time: 1000})
                }
            })
        })
    }

});

// 点击添加企业按钮，打开模态框
function addModal(){
    $("#enterForm")[0].reset();
    $("#ADDENTER").css('display','block');
    $("#EDITENTER").css('display','none');
    $("#enter-add-edit-modal").modal({closeViaDimmer: false,dimmer: false });//点击遮罩不关闭modal
    $("#enter-add-edit-modal").modal("open");
    clearCheckbox();
}

// 添加企业
$("#ADDENTER").click(function () {
    var name = $("#name").val();
    var address = $("#address").val();
    var contact = $("#contact").val();
    var introduce = $("#introduce").val();

    if(name === ''){
        layer.msg('企业名称为空',{icon: 5,time: 1000});
    }else if(address === ''){
        layer.msg('企业地址为空',{icon: 5,time: 1000});
    }else if(contact === ''){
        layer.msg('联系人为空',{icon: 5,time: 1000});
    }else{
        var data = {"name": name,"address": address,"contact":contact,"introduce":introduce};
        $.ajax({
            url: baseUrl() + '/enter/addEnter',
            type: 'post',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (dt) {
                if(dt.code === 200){
                    layer.msg('添加成功',{icon: 6,time: 1000},function () {
                        $("#enter-add-edit-modal").modal("close");

                        var searchName = $(".am-form-field").val();
                        if(searchName !== ''){
                            initEnterTable(1);
                            $(".am-form-field").val('');
                        }else {
                            initEnterTable(currentPage);
                        }
                    })
                }
            },
            error: function (error) {
                layer.msg(error_msg(),{icon: 5,time: 1000})
            }
        })
    }

    return false;
});

// 查看企业信息
function view(value) {
    $.ajax({
        url: baseUrl() + '/enter/getEnter/'+value,
        type: 'get',
        success: function (dt) {
            if (dt.code === 200){
                $("#VIEW_INTRODUCE").text(dt.data.introduce);
            }
        },
        error: function (error) {
            layer.msg(error_msg(),{icon: 5,time: 1000})
        }
    });
}

// 编辑企业信息(打开模态框，显示企业信息)
function edit(value) {
    enterId = value;

    $("#enterForm")[0].reset();
    $("#ADDENTER").css('display','none');
    $("#EDITENTER").css('display','block');
    $("#enter-add-edit-modal").modal({closeViaDimmer: false,dimmer: false });//点击遮罩不关闭modal
    $("#enter-add-edit-modal").modal("open");


    $.ajax({
        url: baseUrl() + '/enter/getEnter/'+value,
        type: 'get',
        success: function (dt) {
            if (dt.code === 200){
                $("#name").val(dt.data.name);
                $("#address").val(dt.data.address);
                $("#contact").val(dt.data.contact);
                $("#introduce").val(dt.data.introduce);
            }
        },
        error: function (error) {
            layer.msg(error_msg(),{icon: 5,time: 1000})
        }
    });
}

// 修改企业
$("#EDITENTER").click(function () {
    var name = $("#name").val();
    var address = $("#address").val();
    var contact = $("#contact").val();
    var introduce = $("#introduce").val();

    if(name === ''){
        layer.msg('企业名称为空',{icon: 5,time: 1000});
    }else if(address === ''){
        layer.msg('企业地址为空',{icon: 5,time: 1000});
    }else if(contact === ''){
        layer.msg('联系人为空',{icon: 5,time: 1000});
    }else{
        var data = {"enterId": enterId,"name": name,"address": address,"contact":contact,"introduce":introduce};
        $.ajax({
            url: baseUrl() + '/enter/updateEnter',
            type: 'post',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (dt) {
                if(dt.code === 200){
                    layer.msg('修改成功',{icon: 6,time: 1000},function () {
                        $("#enter-add-edit-modal").modal("close");

                        var searchName = $(".am-form-field").val();
                        if(searchName !== ''){
                            initEnterTable(1);
                            $(".am-form-field").val('');
                        }else {
                            initEnterTable(currentPage);
                        }
                    })
                }
            },
            error: function (error) {
                layer.msg(error_msg(),{icon: 5,time: 1000})
            }
        })
    }

    return false;
});

// 删除企业信息
function del(value) {
    var index = layer.confirm("是否删除",{
        title:'提示',
        icon:3
    },function () {
        layer.close(index);
        $.ajax({
            url: baseUrl() + '/enter/delEnter/' + value,
            type: 'delete',
            success: function (dt) {
                if (dt.code === 200) {
                    layer.msg("删除成功", {icon: 6, time: 1000}, function () {
                        // 换页时将根checkbox设置为不选中
                        if($("input[name='enterCheckboxs']").prop('checked')){
                            $("input[name='enterCheckboxs']").removeAttr('checked');
                        }

                        var searchName = $(".am-form-field").val();
                        if (searchName !== '') {
                            initEnterTable(1);
                            $(".am-form-field").val('');
                        } else {
                            if (Number(currentPage) === 1) {
                                initEnterTable(currentPage);
                            } else {
                                if (currentLength === 1) {
                                    initEnterTable(currentPage - 1);
                                } else {
                                    initEnterTable(currentPage);
                                }
                            }
                        }
                    })
                }
            },
            error: function (error) {
                layer.msg(error_msg(), {icon: 5, time: 1000})
            }
        });
    });
}