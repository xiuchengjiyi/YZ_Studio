<%@pagelanguage="java" contentType="text/html;charset=UTF-8" 
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>电影列表-休城记忆的影视基地</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
		<link rel="stylesheet" href="../css/font.css">
		<link rel="stylesheet" href="../css/weadmin.css">
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
		a{color:red}
		a:hover{color:#ff3399}
		
	</style>
	<body>
		<div class="weadmin-body">
			<div class="layui-row">
				<form class="layui-form layui-col-md12 we-search" onsubmit="return false"> 
					观看时间：
					<div class="layui-inline">
						<input style="width:100px" class="layui-input" placeholder="开始日" name="start" id="start" autocomplete="off">
					</div>
					——
					<div class="layui-inline">
						<input style="width:100px" class="layui-input" placeholder="截止日" name="end" id="end" autocomplete="off">
					</div>
					电影名称：
					<div class="layui-inline">
						<input type="text" id="film_name" name="film_name" placeholder="如：钢铁侠" class="layui-input"  autocomplete="off">
					</div>
					主演：
					<div class="layui-inline">
						<input type="text" id="ac_id" name="ac_id" placeholder="如：杨紫" class="layui-input"  autocomplete="off">
					</div>
					制片地区：
					<div class="layui-inline">
						<select id="nat_id">
							<option value="">请选择</option>
							<c:forEach items="${nationalitys }" var="nationality" varStatus="i">
				        		<option value="${nationality.nat_id }">${nationality.nationality }</option>
							</c:forEach>
						</select>
					</div>
					评分：
					<div class="layui-inline" >
						<select id="db_score"  lay-search>
							<option value="">请选择</option>
							<option value="1">9.0以上</option>
							<option value="2">8.0~8.9</option>
							<option value="3">7.0~7.9</option>
							<option value="4">6.0~6.9</option>
							<option value="5">5.0~5.9</option>
							<option value="6">4.0~4.9</option>
							<option value="7">4.0以下</option>
						</select>
					</div>
					<button class="layui-btn" data-type="reloadTable" id="searchBtn"><i class="layui-icon">&#xe615;搜索</i></button>
				</form> 
			</div>
			<div class="weadmin-block">
				<button class="layui-btn" id="addMovie" data-type="addMovie"><i class="layui-icon"></i>添加</button>
				<!-- <button class="layui-btn" id="export" data-type="exportData"><i class="layui-icon">&#xe601;</i>导出表格</button> -->
				<button class="layui-btn layui-btn-normal" id="great" data-type="great"><i class="layui-icon">&#xe6c6;</i>佳片有约</button>
				<button class="layui-btn layui-btn-danger" id="bad" data-type="bad"><i class="layui-icon">&#xe6c5;</i>烂番茄榜</button>
				<button class="layui-btn layui-btn-warm" id="piaofang" data-type="piaofang"><i class="layui-icon">&#xe756;</i>票房榜</button>
				<button class="layui-btn layui-btn-normal" id="cinema" data-type="cinema"><i class="layui-icon">&#xe658;</i>影院观看</button>				
				<span class="fr" id="count" style="line-height:40px"></span>
			</div>


			<table id="movie_table" lay-filter="movieTable"></table>

		</div>
		<script type="text/html" id="recommendTpl">
			<input type="checkbox" name="zzz" lay-skin="switch" lay-filter="recommend" lay-text="是|否" {{d.recommend == "1" ?"checked":""}}>
		</script>
		<script type="text/html" id="movieposter">
			<img src="{{'data:image/jpg;base64,'+d.post_picture}}" style="width:60px;height:100px" />
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
    			<!--<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete">删除</button>-->
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
					
				$(function(){  
				    var nat_ids = $("#nat_id option");
				    for(var i = 0;i<nat_ids.length;i++){
			    		if(nat_ids[i].text == "中国"){
			    			nat_ids[i].text = "中国大陆";
			    		}
			    	}
			    	form.render('select');
				});
					

				table.render({
					elem: '#movie_table',
					url: 'films?film_type=1',
					cols: [
						[{
							title: '序号',
							type: 'numbers',
							width: 60,
						}, {
							field: 'film_id',
							title: 'film_id',
							sort: true,
							width: 60,
							hide: true,
							align: 'center'
						}, {
							field: 'film_name',
							title: '电影名称',
							width: 250,
							align: 'center',
							templet: function(data){
								return "<b>"+data.film_name+"</b><br/><span>"+(data.film_english==null?"":data.film_english)+"</span>";
							}
						}, {
							field: 'post_path',
							title: '电影海报',
							templet: '#movieposter',
							width: 120,
							align: 'center'
						}, {
							field: 'actors',
							title: '主演',
							align: 'center',
							templet: function(data){
								if(data.actors == null || data.actors == ""){
									return "动漫或动画片（无演员）";
								}else{
									return data.actors;
								}
								
							}
						}, {
							field: 'nationalities',
							title: '制片地区',
							sort: true,
							width: 150,
							align: 'center'
						}, {
							field: 'db_score',
							title: '豆瓣评分',
							sort: true,
							width: 100,
							align: 'center',
							
						}, {
							field: 'piaofang',
							title: '票房',
							sort: false,
							width: 100,
							align: 'center',
							templet: function(data){
								var danwei = "";
								if("Y" == data.danwei){
									danwei = "亿";
								}else if("W" == data.danwei){
									danwei = "万";
								}
								if(data.piaofang == null || data.piaofang == ""){
									return "暂无票房信息"
								}else{
									return data.piaofang+danwei
								}
								
							}
						}, {
							field: 'run_date',
							title: '上映时间',
							sort: true,
							width: 120,
							align: 'center',
							templet: function(data){
								return data.run_date == null ? "暂无":data.run_date;
							}
						}, {
							field: 'end_date',
							title: '观看时间',
							sort: true,
							width: 120,
							align: 'center',
							templet: function(data){
								if(data.is_cinema == 2){
									return data.end_date == null ? "暂无":data.end_date;
								}else{
									return data.end_date +"<br/><a class='ticket' name='"+data.ticket_picture+"'>影院观看</a>";
								}
								
							}
						}, {
							field: 'recommend',
							title: '是否推荐',
							templet: '#recommendTpl',
							unresize: true,
							align: 'center',
							width: 100
						}, {
							field: 'operate',
							title: '操作',
							toolbar: '#operateTpl',
							unresize: true,
							width: 80,
							align: 'center'
						}]
					],
					event: true,
					page: true,
					limit: 5,
					limits: [5, 10, 20, 50,100],
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
			            console.log(img)
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
					
				
				laydate.render({
					elem : '#start'
				});
				laydate.render({
					elem : '#end'
				}); 
				
				//事件监听,监听行工具条用tool，监听头工具条用toolbar
				table.on('tool(movieTable)',function(obj){ //movieTable为table的lay-filter
					 var data = obj.data // 获得当前行数据
       				 , layEvent = obj.event; // 获得 lay-event 对应的值
					if(layEvent == 'update'){
						var index = layer.open({
							type : 2,
				            content : 'addMovie?film_id='+data.film_id,
				            area : [ '900px', '730px' ],
				            maxmin : true,
				            title : '更新电影',
				            success : function(layero, index) {
							}
						});
					}
				});
				
				
				//监听开关，进行推荐修改
				form.on('switch(recommend)',function (data) {
					var value = data.elem.checked;
					// 获取当前控件                                                                
					var selectIfKey=data.othis;                                               
					// 获取当前所在行                                                               
					var parentTr = selectIfKey.parents("tr"); 
					//获取当前行的某个字段
					var id = $(parentTr).find("td:eq(1)").find(".layui-table-cell").text(); 
					// 获取当前所在行的索引                                                            
					//var parentTrIndex = parentTr.attr("data-index");
					var recommend;
					if(value == true){
						recommend = 1;
					}else{
						recommend = 0;
					}
					$.post(
						"updateRecommend",
						{"recommend":recommend,"film_id":id},
						function(msg){
							
						}
					);
				})
				
				//搜索，表格重载
				var active = {
					reloadTable: function() {
							
							table.reload('movie_table',{
								where:{
									start_date: $("#start").val(),
									end_date: $("#end").val(),
									film_name: $("#film_name").val(),
									ac_id: $("#ac_id").val(),
									db_score: $("#db_score option:selected").val(),
									nat_id: $("#nat_id option:selected").val(),
								}
								,page: {
								    curr: 1 //重新从第 1 页开始
								}
							});
					},
					great: function() {
						
						table.reload('movie_table',{
							url: 'films?film_type=1',
							where:{
								rank: '1'
							}
							,page: {
							    curr: 1 //重新从第 1 页开始
							}
						});
					},
					bad: function() {
						
						table.reload('movie_table',{
							url: 'films?film_type=1',
							where:{
								rank: '2'
							}
							,page: {
							    curr: 1 //重新从第 1 页开始
							}
						});
					},
					cinema:function() {
						
						table.reload('movie_table',{
							url: 'films?film_type=1',
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
							url: 'films?film_type=1',
							where:{
								rank: '3'
							}
							,page: {
							    curr: 1 //重新从第 1 页开始
							}
						});
					},
					addMovie: function() {
						var index = layer.open({
							type: 2, //Layer提供了5种层类型。可传入的值有：0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）,
						    title: '增加电影',   //标题
						    area: ['900px', '730px'],   //宽高
						    shade: 0.4,   //遮罩透明度
						    content: 'addMovie',//支持获取DOM元素
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
					$.get(
							"../../acMOVIE!getCountryList.action",
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
							"../../acMOVIE!getPerformersList.action",
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

