<%@pagelanguage="java" contentType="text/html;charset=UTF-8" 
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>演员列表-休城记忆的管理系统</title>
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
		<div class="weadmin-body">
			<div class="layui-row layui-card-body">
				<form class="layui-form layui-col-md12 we-search" onsubmit="return false"> 
					名字：
					<div class="layui-inline">
						<input type="text" id="ac_name" name="ac_name" placeholder="中文或英文名搜索" class="layui-input"  autocomplete="off">
					</div>
					出生地：
					<div class="layui-inline">
						<select id="birth_place">
							<option value="">请选择</option>
							<c:forEach items="${nationalitys }" var="nationality" varStatus="i">
				        		<option value="${nationality.nat_id }">${nationality.nationality }</option>
							</c:forEach>
						</select>
					</div>
					性别：
					<div class="layui-inline" >
						<select id="sex" style="width:100px;">
							<option value="">请选择</option>
				        	<option value="1">男</option>
				        	<option value="0">女</option>
						</select>
					</div>
					<button class="layui-btn" data-type="reloadTable" id="searchBtn"><i class="layui-icon">&#xe615;搜索</i></button>
					<button class="layui-btn" id="addMovie" data-type="addMovie"><i class="layui-icon"></i>添加</button>
					<span style="margin-left: 20px" id="count" style="line-height:40px"></span>
				</form> 
				排序：<button class="layui-btn layui-btn-normal" id="sort_count" data-type="sort_count">按作品数</button>
				<button class="layui-btn layui-btn-normal" id="sort_score" data-type="sort_score">豆瓣评分（3部以上）</button>
			</div>
			
			<div >
				
			</div>
			<div class="layui-card-body">
				<div class="layui-inline">
					<table style="width:70%" id="actor_table" lay-filter="actorTable"></table>
				</div>
			</div>
		</div>
		<script type="text/html" id="recommendTpl">
			<input type="checkbox" name="zzz" lay-skin="switch" lay-filter="recommend" lay-text="是|否" {{d.recommend == "1" ?"checked":""}}>
		</script>
		<script type="text/html" id="ac_picture">
			<img src="{{'data:image/jpg;base64,'+d.ac_picture}}" style="width:60px;height:100px" />
		</script>
		<script type="text/html" id="operateTpl">
			<div class="layui-btn-container">
				<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="detail">详情</button>
				<button class="layui-btn layui-btn-sm" lay-event="update">编辑</button>
    			<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete">删除</button>
  			</div>
		</script>
		<!--<script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>-->
		<script src="../lib/layui/layui.js" charset="utf-8"></script>
		<script src="../js/eleDel.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/admin.js" type="text/javascript" charset="utf-8"></script>

		<script>
			/* layui.config({
			  base: 'js/'
			  ,version: '101100'
			}).use('admin'); */

			layui.use(['table', 'jquery', 'form', 'admin','laydate','layer'], function() {
				var table = layui.table,
					$ = layui.jquery,
					form = layui.form,
					laydate = layui.laydate,
					admin = layui.admin,
					layer = layui.layer;
					
					

				table.render({
					elem: '#actor_table',
					url: 'actors?sort=1',
					cols: [
						[{
							title: '序号',
							type: 'numbers',
							width: 60,
						}, {
							field: 'ac_id',
							title: 'ID',
							sort: true,
							width: 120,
							align: 'center'
						}, {
							field: 'ac_name',
							title: '姓名',
							width: 200,
							align: 'center',
							templet : function(d){
								var en_name = d.english_name;
								if(en_name == null || en_name ==""){
									return "<b>"+d.ac_name+"<b/>";
								}else{
									return "<b>"+d.ac_name+"<b/><br/><span>"+en_name+"<span/>";
								}
							}
						}, {
							field: 'ac_picture',
							title: '照片',
							templet: '#ac_picture',
							width: 80,
							align: 'center'
						}, {
							field: 'sex',
							title: '性别',
							width: 100,
							align: 'center',
							templet : function(d){
								return d.sex=="1"?"男":"女";
							}
						}, {
							field: 'birth_place',
							title: '出生地',
							width: 150,
							align: 'center'
						}, {
							field: 'birthday',
							title: '生日',
							width: 150,
							align: 'center'
						}, {
							field: 'age',
							title: '年龄',
							sort: true,
							width: 100,
							align: 'center'
						}, {
							field: 'count',
							title: '作品数',
							sort: true,
							width: 100,
							align: 'center'
						}, {
							field: 'avg_score',
							title: '豆瓣平均分',
							sort: true,
							width: 100,
							align: 'center'
						}, {
							field: 'operate',
							title: '操作',
							toolbar: '#operateTpl',
							unresize: true,
							width: 200,
							align: 'center'
						}]
					],
					event: true,
					page: true,
					limit: 5,
					limits: [5, 10, 20, 30, 50],
					done:function(res,curr,count){
						$("#count").html("共有数据："+res.count+"条");//获取当前表的总记录数
		                hoverOpenImg();//显示大图
		               <%--  $('table tr').on('click',function(){
		                     $('table tr').css('background','');
		                     $(this).css('background','<%=PropKit.use("config.properties").get("table_color")%>');
		                 }); --%>
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
			                tips:[1, 'rgba(41,41,41,.5)']
			                ,area: ['200px']
			                ,time:1000000000
			            });
			        },function(){
			            layer.close(img_show);
			        });
			        $('td img').attr('style','max-width:70px');
			    }
				
				
				//事件监听,监听行工具条用tool，监听头工具条用toolbar
				table.on('tool(actorTable)',function(obj){ //movieTable为table的lay-filter
					 var data = obj.data // 获得当前行数据
       				 , layEvent = obj.event; // 获得 lay-event 对应的值
					if(layEvent == 'update'){
						var index = layer.open({
							type : 2,
				            content : 'addActor?ac_id='+data.ac_id,
				            area : [ '900px', '650px' ],
				            maxmin : true,
				            title : '更新演员信息',
				            success : function(layero, index) {
							}
						});
					}else if(layEvent == 'delete'){
						layer.confirm('确认要删除【'+data.ac_name+'】吗？', function(index) {
							$.post(
								"deleteActor",
								{"ac_id":data.ac_id},
								function(data){
									var obj = new Function("return" + data)();
									if(obj.code != 0){
										layer.msg(obj.message,
												{
													icon : 6,
													time : 500,
												},
												function() {
													var currpage = $(".layui-laypage-skip").find("input").val(); //当前页码值
													layui.table.reload('actor_table',{page : {curr : currpage}});//刷新当前页面
										});
									}else{
										layer.alert(obj.message,{icon:2})
									}
								}
							);
						});
					}else if(layEvent == 'detail'){
						//查看详情
						var index = layer.open({
							type : 2,
				            content : 'actorDetail?ac_id='+data.ac_id,
				            area : [ '600px', '700px' ],
				            maxmin : true,
				            title : '演员详细信息'
						});
					}
				});
				
				//搜索，表格重载
				var active = {
					reloadTable: function() {
							
							table.reload('actor_table',{
								where:{
									ac_name: $("#ac_name").val(),
									birth_place: $("#birth_place option:selected").val(),
									sex: $("#sex option:selected").val(),
								}
								,page: {
								    curr: 1 //重新从第 1 页开始
								}
							});
					},
					addMovie: function() {
						var index = layer.open({
							type: 2, //Layer提供了5种层类型。可传入的值有：0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）,
						    title: '新增演员',   //标题
						    area: ['900px', '650px'],   //宽高
						    shade: 0.4,   //遮罩透明度
						    content: 'addActor',//支持获取DOM元素
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
					sort_count: function(){
						table.reload('actor_table',{
							url: 'actors?sort=2'
							,page: {
							    curr: 1 //重新从第 1 页开始
							}
						});
					},
					sort_score: function(){
						table.reload('actor_table',{
							url: 'actors?sort=3'
							,page: {
							    curr: 1 //重新从第 1 页开始
							}
						});
					},

				};

				$('.demoTable .layui-btn').on('click', function() {
					var type = $(this).data('type');
					active[type] ? active[type].call(this) : '';
				});
				
				$('#searchBtn').on('click',function(){
		           var type = $(this).data('type');
		           active[type] ? active[type].call(this) : '';
		       });
		       
		       $('#addMovie').on('click',function(){
		           var type = $(this).data('type');
		           active[type] ? active[type].call(this) : '';
		       });
		       
		       $('#sort_count').on('click',function(){
		           var type = $(this).data('type');
		           active[type] ? active[type].call(this) : '';
		       });
		       
		       $('#sort_score').on('click',function(){
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
				});  
			});
			
			//重新渲染表单
			function renderForm(){
			  layui.use('form', function(){
			   var form = layui.form;//高版本建议把括号去掉，有的低版本，需要加()
			   form.render();
			  });
			 }

		</script>
	</body>

</html>

