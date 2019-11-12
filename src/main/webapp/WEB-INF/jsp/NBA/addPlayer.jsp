<%@page import="nba.model.Team"%>
<%@page import="java.util.List"%>
<%@page import="nba.model.Season"%>
<%@pagelanguage="java" contentType="text/html;charset=UTF-8" 
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>添加球员-休城记忆的管理系统</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
		<link rel="stylesheet" href="../../static/css/font.css">
		<link rel="stylesheet" href="../../static/css/weadmin.css">
		<!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
		<!--[if lt IE 9]>
	      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
	      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
	    <![endif]-->
	</head>
	<%
		//获取所有的赛季和所有球队
		List<Season> seasons = Season.getSeasonList();
		List<Team> teams = Team.getTeamList("", 0, 0);
		request.setAttribute("seasons", seasons);
		request.setAttribute("teams", teams);
	%>
	<body>
		<div class="weadmin-body">
			<form id="playerForm" class="layui-form" action="">
				<div class="layui-form-item">
				    <label class="layui-form-label"><span class="we-red">*</span>赛季</label>
				    <div class="layui-input-inline">
				      <select name="season" lay-verify="required">
				      <c:forEach items="${seasons }" var="season">
				      	<option value="${season.id }">${season.season }</option>
				      </c:forEach>
				      </select>
				    </div>
				</div>
				<div class="layui-form-item">
					<label for="L_name" class="layui-form-label">
		                <span class="we-red">*</span>球员姓名
		            </label>
					<div class="layui-input-inline">
						<input type="text" id="L_name" name="name" lay-verify="required" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label for="L_englishName" class="layui-form-label">
		                <span class="we-red">*</span>英文名
		            </label>
					<div class="layui-input-inline">
						<input type="text" id="L_englishName" name="englishName" lay-verify="required" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
				    <label for="L_number" class="layui-form-label">
				    	<span class="we-red">*</span>球衣号码
				    </label>
				    <div class="layui-input-inline">
				      	<input type="text" id="L_number" name="number" lay-verify="required" autocomplete="off" class="layui-input"/>
				    </div>
				</div>
				<div class="layui-form-item">
				    <label for="L_age" class="layui-form-label">
				    	<span class="we-red">*</span>年龄
				    </label>
				    <div class="layui-input-inline">
				      	<input type="text" id="L_age" name="age" lay-verify="required" autocomplete="off" class="layui-input"/>
				    </div>
				</div>
				<div class="layui-form-item">
				    <label for="L_position" class="layui-form-label">
				    	<span class="we-red">*</span>场上位置
				    </label>
				    <div class="layui-input-inline">
				      	<input type="text" id="L_position" name="position" lay-verify="required" autocomplete="off" class="layui-input"/>
				    </div>
				</div>
				<div class="layui-form-item">
				    <label for="L_comefrom" class="layui-form-label">
				    	<span class="we-red">*</span>来自
				    </label>
				    <div class="layui-input-inline">
				      	<input type="text" id="L_comefrom" name="comefrom" lay-verify="required" autocomplete="off" class="layui-input"/>
				    </div>
				</div>
				<input type="hidden" id="L_worked" name="worked"  />
				<div class="layui-form-item">
				    <label for="workedTeam" class="layui-form-label">
				    	曾效力于
				    </label>
				    <div class="layui-input-inline">
				      	<input type="text" id="workedTeam" placeholder="请从右侧选择，可多选" autocomplete="off" class="layui-input"/>
				    </div>
				  	<div class="layui-input-inline">
				      <select id="team" lay-filter="team"  lay-search>
				      <option value="">请选择</option>
				      <c:forEach items="${teams }" var="team">
				      	<option value="${team.id }">${team.teamName }</option>
				      </c:forEach>
				      </select>
				    </div>
				</div>
				<div class="layui-form-item">
				    <label for="L_photo" class="layui-form-label">
				    	球员照片
				    </label>
				    <div class="layui-input-block">
				      <textarea id="L_photo" name="photo" placeholder="请输入球员照片链接" class="layui-textarea"></textarea>
				    </div>			
				</div>
				<div class="layui-form-item">
				    <label for="L_contract" class="layui-form-label">
				    	合同
				    </label>
				    <div class="layui-input-block">
				      <textarea id="L_contract" name="contract" placeholder="请输入详细合同内容" class="layui-textarea"></textarea>
				    </div>			
				</div>
				<div class="layui-form-item">
				    <label for="L_comment" class="layui-form-label">
				    	备注
				    </label>
				    <div class="layui-input-block">
				      <textarea id="L_comment" name="comment" placeholder="请输入内容" class="layui-textarea"></textarea>
				    </div>
				</div>			
				<div class="layui-form-item">
					<button class="layui-btn" lay-filter="add" lay-submit="">确定</button>
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				</div>
			</form>
		</div>
		<script src="../../lib/layui/layui.js" charset="utf-8"></script>
		<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
		<script>
			layui.extend({
				admin: '{/}../../static/js/admin'
			});
			layui.use(['form', 'jquery','util','admin', 'layer' ,'laydate'], function() {
				var form = layui.form,
					$ = layui.jquery,
					util = layui.util,
					admin = layui.admin,
					laydate = layui.laydate,
					layer = layui.layer;
				
				form.on('select(team)', function(data){
					var team = $("#team option:selected").text();
					var value = $("#workedTeam").val();
					var id = $("#L_worked").val();
					if(value == ""){
						$("#workedTeam").val(team)
					}else{
						$("#workedTeam").val(value+"、"+team)
					}
					if(id == ""){
						$("#L_worked").val(data.value)
					}else{
						$("#L_worked").val(id+"、"+data.value)
					}
					
				});
					
				laydate.render({
					elem: '#L_watchedate'
				});

				form.verify({
					
				});
				$('input[name="email"]').blur(function(){
					if($('input[name="email"]').val()){
						$('input[name="email"]').attr('lay-verify','email');
					}else{
						$('input[name="email"]').removeAttr('lay-verify');
					}
				});

				form.on('submit(add)', function(data) {
					$.post(
						"../../acPLAYER!insertPlayer.action",
						$("#playerForm").serialize(),
						function(data){
							layer.alert("添加成功", {
								icon: 6
							}, function() {
								var index = parent.layer.getFrameIndex(window.name);
								parent.layer.close(index);
								var parent$ = window.parent.layui.jquery;
								var currpage = parent$(".layui-laypage-skip").find("input").val();
								parent.layui.table.reload('player_table',{page:{curr:currpage}});
							});
						}
					);
					//$(".layui-laypage-btn")[0].click();
					return false;
				});

			});
		</script>
	</body>

</html>