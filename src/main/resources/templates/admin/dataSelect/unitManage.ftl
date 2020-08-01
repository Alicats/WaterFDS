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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.15.3/dist/bootstrap-table.min.css">
    <script src="${basePath}/statics/admin/assets/js/jquery.min.js"></script>
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
                    <a href="${basePath}/index">
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
                        <ul class="sidebar-nav sidebar-nav-sub">
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
                        <a href="javascript:;" class="sidebar-nav-sub-title sub-active">
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
                                <a href="${basePath}/dataSelect/unitManage" class="active">
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
                        <a href="javascript:;" class="sidebar-nav-sub-title">
                            <i class="am-icon-table sidebar-nav-link-logo"></i> 系统管理
                            <span class="am-icon-chevron-down am-fr am-margin-right-sm sidebar-nav-sub-ico"></span>
                        </a>
                        <ul class="sidebar-nav sidebar-nav-sub">
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
            <div class="row-content am-cf">
                <div class="row">
                    <div class="am-u-sm-12 am-u-md-12 am-u-lg-12">
                        <div class="widget am-cf">
                            <div class="widget-head am-cf">
                                <div class="widget-title  am-cf">
                                    <small>数据遴选管理 > 单位管理</small>
                                </div>
                            </div>
                            <div class="widget-body  am-fr">

                                <div class="am-u-sm-12 am-u-md-6 am-u-lg-6">
                                    <div class="am-form-group">
                                        <div class="am-btn-toolbar">
                                            <div class="am-btn-group am-btn-group-xs">
                                                <button type="button" class="am-btn am-btn-default am-btn-success" id="BTN_ADD_LifeCycle"><span class="am-icon-plus"></span> 添加</button>
                                                <button type="button" id="delAllUser" class="am-btn am-btn-default am-btn-danger"><span class="am-icon-trash-o"></span> 批量删除</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <#--
                                <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
                                    <div class="am-form-group tpl-table-list-select">
                                        <select data-am-selected="{btnSize: 'sm'}" id="ROLE">
                                            <option value="none">请选择</option>
                                            <option value="supplier">供应商</option>
                                            <option value="collaborator">内部协作人</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="am-u-sm-12 am-u-md-12 am-u-lg-3" style="float: right;">
                                    <div class="am-input-group am-input-group-sm tpl-form-border-form cl-p">
                                        <input type="text" class="am-form-field" id="USER_SEARCH" placeholder="请输入用户名称">
                                        <span class="am-input-group-btn">
                                            <button id="SEARCHUSER" class="am-btn  am-btn-default am-btn-success tpl-table-list-field am-icon-search" type="button"></button>
                                        </span>
                                    </div>
                                </div>
                                -->

                                <div class="am-u-sm-12">
                                    <table width="100%" class="am-table am-table-compact am-table-bordered tpl-table-black " >
                                        <thead>
                                            <tr>
                                                <th style="text-align: center;"><input type="checkbox" name="unitCheckboxs"></th>
                                                <th style="text-align: center;">序号</th>
                                                <th style="text-align: center;">单位编号</th>
                                                <th style="text-align: center;">单位名称</th>
                                                <th style="text-align: center;">单位符号</th>
                                                <th style="text-align: center;">操作</th>
                                            </tr>
                                        </thead>

                                        <tbody id="otherTableTbody">
                                             <tr>
                                                <td style="text-align: center;"><input type="checkbox" name="unitCheckbox"></td>
                                                <td style="text-align: center;">1</td>
                                                <td style="text-align: center;">GSDFGSDF</td>
                                                <td style="text-align: center;">千克</td>
                                                <td style="text-align: center;">kg</td>
                                                <td style="text-align: center;"><button class="am-btn am-btn-danger am-btn-xs" type="button">删除</button></td>
                                             </tr>
                                             <tr>
                                                 <td style="text-align: center;"><input type="checkbox" name="unitCheckbox"></td>
                                                 <td style="text-align: center;">2</td>
                                                 <td style="text-align: center;">GSDDF</td>
                                                 <td style="text-align: center;">米</td>
                                                 <td style="text-align: center;">m</td>
                                                 <td style="text-align: center;"><button class="am-btn am-btn-danger am-btn-xs" type="button">删除</button></td>
                                             </tr>
                                        </tbody>

                                    </table>

                                </div>
                                <#--
                                <div class="am-u-lg-12 am-cf">
                                    <p id="TOTAL" class="am-fr" style="padding-left: 2%;margin: 1.5rem 0;float: left;">第 <span id="start"></span> 到 <span id="end"></span> 条记录，共 <span id="totalNum"></span> 条</p>
                                    <div class="am-fr">

                                        <ul class="am-pagination tpl-pagination">

                                        </ul>
                                    </div>
                                </div>
                                -->
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
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/bootstrap-table@1.15.3/dist/bootstrap-table.min.js"></script>
</body>
</html>