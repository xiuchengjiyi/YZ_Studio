<%@pagelanguage="java" contentType="text/html;charset=UTF-8" 
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>休城记忆的影视基地</title>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="shortcut icon" href="./favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="css/font.css">
	<link rel="stylesheet" href="css/weadmin.css">
    <script src="lib/layui/layui.js" charset="utf-8"></script>

</head>
<body class="login-bg">
    
    <div class="login">
        <div class="message">登录</div>
        <div id="darkbannerwrap"></div>
        
        <form id="loginForm" class="layui-form">
            <input name="username" placeholder="用户名"  type="text" lay-verify="required" class="layui-input" >
            <hr class="hr15">
            <input name="password" lay-verify="required" placeholder="密码"  type="password" class="layui-input">
            <hr class="hr15">
            <input class="loginin" value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit">
            <hr class="hr20" >
            <div style="float: right;"><a href="${pageContext.request.contextPath }/login/toRegist">立即注册</a></div>
        </form>
    </div>

    <script type="text/javascript">
        
        	layui.extend({
				admin: 'js/admin'
			});
            layui.use(['form','admin','jquery'], function(){
              var form = layui.form,
              $ = layui.jquery,
              admin = layui.admin;
              // layer.msg('玩命卖萌中', function(){
              //   //关闭后的操作
              //   });
              //监听提交
              form.on('submit(login)', function(data){
                $.post(
                	"login",
                	$("#loginForm").serialize(),
                	function(data){
                		var obj = new Function("return" + data)();//转换后的JSON对象
                		if(obj.code == 1){
                			location.href='index'
                		}else if(obj.code == 0){
                			layer.alert(obj.message, {
								icon: 2
							});
                		}
                	}
                );
                
                return false;
              });
            });   
    </script>  
    <!-- 底部结束 -->
</body>
</html>