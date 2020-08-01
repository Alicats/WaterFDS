<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:th="http://www.thymeleaf.org"
      xmlns:sec="http://www.thymeleaf.org/thymeleaf-extras-springsecurity3">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Amaze UI Admin index Examples</title>
    <meta name="description" content="这是一个 index 页面">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="icon" type="image/png" href="${basePath}/statics/admin/assets/i/favicon.png">
    <link rel="apple-touch-icon-precomposed" href="${basePath}/statics/admin/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <script src="${basePath}/statics/admin/assets/js/echarts.min.js"></script>
    <link rel="stylesheet" href="${basePath}/statics/admin/assets/css/amazeui.min.css" />
    <link rel="stylesheet" href="${basePath}/statics/admin/assets/css/amazeui.datatables.min.css" />
    <link rel="stylesheet" href="${basePath}/statics/admin/assets/css/app.css">
    <script src="${basePath}/statics/admin/assets/js/jquery.min.js"></script>

</head>
<body data-type="index">
<script src="${basePath}/statics/admin/assets/js/theme.js"></script>
<div class="am-g tpl-g">

    <#include "common/header.ftl"/>
    <#include "common/skiner.ftl"/>


    <!-- 侧边导航栏 -->
    <div class="left-sidebar">
        <!-- 用户信息 -->
        <div class="tpl-sidebar-user-panel">
            <div class="tpl-user-panel-slide-toggleable">
                <div class="tpl-user-panel-profile-picture">
                    <img src="${basePath}/statics/admin/assets/img/user04.png" alt="">
                </div>
                <span class="user-panel-logged-in-text">
                        <i class="am-icon-circle-o am-text-success tpl-user-panel-status-icon"></i>
                      禁言小张
                    </span>
            </div>
        </div>

        <!-- 菜单 -->
        <ul class="sidebar-nav">
            <#--<li class="sidebar-nav-heading">Components <span class="sidebar-nav-heading-info"> 附加组件</span></li>-->
            <li class="sidebar-nav-link">
                <a href="${basePath}/index">
                    <i class="am-icon-home sidebar-nav-link-logo"></i> 首页
                </a>
            </li>

            <@shiro.hasRole name="admin">
                <li class="sidebar-nav-link">
                    <a href="javascript:;" class="sidebar-nav-sub-title">
                        <i class="am-icon-table sidebar-nav-link-logo"></i> 基础信息
                        <span class="am-icon-chevron-down am-fr am-margin-right-sm sidebar-nav-sub-ico"></span>
                    </a>
                    <ul class="sidebar-nav sidebar-nav-sub">
                        <li class="sidebar-nav-link">
                            <a href="${basePath}/admin/enterManage">
                                <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 企业管理
                            </a>
                        </li>

                        <li class="sidebar-nav-link">
                            <a href="table-list-img.html">
                                <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 生命周期管理
                            </a>
                        </li>

                        <li class="sidebar-nav-link">
                            <a href="${basePath}/admin/unitManage">
                                <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 量纲管理
                            </a>
                        </li>

                        <li class="sidebar-nav-link">
                            <a href="table-list-img.html">
                                <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 基础流管理
                            </a>
                        </li>

                        <li class="sidebar-nav-link">
                            <a href="${basePath}/admin/materialGroupManage">
                                <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 群组管理
                            </a>
                        </li>
                    </ul>

                </li>
            </@shiro.hasRole>


            <@shiro.hasAnyRoles name="admin,enterprise">

                <li class="sidebar-nav-link">
                    <a href="javascript:;" class="sidebar-nav-sub-title">
                        <i class="am-icon-table sidebar-nav-link-logo"></i> 用户管理
                        <span class="am-icon-chevron-down am-fr am-margin-right-sm sidebar-nav-sub-ico"></span>
                    </a>
                    <@shiro.hasRole name="admin">
                        <ul class="sidebar-nav sidebar-nav-sub">
                            <li class="sidebar-nav-link">
                                <a href="${basePath}/admin/enterpriseManage">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 企业负责人管理
                                </a>
                            </li>

                            <li class="sidebar-nav-link">
                                <a href="${basePath}/admin/otheruserManage">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 其他用户管理
                                </a>
                            </li>
                        </ul>
                    </@shiro.hasRole>

                    <@shiro.hasRole name="enterprise">
                        <ul class="sidebar-nav sidebar-nav-sub">
                            <li class="sidebar-nav-link">
                                <a href="${basePath}/enterprise/supplierManage">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 供应商管理
                                </a>
                            </li>

                            <li class="sidebar-nav-link">
                                <a href="${basePath}/enterprise/collaboratorManage">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 内部协作人管理
                                </a>
                            </li>
                        </ul>
                    </@shiro.hasRole>

                </li>
            </@shiro.hasAnyRoles>

            <li class="sidebar-nav-link">
                <a href="javascript:;" class="sidebar-nav-sub-title">
                    <i class="am-icon-table sidebar-nav-link-logo"></i> 产品管理
                    <span class="am-icon-chevron-down am-fr am-margin-right-sm sidebar-nav-sub-ico"></span>
                </a>
                <ul class="sidebar-nav sidebar-nav-sub">
                    <@shiro.hasAnyRoles name="admin,enterprise">
                        <li class="sidebar-nav-link">
                            <a href="${basePath}/productTypeManage">
                                <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 产品类型管理
                            </a>
                        </li>
                    </@shiro.hasAnyRoles>

                    <li class="sidebar-nav-link">
                        <a href="${basePath}/admin/otheruserManage">
                            <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 其他产品管理
                        </a>
                    </li>
                </ul>
            </li>

            <li class="sidebar-nav-link">
                <a href="login.html">
                    <i class="am-icon-key sidebar-nav-link-logo"></i> 消息管理
                </a>
            </li>
            <li class="sidebar-nav-link">
                <a href="login.html">
                    <i class="am-icon-key sidebar-nav-link-logo"></i> 报告管理
                </a>
            </li>

            <li class="sidebar-nav-link">
                <a href="${basePath}/userInfo" class="active">
                    <i class="am-icon-clone sidebar-nav-link-logo"></i> 个人信息
                </a>
            </li>
        </ul>
    </div>




    <!-- 内容区域 -->
    <div class="tpl-content-wrapper">

        <div class="container-fluid am-cf">
            <div class="row">
                <div class="am-u-sm-12 am-u-md-12 am-u-lg-9">
                    <div class="page-header-heading"><span class="am-icon-home page-header-heading-icon"></span> 个人信息</div>
                </div>

                <div class="am-modal-bd">
                    <div class="row">
                        <div class="am-u-sm-12 am-u-md-12 am-u-lg-12">
                            <div class="widget am-cf">
                                <div class="widget-body am-fr">

                                    <input id="userId" type="hidden" value="${Session.currentUser.userId}">
                                    <input id="roleId" type="hidden" value="${Session.currentUser.roleId}">
                                    <input id="enterId" type="hidden" value="${Session.currentUser.enterId}">
                                    <input id="status" type="hidden" value="${Session.currentUser.status}">

                                    <form id="supplierForm" class="am-form tpl-form-border-form tpl-form-border-br" data-am-validator>
                                        <div class="am-form-group">
                                            <label for="username" class="am-u-sm-3 am-form-label">用户名称</label>
                                            <div class="am-u-sm-7">
                                                <#if Session.currentUser.username != ''>
                                                    <input type="text" class="tpl-form-input" id="username" name="username" placeholder="请输入用户名" required value="${Session.currentUser.username}" >
                                                </#if>
                                                <#if Session.currentUser.username == ''>
                                                    <input type="text" class="tpl-form-input" id="username" name="username" placeholder="请输入用户名">
                                                </#if>
                                            </div>
                                            <div class="am-u-sm-2">

                                            </div>
                                        </div>

                                        <div class="am-form-group">
                                            <label for="password" class="am-u-sm-3 am-form-label">用户密码</label>
                                            <div class="am-u-sm-7">
                                                <#if Session.currentUser.password != ''>
                                                    <input type="password" class="tpl-form-input" id="password" name="password" placeholder="请输入用户密码" required value="${Session.currentUser.password}">
                                                </#if>
                                                <#if Session.currentUser.password == ''>
                                                    <input type="password" class="tpl-form-input" id="password" name="password" placeholder="请输入用户密码" required>
                                                </#if>
                                            </div>
                                            <div class="am-u-sm-2">

                                            </div>
                                        </div>

                                        <div class="am-form-group">
                                            <label for="address" class="am-u-sm-3 am-form-label">用户地址</label>
                                            <div class="am-u-sm-7">
                                                <#if Session.currentUser.address != ''>
                                                    <input type="text" class="tpl-form-input" id="address" name="address" placeholder="请输入用户地址" value="${Session.currentUser.address}">
                                                </#if>
                                                <#if Session.currentUser.address == ''>
                                                    <input type="text" class="tpl-form-input" id="address" name="address" placeholder="请输入用户地址">
                                                </#if>
                                            </div>
                                            <div class="am-u-sm-2">

                                            </div>
                                        </div>

                                        <div class="am-form-group">
                                            <label for="email" class="am-u-sm-3 am-form-label">用户邮箱</label>
                                            <div class="am-u-sm-7">
                                                <#if Session.currentUser.email != ''>
                                                    <input type="text" class="tpl-form-input" id="email" name="email" placeholder="请输入用户邮箱" value="${Session.currentUser.email}">
                                                </#if>
                                                <#if Session.currentUser.email == ''>
                                                    <input type="text" class="tpl-form-input" id="email" name="email" placeholder="请输入用户邮箱">
                                                </#if>
                                            </div>
                                            <div class="am-u-sm-2">

                                            </div>
                                        </div>

                                        <div class="am-form-group">
                                            <label for="telephone" class="am-u-sm-3 am-form-label">用户号码</label>
                                            <div class="am-u-sm-7">
                                                <#if Session.currentUser.telephone != ''>
                                                    <input type="text" class="tpl-form-input" id="telephone" name="telephone" placeholder="请输入用户号码" value="${Session.currentUser.telephone}">
                                                </#if>
                                                <#if Session.currentUser.telephone == ''>
                                                    <input type="text" class="tpl-form-input" id="telephone" name="telephone" placeholder="请输入用户号码">
                                                </#if>
                                            </div>
                                            <div class="am-u-sm-2">

                                            </div>
                                        </div>

                                        <div class="am-form-group">
                                            <label for="remark" class="am-u-sm-3 am-form-label">备注</label>
                                            <div class="am-u-sm-7">
                                                <input type="text" class="tpl-form-input" id="remark" name="remark" value="${Session.currentUser.remark}">
                                            </div>
                                            <div class="am-u-sm-2">

                                            </div>
                                        </div>

                                        <div class="am-form-group">
                                            <button type="button" class="am-btn am-btn-primary tpl-btn-bg-color-success " id="EDITUSER">修改</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
    </div>
