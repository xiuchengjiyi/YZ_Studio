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
		<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
		<link rel="stylesheet" href="css/font.css">
		<link rel="stylesheet" href="css/weadmin.css">
		<script type="text/javascript" src="lib/layui/layui.js" charset="utf-8"></script>

	</head>
	<body>
		<!-- 顶部开始 -->
		<div class="container">
			<div class="logo">
				<a href="index.html">欢迎您，${username }</a>
			</div>
			<div class="left_open">
				<i title="展开左侧栏" class="iconfont">&#xe699;</i>
			</div>
			<ul class="layui-nav left fast-add" lay-filter="">
				<li style='white-space:pre;' class="layui-nav-item">
				<span style="color: white;"></span>
				</li>
			</ul>
			<ul class="layui-nav right" lay-filter="">
				<li class="layui-nav-item">
					<a href="javascript:;"></a>
					<dl class="layui-nav-child">
						<!-- 二级菜单 -->
						<dd>
							<a onclick="WeAdminShow('个人信息','http://www.baidu.com')">个人信息</a>
						</dd>
						<dd>
							<a onclick="WeAdminShow('切换帐号','./login.html')">切换帐号</a>
						</dd>
						<dd>
							<a class="loginout" href="login.html">退出</a>
						</dd>
					</dl>
				</li>
				<li class="layui-nav-item to-index">
					<a href="/">前台首页</a>
				</li>
			</ul>

		</div>
		<!-- 顶部结束 -->
		<!-- 中部开始 -->
		<!-- 左侧菜单开始 -->
		<div class="left-nav">
			<div id="side-nav">
				<ul id="nav">
					<li>
						<a href="javascript:;">
							<i class="iconfont">🎦</i>
							<cite>影视专区</cite>
							<i class="iconfont nav_right">&#xe697;</i>
						</a>
						<ul class="sub-menu">
							<li>
								<a _href="film/movielist">
									<i class="iconfont">&#xe6a7;</i>
									<cite>电影</cite>

								</a>
							</li>
							<li>
								<a _href="film/TVlist">
									<i class="iconfont">&#xe6a7;</i>
									<cite>电视剧</cite>

								</a>
							</li>
							<li>
								<a _href="actor/actorlist">
									<i class="iconfont">&#xe6a7;</i>
									<cite>演员</cite>

								</a>
							</li>
							<li>
								<a _href="nationality/nationalityList">
									<i class="iconfont">&#xe6a7;</i>
									<cite>国家及地区</cite>

								</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="javascript:;">
							<i class="iconfont">🏀</i>
							<cite>篮球专区</cite>
							<i class="iconfont nav_right">&#xe697;</i>
						</a>
						<ul class="sub-menu">
							<li>
								<a _href="NBA/playerlist.html">
									<i class="iconfont">&#xe6a7;</i>
									<cite>球员</cite>
								</a>
							</li>
							<li>
								<a _href="NBA/gamelist.html">
									<i class="iconfont">&#xe6a7;</i>
									<cite>赛程</cite>
								</a>
							</li>
							<li>
								<a _href="article/category.html">
									<i class="iconfont">&#xe6a7;</i>
									<cite>数据</cite>
								</a>
							</li>
							<li>
								<a _href="NBA/teamlist.html">
									<i class="iconfont">&#xe6a7;</i>
									<cite>球队</cite>
								</a>
							</li>
						</ul>
					</li>
