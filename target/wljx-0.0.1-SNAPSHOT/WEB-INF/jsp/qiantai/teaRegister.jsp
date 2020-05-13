<%--
  Created by IntelliJ IDEA.
  User: 11192
  Date: 2020/5/12
  Time: 21:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
    <link rel="stylesheet" href="css/admin.css" media="all">
    <link rel="stylesheet" href="css/login.css" media="all">
    <link id="layuicss-layer" rel="stylesheet" href="css/layer.css" media="all">
</head>
<body>
<div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">

    <div class="layadmin-user-login-main">
        <div class="layadmin-user-login-box layadmin-user-login-header">
            <h2>学生注册</h2>
        </div>

        <form class="layui-form" method="post" action="">
            <div class="layadmin-user-login-box layadmin-user-login-body layui-form">

                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-username" for="LAY-user-login-username"></label>
                    <input type="text" name="name" id="LAY-user-login-username" lay-verify="username" placeholder="账号" class="layui-input">
                </div>

                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-password"></label>
                    <input type="password" name="password" id="LAY-user-login-password" lay-verify="password" placeholder="密码" class="layui-input">
                </div>

                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-password"></label>
                    <input type="password" name="password" id="LAY-user-login-password" lay-verify="password" placeholder="重复密码" class="layui-input">
                </div>

                <div>
                    <label class="layui-icon layui-icon-key"></label>
                    <input type="text" name="passphrase"   placeholder="通行码" class="layui-input">
                </div>

                <div class="layui-form-item">
                    <button type="button" class="layui-btn layui-btn-fluid"  lay-submit="" lay-filter="LAY-user-login-submit">注 册</button>
                </div>
            </div>
        </form>
    </div>
    <div class="layui-trans layadmin-user-login-footer">
        <p><a href="http://http://www.guit.edu.cn/" target="_blank">桂林电子科技大学信息科技学院</a> copyright © 2020</p>
    </div>
</div>
<script type="text/javascript" src="js/jquery-3.4.0.min.js"></script>
<script src="layui/layui.js"></script>
<script>
    layui.use(['form', 'layedit', 'laydate'],function() {
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
            username: function(value) {
                if (value.length < 4) {
                    return '账号至少得4个字符啊';
                }
            },
            password: [/^[\S]{6,12}$/, '密码必须6到12位，且不能出现空格'],

        });

        //监听提交
        form.on('submit(LAY-user-login-submit)',function(data) {
            $.post('${pageContext.request.contextPath}/qiantai/login',data.field,function(result){
                if(result.status==201 || result.status==202 || result.status==203){
                    layer.open({
                        title: '提示',content: result.msg
                    });
                    return false;
                }else if(result.status==200){
                    layer.open({
                        title: '提示',content: result.msg,end:function(){
                            window.location.href="${pageContext.request.contextPath}/";
                        }
                    });
                }
            });
            return false;
        });
    });
</script>
</body>
</html>