</div>
</div>
<script src="${basePath}/statics/admin/assets/js/amazeui.min.js"></script>
<script src="${basePath}/statics/admin/assets/js/amazeui.datatables.min.js"></script>
<script src="${basePath}/statics/admin/assets/js/dataTables.responsive.min.js"></script>
<script src="${basePath}/statics/admin/assets/js/app.js"></script>
<script src="${basePath}/statics/plugin/layer/layer.js"></script>


<script src="${basePath}/statics/my/constance.js"></script>



<script>
    // 修改用户信息
    $("#EDITUSER").click(function () {
        var userId = $("#userId").val();
        var roleId = $("#roleId").val();
        var enterId = $("#enterId").val();
        var status = $("#status").val();

        var username = $("#username").val();
        var password = $("#password").val();
        var address = $("#address").val();
        var email = $("#email").val();
        var telephone = $("#telephone").val();
        var remark = $("#remark").val();

        var pwdRegex = new RegExp('(?=.*[0-9])(?=.*[a-zA-Z]).{8,30}');

        if(username === ''){
            layer.msg('用户名称为空',{icon: 5,time: 1000});
        }else if(password === ''){
            layer.msg('用户密码为空',{icon: 5,time: 1000});
        }else if(address === ''){
            layer.msg('用户地址为空',{icon: 5,time: 1000});
        }else if(email === ''){
            layer.msg('用户邮箱为空',{icon: 5,time: 1000});
        }else if(telephone === ''){
            layer.msg('用户号码为空',{icon: 5,time: 1000});
        }else if(!pwdRegex.test(password)){
            layer.msg('您的密码太简单(须包含字母、数字)',{icon: 5,time: 1000});
        }else{
            var data = {"userId": userId, "username": username, "password": password, "address": address, "email": email, "telephone":telephone, "remark": remark, "roleId":roleId, "enterId":enterId, "status":status};
            var index = layer.confirm("是否修改", {
                title: '提示',
                icon: 3
            }, function () {
                layer.close(index);
                $.ajax({
                    url: '${basePath}/user/updateUserInfo',
                    type: 'post',
                    contentType: 'application/json',
                    data: JSON.stringify(data),
                    success: function (dt) {
                        console.log(dt.data);
                        if (dt.code === 200) {
                            layer.msg('修改成功', {icon: 6, time: 1000});
                        }
                    },
                    error: function () {
                        layer.msg(error_msg(), {icon: 5, time: 1000});
                    }

                })
            });
        }
    })
</script>
</body>
</html>