<%-- 					<li>
						<a href="javascript:;">
							<i class="iconfont">&#xe723;</i>
							<cite>订单管理</cite>
							<i class="iconfont nav_right">&#xe697;</i>
						</a>
						<ul class="sub-menu">
							<li>
								<a _href="./pages/order/list.html">
									<i class="iconfont">&#xe6a7;</i>
									<cite>订单列表</cite>
								</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="javascript:;">
							<i class="iconfont">&#xe726;</i>
							<cite>管理员管理</cite>
							<i class="iconfont nav_right">&#xe697;</i>
						</a>
						<ul class="sub-menu">
							<li>
								<a _href="./pages/admin/list.html">
									<i class="iconfont">&#xe6a7;</i>
									<cite>管理员列表</cite>
								</a>
							</li>
							<li>
								<a _href="./pages/admin/role.html">
									<i class="iconfont">&#xe6a7;</i>
									<cite>角色管理</cite>
								</a>
							</li>
							<li>
								<a _href="./pages/admin/cate.html">
									<i class="iconfont">&#xe6a7;</i>
									<cite>权限分类</cite>
								</a>
							</li>
							<li>
								<a _href="./pages/admin/rule.html">
									<i class="iconfont">&#xe6a7;</i>
									<cite>权限管理</cite>
								</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="javascript:;">
							<i class="iconfont">&#xe6ce;</i>
							<cite>系统统计</cite>
							<i class="iconfont nav_right">&#xe697;</i>
						</a>
						<ul class="sub-menu">
							<li>
								<a _href="./pages/echarts/echarts1.html">
									<i class="iconfont">&#xe6a7;</i>
									<cite>拆线图</cite>
								</a>
							</li>
							<li>
								<a _href="./pages/echarts/echarts2.html">
									<i class="iconfont">&#xe6a7;</i>
									<cite>柱状图</cite>
								</a>
							</li>
							<li>
								<a _href="./pages/echarts/echarts3.html">
									<i class="iconfont">&#xe6a7;</i>
									<cite>地图</cite>
								</a>
							</li>
							<li>
								<a _href="./pages/echarts/echarts4.html">
									<i class="iconfont">&#xe6a7;</i>
									<cite>饼图</cite>
								</a>
							</li>
							<li>
								<a _href="./pages/echarts/echarts5.html">
									<i class="iconfont">&#xe6a7;</i>
									<cite>雷达图</cite>
								</a>
							</li>
							<li>
								<a _href="./pages/echarts/echarts6.html">
									<i class="iconfont">&#xe6a7;</i>
									<cite>k线图</cite>
								</a>
							</li>
							<li>
								<a _href="./pages/echarts/echarts7.html">
									<i class="iconfont">&#xe6a7;</i>
									<cite>热力图</cite>
								</a>
							</li>
							<li>
								<a _href="./pages/echarts/echarts8.html">
									<i class="iconfont">&#xe6a7;</i>
									<cite>仪表图</cite>
								</a>
							</li>
							<li>
								<a _href="./pages/echarts/echarts9.html">
									<i class="iconfont">&#xe6a7;</i>
									<cite>地图DIY实例</cite>
								</a>
							</li>
						</ul>
					</li> --%>
				</ul>
			</div>
		</div>
		<!-- <div class="x-slide_left"></div> -->
		<!-- 左侧菜单结束 -->
		<!-- 右侧主体开始 -->
		<div class="page-content">
			<div class="layui-tab tab" lay-filter="wenav_tab" id="WeTabTip" lay-allowclose="true">
				<ul class="layui-tab-title" id="tabName">
					<li>我的桌面</li>
				</ul>
				<div class="layui-tab-content">
					<div class="layui-tab-item layui-show">
						<iframe src='${pageContext.request.contextPath }/welcome' frameborder="0" scrolling="yes" class="weIframe"></iframe>
					</div>
				</div>
			</div>
		</div>
		<div class="page-content-bg"></div>
		<!-- 右侧主体结束 -->
		<!-- 中部结束 -->
		<!-- 底部开始 -->
		<div class="footer">
			<div class="copyright">Copyright ©2018 WeAdmin v1.0 All Rights Reserved</div>
		</div>
		<!-- 底部结束 -->
		<script type="text/javascript">
//			layui扩展模块的两种加载方式-示例
//		    layui.extend({
//			  admin: '{/}../../static/js/admin' // {/}的意思即代表采用自有路径，即不跟随 base 路径
//			});
//			//使用拓展模块
//			layui.use('admin', function(){
//			  var admin = layui.admin;
//			});
			layui.config({
			  base: 'js/'
			  ,version: '101100'
			}).use('admin');
			layui.use(['jquery','admin'], function(){
				var $ = layui.jquery;
				$(function(){
					
					//var login = JSON.parse(localStorage.getItem("login"));
					var username=""
					if(username != "休城记忆"){
						
						//window.location.href='./login.html';
					}else{
						//通过jsonp调用心知天气的接口获取天气信息
						$.ajax({
				            type: "get",
				            async: false,
				            cache: false,
				            url: '',
				            dataType: "jsonp",
				            jsonp: "callback",//传递给请求处理程序或页面的，用以获得jsonp回调函数名的参数名(一般默认为:callback)
				            jsonpCallback:"showWeather",//自定义的jsonp回调函数名称，默认为jQuery自动生成的随机函数名，也可以写"?"，jQuery会自动为你处理数据
				            success: function(json){
				            	console.log(json)
				            	var location = json.results[0].location;
				     			var daily = json.results[0].daily[0];
				     			var daily2 = json.results[0].daily[1];
				     			var daily3 = json.results[0].daily[2];
				     			var last_update = json.results[0].last_update;
				     			
				     			$("#weather").text(location.name+"："+"今天（"+daily.date+"）"+daily.text_day+"   "+daily.low+"~"+daily.high+"°    "
				     					+daily.wind_direction+"风"+daily.wind_scale+"级（Powerd by 心知天气）");
				     			var two = location.name+"："+"明天（"+daily2.date+"）"+daily2.text_day+"   "+daily2.low+"~"+daily2.high+"°    "
		     								+daily2.wind_direction+"风"+daily2.wind_scale+"级";
				     			var three = location.name+"："+"后天（"+daily3.date+"）"+daily3.text_day+"   "+daily3.low+"~"+daily3.high+"°    "
 											+daily3.wind_direction+"风"+daily3.wind_scale+"级";
				     			console.log(two)
				     			var dl = "<dl class='layui-nav-child'>"
				     						+"<dd>"+two+"</dd>"
				     						+"<dd>"+three+"</dd>"
				     					+"</dl>";
				     			
				     			//$("#weather").append(dl);
				            },
				            error: function(){
				            	console.log("获取天气信息失败");
				            }
				        });
					}
					

				});
			});

		</script>
	</body>
	<!--Tab菜单右键弹出菜单-->
	<ul class="rightMenu" id="rightMenu">
        <li data-type="fresh">刷新</li>
        <li data-type="current">关闭当前</li>
        <li data-type="other">关闭其它</li>
        <li data-type="all">关闭所有</li>
    </ul>

</html>