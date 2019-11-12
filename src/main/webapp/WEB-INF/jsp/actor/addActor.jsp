<%@pagelanguage ="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>添加演员-休城记忆的影视基地</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/font.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/weadmin.css">
<!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
<!--[if lt IE 9]>
	      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
	      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
	    <![endif]-->
</head>

<body>
	<div class="weadmin-body">
		<form id="actorForm" class="layui-form"
			action="">
			<div class="layui-form-item">
				<input name="ac_id" type="hidden" value="${actor.ac_id }"/>
				<div class="layui-inline">
					<label for="ac_name" class="layui-form-label"> <span
						class="we-red">*</span>名字
					</label>
					<div class="layui-input-inline" style="width: 250px">
						<input type="text" id="ac_name" name="ac_name" value="${actor.ac_name }"
							lay-verify="required" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label for="english_name" class="layui-form-label">英文名</label>
					<div class="layui-input-inline" style="width: 250px">
						<input type="text" id="english_name" name="english_name"  value="${actor.english_name }"
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>

			<div class="layui-form-item">
				<div class="layui-inline">
					<label for="birth_place" class="layui-form-label"> <span
						class="we-red"></span>出生地
					</label>
					<div class="layui-input-block" style="width: 250px">
				      <select id="birth_place" name="birth_place" lay-verify="required">
				        <option value=""></option>
				        <c:forEach items="${nationalitys }" var="nationality" varStatus="i">
				        	<option value="${nationality.nat_id }">${nationality.nationality }</option>
				        </c:forEach>
				      </select>
				    </div>
				</div>
				<div class="layui-inline">
					<label for="birthday" class="layui-form-label"> <span
						class="we-red">*</span>生日
					</label>
					<div class="layui-input-inline" style="width: 250px">
						<input type="text" id="birthday" name="birthday"  value="${actor.birthday }"
							lay-verify="required" autocomplete="off" class="layui-input" />
					</div>
				</div>
			</div>

			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">性别</label>
					<div class="layui-input-block" >
						<input type="radio" name="sex" value="1" title="男" checked>
						<input type="radio" name="sex" value="0" title="女">
					</div>
				</div>
				
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">照片</label>
				<div class="layui-upload">
					<button type="button" class="layui-btn" id="test1">上传图片</button>
					<div style="margin-left: 110px;" class="layui-upload-list">
						<img class="layui-upload-img" width="150px" height="200px"
							id="demo1" src="data:image/jpg;base64,${actor.ac_picture }"> <input type="hidden" id="ac_picture"
							name="ac_picture" value="${actor.ac_picture_path }">
						<p id="demoText"></p>
					</div>
				</div>
			</div>

			<div class="layui-form-item">
				<button class="layui-btn" lay-filter="add" id="add" lay-submit="">确定</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</form>
	</div>
	<script src="${pageContext.request.contextPath }/js/jquery1.9.1/jquery.min.js" charset="utf-8"></script>
	<script src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
	<script src="${pageContext.request.contextPath }/lib/layui/lay/modules/rate.js" charset="utf-8"></script>
	<script>
		layui.extend({
			admin : '${pageContext.request.contextPath }/js/admin'
		});

		layui.use(
			[ 'form', 'jquery', 'util', 'admin', 'layer', 'laydate', 'upload' ],
			function() {
				var form = layui.form, $ = layui.jquery, util = layui.util, admin = layui.admin, laydate = layui.laydate, layer = layui.layer, upload = layui.upload;

				$(function(){  
					if("${flag}" == "edit"){
						var sex = "${actor.sex }";
					    if(sex != "" && sex != null){
					    	var sexes = $("input[name='sex']");
					    	for(var i = 0;i<sexes.length;i++){
					    		if(sexes[i].value == sex){
					    			console.log(sexes[i].checked)
					    			sexes[i].checked = true;
					    		}
					    	}
					    	form.render('radio');
					    }
					    
					    var nats = $("select[name='birth_place'] option");
					    for(var i = 0;i<nats.length;i++){
				    		if(nats[i].value == "${actor.birth_place}"){
				    			nats[i].selected = true;
				    		}
				    	}
				    	form.render('select');
					}else{
						var nats = $("select[name='birth_place'] option");
					    for(var i = 0;i<nats.length;i++){
				    		if(nats[i].value == "1"){
				    			nats[i].selected = true;
				    		}
				    	}
				    	form.render('select');
					}
				    
				});
				//普通图片上传
				var uploadInst = upload
						.render({
							elem : '#test1',
							url : 'upload',
							before : function(obj) {
								//预读本地文件示例，不支持ie8
								obj.preview(function(index,
												file, result) {
											$('#demo1').attr('src',
													result); //图片链接（base64）
										});
							},
							done : function(res) {
								if (res.code == 0) {
									//上传成功
									$("#ac_picture").val(
											res.data[0].src);
								}
								//如果上传失败
								if (res.code > 0) {
									return layer.msg('上传失败');
								}
								//上传成功
							},
							error : function() {
								//演示失败状态，并实现重传
								var demoText = $('#demoText');
								demoText
										.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
								demoText.find('.demo-reload').on(
										'click', function() {
											uploadInst.upload();
										});
							}
						});

				/* laydate.render({
					elem : '#birthday'
				}); */

				//自定义验证规则
				form.verify({
					checkdate : function(value) {
						var now = new Date();
						var time = now.getFullYear()
								+ "-"
								+ ((now.getMonth() + 1) < 10 ? "0"
										: "")
								+ (now.getMonth() + 1) + "-"
								+ (now.getDate() < 10 ? "0" : "")
								+ now.getDate();
						var valueNum = parseInt(value.replace(/-/g,
								''), 10);
						var nowNum = parseInt(time
								.replace(/-/g, ''), 10);
						if (valueNum > nowNum) {
							return "观看时间不能超过当前时间";
						}
					},
				});
				//失去焦点时判断值为空不验证，一旦填写必须验证
				$('input[name="birthday"]').blur(
						function() {
							var birthday = $("#birthday").val();
							if(birthday.length != 8){
								layer.msg("出生日期不规范！",{icon:2,time:500});
								return
							}else{
								birthday = birthday.substring(0,4)+"-"+birthday.substring(4,6)+"-"+birthday.substring(6)
								$("#birthday").val(birthday);
							}
						});
				//判断该演员是否可能已经存在
				$('input[name="ac_name"]').blur(
					function() {
						var ac_name = $("#ac_name").val();
						if(ac_name != null && ac_name != ""){
							$.get(
								"checkActor?ac_name="+ac_name,
								function(msg){
									var obj = new Function("return"+msg)();
									if(obj.code == "1"){
										layer.alert("【"+ac_name+"】可能已存在，从系统中查询到【"+obj.message+"】")
									}
								}
							);
						}
				});

				//监听提交
				form.on('submit(add)',function(data) {
					var url;
					if("${flag}" == "edit"){
						url = "editActor";
					}else if("${flag}" == "insert"){
						url = "insertActor";
					}
					$("#add").attr("disabled","disabled");
					$.post(
						url,
						$("#actorForm").serialize(),
						function(data) {
							var obj = new Function("return" + data)();
							if(obj.code != 0){
								layer.msg(obj.message,
										{
											icon : 6,
											time : 1000,
										},
										function() {
											// 获得iframe索引
											var index = parent.layer.getFrameIndex(window.name);
											//关闭当前iframe
											parent.layer.close(index);
											var parent$ = window.parent.layui.jquery;//获取父页面的jQuery
											var currpage = parent$(".layui-laypage-skip").find("input").val(); //当前页码值
											parent.layui.table.reload('actor_table',{page : {curr : currpage}});//刷新当前页面
								});
							}else{
								layer.alert(obj.message,{icon:2},function(){
									$("#add").attr("disabled","");
								})
							}
							
					});
					//$(".layui-laypage-btn")[0].click();
					return false;
				});

			});
	</script>
</body>

</html>