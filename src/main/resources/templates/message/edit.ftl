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

    <!-- bootstrap-table -->
    <link rel="stylesheet" href="${basePath}/statics/plugin/bootstraptable/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${basePath}/statics/plugin/bootstraptable/css/bootstrap-table.min.css" />

    <style>
        tr td{
            text-align: center;
        }
    </style>
</head>
<body data-type="widgets">
<div class="am-g tpl-g">
    <script src="${basePath}/statics/admin/assets/js/theme.js"></script>
    <#include "../common/header.ftl"/>
    <#include "../common/skiner.ftl"/>

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
                                <a href="table-list-img.html">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 其他用户管理
                                </a>
                            </li>
                        </ul>
                    </@shiro.hasRole>

                    <@shiro.hasRole name="enterprise">
                        <ul class="sidebar-nav sidebar-nav-sub">
                            <li class="sidebar-nav-link">
                                <a href="${basePath}/admin/userManage">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 供应商管理
                                </a>
                            </li>

                            <li class="sidebar-nav-link">
                                <a href="table-list-img.html">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 内部协作人管理
                                </a>
                            </li>
                        </ul>
                    </@shiro.hasRole>

                </li>
            </@shiro.hasAnyRoles>

            <li class="sidebar-nav-link">
                <a href="form.html">
                    <i class="am-icon-wpforms sidebar-nav-link-logo"></i> 产品管理
                </a>
            </li>

            <li class="sidebar-nav-link">
                <a href="javascript:;" class="sidebar-nav-sub-title active">
                    <i class="am-icon-table sidebar-nav-link-logo"></i> 消息管理
                    <span class="am-icon-chevron-down am-fr am-margin-right-sm sidebar-nav-sub-ico"></span>
                </a>
                <ul class="sidebar-nav sidebar-nav-sub" style="display: block;">
                    <li class="sidebar-nav-link">
                        <a href="${basePath}/message/edit" class="sub-active">
                            <span class="am-icon-angle-right sidebar-nav-link-logo" ></span> 发送消息
                        </a>
                    </li>

                    <li class="sidebar-nav-link">
                        <a href="${basePath}/message/receiveList">
                            <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 消息列表
                        </a>
                    </li>

                    <li class="sidebar-nav-link">
                        <a href="${basePath}/message/sendList">
                            <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 已发消息
                        </a>
                    </li>
                </ul>
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

    <!-- 内容区域 -->
    <div class="tpl-content-wrapper">
        <div class="row-content am-cf">
            <div class="row">

                <div class="am-u-sm-12 am-u-md-12 am-u-lg-12">
                    <div class="widget am-cf">
                        <div class="widget-head am-cf">
                            <div class="widget-title  am-cf">
                                <small>消息管理 > 发送消息</small>
                            </div>
                        </div>
                        <div class="widget-body am-fr">

                            <form class="am-form tpl-form-border-form"  data-am-validator id="Message_Send_Form">
                                <div class="am-form-group">
                                    <label for="user-name" class="am-u-sm-12 am-form-label am-text-left">标题
                                        <span class="tpl-form-line-small-title">Title</span>
                                    </label>
                                    <div class="am-u-sm-12">
                                        <input type="text" class="tpl-form-input am-margin-top-xs" id="Message_Title" name="title" placeholder="请输入标题文字" required>
                                        <small>请填写标题文字10-20字左右。</small>
                                    </div>
                                </div>

                                <div class="am-form-group">
                                    <label for="user-name" class="am-u-sm-12 am-form-label am-text-left">
                                        <a href="javascript:;" onclick=selectAddressee();>收件人</a>
                                        <span class="tpl-form-line-small-title">Addressee</span>
                                    </label>
                                    <div class="am-u-sm-12">
                                        <input type="text" class="tpl-form-input am-margin-top-xs" disabled autocomplete="off" id="Message_Receiver" name="receiverIds" placeholder="请选择收件人" required>
                                    </div>
                                </div>

                                <div class="am-form-group">
                                    <label for="user-intro" class="am-u-sm-12 am-form-label  am-text-left">消息内容
                                        <span class="tpl-form-line-small-title">Content</span>
                                    </label>
                                    <div class="am-u-sm-12 am-margin-top-xs">
                                        <textarea class="" rows="10" id="Message_Content" placeholder="请输入消息内容" name="content"></textarea>
                                    </div>
                                </div>

                                <div class="am-form-group">
                                    <div class="am-u-sm-12 am-u-sm-push-12">
                                        <button type="button" class="am-btn am-btn-primary tpl-btn-bg-color-success " style="float: right" id="Submit_Message">发送</button>
                                    </div>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <#-- 收件人区域 -->
    <div style="display: none" class="widget" id="DIV_ADDRESSEE">
        <table id="Receiver_Table"></table>
    </div>

    <!-- bootstrap-table -->
    <script src="${basePath}/statics/plugin/bootstraptable/js/bootstrap.min.js"></script>
    <script src="${basePath}/statics/plugin/bootstraptable/js/bootstrap-table.min.js"></script>
    <script src="${basePath}/statics/plugin/bootstraptable/js/bootstrap-table-zh-CN.min.js"></script>

    <script src="${basePath}/statics/admin/assets/js/amazeui.min.js"></script>
    <script src="${basePath}/statics/admin/assets/js/amazeui.datatables.min.js"></script>
    <script src="${basePath}/statics/admin/assets/js/dataTables.responsive.min.js"></script>
    <script src="${basePath}/statics/admin/assets/js/app.js"></script>
    <script src="${basePath}/statics/plugin/layer/layer.js"></script>
    <script src="${basePath}/statics/my/page-js/editMessage.js"></script>
    <script src="${basePath}/statics/my/constance.js"></script>
    <script src="${basePath}/statics/my/utils.js"></script>


</div>

</body>
</html>