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
    <#-- amaze的分页 -->
    <script src="${basePath}/statics/admin/assets/js/amazeui-pagination.js"></script>
</head>
<body data-type="widgets">
<script src="${basePath}/statics/admin/assets/js/theme.js"></script>
<div class="am-g tpl-g">

    <#include "../../common/header.ftl"/>
    <#include "../../common/skiner.ftl"/>


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
                <a href="${basePath}/index" >
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
                            <a href="${basePath}/admin/lifeCycleManage">
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
                    <a href="javascript:;" class="sidebar-nav-sub-title active" >
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
                        <ul class="sidebar-nav sidebar-nav-sub" style="display: block;">
                            <li class="sidebar-nav-link">
                                <a href="${basePath}/enterprise/supplierManage" class="sub-active">
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
                <a href="${basePath}/userInfo">
                    <i class="am-icon-clone sidebar-nav-link-logo"></i> 个人信息
                </a>
            </li>
        </ul>
    </div>


    <#-- 添加,编辑供应商窗口 -->
    <div class="am-modal am-modal-no-btn" tabindex="-1" id="user-add-edit-modal">
        <div class="am-modal-dialog widget" style="width: 35%;">
            <div class="am-modal-hd" style="border-bottom: 1px solid #b571a6;">供应商信息
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div class="row">
                    <div class="am-u-sm-12 am-u-md-12 am-u-lg-12">
                        <div class="widget am-cf">
                            <div class="widget-body am-fr">

                                <form id="supplierForm" class="am-form tpl-form-border-form tpl-form-border-br" data-am-validator>
                                    <div class="am-form-group" id="USERIDS">
                                        <label for="userId" class="am-u-sm-3 am-form-label">用户编号</label>
                                        <div class="am-u-sm-7">
                                            <input type="text" class="tpl-form-input" id="userId" name="userId" placeholder="请输入用户编号" required>
                                        </div>
                                        <div class="am-u-sm-2">
                                            <small id="result"></small>
                                        </div>
                                    </div>


                                    <div class="am-form-group">
                                        <label for="username" class="am-u-sm-3 am-form-label">用户名称</label>
                                        <div class="am-u-sm-7">
                                            <input type="text" class="tpl-form-input" id="username" name="username" placeholder="请输入用户名" required value="污垢">
                                        </div>
                                        <div class="am-u-sm-2">

                                        </div>
                                    </div>
                                    <div class="am-form-group">
                                        <label for="address" class="am-u-sm-3 am-form-label">用户地址</label>
                                        <div class="am-u-sm-7">
                                            <input type="text" class="tpl-form-input" id="address" name="address" placeholder="请输入用户地址" value="北京">
                                        </div>
                                        <div class="am-u-sm-2">

                                        </div>
                                    </div>

                                    <div class="am-form-group">
                                        <label for="email" class="am-u-sm-3 am-form-label">用户邮箱</label>
                                        <div class="am-u-sm-7">
                                            <input type="text" class="tpl-form-input" id="email" name="email" placeholder="请输入用户邮箱" value="1102@qq.com">
                                        </div>
                                        <div class="am-u-sm-2">

                                        </div>
                                    </div>

                                    <div class="am-form-group">
                                        <label for="telephone" class="am-u-sm-3 am-form-label">用户号码</label>
                                        <div class="am-u-sm-7">
                                            <input type="text" class="tpl-form-input" id="telephone" name="telephone" placeholder="请输入用户号码" value="12345">
                                        </div>
                                        <div class="am-u-sm-2">

                                        </div>
                                    </div>

                                    <div class="am-form-group">
                                        <label for="remark" class="am-u-sm-3 am-form-label">备注</label>
                                        <div class="am-u-sm-7">
                                            <input type="text" class="tpl-form-input" id="remark" name="remark" value="哈哈">
                                        </div>
                                        <div class="am-u-sm-2">

                                        </div>
                                    </div>


                                    <div class="am-form-group">
                                        <div class="am-u-sm-9 am-u-sm-push-3">
                                            <button type="button" class="am-btn am-btn-primary tpl-btn-bg-color-success " id="ADDUSER">注册</button>
                                            <button type="button" class="am-btn am-btn-primary tpl-btn-bg-color-success " id="EDITUSER">修改</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <#--查看窗口-->
    <div class="am-modal am-modal-no-btn" tabindex="-1" id="user-view-modal">
        <div class="am-modal-dialog widget" style="width: 35%;">
            <div class="am-modal-hd" style="border-bottom: 1px solid #b571a6;">用户信息
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div class="row">
                    <div class="am-u-sm-12 am-u-md-12 am-u-lg-12">
                        <div class="widget am-cf">
                            <div class="widget-body am-fr">

                                <form class="am-form tpl-form-border-form tpl-form-border-br" data-am-validator>
                                    <div class="am-form-group">
                                        <label for="USERID" class="am-u-sm-3 am-form-label">用户编号</label>
                                        <div class="am-u-sm-7">
                                            <input type="text" class="tpl-form-input" id="USERID" name="USERID" placeholder="请输入用户编号" required disabled>
                                        </div>
                                        <div class="am-u-sm-2">
                                            <small id="result"></small>
                                        </div>
                                    </div>


                                    <div class="am-form-group">
                                        <label for="USERNAME" class="am-u-sm-3 am-form-label">用户名称</label>
                                        <div class="am-u-sm-7">
                                            <input type="text" class="tpl-form-input" id="USERNAME" name="USERNAME" placeholder="请输入用户名" required disabled>
                                        </div>
                                        <div class="am-u-sm-2">

                                        </div>
                                    </div>
                                    <div class="am-form-group">
                                        <label for="ADDRESS" class="am-u-sm-3 am-form-label">用户地址</label>
                                        <div class="am-u-sm-7">
                                            <input type="text" class="tpl-form-input" id="ADDRESS" name="ADDRESS" placeholder="请输入用户地址" disabled>
                                        </div>
                                        <div class="am-u-sm-2">

                                        </div>
                                    </div>

                                    <div class="am-form-group">
                                        <label for="EMAIL" class="am-u-sm-3 am-form-label">用户邮箱</label>
                                        <div class="am-u-sm-7">
                                            <input type="text" class="tpl-form-input" id="EMAIL" name="EMAIL" placeholder="请输入用户邮箱" disabled>
                                        </div>
                                        <div class="am-u-sm-2">

                                        </div>
                                    </div>

                                    <div class="am-form-group">
                                        <label for="TELEPHONE" class="am-u-sm-3 am-form-label">用户号码</label>
                                        <div class="am-u-sm-7">
                                            <input type="text" class="tpl-form-input" id="TELEPHONE" name="TELEPHONE" placeholder="请输入用户号码" disabled>
                                        </div>
                                        <div class="am-u-sm-2">

                                        </div>
                                    </div>

                                    <div class="am-form-group">
                                        <label for="ROLENAME" class="am-u-sm-3 am-form-label">用户角色</label>
                                        <div class="am-u-sm-7">
                                            <input type="text" class="tpl-form-input" id="ROLENAME" name="ROLENAME" placeholder="请输入用户角色" disabled>
                                        </div>
                                        <div class="am-u-sm-2">

                                        </div>
                                    </div>

                                    <div class="am-form-group">
                                        <label for="BELONG_ENTER" class="am-u-sm-3 am-form-label">所属企业</label>
                                        <div class="am-u-sm-7">
                                            <select data-am-selected="{searchBox: 1}" style="display: none;" id="BELONG_ENTER" disabled>
                                            </select>

                                        </div>
                                        <div class="am-u-sm-2">

                                        </div>
                                    </div>

                                    <div class="am-form-group">
                                        <label for="REMARK" class="am-u-sm-3 am-form-label">备注</label>
                                        <div class="am-u-sm-7">
                                            <input type="text" class="tpl-form-input" id="REMARK" name="REMARK">
                                        </div>
                                        <div class="am-u-sm-2">

                                        </div>
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 内容区域 -->
    <div class="tpl-content-wrapper">
        <div class="row-content am-cf">
            <div class="row">
                <div class="am-u-sm-12 am-u-md-12 am-u-lg-12">
                    <div class="widget am-cf">
                        <div class="widget-head am-cf">
                            <div class="widget-title  am-cf">
                                <small>用户管理 > 供应商列表</small>
                            </div>
                        </div>
                        <div class="widget-body  am-fr">

                            <div class="am-u-sm-12 am-u-md-6 am-u-lg-6">
                                <div class="am-form-group">
                                    <div class="am-btn-toolbar">
                                        <div class="am-btn-group am-btn-group-xs">
                                            <button type="button" class="am-btn am-btn-default am-btn-success" onclick="addModal()"><span class="am-icon-plus"></span> 添加供应商</button>
                                            <button type="button" id="delAllUser" class="am-btn am-btn-default am-btn-danger"><span class="am-icon-trash-o"></span> 批量删除</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="am-u-sm-12 am-u-md-12 am-u-lg-3" style="float: right;">
                                <div class="am-input-group am-input-group-sm tpl-form-border-form cl-p">
                                    <input type="text" class="am-form-field" id="USER_SEARCH" placeholder="请输入供应商名称">
                                    <span class="am-input-group-btn">
                                        <button id="SEARCHUSER" class="am-btn  am-btn-default am-btn-success tpl-table-list-field am-icon-search" type="button"></button>
                                    </span>
                                </div>
                            </div>

                            <div class="am-u-sm-12">
                                <table width="100%" class="am-table am-table-compact am-table-bordered tpl-table-black " >
                                    <thead>
                                    <tr>
                                        <th style="text-align: center;"><input type="checkbox" name="otherCheckboxs"></th>
                                        <th style="text-align: center;">序号</th>
                                        <th style="text-align: center;">用户编号</th>
                                        <th style="text-align: center;">用户名称</th>
                                        <th style="text-align: center;">用户地址</th>
                                        <th style="text-align: center;">用户邮箱</th>
                                        <th style="text-align: center;">用户号码</th>
                                        <th style="text-align: center;">创建时间</th>
                                        <th style="text-align: center;">企业名称</th>
                                        <th style="text-align: center;">操作</th>
                                    </tr>
                                    </thead>

                                    <tbody id="supplierTableTbody">

                                    </tbody>

                                </table>
                            </div>
                            <div class="am-u-lg-12 am-cf">
                                <p id="TOTAL" class="am-fr" style="padding-left: 2%;margin: 1.5rem 0;float: left;">第 <span id="start"></span> 到 <span id="end"></span> 条记录，共 <span id="totalNum"></span> 条</p>
                                <div class="am-fr">
                                    <ul class="am-pagination tpl-pagination">

                                    </ul>
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

<script src="${basePath}/statics/my/page-js/supplierManage.js"></script>
<script src="${basePath}/statics/my/constance.js"></script>
<script src="${basePath}/statics/my/utils.js"></script>

</body>
</html>