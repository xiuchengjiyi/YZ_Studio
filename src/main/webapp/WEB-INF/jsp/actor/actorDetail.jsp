<%@pagelanguage ="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>演员详情-休城记忆的影视基地</title>
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
<style>
	.base{
		color: gray;
		font-size: 18px;
	}
	.baseInfo{
		font-size: 18px;
	}
	.clearFloat{
	 	clear: both;
	}
	img{
		border-radius:5px;
	}
</style>

<body>
	<div style="margin-left: 30px;margin-top: 10px">
		<div style="float: left;">
			<img  src="data:image/jpg;base64,${actor.ac_picture }" width="130px" height="180px">
		</div>
		<!-- 基本信息 -->
		<div style="float: left;margin-left: 10px;">
			<span class="base">名字：</span><span class="baseInfo">${actor.ac_name }</span><br/>
			<c:if test="${actor.english_name != ''  }">
			<span class="base">英文名：</span><span class="baseInfo">${actor.english_name }</span><br/>
			</c:if>
			<span class="base">性别：</span><span class="baseInfo">
			<c:if test="${actor.sex == 1  }">
			男
			</c:if>
			<c:if test="${actor.sex == 0  }">
			女
			</c:if>
			</span><br/>
			<span class="base">出生日期：</span><span class="baseInfo">${actor.birthday }</span><br/>
			<span class="base">年龄：</span><span class="baseInfo">${actor.age }</span><br/>
			<span class="base">出生地：</span><span class="baseInfo">${actor.nationality.nationality }</span><br/>
			<span class="base">系统编号：</span><span class="baseInfo">${actor.ac_id }</span><br/>
		</div>
		<div class="clearFloat"></div>
		<!-- 作品 -->
		<div style="margin-top: 10px;">
			<div >
				<span class="base">我看过的作品（按评分排序）</span>
			</div>
			<c:forEach  items="${actor.films }" var="film" varStatus="i">
				<c:if test="${i.index%5 == 0 }">
				<div style="float: left;margin-top: 10px;height:200px;">
					<img src="data:image/jpg;base64,${film.post_path }" width="100px" height="133px" ><br/>
					<div style="text-align: center;float: left;">
						<div style="width:100px;">${film.film_name }</div>
						<div style="color: orange;">${film.db_score }</div>
					</div>
				</div>
				</c:if>
				<c:if test="${i.index%5 != 0 }">
				<div style="float: left;margin-top: 10px;margin-left: 10px;height:200px;">
					<img src="data:image/jpg;base64,${film.post_path }" width="100px" height="133px"><br/>
					<div style="text-align: center;float: left;">
						<div  style="width:100px;">${film.film_name }</div>
						<div style="color: orange;">${film.db_score }</div>
					</div>
				</div>
				</c:if>
				
			</c:forEach>
			<div class="clearFloat"></div>
		</div>
	</div>
		
	<script src="${pageContext.request.contextPath }/js/jquery1.9.1/jquery.min.js" charset="utf-8"></script>
	<script src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
	<script src="${pageContext.request.contextPath }/lib/layui/lay/modules/rate.js" charset="utf-8"></script>
	<script>
	</script>
</body>

</html>