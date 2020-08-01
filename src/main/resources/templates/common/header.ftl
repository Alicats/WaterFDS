<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:th="http://www.thymeleaf.org"
      xmlns:sec="http://www.thymeleaf.org/thymeleaf-extras-springsecurity3">
<head>
    <title>Hello World!</title>
</head>
<body>
    <#-- 头部 -->
    <header>
        <!-- logo -->
        <div class="am-fl tpl-header-logo">
            <a href="javascript:;"><img src="${basePath}/statics/admin/assets/img/logo.png" alt=""></a>
        </div>
        <!-- 右侧内容 -->
        <div class="tpl-header-fluid">
            <!-- 侧边切换 -->
            <div class="am-fl tpl-header-switch-button am-icon-list">
                            <span>

                        </span>
            </div>
            <!-- 搜索 -->
            <div class="am-fl tpl-header-search">
                <form class="tpl-header-search-form" action="javascript:;">
                    <button class="tpl-header-search-btn am-icon-search"></button>
                    <input class="tpl-header-search-box" type="text" placeholder="搜索内容...">
                </form>
            </div>
            <!-- 其它功能-->
            <div class="am-fr tpl-header-navbar">
                <ul>
                    <!-- 欢迎语 -->
                    <li class="am-text-sm tpl-header-navbar-welcome">
                        <a href="javascript:;">欢迎你, <span>${Session.currentUser.username}</span> </a>
                    </li>

                    <!-- 新邮件 -->
                    <li class="am-dropdown tpl-dropdown" data-am-dropdown>
                        <a href="javascript:;" class="am-dropdown-toggle tpl-dropdown-toggle" data-am-dropdown-toggle>
                            <i class="am-icon-envelope"></i>
                            <span class="am-badge am-badge-success am-round item-feed-badge" id="UNREAD_MESSAGE_COUNT"></span>
                        </a>
                        <!-- 弹出列表 -->
                        <ul class="am-dropdown-content tpl-dropdown-content">

                            <div id="UNREAD_MESSAGE_DIV">
                                <li class="tpl-dropdown-menu-messages">
                                    <a href="${basePath}/message/receiveList" class="tpl-dropdown-menu-messages-item am-cf">
                                        <div class="menu-messages-ico">
                                            <img src="${basePath}/statics/admin/assets/img/user04.png" alt="">
                                        </div>
                                        <div class="menu-messages-content">
                                            <div class="menu-messages-content-title">
                                                <i class="am-icon-circle-o am-text-success"></i>
                                                <span id="UNREAD_SENDER0"></span>
                                            </div>
                                            <div class="am-text-truncate" id="UNREAD_SEND_TITLE0"></div>
                                            <div class="menu-messages-content-time" id="UNREAD_SEND_TIME0"></div>
                                        </div>
                                    </a>
                                </li>

                                <li class="tpl-dropdown-menu-messages">
                                    <a href="${basePath}/message/receiveList" class="tpl-dropdown-menu-messages-item am-cf">
                                        <div class="menu-messages-ico">
                                            <img src="${basePath}/statics/admin/assets/img/user02.png" alt="">
                                        </div>
                                        <div class="menu-messages-content">
                                            <div class="menu-messages-content-title">
                                                <i class="am-icon-circle-o am-text-warning"></i>
                                                <span id="UNREAD_SENDER1"></span>
                                            </div>
                                            <div class="am-text-truncate" id="UNREAD_SEND_TITLE1"></div>
                                            <div class="menu-messages-content-time" id="UNREAD_SEND_TIME1"></div>
                                        </div>
                                    </a>
                                </li>
                            </div>

                            <li class="tpl-dropdown-menu-messages">
                                <a href="${basePath}/message/receiveList" class="tpl-dropdown-menu-messages-item am-cf">
                                    <i class="am-icon-circle-o"></i> 进入列表…
                                </a>
                            </li>
                        </ul>
                    </li>


                    <!-- 退出 -->
                    <li class="am-text-sm">
                        <a href="javascript:;" class="login-out">
                            <span class="am-icon-sign-out"></span> 退出
                        </a>
                    </li>
                </ul>
            </div>
        </div>

    </header>

    <script src="${basePath}/statics/admin/assets/js/jquery.min.js"></script>
    <script src="${basePath}/statics/plugin/layer/layer.js"></script>
    <script src="${basePath}/statics/my/utils.js"></script>

    <script>
        $(".login-out").on('click',function () {
            layer.confirm('是否注销？', {
                title:'提示',
                icon:3,
                btn:['确定','取消']
            },function () {
                $.ajax({
                    url: '${basePath}/logout',
                    type: 'post',
                    success: function (dt) {
                        if(dt.code === 200){
                            location.href = "${basePath}/welcome";
                        }
                    }
                })
            })
        });

        $(function initUnReadMessageCount() {
            $.ajax({
                url:'${basePath}/message/initHeaderMessageCount',
                type:'get',
                success:function (dt) {
                    console.log(dt);
                    if(dt.code == 200){
                        $("#UNREAD_MESSAGE_COUNT").text(dt.data.length);

                        // $("#DIV_UNREAD_MESSAGE").empty();
                        var count = dt.data.length;
                        if(count == 0){
                            $("#UNREAD_MESSAGE_DIV").empty();
                        }

                        if(count >3 )
                            count = 3;

                        for(var i=0;i<count;i++){
                            // var msg = "<li class='tpl-dropdown-menu-messages'>" +
                            //                 "<a href='javascript:;' class='tpl-dropdown-menu-messages-item am-cf'>" +
                            //                     "<div class='menu-messages-ico'>" +
                            //                         "<img src='"+baseUrl()+"/statics/admin/assets/user04.png' "> +
                            //                     "</div>" +
                            //                     "<div>" +
                            //                         "<div>" +
                            //                             "<i class='am-icon-circle-o am-text-success'></i>" +
                            //                             "<span>"+dt.data[i].senderName+"</span>" +
                            //                         "</div>" +
                            //                         "<div class='am-text-truncate'>"+dt.data[i].content+"</div>" +
                            //                         "<div content='menu-messages-content-time'>"+dt.data[i].sendTime+"</div> " +
                            //                     "</div>" +
                            //                 "</a>" +
                            //             "</li>";
                            //
                            //
                            // alert(msg);

                            $("#UNREAD_SENDER"+i).text(dt.data[i].senderName);
                            $("#UNREAD_SEND_TITLE"+i).text(dt.data[i].title);
                            $("#UNREAD_SEND_TIME"+i).text(dt.data[i].sendTime);

                        }
                    }
                },
                error:function (error) {
                    layer.msg(error_msg(),{icon:5});
                }
            })
        })
    </script>
</body>
</html>