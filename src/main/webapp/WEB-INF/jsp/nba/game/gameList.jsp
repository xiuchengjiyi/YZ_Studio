<%@pagelanguage="java" contentType="text/html;charset=UTF-8" 
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>赛程列表-休城记忆的管理系统</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
		<link rel="stylesheet" href="${pageContext.request.contextPath }/css/font.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath }/css/weadmin.css">
		<!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
		<!--[if lt IE 9]>
	      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
	      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
	    <![endif]-->
	</head>
	<style>
		.layui-table-cell{
			height:auto !important;
		}
		.layui-table-cell {
			font-size:14px;
			padding:0 5px;
			height:auto;
			overflow:visible;
			text-overflow:inherit;
			white-space:normal;
		}
		
	</style>
	<body>
		<div class="weadmin-nav">
			<span class="layui-breadcrumb">
				<a href="">首页</a>
				<a href="">篮球专区</a>
				<a>
					<cite>赛程</cite></a>
			</span>
			<a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);"
			 title="刷新">
				<i class="layui-icon" style="line-height:30px">&#x1002;</i></a>
		</div>
		<div id="testText">
		</div>
		<div class="weadmin-body">
			<div class="layui-row">
				<form class="layui-form layui-col-md12 we-search" onsubmit="return false"> 
					日期
					<div class="layui-input-inline">
						    <button type="button" style="float: left;" data-type="before" id="before" class="layui-btn layui-btn-primary">前一天</button>
						    <input type="text" style="width:100px;float: left;" value="" id="game_date" name="game_date"  autocomplete="off" class="layui-input">
						    <button type="button" data-type="last" id="last" class="layui-btn layui-btn-primary">后一天</button>
					</div>
					球队赛程：
					<div class="layui-input-inline">
				      <select id="select_team" name="select_team" lay-filter="select_team"  lay-search>
				      <option value="">请选择</option>
				      <c:forEach items="${teams }" var="team">
				      	<option value="${team.team_id }">${team.team_name }</option>
				      </c:forEach>
				      </select>
				    </div>
					<button class="layui-btn" data-type="reloadTable" id="searchBtn"><i class="layui-icon">&#xe615;搜索</i></button>
					<button class="layui-btn" id="addPlayer" data-type="addPlayer"><i class="layui-icon"></i>添加</button>
					<span class="fr" id="count" style="line-height:40px"></span>
				</form> 
			</div>

			<table id="game_table" lay-filter="gameTable"></table>

		</div>
		<script type="text/html" id="away_team_name">
			<img src="{{'data:image/jpg;base64,'+d.away_team_photo}}" style="width:60px;height:60px" />  &nbsp;  {{d.away_team_name}}
		</script>
		<script type="text/html" id="home_team_name">
			{{d.home_team_name}}&nbsp; <img src="{{'data:image/jpg;base64,'+d.home_team_photo}}" style="width:60px;height:60px" />    
		</script>
		<script type="text/html" id="data_details">
			<a lay-event="data_details">查看数据</a>
		</script>
		<script type="text/html" id="operateTpl">
			            <!--<a title="编辑" onclick="WeAdminEdit('编辑','./edit.html', 2, 600, 400)" href="javascript:;">
							<i class="layui-icon">&#xe642;</i>
						</a>
						<a title="删除" onclick="member_del(this,'要删除的id')" href="javascript:;">
							<i class="layui-icon">&#xe640;</i>
						</a>-->
			<div class="layui-btn-container">
				<button class="layui-btn layui-btn-sm" lay-event="update">编辑</button>
    			<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete">删除</button>
  			</div>
		</script>
		<!--<script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>-->
		<script src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath }/js/eleDel.js" type="text/javascript" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath }/js/admin.js" type="text/javascript" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath }/js/utils.js" type="text/javascript" charset="utf-8"></script>
		<script>
			layui.extend({
				admin: '${pageContext.request.contextPath }/js/admin'
			});

			layui.use(['table', 'jquery', 'form', 'admin','laydate','layer'], function() {
				var table = layui.table,
					$ = layui.jquery,
					form = layui.form,
					laydate = layui.laydate,
					admin = layui.admin,
					layer = layui.layer;
				
				$(function(){  
					var today = new Date();
					$("#game_date").val(getDateStr(today));
				})
					
				laydate.render({
					elem: '#game_date'
				});

				table.render({
					elem: '#game_table',
					url: 'games?game_date='+$("#game_date").val(),
					cols: [
						[{
							title: '序号',
							type: 'numbers'
						}, {
							field: 'game_date',
							title: '时间',
							width: 200,
							align: 'center'
						}, {
							field: 'game_type',
							title: '赛事类型',
							width: 200,
							align: 'center',
							templet: function(data){
								if(data.game_type == '1'){
									return "常规赛";
								}else if(data.game_type == '3'){
									return "季前赛";
								}else if(data.game_type == '2'){
									return "季后赛";
								}
							}
						}, {
							field: 'status',
							title: '状态',
							width: 170,
							align: 'center',
							templet: function(data){
								if(data.status == '已结束' || data.status == '未开始'){
									return data.status;
								}else{
									return "<span style='color:red;'>"+data.status+"</span>";
								}
							}
						}, {
							field: 'away_team_name',
							title: '客队',
							width: 170,
							align: 'center',
							templet: '#away_team_name'
						}, {
							field: 'score',
							title: '比分',
							width: 170,
							align: 'center',
							templet: function(data){
								if(data.home_score != null && data.away_score != null){
									if(data.home_score > data.away_score){
										return data.away_score+" - <strong>"+data.home_score+"</strong>";
									}else{
										return "<strong>"+data.away_score+"</strong> - "+data.home_score;
									}
								}else{
									return "-";
								}
								
							}
						}, {
							field: 'home_team_name',
							title: '主队',
							width: 170,
							align: 'center',
							templet: '#home_team_name'
						}, {
							field: 'result',
							title: '赛果',
							sort: true,
							width: 80,
							align: 'center',
							templet: function(data){
								if(data.result == 1){
									return "<p style='color:red;'>胜</p>";
								}else if(data.result == 0){
									return "负";
								}else{
									return "";
								}
								
							}
						}, {
							field: 'look',
							title: '数据',
							sort: true,
							width: 120,
							align: 'center',
							toolbar: '#data_details',
						}, {
							field: 'operate',
							title: '操作',
							toolbar: '#operateTpl',
							width: 160,
							align: 'center'
						}]
					],
					toolbar: '#toolbarDemo',
					event: true,
					page: true,
					limit: 15,
					limits: [15, 30],
					done:function(res,curr,count){
						$("#count").html("共有数据："+res.count+"条");//获取当前表的总记录数
		                //hoverOpenImg();//显示大图
		            }
				});
				/*
				 *数据表格中form表单元素是动态插入,所以需要更新渲染下
				 * http://www.layui.com/doc/modules/form.html#render
				 * */
				$(function() {
					form.render();
				});
				
				//放大图片
				function hoverOpenImg(){
			        var img_show = null; // tips提示
			        $('td img').hover(function(){
			            //alert($(this).attr('src'));
			            var img = "<img class='img_msg' src='"+$(this).attr('src')+"' style='width:170px;' />";
			            img_show = layer.tips(img, this,{
			                tips:[2, 'rgba(41,41,41,.5)']
			                ,area: ['200px']
			                ,time:1000000000
			            });
			        },function(){
			            layer.close(img_show);
			        });
			        $('td img').attr('style','max-width:70px');
			    }
				
				
				//事件监听,监听行工具条用tool，监听头工具条用toolbar
				table.on('tool(gameTable)',function(obj){ //teamTable为table的lay-filter
					 var data = obj.data // 获得当前行数据
       				 , layEvent = obj.event; // 获得 lay-event 对应的值
					if(layEvent == 'update'){
						layer.open({
							type : 2,
				            content : 'editGameScore?game_id='+data.game_id,
				            area : [ '800px', '300px' ],
				            maxmin : true,
				            title : '更新比分',
				            success : function(layero, index) {
				                var body = layer.getChildFrame('body', index);
				                var iframeWindow = layero.find('iframe')[0].contentWindow;
				                body.find('#id').val(data.id)
				                body.find('#away_name').text(data.away_name)
				                body.find('#away_photo').attr('src',data.away_photo)
				                body.find('#home_name').text(data.home_name)
				                body.find('#home_photo').attr('src',data.home_photo)
				                
				              //重新渲染
		                        iframeWindow.layui.form.render();
							}
						});
					}
				});
				
				//搜索，表格重载
				var active = {
					reloadTable: function() {
							
							table.reload('game_table',{
								url : "games",
								where:{
									select_team: $("#select_team").val(),
									game_date: $("#game_date").val(),
								}
								,page: {
								    curr: 1 //重新从第 1 页开始
								}
							});
					},
					before: function() {//查询前一天赛程
						var game_date = $("#game_date").val();
						game_date = game_date.replace(/-/g, '/'); // "2010/08/01";
						// 创建日期对象
						var date = new Date(game_date);
						// 减一天
						date.setDate(date.getDate() - 1);
						game_date = getDateStr(date);
						$("#game_date").val(game_date);
						table.reload('game_table',{
							url : "games",
							where:{
								game_date: game_date,
							}
							,page: {
							    curr: 1 //重新从第 1 页开始     此心向紫
							}
						});
					},
					last: function() {//查询前一天赛程
						var game_date = $("#game_date").val();
						game_date = game_date.replace(/-/g, '/'); // "2010/08/01";
						// 创建日期对象
						var date = new Date(game_date);
						// 减一天
						date.setDate(date.getDate() + 1);
						game_date = getDateStr(date);
						$("#game_date").val(game_date);
						table.reload('game_table',{
							url : "games",
							where:{
								game_date: game_date,
							}
							,page: {
							    curr: 1 //重新从第 1 页开始
							}
						});
					},
					addPlayer: function() {
						layer.open({
							type: 2, //Layer提供了5种层类型。可传入的值有：0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）,
						    title: '增加比赛',   //标题
						    area: ['800px', '600px'],   //宽高
						    shade: 0.4,   //遮罩透明度
						    content: 'addGame',//支持获取DOM元素
						    //btn: ['确定', '取消'], //按钮组
						    scrollbar: false ,//屏蔽浏览器滚动条
						    yes: function(index){//layer.msg('yes');    //点击确定回调
						    	alert(22);
						        layer.close(index);
						        showToast();
						    },
						    btn2: function(){//layer.alert('aaa',{title:'msg title'});  ////点击取消回调
						        
						    }
						});
					}
					

				};

				$('.demoTable .layui-btn').on('click', function() {
					var type = $(this).data('type');
					active[type] ? active[type].call(this) : '';
				});
				
				$('#searchBtn').on('click',function(){
		           var type = $(this).data('type');
		           active[type] ? active[type].call(this) : '';
		       });
				$('#before').on('click',function(){
			           var type = $(this).data('type');
			           active[type] ? active[type].call(this) : '';
			       });
				$('#last').on('click',function(){
			           var type = $(this).data('type');
			           active[type] ? active[type].call(this) : '';
			       });
		       
		       $('#addPlayer').on('click',function(){
		           var type = $(this).data('type');
		           active[type] ? active[type].call(this) : '';
		       });
		       
		       $('#export').on('click',function(){
		           var type = $(this).data('type');
		           active[type] ? active[type].call(this) : '';
		       });

				/*用户-删除*/
				window.member_del = function(obj, id) {
					layer.confirm('确认要删除吗？', function(index) {
						//发异步删除数据
						$(obj).parents("tr").remove();
						layer.msg('已删除!', {
							icon: 1,
							time: 1000
						});
					});
				}
				
				$(function(){  
					$.get(
							"../../acTEAM!getCountryList.action",
							function(data){
								var obj = new Function("return" + data)();//转换后的JSON对象
								var countrys = obj.country;
								for(var i = 0;i<countrys.length;i++){
									$("#country").append("<option value='"+countrys[i]+"'>"+countrys[i]+"</option>");
								}
								renderForm();
							}
						);
					$.get(
							"../../acTEAM!getPerformersList.action",
							function(data){
								var obj = new Function("return" + data)();//转换后的JSON对象
								var performers = obj.performers;
								for(var i = 0;i<performers.length;i++){
									$("#performers").append("<option value='"+performers[i]+"'>"+performers[i]+"</option>");
								}
								renderForm();
							}
					);
				});  
			});
			
			//重新渲染表单
			function renderForm(){
			  layui.use('form', function(){
			   var form = layui.form;//高版本建议把括号去掉，有的低版本，需要加()
			   form.render();
			  });
			 }

			function delAll(argument) {
				var data = tableCheck.getData();
				layer.confirm('确认要删除吗？' + data, function(index) {
					//捉到所有被选中的，发异步进行删除
					layer.msg('删除成功', {
						icon: 1
					});
					$(".layui-form-checked").not('.header').parents('tr').remove();
				});
			}
		</script>
	</body>

</html>

