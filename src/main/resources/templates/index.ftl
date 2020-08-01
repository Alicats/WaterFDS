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
            <!-- 用户信息
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
            -->

            <!-- 菜单 -->
            <ul class="sidebar-nav">
                <#--<li class="sidebar-nav-heading">Components <span class="sidebar-nav-heading-info"> 附加组件</span></li>-->
                <li class="sidebar-nav-link">
                    <a href="${basePath}/index" class="active">
                        <i class="am-icon-home sidebar-nav-link-logo"></i> 我的桌面
                    </a>
                </li>

                <#-- admin -->
                <@shiro.hasRole name="admin">
                    <li class="sidebar-nav-link">
                        <a href="javascript:;" class="sidebar-nav-sub-title">
                            <i class="am-icon-table sidebar-nav-link-logo"></i> 量化评价系统
                            <span class="am-icon-chevron-down am-fr am-margin-right-sm sidebar-nav-sub-ico"></span>
                        </a>
                        <ul class="sidebar-nav sidebar-nav-sub" style="display: block;">
                            <li class="sidebar-nav-link">
                                <a href="${basePath}/admin/enterManage">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 项目基础信息
                                </a>
                            </li>

                            <li class="sidebar-nav-link">
                                <a href="${basePath}/admin/lifeCycleManage">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 生命周期评价管理
                                </a>
                            </li>

                        </ul>
                    </li>

                    <li class="sidebar-nav-link">
                        <a href="javascript:;" class="sidebar-nav-sub-title">
                            <i class="am-icon-table sidebar-nav-link-logo"></i> 数据遴选管理
                            <span class="am-icon-chevron-down am-fr am-margin-right-sm sidebar-nav-sub-ico"></span>
                        </a>
                        <ul class="sidebar-nav sidebar-nav-sub" style="display: block;">
                            <li class="sidebar-nav-link">
                                <a href="${basePath}/dataSelect/lifeCycleManage">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 生命周期阶段管理
                                </a>
                            </li>

                            <li class="sidebar-nav-link">
                                <a href="${basePath}/admin/lifeCycleManage">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 数据分级指标管理
                                </a>
                            </li>

                            <li class="sidebar-nav-link">
                                <a href="${basePath}/dataSelect/unitManage">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 单位管理
                                </a>
                            </li>

                            <li class="sidebar-nav-link">
                                <a href="${basePath}/admin/lifeCycleManage">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 数据库管理首页
                                </a>
                            </li>

                            <li class="sidebar-nav-link">
                                <a href="${basePath}/admin/lifeCycleManage">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 数据库管理
                                </a>
                            </li>

                            <li class="sidebar-nav-link">
                                <a href="${basePath}/admin/lifeCycleManage">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 数据库群组管理
                                </a>
                            </li>
                        </ul>
                    </li>

                    <li class="sidebar-nav-link">
                        <a href="javascript:;" class="sidebar-nav-sub-title">
                            <i class="am-icon-table sidebar-nav-link-logo"></i> 消息管理
                            <span class="am-icon-chevron-down am-fr am-margin-right-sm sidebar-nav-sub-ico"></span>
                        </a>
                        <ul class="sidebar-nav sidebar-nav-sub" style="display: block;">
                            <li class="sidebar-nav-link">
                                <a href="${basePath}/message/edit">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 发送消息
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
                        <a href="javascript:;" class="sidebar-nav-sub-title">
                            <i class="am-icon-table sidebar-nav-link-logo"></i> 系统管理
                            <span class="am-icon-chevron-down am-fr am-margin-right-sm sidebar-nav-sub-ico"></span>
                        </a>
                        <ul class="sidebar-nav sidebar-nav-sub" style="display: block;">
                            <li class="sidebar-nav-link">
                                <a href="${basePath}/user/accountManage">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 用户账号管理
                                </a>
                            </li>

                            <li class="sidebar-nav-link">
                                <a href="${basePath}/message/receiveList">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 用户注册
                                </a>
                            </li>

                            <li class="sidebar-nav-link">
                                <a href="${basePath}/message/sendList">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 个人信息
                                </a>
                            </li>

                            <li class="sidebar-nav-link">
                                <a href="${basePath}/message/sendList">
                                    <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 密码修改
                                </a>
                            </li>
                        </ul>
                    </li>
                </@shiro.hasRole>

                <#-- admin, enterprise
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
                -->

                <#--
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
                    <a href="javascript:;" class="sidebar-nav-sub-title">
                        <i class="am-icon-table sidebar-nav-link-logo"></i> 消息管理
                        <span class="am-icon-chevron-down am-fr am-margin-right-sm sidebar-nav-sub-ico"></span>
                    </a>
                    <ul class="sidebar-nav sidebar-nav-sub">
                        <li class="sidebar-nav-link">
                            <a href="${basePath}/message/edit">
                                <span class="am-icon-angle-right sidebar-nav-link-logo"></span> 发送消息
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
                -->
            </ul>
        </div>




        <!-- 内容区域 -->
        <div class="tpl-content-wrapper">

            <!--<div class=" am-cf">-->
            <!--&lt;!&ndash;<div class="row">&ndash;&gt;-->
            <!--&lt;!&ndash;<div class="am-u-sm-12 am-u-md-12 am-u-lg-9">&ndash;&gt;-->
            <!--<div class="page-header-heading">-->
            <!--<span class="am-icon-home page-header-heading-icon"></span> 首页-->
            <!--&lt;!&ndash;<small>Amaze UI</small>&ndash;&gt;-->
            <!--</div>-->
            <!--&lt;!&ndash;<p class="page-header-description">Amaze UI 含近 20 个 CSS 组件、20 余 JS 组件，更有多个包含不同主题的 Web 组件。</p>&ndash;&gt;-->
            <!--&lt;!&ndash;</div>&ndash;&gt;-->
            <!--&lt;!&ndash;<div class="am-u-lg-3 tpl-index-settings-button">&ndash;&gt;-->
            <!--&lt;!&ndash;<button type="button" class="page-header-button"><span class="am-icon-paint-brush"></span> 设置&ndash;&gt;-->
            <!--&lt;!&ndash;</button>&ndash;&gt;-->
            <!--&lt;!&ndash;</div>&ndash;&gt;-->
            <!--&lt;!&ndash;</div>&ndash;&gt;-->
            <!--</div>-->

            <div class="row-content am-cf">
                <!--<div class="widget-head am-cf">-->
                <!--<div class="widget-title  am-cf">-->
                <!--<i class="am-icon-home"></i>-->
                <!--<small>首页</small>-->
                <!--</div>-->
                <!--</div>-->
                <div class="row  am-cf">
                    <div class="am-u-sm-12 am-u-md-12 am-u-lg-8">
                        <div class="row am-cf">
                            <!--用户信息-->
                            <div class="am-u-sm-12 am-u-md-12 am-u-lg-6" >
                                <div class="am-panel am-panel-success" style="background-color: #4b5357;">
                                    <div class="am-panel-hd">
                                        <span class="am-icon-credit-card-alt"> 用户信息</span>
                                    </div>
                                    <div class="am-panel-bd">
                                        <div class="row am-cf">
                                            <div id="WELCOME_IMG" class="am-u-md-12 am-animation-scale-up">
                                                <img src="${basePath}/statics/img/welcome1.png"
                                                     style="width: 100%;margin-right: 150px;">
                                            </div>
                                            <div class="am-u-md-6 am-animation-scale-up">
                                                <img src="${basePath}/statics/img/user.jpg" title="用户"
                                                     style="width: 65%;height: 65%;margin-top: 15px"/>
                                            </div>
                                            <div id="USER_PROFILE" class="am-u-md-6 am-animation-scale-up"
                                                 style="margin-top: 50px">
                                                <ul>
                                                    <li><span style="font-size: 20px;"
                                                              class="am-kai am-text-success">管理员</span></li>
                                                    <li>
                                                        <label class="am-kai am-text-success">ID：</label>
                                                        <label class="am-kai am-text-success">admin</label>
                                                    </li>
                                                    <li>
                                                        <label class="am-kai am-text-success">角色：</label>
                                                        <label class="am-kai am-text-success">管理员</label>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--快捷入口-->
                            <div class="am-u-sm-12 am-u-md-12 am-u-lg-6">
                                <div class="am-panel am-panel-success" style="background-color: #4b5357;">
                                    <div class="am-panel-hd">
                                        <span class="am-icon-hand-o-right"> 快捷入口</span>
                                    </div>
                                    <div class="am-panel-bd">
                                        <div class="row am-cf" style="margin-top: 5px">
                                            <div class="am-u-md-12">
                                                <div class="am-u-md-3" style="text-align: center">
                                                    <a class="am-btn am-btn-default" style="width: 80px;height: 60px">
                                                        <i class="am-icon-product-hunt am-icon-lg"></i>
                                                    </a>
                                                    <small style="color: white;">产品管理</small>
                                                </div>

                                                <div class="am-u-md-3" style="text-align: center">
                                                    <a class="am-btn am-btn-default" style="width: 80px;height: 60px">
                                                        <i class="am-icon-folder-open am-icon-lg"></i>
                                                    </a>
                                                    <small style="color: white;">项目管理</small>
                                                </div>

                                                <div class="am-u-md-3" style="text-align: center">
                                                    <a class="am-btn am-btn-default" style="width: 80px;height: 60px">
                                                        <i class="am-icon-info-circle am-icon-lg"></i>
                                                    </a>
                                                    <small style="color: white;">信息管理</small>
                                                </div>

                                                <div class="am-u-md-3" style="text-align: center">
                                                    <a class="am-btn am-btn-default" style="width: 80px;height: 60px">
                                                        <i class="am-icon-comment am-icon-lg"></i>
                                                    </a>
                                                    <small style="color: white;">消息管理</small>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row am-cf" style="margin-top: 6px">
                                            <div class="am-u-md-12">
                                                <div class="am-u-md-3" style="text-align: center">
                                                    <a class="am-btn am-btn-default" style="width: 80px;height: 60px">
                                                        <i class="am-icon-cogs am-icon-lg"></i>
                                                    </a>
                                                    <small style="color: white;">系统管理</small>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--图表1-->
                        <div class="row am-cf">
                            <div class="am-u-sm-12 am-u-md-12">
                                <div class="widget am-cf">
                                    <div class="widget-head am-cf">
                                        <div class="widget-title am-fl">我的产品</div>
                                        <div class="widget-function am-fr">
                                            <a href="javascript:;" class="am-icon-cog"></a>
                                        </div>
                                    </div>
                                    <div class="widget-body widget-body-md am-fr">

                                        <table width="100%" class="am-table am-table-compact am-table-bordered tpl-table-black " >
                                            <thead>
                                            <tr>
                                                <th style="text-align: center;">序号</th>
                                                <th style="text-align: center;">产品编号</th>
                                                <th style="text-align: center;">产品名称</th>
                                                <th style="text-align: center;">生产企业</th>
                                            </tr>
                                            </thead>

                                            <tbody id="otherTableTbody">
                                            <tr>
                                                <td style="text-align: center;">1</td>
                                                <td style="text-align: center;">SJK</td>
                                                <td style="text-align: center;">棉花</td>
                                                <td style="text-align: center;">xxx有限公司</td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center;">2</td>
                                                <td style="text-align: center;">FGFGD</td>
                                                <td style="text-align: center;">丝绸</td>
                                                <td style="text-align: center;">xxx有限公司</td>
                                            </tr>
                                            </tbody>

                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--图表2-->
                        <div class="row am-cf">
                            <div class="am-u-sm-12 am-u-md-12">
                                <div class="widget am-cf">
                                    <div class="widget-head am-cf">
                                        <div class="widget-title am-fl">项目进度</div>
                                        <div class="widget-function am-fr">
                                            <a href="javascript:;" class="am-icon-cog"></a>
                                        </div>
                                    </div>
                                    <div class="widget-body widget-body-md am-fr">

                                        <div class="am-progress-title">项目一 <span class="am-fr am-progress-title-more">28% / 100%</span></div>
                                        <div class="am-progress">
                                            <div class="am-progress-bar" style="width: 15%"></div>
                                        </div>
                                        <div class="am-progress-title">项目二 <span class="am-fr am-progress-title-more">28% / 100%</span></div>
                                        <div class="am-progress">
                                            <div class="am-progress-bar  am-progress-bar-warning" style="width: 75%"></div>
                                        </div>
                                        <div class="am-progress-title">项目三 <span class="am-fr am-progress-title-more">28% / 100%</span></div>
                                        <div class="am-progress">
                                            <div class="am-progress-bar am-progress-bar-danger" style="width: 35%"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--消息列表-->
                    <div class="am-u-sm-12 am-u-md-12 am-u-lg-4">
                        <div class="am-panel am-panel-success" style="background-color: #4b5357;">
                            <div class="am-panel-hd">
                                <span class="am-icon-comment"> 消息列表</span>
                            </div>
                            <div class="am-panel-bd">
                                <ul class="am-comments-list am-comments-list-flip">
                                    <li class="am-comment am-comment-highlight">
                                        <article class="am-comment"> <!-- 评论容器 -->
                                            <a href="">
                                                <img class="am-comment-avatar" alt=""/> <!-- 评论者头像 -->
                                            </a>

                                            <div class="am-comment-main"> <!-- 评论内容容器 -->
                                                <header class="am-comment-hd">
                                                    <!--<h3 class="am-comment-title">评论标题</h3>-->
                                                    <div class="am-comment-meta"> <!-- 评论元数据 -->
                                                        <a href="#link-to-user" class="am-comment-author">张三</a><!-- 评论者 -->
                                                        发送于
                                                        <time datetime="">2020-7-12 15:30</time>
                                                    </div>
                                                </header>

                                                <div class="am-comment-bd">
                                                    <p style="color: white;">你好！我是张三</p>
                                                </div> <!-- 评论内容 -->
                                            </div>
                                        </article>
                                    </li>

                                    <li class="am-comment am-comment-highlight">
                                        <article class="am-comment"> <!-- 评论容器 -->
                                            <a href="">
                                                <img class="am-comment-avatar" alt=""/> <!-- 评论者头像 -->
                                            </a>

                                            <div class="am-comment-main"> <!-- 评论内容容器 -->
                                                <header class="am-comment-hd">
                                                    <!--<h3 class="am-comment-title">评论标题</h3>-->
                                                    <div class="am-comment-meta"> <!-- 评论元数据 -->
                                                        <a href="#link-to-user" class="am-comment-author">李四</a><!-- 评论者 -->
                                                        发送于
                                                        <time datetime="">2020-7-12 15:30</time>
                                                    </div>
                                                </header>

                                                <div class="am-comment-bd">
                                                    <p style="color: white;">你好！我是李四</p>
                                                </div> <!-- 评论内容 -->
                                            </div>
                                        </article>
                                    </li>

                                    <li class="am-comment am-comment-highlight">
                                        <article class="am-comment"> <!-- 评论容器 -->
                                            <a href="">
                                                <img class="am-comment-avatar" alt=""/> <!-- 评论者头像 -->
                                            </a>

                                            <div class="am-comment-main"> <!-- 评论内容容器 -->
                                                <header class="am-comment-hd">
                                                    <!--<h3 class="am-comment-title">评论标题</h3>-->
                                                    <div class="am-comment-meta"> <!-- 评论元数据 -->
                                                        <a href="#link-to-user" class="am-comment-author">王五</a><!-- 评论者 -->
                                                        发送于
                                                        <time datetime="">2020-7-12 15:30</time>
                                                    </div>
                                                </header>

                                                <div class="am-comment-bd">
                                                    <p style="color: white;">你好！我是王五</p>
                                                </div> <!-- 评论内容 -->
                                            </div>
                                        </article>
                                    </li>
                                </ul>
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
        layer.msg("登录成功", {icon: 6, time: 1500},function () {
            $.ajax({
                url: '${basePath}/user/checkPwd',
                type: 'get',
                success: function (dt) {
                    if(dt.code === 400){
                        layer.alert('密码太简单', {
                            icon: 5,
                            time: false,
                            btn: ['前往修改'],
                            yes: function (index) {
                                layer.close(index); // 手动关闭
                                location.href = '${basePath}/userInfo';
                            }
                        });
                    }
                },
                error: function () {
                    layer.msg(error_msg(),{icon: 5, time: 1000});
                }
            })
        });


    </script>
</body>
</html>