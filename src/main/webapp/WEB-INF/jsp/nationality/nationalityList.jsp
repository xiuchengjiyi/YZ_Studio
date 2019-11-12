<%@pagelanguage="java" contentType="text/html;charset=UTF-8" 
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>国家及地区列表-休城记忆的管理系统</title>
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
			<div class="layui-row">
				<form class="layui-form layui-col-md12 we-search" onsubmit="return false"> 
					<button class="layui-btn" data-type="reloadTable" id="searchBtn"><i class="layui-icon">&#xe615;搜索</i></button>
					<button class="layui-btn" id="addNationality" data-type="addNationality"><i class="layui-icon"></i>添加</button>
					<span class="fr" id="count" style="line-height:40px"></span>
				</form> 
			</div>

			<table id="nationality_table" lay-filter="actorTable"></table>

		</div>
		<script type="text/html" id="recommendTpl">
			<input type="checkbox" name="zzz" lay-skin="switch" lay-filter="recommend" lay-text="是|否" {{d.recommend == "1" ?"checked":""}}>
		</script>
		<script type="text/html" id="flag_picture">
			<img src="{{'data:image/jpg;base64,'+d.flag_picture}}" style="width:90px;height:60px" />
		</script>
		<script type="text/html" id="operateTpl">
			<div class="layui-btn-container">
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
					elem: '#nationality_table',
					url: 'nationalitys',
					cols: [
						[ {
							field: 'nat_id',
							title: 'ID',
							sort: true,
							width: 60,
							align: 'center'
						}, {
							field: 'nationality',
							title: '国家及地区名',
							width: 150,
							align: 'center'
						}, {
							field: 'en_nationality',
							title: '英文名',
							width: 150,
							align: 'center'
						}, {
							field: 'flag_picture',
							title: '国旗',
							templet: '#flag_picture',
							width: 100,
							align: 'center'
						}, {
							field: 'operate',
							title: '操作',
							toolbar: '#operateTpl',
							unresize: true,
							width: 150,
							align: 'center'
						}]
					],
					event: true,
					page: true,
					limit: 10,
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
				table.on('tool(actorTable)',function(obj){ //movieTable为table的lay-filter
					 var data = obj.data // 获得当前行数据
       				 , layEvent = obj.event; // 获得 lay-event 对应的值
					if(layEvent == 'update'){
						var index = layer.open({
							type : 2,
				            content : 'addNationality?nat_id='+data.nat_id,
				            area : [ '600px', '600px' ],
				            maxmin : true,
				            title : '更新信息',
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
													layui.table.reload('nationality_table',{page : {curr : currpage}});//刷新当前页面
										});
									}else{
										layer.alert(obj.message,{icon:2})
									}
								}
							);
						});
					}
				});
				
				//搜索，表格重载
				var active = {
					reloadTable: function() {
							
							table.reload('movie_table',{
								where:{
									start: $("#start").val(),
									end: $("#end").val(),
									moviename: $("#moviename").val(),
									performers: $("#performers option:selected").val(),
									country: $("#country option:selected").val(),
									score: $("#score option:selected").val()
								}
								,page: {
								    curr: 1 //重新从第 1 页开始
								}
							});
					},
					great: function() {
						
						table.reload('movie_table',{
							url: '../../acMOVIE!getMovieList.action',
							where:{
								rank: 'great'
							}
							,page: {
							    curr: 1 //重新从第 1 页开始
							}
						});
					},
					bad: function() {
						
						table.reload('movie_table',{
							url: '../../acMOVIE!getMovieList.action',
							where:{
								rank: 'bad'
							}
							,page: {
							    curr: 1 //重新从第 1 页开始
							}
						});
					},
					cinema:function() {
						
						table.reload('movie_table',{
							url: '../../acMOVIE!getMovieList.action',
							where:{
								is_cinema: '1'
							}
							,page: {
							    curr: 1 //重新从第 1 页开始
							}
						});
					},
					piaofang :function() {
						
						table.reload('movie_table',{
							url: '../../acMOVIE!getMovieList.action',
							where:{
								rank: 'piaofang'
							}
							,page: {
							    curr: 1 //重新从第 1 页开始
							}
						});
					},
					addNationality: function() {
						var index = layer.open({
							type: 2, //Layer提供了5种层类型。可传入的值有：0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）,
						    title: '新增国家或地区',   //标题
						    area: ['600px', '600px'],   //宽高
						    shade: 0.4,   //遮罩透明度
						    content: 'addNationality',//支持获取DOM元素
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
						jsonurl = "../../acMOVIE!getMovieExel.action?start="+$("#start").val()+"&end="+$("#end").val()
							+"&moviename="+$("#moviename").val()+"&country="+$("#country option:selected").val()
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
		       
		       $('#addNationality').on('click',function(){
		           var type = $(this).data('type');
		           active[type] ? active[type].call(this) : '';
		       });
		       
		       $('#export').on('click',function(){
		           var type = $(this).data('type');
		           active[type] ? active[type].call(this) : '';
		       });
		       $('#great').on('click',function(){
		           var type = $(this).data('type');
		           active[type] ? active[type].call(this) : '';
		       });
		       $('#bad').on('click',function(){
		           var type = $(this).data('type');
		           active[type] ? active[type].call(this) : '';
		       });
		       $('#cinema').on('click',function(){
		           var type = $(this).data('type');
		           active[type] ? active[type].call(this) : '';
		       });
		       $('#piaofang').on('click',function(){
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

