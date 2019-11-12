<%@pagelanguage ="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>添加电影-休城记忆的影视基地</title>
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
		<form id="filmForm" class="layui-form"
			action="">
			<div class="layui-form-item">
				<input name="film_id" type="hidden" value="${film.film_id }"/>
				<input name="film_type" type="hidden" value="1"/>
				<div class="layui-inline">
					<label for="film_name" class="layui-form-label"> <span
						class="we-red">*</span>电影名
					</label>
					<div class="layui-input-inline" style="width: 250px">
						<input type="text" id="film_name" name="film_name" value="${film.film_name }"
							lay-verify="required" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label for="film_english" class="layui-form-label"> 英文名 </label>
					<div class="layui-input-inline" style="width: 250px">
						<input type="text" id="film_english" name="film_english"  value="${film.film_english }"
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>

			<div class="layui-form-item">
				<div class="layui-inline">
					<label for="place_names" class="layui-form-label"> <span
						class="we-red">*</span>制片地区
					</label>
					<div class="layui-input-inline" style="width: 250px">
						<input type="text" id="place_names"   value="${film.place_names }"
							lay-verify="required" autocomplete="off" class="layui-input" placeholder="请从右方下拉框选择，可多次选择" />
						<input type="hidden" id="place_ids" name="place_ids" value="${film.place_ids }" />
					</div>
				</div>
				<div class="layui-inline">
					<div class="layui-input-block" style="width: 250px">
				      <select id="nationalitys" lay-search lay-filter="nationalitys">
				        <option value=""></option>
				        <c:forEach items="${nationalitys }" var="nationality" varStatus="i">
				        	<option value="${nationality.nat_id }">${nationality.nationality }</option>
				        </c:forEach>
				      </select>
				    </div>
				</div>
				
			</div>
			
			
			<div class="layui-form-item">
				<div class="layui-inline">
					<label for="actor_names" class="layui-form-label"> <span
						class="we-red">*</span>主演
					</label>
					<div class="layui-input-inline" style="width: 634px">
						<input type="text" id="actor_names"   value="${film.actor_names }"
							lay-verify="" autocomplete="off" class="layui-input"  placeholder="请从下方下拉框选择，可多次选择"/>
						<input type="hidden" id="actor_ids" name="actor_ids"  value="${film.actor_ids }" />
					</div>
				</div>
			</div>
			
			<div class="layui-form-item">
				<div class="layui-inline">
					<div class="layui-input-block" style="width: 250px">
				      <select id="actors"  lay-search lay-filter="actors">
				        <option value=""></option>
				        <c:forEach items="${actors }" var="actor" varStatus="i">
				        	<option value="${actor.ac_id }">${actor.ac_name }</option>
				        </c:forEach>
				      </select>
				    </div>
				</div>
			</div>

			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">影院观看</label>
					<div class="layui-input-block" >
						<input type="radio" name="is_cinema" value="1" title="是">
						<input type="radio" name="is_cinema" value="2" title="否" checked>
					</div>
				</div>
				<div class="layui-inline">
					<label for="db_score" class="layui-form-label"> <span
						class="we-red"></span>豆瓣评分
					</label>
					<div class="layui-input-inline" style="width: 80px">
						<input type="text" id="db_score" name="db_score"  value="${film.db_score }"
							lay-verify="" autocomplete="off" class="layui-input" />
					</div>
				</div>
				<div class="layui-inline">
					<label for="piaofang" class="layui-form-label"> <span
						class="we-red"></span>票房
					</label>
					<div class="layui-input-inline" style="width: 85px">
						<input type="text" id="piaofang" name="piaofang"  value="${film.piaofang }"
							lay-verify="" autocomplete="off" class="layui-input" />
					</div>
					<div class="layui-input-inline" style="width: 65px">
						<select id="danwei" name="danwei"   lay-filter="danwei">
				        	<option value="Y">亿</option>
				        	<option value="W">万</option>
				      </select>
					</div>
				</div>
			</div>
			<div class="layui-form-item">
			<div class="layui-inline">
					<label for="run_date" class="layui-form-label"> <span
						class="we-red"></span>上映日期
					</label>
					<div class="layui-input-inline" style="width: 250px">
						<input type="text" id="run_date" name="run_date"  value="${film.run_date }"
							lay-verify="required" autocomplete="off" class="layui-input" />
					</div>
				</div>
				<div class="layui-inline">
					<label for="end_date" class="layui-form-label"> <span
						class="we-red"></span>观看日期
					</label>
					<div class="layui-input-inline" style="width: 250px">
						<input type="text" id="end_date" name="end_date"  value="${film.end_date }"
							lay-verify="" autocomplete="off" class="layui-input" />
					</div>
				</div>
			</div>
			
			<div class="layui-form-item">
				<label class="layui-form-label">海报</label>
				<div class="layui-upload">
					<button type="button" class="layui-btn" id="test1">上传图片</button>
					<div style="margin-left: 110px;" class="layui-upload-list">
						<img class="layui-upload-img" width="150px" height="200px"
							id="demo1" src="data:image/jpg;base64,${film.post_picture }"> <input type="hidden" id="post_path"
							name="post_path" value="${film.post_path }">
						<p id="demoText"></p>
					</div>
				</div>
			</div>

			<div class="layui-form-item">
				<div class="layui-inline" style="margin-left: 350px">
					<button class="layui-btn" lay-filter="add" id="add" lay-submit="">确定</button>
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				</div>
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
						var is_cinema = "${film.is_cinema }";
					    if(is_cinema != "" && is_cinema != null){
					    	var is_cinemas = $("input[name='is_cinema']");
					    	for(var i = 0;i<is_cinemas.length;i++){
					    		if(is_cinemas[i].value == is_cinema){
					    			console.log(is_cinemas[i].checked)
					    			is_cinemas[i].checked = true;
					    		}
					    	}
					    	form.render('radio');
					    }
					    
					    var danweis = $("select[name='danwei'] option");
					    for(var i = 0;i<danweis.length;i++){
				    		if(danweis[i].value == "${film.danwei}"){
				    			console.log("${film.danwei}")
				    			danweis[i].selected = true;
				    		}
				    	}
				    	form.render('select');
					}
					
					var nat_ids = $("#nat_id option");
				    for(var i = 0;i<nat_ids.length;i++){
			    		if(nat_ids[i].text == "中国"){
			    			nat_ids[i].text = "中国大陆";
			    		}
			    	}
			    	form.render('select');
				    
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
									$("#post_path").val(
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
					elem : '#run_date'
				});
				laydate.render({
					elem : '#end_date'
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
				/* $('input[name="run_date"]').blur(
						function() {
							var run_date = $("#run_date").val();
							run_date = checkDate(run_date);
							$("#run_date").val(run_date);
						});
				$('input[name="end_date"]').blur(
						function() {
							var end_date = $("#end_date").val();
							end_date = checkDate(end_date);
							$("#end_date").val(end_date);
						}); */
				function checkDate(adate) {
					if(adate.length != 8){
						layer.msg("出生日期不规范！",{icon:2,time:500});
						return
					}else{
						adate = adate.substring(0,4)+"-"+adate.substring(4,6)+"-"+adate.substring(6)
						return adate;
					}
				}
				//监听制片地区下拉框
				form.on('select(nationalitys)', function(data){
					  var nat_id = data.value;
					  var nat_nm = data.elem[data.elem.selectedIndex].text;
					  var place_names = $("#place_names").val();
					  var place_ids = $("#place_ids").val();
					  if(place_ids == null || place_ids == ""){
						  place_ids += nat_id;
						  place_names += nat_nm;
					  }else{
						  var split = place_ids.split("/");
						  for(var i = 0; i<split.length; i++){
							  if(nat_id == split[i]){
								  layer.msg("制片地区【"+nat_nm+"】已添加!",{icon:2,time:1000});
								  return;
							  }
						  }
						  place_ids += "/"+nat_id;
						  place_names += "/"+nat_nm;
					  }
					  $("#place_names").val(place_names);
					  $("#place_ids").val(place_ids);
				});
				//制片地区修改时触发事件
				$("#place_names").change(
					function(){
						var place_names = $("#place_names").val();
						var place_ids = $("#place_ids").val();
						var split1 = place_names.split("/");
						var split2 = place_ids.split("/");
						var len1 = split1.length;
						var len2 = split2.length;
						if(len1<len2){//制片地区少一个，对应的id也少一个
							place_ids = "";
							for(var i = 0;i<len1;i++){
								if(i==0){
									place_ids = split2[i];
								}else{
									place_ids += "/"+split2[i];
								}
							}
							$("#place_ids").val(place_ids);
						}
					}		
				);
				//监听演员下拉框
				form.on('select(actors)', function(data){
					  var actor_id = data.value;
					  var actor_nm = data.elem[data.elem.selectedIndex].text;
					  var actor_names = $("#actor_names").val();
					  var actor_ids = $("#actor_ids").val();
					  if(actor_ids == null || actor_ids == ""){
						  actor_ids += actor_id;
						  actor_names += actor_nm;
					  }else{
						  var split = actor_ids.split("/");
						  for(var i = 0; i<split.length; i++){
							  if(actor_id == split[i]){
								  layer.msg("主演【"+actor_nm+"】已添加!",{icon:2,time:1000});
								  return;
							  }
						  }
						  actor_ids += "/"+actor_id;
						  actor_names += "/"+actor_nm;
					  }
					  $("#actor_names").val(actor_names);
					  $("#actor_ids").val(actor_ids);
				});
				//演员修改时触发事件
				$("#actor_names").change(
					function(){
						var actor_names = $("#actor_names").val();
						var actor_ids = $("#actor_ids").val();
						var split1 = actor_names.split("/");
						var split2 = actor_ids.split("/");
						var len1 = split1.length;
						var len2 = split2.length;
						if(len1<len2){//制片地区少一个，对应的id也少一个
							actor_ids = "";
							for(var i = 0;i<len1;i++){
								if(i==0){
									actor_ids = split2[i];
								}else{
									actor_ids += "/"+split2[i];
								}
							}
							$("#actor_ids").val(actor_ids);
						}
					}		
				);

				//监听提交
				form.on('submit(add)',function(data) {
					var url;
					if("${flag}" == "edit"){
						url = "editFilm";
					}else if("${flag}" == "insert"){
						url = "insertFilm";
					}
					$("#add").attr("disabled","disabled");
					$.post(
						url,
						$("#filmForm").serialize(),
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
											parent.layui.table.reload('movie_table',{page : {curr : currpage}});//刷新当前页面
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