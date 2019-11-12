<%@pagelanguage ="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>休城记忆的影视基地</title>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/font.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/weadmin.css">
<script src="${pageContext.request.contextPath }/js/jquery1.9.1/jquery.min.js"
	charset="utf-8"></script>
<script src="${pageContext.request.contextPath }/lib/layui/layui.js"
	charset="utf-8"></script>

</head>
<body class="login-bg">

	<div class="login">
		<div class="message">注册</div>
		<div id="darkbannerwrap"></div>

		<form id="registForm" class="layui-form">
			<input name="username" id="username" placeholder="用户名" type="text"
				lay-verify="required" onblur="checkUsername()" class="layui-input">
			<hr class="hr15">
			<input name="password" id="password" lay-verify="required"
				placeholder="密码" type="password" class="layui-input">
			<hr class="hr15">
			<input name="rePassword" id="rePassword" lay-verify="required"
				placeholder="确认密码" onblur="checkPassword()" type="password"
				class="layui-input">
			<hr class="hr15">
			<input class="loginin" value="注册" lay-submit lay-filter="regist"
				style="width:100%;" type="submit">
			<hr class="hr20">
			<div style="float: right;">
				<a href="${pageContext.request.contextPath }/toLogin">前往登录</a>
			</div>
		</form>
	</div>

	<script type="text/javascript">
		var flag = true;
		var flag2 = true;
		layui.extend({
			admin : '${pageContext.request.contextPath }/js/admin'
		});
		layui.use([ 'form', 'admin', 'jquery' ], function() {
			var form = layui.form, $ = layui.jquery, admin = layui.admin;
			// layer.msg('玩命卖萌中', function(){
			//   //关闭后的操作
			//   });
			//监听提交
			form.on('submit(regist)', function(data) {
				checkPassword();
				checkUsername();
				if(flag && flag2){
					$.post("regist", $("#registForm").serialize(), function(data) {
						//var obj = new Function("return" + data)();//转换后的JSON对象
						if (data == 0) {
							layer.alert("注册失败！", {
								icon : 2
							});
						} else {
							layer.msg("注册成功，前往登录！", {
								icon : 1,time : 1000
							},function(){
								window.location.href = "${pageContext.request.contextPath }/toLogin";
							});
							
						}
					});
				}
				
				return false;
			});
		});
		//两次密码校验
		function checkPassword(){
			var pwd = $("#password").val();
			var repwd = $("#rePassword").val();
			if(pwd != null && pwd != ""){
				if(pwd != repwd){
					layer.msg("两次密码不一致！",{icon:2});
					flag = false;
				}else {
					flag = true;
				}
			}
		}
		//检查用户名是否已存在
		function checkUsername(){
			var username = $("#username").val();
			$.post("checkUsername", {"username":username}, function(data) {
				var obj = new Function("return" + data)();//转换后的JSON对象
				if (obj.code == 1) {
					layer.msg("用户名已存在",{icon:2});
					flag2 = false;
				} else if (obj.code == 0) {
					flag2 = true;
				}
			});
		}
	</script>
	<!-- 底部结束 -->
</body>
</html>