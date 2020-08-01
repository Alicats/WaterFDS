var currentPage = 1;
var typeId;
var SEARCH_NAME;
var currentLength;

// 初始化
$(function () {
    initProductTypeTable(currentPage);
});

// 切换主题改变颜色
$("span[name='SKIN']").on('click',function () {
    if($("body").hasClass("theme-white")){
        $("#TOTAL").css('color','black');
    }else {
        $("#TOTAL").css('color','white');
    }
});


// 初始化加载产品类别表格
function initProductTypeTable(page){
    currentPage = page;
    $.ajax({
        url: baseUrl() + '/productType/initProductTypeTable',
        type: 'post',
        data: {
            page: page,
            name: SEARCH_NAME
        },
        success: function (dt) {
            if(dt.code === 200){
                initProductTypeTableTbody(dt);
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
                            url: baseUrl() + '/productType/initProductTypeTable',
                            type: 'post',
                            data: {
                                page: page,
                                name: SEARCH_NAME
                            },
                            success: function (dt) {
                                initProductTypeTableTbody(dt);
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


// 分页时动态改变产品类别表格数据
function initProductTypeTableTbody(dt){
    var productTypeTableTbody = $("#productTypeTableTbody");
    productTypeTableTbody.empty();
    for(var i=0;i<dt.data.productTypeList.length;i++){
        currentLength = dt.data.productTypeList.length;
        var xuhao = ((currentPage-1)*dt.data.pageSize+(1+i));
        var html = "<tr>" +
            "<td style='text-align: center;'><input type='checkbox' name='productTypeCheckbox' value='"+ dt.data.productTypeList[i].typeId +"'></td>" +
            "<td style='text-align: center;'>"+ xuhao +"</td>" +
            "<td style='text-align: center;'>"+ dt.data.productTypeList[i].typeId +"</td>" +
            "<td style='text-align: center;'>"+ dt.data.productTypeList[i].name +"</td>" +
            "<td style='text-align: center;'>"+ dt.data.productTypeList[i].introduce +"</td>" +
            "<td style='text-align: center;'>"+ dt.data.productTypeList[i].remark +"</td>" +
            "<td style='text-align: center;'>" +
            "<div class='tpl-table-black-operation'>" +
            "<button type='button' onclick='edit(\""+ dt.data.productTypeList[i].typeId +"\")' class=\"am-btn am-btn-warning am-round am-btn-xs\"><i class='am-icon-cog'></i>编辑</button>" +
            "<button type='button' onclick='del(\""+ dt.data.productTypeList[i].typeId +"\")' class=\"am-btn am-btn-danger am-round am-btn-xs\"><i class='am-icon-cog'></i>删除</button>" +
            "</div>" +
            "</td>" +
            "</tr>";

        productTypeTableTbody.append(html);
    }
}


// 模糊搜索产品类型
$("#SEARCH_ProductType").click(function () {
    var searchName = $("#ProductType_SEARCH").val();
    if(searchName === ''){
        SEARCH_NAME = undefined;
        initProductTypeTable(1);
    }else{
        SEARCH_NAME = searchName;
        $.ajax({
            url: baseUrl() + '/productType/initProductTypeTable',
            type: 'post',
            data: {
                page: 1,
                name: searchName
            },
            success: function (dt) {
                if(dt.code === 200){
                    currentPage = 1;
                    initProductTypeTableTbody(dt);
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
                                url: baseUrl() + '/productType/initProductTypeTable',
                                type: 'post',
                                data: {
                                    page: page,
                                    name: searchName
                                },
                                success: function (dt) {
                                    initProductTypeTableTbody(dt);
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
            },
            error: function () {
                layer.msg(error_msg(),{icon: 5, time: 1000});
            }

        })
    }
    return false;
});


// 左侧 第 1 到 2 条记录，共 4 条
function startToEndAndTotal(dt){
    if(dt.data.productTypeCount === 0){
        $("#start").text(0);
        $("#end").text(0);
        // 总数量
        $("#totalNum").text(0);
    }else {
        var startXuhao = ((currentPage - 1) * dt.data.pageSize + (1));
        var endXuhao = ((currentPage - 1) * dt.data.pageSize + (1) + (dt.data.productTypeList.length - 1));
        $("#start").text(startXuhao);
        $("#end").text(endXuhao);
        // 总数量
        $("#totalNum").text(dt.data.productTypeCount);
    }
}


// checkbox 全选和全不选
$("input[name='productTypeCheckboxs']").click(function () {
    if(this.checked){
        $("input[name='productTypeCheckbox']").prop('checked','checked');
    }else {
        $("input[name='productTypeCheckbox']").removeAttr('checked');
    }
});

// 初始化checkbox不选
function clearCheckbox(){
    // 换页时将根checkbox设置为不选中
    if($("input[name='productTypeCheckboxs']").prop('checked')){
        $("input[name='productTypeCheckboxs']").removeAttr('checked');
        $("input[name='productTypeCheckbox']").removeAttr('checked');
    }
}


// 批量删除产品类型
$("#delAllProductType").click(function () {
    var typeIds=[];
    $("input[name='productTypeCheckbox']:checked").each(function () {
        typeIds.push($(this).val());
    });

    if(typeIds.length === 0){
        layer.msg("请选择产品类型", {icon: 5, time: 1000});
    }else {
        var index = layer.confirm("是否删除",{
            title:'提示',
            icon:3
        },function () {
            layer.close(index);
            $.ajax({
                url: baseUrl() + '/productType/delAllProductType',
                type: 'post',
                data: {
                    typeIds: typeIds
                },
                success: function (dt) {
                    if(dt.code === 200){
                        layer.msg("删除成功",{icon: 6,time: 1000},function () {
                            var searchName = $("#ProductType_SEARCH").val();
                            if (searchName !== '') {
                                if(Number(currentPage)===1){
                                    initProductTypeTable(currentPage);
                                }else {
                                    initProductTypeTable(currentPage - 1);
                                }
                            } else {
                                if(Number(currentPage)===1){
                                    initProductTypeTable(currentPage);
                                }else {
                                    initProductTypeTable(currentPage - 1);
                                }
                            }
                            $("input[name='productTypeCheckboxs']").removeAttr('checked');
                        });
                    }
                }
            })
        })
    }
});

// 删除产品类型
function del(value) {
    var index = layer.confirm("是否删除",{
        title:'提示',
        icon:3
    },function () {
        layer.close(index);
        $.ajax({
            url: baseUrl() + '/productType/delProductType/' + value,
            type: 'delete',
            success: function (dt) {
                if (dt.code === 200) {
                    layer.msg("删除成功", {icon: 6, time: 1000}, function () {
                        var searchName = $("#ProductType_SEARCH").val();

                        if (searchName !== '') {
                            if (Number(currentPage) === 1) {
                                initProductTypeTable(currentPage);
                            } else {
                                if (currentLength === 1) {
                                    initProductTypeTable(currentPage - 1);
                                } else {
                                    initProductTypeTable(currentPage);
                                }
                            }
                        } else {
                            if (Number(currentPage) === 1) {
                                initProductTypeTable(currentPage);
                            } else {
                                if (currentLength === 1) {
                                    initProductTypeTable(currentPage - 1);
                                } else {
                                    initProductTypeTable(currentPage);
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


// 点击添加产品类型按钮，打开模态框
function addModal(){
    $("#productTypeForm")[0].reset();
    $("#result").text("");
    $("#ADD_ProductType").css('display','block');
    $("#EDIT_ProductType").css('display','none');
    $("#productType-add-edit-modal").modal({closeViaDimmer: false,dimmer: false });//点击遮罩不关闭modal
    $("#productType-add-edit-modal").modal("open");
    clearCheckbox();
}

// 添加产品类型
$("#ADD_ProductType").click(function () {
    var name = $("#name").val();
    var introduce = $("#introduce").val();
    var remark = $("#remark").val();

    if(name === ''){
        layer.msg('产品类型名称为空',{icon: 5,time: 1000});
    }else{
        var data = {"name":name,"introduce":introduce,"remark":remark};

        $.ajax({
            url: baseUrl() + '/productType/addProductType',
            type: 'post',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (dt) {
                if(dt.code === 200){
                    layer.msg('添加成功',{icon: 6, time: 1000},function () {
                        $("#productType-add-edit-modal").modal("close");

                        var searchName = $("#ProductType_SEARCH").val();
                        if(searchName !== ''){
                            initProductTypeTable(currentPage);
                        }else {
                            initProductTypeTable(currentPage);
                        }
                    })
                }
            },
            error: function () {
                layer.msg(error_msg(),{icon: 5, time: 1000});
            }

        })
    }

    return false;
});


// 编辑产品类型信息, 打开模态框
function edit(value) {
    typeId = value;

    $("#productTypeForm")[0].reset();
    $("#ADD_ProductType").css('display','none');
    $("#EDIT_ProductType").css('display','block');
    $("#productType-add-edit-modal").modal({closeViaDimmer: false,dimmer: false });//点击遮罩不关闭modal
    $("#productType-add-edit-modal").modal("open");


    $.ajax({
        url: baseUrl() + '/productType/getProductType/'+value,
        type: 'get',
        success: function (dt) {
            if (dt.code === 200){
                $("#name").val(dt.data.name);
                $("#introduce").val(dt.data.introduce);
                $("#remark").val(dt.data.remark);
            }
        }
    });
}

// 修改产品类型信息
$("#EDIT_ProductType").click(function () {
    var name = $("#name").val();
    var introduce = $("#introduce").val();
    var remark = $("#remark").val();

    if(name === ''){
        layer.msg('产品类型名称为空',{icon: 5,time: 1000});
    }else {
        var data = {"typeId": typeId,"name": name,"introduce": introduce,"remark": remark};

        $.ajax({
            url: baseUrl() + '/productType/updateProductType',
            type: 'post',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (dt) {
                if(dt.code === 200){
                    layer.msg('修改成功',{icon: 6, time: 1000},function () {
                        $("#productType-add-edit-modal").modal("close");

                        var searchName = $("#ProductType_SEARCH").val();
                        if(searchName !== ''){
                            SEARCH_NAME = searchName;
                            initProductTypeTable(currentPage);
                        }else {
                            initProductTypeTable(currentPage);
                        }
                    })
                }
            },
            error: function () {
                layer.msg(error_msg(),{icon: 5, time: 1000});
            }

        })
    }
    return false;
});