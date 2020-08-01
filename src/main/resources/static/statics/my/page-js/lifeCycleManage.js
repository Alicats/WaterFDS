var clickPage = 1;
var pageSize = 2;

/**
 * 点击添加按钮
 */
$('#BTN_ADD_LifeCycle').on('click', function () {
    initSelect();
    addLifeCycle();
});

/**
 * 点击搜索按钮
 */
$("#BTN_SEARCH").click(function () {
    clickPage = 1;
    searchLifeCycle($("#SEARCH_NAME").val(),clickPage);
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
    delLifeCycleBatch();
});


/**
 * 初始化生命周期数据表
 */
$(function () {
    $.ajax({
        url: baseUrl() + '/lifecycle/initTable?page=1',
        type: 'get',
        success: function (dt) {
            console.log(dt)
            if (dt.code == 200) {
                initTable(dt.data.lifeCycles);
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
    $("#LifeCycle_TABLE_BODY").empty();

    for (var i = 0; i < dt.length; i++) {
        var item = "<tr data-tt-id="+dt[i].lifeId+" data-tt-parent-id="+dt[i].pid+">" +
            "<td><input type='checkbox' name='ckbox' value='"+dt[i].lifeId+"'></td>" +
            // "<td>" + ((clickPage-1)*pageSize+(i+1)) + "</td>" +
            "<td>" + dt[i].name + "</td>" +
            "<td>" + dt[i].introduce + "</td>" +
            "<td>" +
            "<div class='tpl-table-black-operation'>" +
            "<a href='javascript:;' onclick=editLifeCycle("+dt[i].lifeId+")><i class='am-icon-pencil'></i> 编辑</a>&emsp;" +
            "<a href='javascript:;' onclick=delLifeCycle("+dt[i].lifeId+","+dt.length+") class='tpl-table-black-operation-del'><i class='am-icon-trash'></i> 删除</a>" +
            "</div>" +
            "</td>" +
            "</tr>";

        $("#LifeCycle_TABLE_BODY").append(item);
    }

    //创建tree_table
    $("#LifeCycle_Table").treetable({
        theme:'vsStyle',
        expandable:true,
        initialState:"expanded",
    },true);
}

/**
 * 初始化下拉框
 * @param dt
 */
function initSelect(val) {

    $.ajax({
        url: baseUrl() + "/lifecycle/initSelect",
        type:'get',
        success:function (dt) {
            console.log(dt);
            if(dt.code == 200){

                $("#ADD_LifeCycle_SELECT").empty();

                var opt = "<option value='0' name='pid'>无</option>";
                $("#ADD_LifeCycle_SELECT").append(opt);

                for(var i=0;i<dt.data.length;i++){
                    var item;
                    if(val == dt.data[i].lifeId)
                        item = "<option value="+dt.data[i].lifeId+" name='pid' selected='selected'>"+dt.data[i].name+"</option>";
                    else
                        item = "<option value="+dt.data[i].lifeId+" name='pid'>"+dt.data[i].name+"</option>";
                    $("#ADD_LifeCycle_SELECT").append(item);
                }

            }
        },
        error:function (error) {
            layer.msg(error_msg(),{icon:5});
        }
    });
}

/**
 * 刷新数据表
 */
function refreshTable(page) {
    $("#UNIT_TABLE_BODY").empty();

    var searchName = $("#SEARCH_NAME").val();

    if(searchName === ''){
        $.ajax({
            url: baseUrl() + '/lifecycle/initTable?page='+page,
            type: 'get',
            success: function (dt) {
                console.log(dt);
                if (dt.code == 200) {
                    initTable(dt.data.lifeCycles);
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
        searchLifeCycle(searchName,page);
    }

}

/**
 * 添加一条生命周期信息
 */
function addLifeCycle(){
    $('#ADD_LifeCycle_FORM')[0].reset();

    var index = layer.open({
        title: '添加生命周期',
        type: '1',
        area: '800px',
        content: $('#ADD_LifeCycle_DIV'),
        btn: ["取消", "提交"],
        btn1: function () {
            layer.close(index);
        },
        btn2: function () {

            if ($("#LifeCycle_NAME").val() === '') {
                layer.msg("请输入生命周期名称",{icon:5});
                return false;
            }

            var serialize = $("#ADD_LifeCycle_FORM").serialize();
            serialize += '&pid='+ $("#ADD_LifeCycle_SELECT option:selected").val();

            $.ajax({
                url:baseUrl() + '/lifecycle/add',
                type:'post',
                data: serialize,
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
 * 删除一条生命周期信息
 * @param unitId
 */
function delLifeCycle(lifeId,count) {
    var index = layer.confirm("是否删除该条信息？",{
        title:'提示',
        icon:2
    },function () {
        $.ajax({
            url:baseUrl() + '/lifecycle/del/'+lifeId,
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
function delLifeCycleBatch() {

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
            url:baseUrl() + '/lifecycle/del',
            type:'delete',
            data:{
                lifeIds:checkIds
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
 * 编辑一条生命周期信息
 * @param unitId
 */
function editLifeCycle(lifeId) {


    $.ajax({
        url:baseUrl() + '/lifecycle/view/'+lifeId,
        type:'get',
        success:function (dt) {
            console.log(dt);
            if(dt.code == 200){
                $("#LifeCycle_NAME").val(dt.data.name);
                $("#LifeCycle_INTRODUCE").val(dt.data.introduce);

                initSelect(dt.data.pid);

                // $("#ADD_LifeCycle_SELECT option").each(function () {
                //     if($(this).val() == dt.data.pid){
                //         console.log("pid:"+dt.data.pid);
                //         $(this).attr("selected", true);
                //     }
                // });

                var index = layer.open({
                    title: '编辑生命周期',
                    type: '1',
                    area: '800px',
                    content: $('#ADD_LifeCycle_DIV'),
                    btn: ["取消", "保存"],
                    btn1: function () {
                        layer.close(index);
                    },
                    btn2: function () {
                        if ($("#LifeCycle_NAME").val() === '') {
                            layer.msg("请输入生命周期名称",{icon:5});
                            return false;
                        }

                        var serialize = $("#ADD_LifeCycle_FORM").serialize();
                        serialize += '&pid='+ $("#ADD_LifeCycle_SELECT option:selected").val();

                        $.ajax({
                            url:baseUrl() + '/lifecycle/modify/'+lifeId,
                            type:'put',
                            data:serialize,
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
 * 根据生命周期名称查找生命周期信息
 */
function searchLifeCycle(searchName,page) {
    $.ajax({
        url:baseUrl() + '/lifecycle/search?searchName='+searchName+'&page='+page,
        type:'get',
        success:function (dt) {
            console.log(dt);
            if(dt.code == 200){
                initTable(dt.data.lifeCycles);
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
                url: baseUrl() + '/lifecycle/initTable?page='+page,
                type: 'get',
                success: function (dt) {
                    initTable(dt.data.lifeCycles);
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
                url:baseUrl() + '/lifecycle/search?searchName='+$("#SEARCH_NAME").val()+'&page='+page,
                type: 'get',
                success: function (dt) {
                    initTable(dt.data.lifeCycles);
                    $("#CKBOX_SELECT_ALL").attr("checked",false);
                },
                error: function (error) {
                    layer.msg(error_msg(),{icon:5});
                }
            })
        }
    });
}


