<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:th="http://www.thymeleaf.org"
      xmlns:sec="http://www.thymeleaf.org/thymeleaf-extras-springsecurity3">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>全生命周期绿色产品数据库系统登录</title>
    <link href="${basePath}/statics/my/css/login.css" rel="stylesheet" type="text/css" />

    <!-- Favicon -->
    <link rel="shortcut icon" href="${basePath}/statics/img/logo.png">

    <script src="${basePath}/statics/admin/assets/js/jquery.min.js"></script>


    <style type="text/css">
        .login-b-b input{
            padding-left: 5px;
        }
    </style>
</head>
<body>
    <div class="login">
        <div class="login-head">
            <div class="login-head-a">
                <img src="${basePath}/statics/img/logo1.png"  title="" alt=""  style="width: 120px;"/>
            </div>
            <div class="login-head-a" style="margin-left: 150px;font-size: 56px;text-align: center;margin-top: 20px;color:#075cb7;font-family: Microsoft YaHei;">
                <img src="${basePath}/statics/img/水足迹数据遴选与集成分析系统.png"  title="" alt=""/>
                <!--   全生命周期绿色产品数据库系统 -->
            </div>
        </div>
        <div class="login-con">
            <div class="login-a">
                <#--<form id="loginForm" method="post" action="userlogin.do" onsubmit="return validate()">-->
                <form>
                    <div class="login-b">
                        <div class="login-b-a">用户登陆</div>
                        <div class="login-b-b">
                            <ul>
                                <#--<c:if test="#request.prevUrl!=null">-->
                                    <#--<input type="hidden" value="${ request.prevUrl }" name="prevUrl">-->
                                <#--</c:if>-->
                                <#--<c:if test="#request.prevUrl==null">-->
                                    <#--<input type="hidden" value="<%=request.getHeader("Referer") %>" name="prevUrl">-->
                                <#--</c:if>-->
                                <li>
                                    <label for="userId">账 &nbsp;&nbsp;号：</label>
                                    <input type="text"  id="userId" placeholder="请输入账号" value="admin">
                                    <h1 id="m-tip"></h1>
                                </li>
                                <li>
                                    <label for="userPwd">密 &nbsp;&nbsp;码：</label>
                                    <input type="password"  id="password" placeholder="请输入密码" value="admin">
                                    <h1 id="p-tip"></h1>
                                </li>
                                <li>
                                    <label>验证码：</label>
                                    <input type="text" id="checkCode" placeholder="请输入验证码"  name="checkCode" required/>
                                    <img id="checkImg" alt="验证码" class="codeImg" src="util/validateCode" onclick="javascript:this.src='util/validateCode?uuid='+Math.random()">
                                    <#--<h1 id="c-tip">-->
                                        <#--${request.msg }-->
                                    <#--</h1>-->
                                </li>

                                <li class="login-x">
                                    <div class="login-x-a">
                                        <input type="button" name="登录" value="登录" id="login"/>
                                        <div class="x"></div>
                                    </div>
                                </li>

                            </ul>
                        </div>
                        <#--<div class="login-b-c">-->
                            <#--<a href="register2.jsp" style=" font-size:16px;">立即注册</a>-->
                        <#--</div>-->
                    </div>
                </form>
            </div>
        </div>
        <div class="login-foot"> © 宁波希耐科环保科技有限公司</br>浙江省宁波市镇海区镇宁西路123号B幢205</br>0574-87522477 </div>
    </div>

    <script src="${basePath}/statics/plugin/layer/layer.js"></script>

    <script>
        // 监听页面的回车按键， 触发按钮点击事件
        $("body").keyup(function (e) {
            if(e.keyCode === 13){
                $('#login').click();
            }
        });

        // 登录
        $("#login").on('click',function () {
            $.ajax({
                url: '${basePath}/login',
                type: 'post',
                data: {
                    userId: $("#userId").val(),
                    password: $("#password").val(),
                    checkCode: $("#checkCode").val()
                },
                success: function (dt) {
                    if(dt.code === 200){
                        location.href = "${basePath}/index";
                    }else {
                        layer.msg(dt.message,{icon: 5,time: 1000});
                    }
                }
            })
        })
    </script>
</body>
</html>