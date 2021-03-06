<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>登录 - 在线教学系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
    <link rel="stylesheet" href="css/admin.css" media="all">
    <link rel="stylesheet" href="css/login.css" media="all">
    <link id="layuicss-layer" rel="stylesheet" href="css/layer.css" media="all">
</head>

<body layadmin-themealias="default">

<div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">

    <div class="layadmin-user-login-main">
        <div class="layadmin-user-login-box layadmin-user-login-header">
            <h2>《C++面向对象程序设计》教学系统</h2>
        </div>

        <form class="layui-form" method="post" action="">
            <div class="layadmin-user-login-box layadmin-user-login-body layui-form">

                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-username"
                           for="LAY-user-login-username"></label>
                    <input type="text" name="name" id="LAY-user-login-username" lay-verify="username" placeholder="账号"
                           class="layui-input">
                </div>

                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-password"
                           for="LAY-user-login-password"></label>
                    <input type="password" name="password" id="LAY-user-login-password" lay-verify="password"
                           placeholder="密码" class="layui-input">
                </div>

                <div class="layui-form-item">
                    <div class="layui-row">
                        <div class="layui-col-xs7">
                            <label class="layadmin-user-login-icon layui-icon layui-icon-vercode"
                                   for="LAY-user-login-vercode"></label>
                            <input type="text" name="vercode" id="LAY-user-login-vercode" lay-verify="required"
                                   placeholder="图形验证码" class="layui-input">
                        </div>
                        <div class="layui-col-xs5">
                            <div style="margin-left: 10px;">
                                <img src="${pageContext.request.contextPath }/captcha/code"
                                     class="layadmin-user-login-codeimg" id="LAY-user-get-vercode"
                                     onclick="this.src=this.src+'?'+Math.random()">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="layui-form-item" style="margin-bottom: 20px;">
                    <label class="layui-form-label" style="width:30px;">角色</label>
                    <div class="layui-input-block" style="margin-left:70px;">
                        <input type="radio" name="role" value="1" title="学生" checked>
                        <input type="radio" name="role" value="0" title="老师">
                        <%--                  <a href="https://www.layui.com/admin/std/dist/views/user/forget.html" class="layadmin-user-jump-change layadmin-link" style="margin-top: 7px;">忘记密码？</a>--%>
                    </div>
                </div>

                <div class="layui-form-item">
                    <button type="button" class="layui-btn layui-btn-fluid" lay-submit="" lay-filter="LAY-user-login-submit">登 录
                    </button>
                </div>
            </div>
        </form>
        <div style="text-align: center">
            <a href="stuRegister.jsp" class="layui-btn">学生注册</a><br>
            <a href="http://www.layui.com" class="layui-btn">一个可跳转的按钮</a>
            <a href="stuRegister.jsp" class="layui-btn">教师注册</a>
<%--            <button type="button" class="layui-btn layui-btn-fluid" lay-submit="" lay-filter="LAY-user-stuRegister-submit">学生注册</button><br>--%>
<%--            <button type="button" class="layui-btn layui-btn-fluid" lay-submit="" lay-filter="LAY-user-teaRegister-submit">教师注册</button>--%>
        </div>
    </div>
    <div class="layui-trans layadmin-user-login-footer">
        <p><a href="http://http://www.guit.edu.cn/" target="_blank">桂林电子科技大学信息科技学院</a> copyright 2020</p>
    </div>
</div>
<script type="text/javascript" src="js/jquery-3.4.0.min.js"></script>
<script src="layui/layui.js"></script>
<script>
    layui.use(['form', 'layedit', 'laydate'], function () {
        var form = layui.form,
            layer = layui.layer,
            layedit = layui.layedit,
            laydate = layui.laydate;
        form.render();
        //日期
        laydate.render({
            elem: '#date'
        });
        laydate.render({
            elem: '#date1'
        });

        //创建一个编辑器
        var editIndex = layedit.build('LAY_demo_editor');

        //自定义验证规则
        form.verify({
            username: function (value) {
                if (value.length < 4) {
                    return '账号至少4个字符';
                }
            },
            password: [/^[\S]{6,12}$/, '密码必须6到12位，且不能出现空格'],

        });

        //监听提交
        form.on('submit(LAY-user-login-submit)', function (data) {
            $.post('${pageContext.request.contextPath}/qiantai/login', data.field, function (result) {
                if (result.status == 201 || result.status == 202 || result.status == 203) {
                    layer.open({
                        title: '提示'
                        , content: result.msg
                    });
                    return false;
                } else if (result.status == 200) {
                    layer.open({
                        title: '提示'
                        , content: result.msg
                        , end: function () {
                            window.location.href = "${pageContext.request.contextPath}/";
                        }
                    });
                }
            });
            return false;
        });

    });

    var stuR = document.getElementById('stuR')
    stuR.onclick=function(){
        stuR.href='stuRegister.jsp'
    }
</script>

</body>
</html>