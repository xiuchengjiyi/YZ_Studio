<%@pagelanguage="java" contentType="text/html;charset=UTF-8" 
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>NBA球队列表-休城记忆的管理系统</title>
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
					<cite>球队</cite></a>
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
					
					球队名称：
					<div class="layui-inline">
						<input style="width: 200px" type="text" id="teamName" name="teamName" placeholder="如：火箭" class="layui-input">
					</div>
					所在赛区：
					<div class="layui-inline">
						<select id="area"  lay-search>
							<option value="">请选择</option>
							<option value="1">西南赛区</option>
					        <option value="2">西北赛区</option>
					        <option value="3">太平洋赛区</option>
					        <option value="4">东南赛区</option>
					        <option value="5">中部赛区</option>
					        <option value="6">大西洋赛区</option>
						</select>
					</div>
					所在分部：
					<div class="layui-inline">
						<select id="branch">
							<option value="">请选择</option>
					        <option value="1">东部</option>
					        <option value="2">西部</option>
						</select>
					</div>
					<button class="layui-btn" data-type="reloadTable" id="searchBtn"><i class="layui-icon">&#xe615;搜索</i></button>
					<button class="layui-btn" id="addTeam" data-type="addTeam"><i class="layui-icon"></i>添加</button>
					<span class="fr" id="count" style="line-height:40px"></span>
				</form> 
			</div>


			<table id="team_table" lay-filter="teamTable"></table>

		</div>
		<script type="text/html" id="recommendTpl">
			<input type="checkbox" name="zzz" lay-skin="switch" lay-text="是|否" {{d.recommend}}>
					</script>
		<script type="text/html" id="teamStandard">
			<img src="{{'data:image/jpg;base64,'+d.photo}}" style="width:40px;height:40px" />
		</script>
		<script type="text/html" id="reviewTpl">
			<!-- 这里的 checked 的状态只是演示 -->
					  <input type="checkbox" name="lock" value="{{d.id}}" title="锁定" lay-filter="lockDemo" {{ d.id == 1 ? 'checked' : '' }}>
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
		<script>

			layui.use(['table', 'jquery', 'form', 'admin','laydate','layer'], function() {
				var table = layui.table,
					$ = layui.jquery,
					form = layui.form,
					laydate = layui.laydate,
					admin = layui.admin,
					layer = layui.layer;
					
					

				table.render({
					elem: '#team_table',
					url: 'teams',
					cols: [
						[{
							type: 'checkbox'
						}, {
							field: 'team_id',
							title: 'ID',
							sort: true,
							width: 60,
							align: 'center'
						}, {
							field: 'photo',
							title: '球队标志',
							templet: '#teamStandard',
							width: 120,
							align: 'center'
						}, {
							field: 'team_name',
							title: '球队名称',
							width: 120,
							align: 'center'
						}, {
							field: 'location_city',
							title: '所属城市',
							width: 200,
							align: 'center'
						}, {
							field: 'area',
							title: '所在赛区',
							width: 200,
							align: 'center',
							templet: function(data){
								var area = data.area;
								if(area == 1){
									return "西南赛区";
								}else if(area == 2){
									return "西北赛区";
								}else if(area == 3){
									return "太平洋赛区";
								}else if(area == 4){
									return "东南赛区";
								}else if(area == 5){
									return "中部赛区";
								}else if(area == 6){
									return "大西洋赛区";
								}
							}
						}, {
							field: 'branch',
							title: '所在分部',
							sort: true,
							width: 100,
							align: 'center',
							templet: function(data){
								var branch = data.branch;
								if(branch == 1){
									return "东部";
								}else if(branch == 2){
									return "西部";
								}
							}
						}, {
							field: 'english_name',
							title: '英文全称',
							sort: true,
							width: 250,
							align: 'center'
						}, {
							field: 'operate',
							title: '操作',
							toolbar: '#operateTpl',
							unresize: true,
							width: 160,
							align: 'center'
						}]
					],
					toolbar: '#toolbarDemo',
					event: true,
					page: true,
					limit: 10,
					limits: [10, 15, 30],
					done:function(res,curr,count){
						$("#count").html("共有数据："+res.count+"条");//获取当前表的总记录数
		                hoverOpenImg();//显示大图
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
				table.on('tool(teamTable)',function(obj){ //teamTable为table的lay-filter
					 var data = obj.data // 获得当前行数据
       				 , layEvent = obj.event; // 获得 lay-event 对应的值
					if(layEvent == 'update'){
						layer.open({
							type : 2,
				            content : './editTeam.html',
				            area : [ '600px', '500px' ],
				            maxmin : true,
				            title : '更新球队',
				            success : function(layero, index) {
				                var body = layer.getChildFrame('body', index);
				                var iframeWindow = layero.find('iframe')[0].contentWindow;
				                
				                $.post(
				                	"../../acTEAM!getTeamById.action",
				                	{'id': data.id},
				                	function(msg){
				                		var obj = new Function("return" + msg)();//转换后的JSON对象
				                		var team = obj.jsonTeam;
				                		body.find('#id').val(team.id);
				                		body.find('#L_teamName').val(team.teamName);
				                		body.find('#L_location').val(team.location);
				                		body.find('#L_englishName').val(team.englishName);
				                		body.find('#L_teamStandard').val(team.teamStandard);
				                		var areas = body.find('#L_area option');
				                		for(var i = 0; i<areas.length; i++){
				                			if(team.area == areas[i].value){
				                				areas[i].selected = true;
				                			}
				                		}
				                		var branchs = body.find('#L_branch option');
				                		for(var i = 0; i<branchs.length; i++){
				                			if(team.branch == branchs[i].value){
				                				branchs[i].selected = true;
				                			}
				                		}
				                        //重新渲染
				                        iframeWindow.layui.form.render();
				                	}
				                );
							}
						});
					}
				});
				
				//搜索，表格重载
				var active = {
					reloadTable: function() {
							
							table.reload('team_table',{
								where:{
									teamName: $("#teamName").val(),
									area: $("#area option:selected").val(),
									branch: $("#branch option:selected").val()
								}
								,page: {
								    curr: 1 //重新从第 1 页开始
								}
							});
					},
					addTeam: function() {
						layer.open({
							type: 2, //Layer提供了5种层类型。可传入的值有：0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）,
						    title: '增加球队',   //标题
						    area: ['600px', '600px'],   //宽高
						    shade: 0.4,   //遮罩透明度
						    content: 'addTeam',//支持获取DOM元素
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
					},
					exportData: function(){
						jsonurl = "../../acTEAM!getTeamExel.action?start="+$("#start").val()+"&end="+$("#end").val()
							+"&teamname="+$("#teamname").val()+"&country="+$("#country option:selected").val()
							+"&performers="+$("#performers option:selected").val();
						$.get(
							jsonurl,
							function(data){
								var obj = new Function("return" + data)();//转换后的JSON对象
								table.exportFile(obj.extitle, obj.exdata); //默认导出 csv，也可以为：xls
							}
						); 
					},
					getCheckData: function() { //获取选中数据
						var checkStatus = table.checkStatus('articleList'),
							data = checkStatus.data;
						//console.log(data);
						//layer.alert(JSON.stringify(data));
						if (data.length > 0) {
							layer.confirm('确认要删除吗？' + JSON.stringify(data), function(index) {
								layer.msg('删除成功', {
									icon: 1
								});
								//找到所有被选中的，发异步进行删除
								$(".layui-table-body .layui-form-checked").parents('tr').remove();
							});
						} else {
							layer.msg("请先选择需要删除的文章！");
						}

					},
					Recommend: function() {
						var checkStatus = table.checkStatus('articleList'),
							data = checkStatus.data;
						if (data.length > 0) {
							layer.msg("您点击了推荐操作");
							for (var i = 0; i < data.length; i++) {
								console.log("a:" + data[i].recommend);
								data[i].recommend = "checked";
								console.log("aa:" + data[i].recommend);
								form.render();
							}

						} else {
							console.log("b");
							layer.msg("请先选择");
						}

						//$(".layui-table-body .layui-form-checked").parents('tr').children().children('input[name="zzz"]').attr("checked","checked");
					},
					Top: function() {
						layer.msg("您点击了置顶操作");
					},
					Review: function() {
						layer.msg("您点击了审核操作");
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
		       
		       $('#addTeam').on('click',function(){
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

