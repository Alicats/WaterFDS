var clickPage = 1;
var pageSize = 2;

/**
 * 点击添加按钮
 */
$('#BTN_ADD_MaterialGroup').on('click', function () {
    addMaterialGroup();
});

/**
 * 点击搜索按钮
 */
$("#BTN_SEARCH").click(function () {
    clickPage = 1;
    searchUnit($("#SEARCH_NAME").val(),clickPage);
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
    delMaterialGroupBatch();
});


/**
 * 初始化材料群组数据表
 */
$(function () {
    $.ajax({
        url: basePath + '/materialGroup/initTable?page=1',
        type: 'get',
        success: function (dt) {
            console.log(dt)
            if (dt.code == 200) {
                initTable(dt.data.materialGroups);
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
    $("#MaterialGroup_TABLE_BODY").empty();

    for (var i = 0; i < dt.length; i++) {
        var item = "<tr>" +
            "<td><input type='checkbox' name='ckbox' value='"+dt[i].groupId+"'></td>" +
            "<td>" + ((clickPage-1)*pageSize+(i+1)) + "</td>" +
            "<td>" + dt[i].name + "</td>" +
            "<td>" + dt[i].introduce + "</td>" +
            "<td>" +
            "<div class='tpl-table-black-operation'>" +
            "<a href='javascript:;' onclick=editMaterialGroup("+dt[i].groupId+")><i class='am-icon-pencil'></i> 编辑</a>&emsp;" +
            "<a href='javascript:;' onclick=delMaterialGroup("+dt[i].groupId+","+dt.length+") class='tpl-table-black-operation-del'><i class='am-icon-trash'></i> 删除</a>" +
            "</div>" +
            "</td>" +
            "</tr>";

        $("#MaterialGroup_TABLE_BODY").append(item);
    }
}

/**
 * 刷新数据表
 */
function refreshTable(page) {
    $("#MaterialGroup_TABLE_BODY").empty();

    var searchName = $("#SEARCH_NAME").val();

    if(searchName === ''){
        $.ajax({
            url: baseUrl() + '/materialGroup/initTable?page='+page,
            type: 'get',
            success: function (dt) {
                console.log(dt);
                if (dt.code == 200) {
                    initTable(dt.data.materialGroups);
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
        searchUnit(searchName,page);
    }

}

/**
 * 添加一条群组信息
 */
function addMaterialGroup(){
    $('#ADD_MaterialGroup_FORM')[0].reset();
    var index = layer.open({
        title: '添加群组',
        type: '1',
        area: '800px',
        content: $('#ADD_MaterialGroup_DIV'),
        btn: ["取消", "提交"],
        btn1: function () {
            layer.close(index);
        },
        btn2: function () {

            if ($("#MaterialGroup_NAME").val() === '') {
                layer.msg("请输入群组名称",{icon:5});
                return false;
            }

            $.ajax({
                url:baseUrl() + '/materialGroup/add',
                type:'post',
                data: $("#ADD_MaterialGroup_FORM").serialize(),
                success:function (dt) {
                    console.log(dt);
                    if(dt.code == 200){
                        layer.msg(dt.message,{icon:6});
                        refreshTable(clickPage);
                    }
                },
                error:function (error) {
                    layer.msg(error_msg(),{icon:5});
                }
            });
            layer.close(index);
        },
        success: function(layero, index){

            if ($("body").hasClass("theme-black")) {
                $("#layui-layer"+index).addClass("widget");
            }

        }
    });
}

/**
 * 删除一条群组信息
 * @param unitId
 */
function delMaterialGroup(groupId,count) {
    var index = layer.confirm("是否删除该条信息？",{
        title:'提示',
        icon:2
    },function () {
        $.ajax({
            url:baseUrl() + '/materialGroup/del/'+groupId,
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
 * 批量删除量纲信息
 */
function delMaterialGroupBatch() {

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
            url:baseUrl() + '/materialGroup/del',
            type:'delete',
            data:{
                groupIds:checkIds
            },
            success:function (dt) {
                console.log(dt);
                if(dt.code == 200){
                    layer.msg(dt.message,{icon:6});
                    clickPage = clickPage - 1;
                    console.log("clickPage:"+clickPage);
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
 * 编辑一条群组信息
 * @param unitId
 */
function editMaterialGroup(groupId) {
    $.ajax({
        url:baseUrl() + '/materialGroup/view/'+groupId,
        type:'get',
        success:function (dt) {
            console.log(dt);
            if(dt.code == 200){
                $("#MaterialGroup_NAME").val(dt.data.name);
                $("#MaterialGroup_INTRODUCE").val(dt.data.introduce);

                var index = layer.open({
                    title: '编辑量纲',
                    type: '1',
                    area: '800px',
                    content: $('#ADD_MaterialGroup_DIV'),
                    btn: ["取消", "保存"],
                    btn1: function () {
                        layer.close(index);
                    },
                    btn2: function () {
                        $.ajax({
                            url:baseUrl() + '/materialGroup/modify/'+groupId,
                            type:'put',
                            data:$("#ADD_MaterialGroup_FORM").serialize(),
                            success:function (dt) {
                                console.log(dt);
                                if(dt.code == 200){
                                    layer.msg(dt.message,{icon:6});
                                    refreshTable(clickPage);
                                }
                            },
                            error:function (error) {
                                layer.msg(error_msg(),{icon:5});
                            }
                        });
                        layer.close(index);
                    }
                });
            }
        },
        error:function (error) {
            layer.msg(error_msg(),{icon:5});
        }
    })
}

/**
 * 根据群组名称查找群组信息
 */
function searchUnit(searchName,page) {
    $.ajax({
        url:baseUrl() + '/materialGroup/search?searchName='+searchName+'&page='+page,
        type:'get',
        success:function (dt) {
            console.log(dt);
            if(dt.code == 200){
                initTable(dt.data.materialGroups);
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
                url: baseUrl() + '/materialGroup/initTable?page='+page,
                type: 'get',
                success: function (dt) {
                    initTable(dt.data.materialGroups);
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
                url:baseUrl() + '/materialGroup/search?searchName='+$("#SEARCH_NAME").val()+'&page='+page,
                type: 'get',
                success: function (dt) {
                    initTable(dt.data.materialGroups);
                    $("#CKBOX_SELECT_ALL").attr("checked",false);
                },
                error: function (error) {
                    layer.msg(error_msg(),{icon:5});
                }
            })
        }
    });
}


