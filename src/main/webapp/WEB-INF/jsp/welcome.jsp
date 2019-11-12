<%@pagelanguage="java" contentType="text/html;charset=UTF-8" 
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>互联网医院管理系统</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="${pageContext.request.contextPath }/css/admin.css" media="all">  
  <script src="${pageContext.request.contextPath }/js/jquery1.9.1/jquery.min.js" charset="utf-8"></script>
 <script>
 
    
  </script>
</head>
<body>
  
  <div class="layui-fluid">
    <div class="layui-row layui-col-space15">
      <div class="layui-col-md8">
        <div class="layui-row layui-col-space15">
          <div class="layui-col-md6">
            <div class="layui-card">
              <div class="layui-card-header">佳片展示（豆瓣评分Top10）</div>
              <div class="layui-card-body">
                <div class="layui-carousel layadmin-carousel layadmin-shortcut">
                  <div carousel-item>
                  	<div>
						<c:forEach items="${films }" var="film" varStatus="i">
						<c:if test="${i.index<5 }">
						<div style="float: left;margin-left: 10px;height:200px;">
							<img width="90px" height="120px" src="data:image/jpg;base64,${film.post_path }"><br/>
							<div style="text-align: center;float: left;">
								<div style="width:90px;">${film.film_name }</div>
								<div style="color: orange;">${film.db_score }</div>
							</div>
						</div>
						</c:if>
						</c:forEach> 
					</div> 
					<div>
					<c:forEach items="${films }" var="film" varStatus="i">
					<c:if test="${i.index>=5 }">
						<div style="float: left;margin-left: 10px;height:200px;">
							<img width="90px" height="120px" src="data:image/jpg;base64,${film.post_path }"><br/>
							<div style="text-align: center;float: left;">
								<div style="width:90px;">${film.film_name }</div>
								<div style="color: orange;">${film.db_score }</div>
							</div>
						</div>
						</c:if>
					</c:forEach> 
					</div>                   
                  </div>
                </div>
                
              </div>
            </div>
          </div>
          <div class="layui-col-md6" >
            <div class="layui-card">
              <div class="layui-card-header">汇总数据</div>
              <div class="layui-card-body">

                <div class="layui-carousel layadmin-carousel layadmin-backlog">
                  <div carousel-item>
                    <ul class="layui-row layui-col-space10">
                      <li class="layui-col-xs6">
                        <a lay-href="base/PAT_CCHART.html" class="layadmin-backlog-body">
                          <h3>总观影数</h3>
                          <p><cite id="totalFilm">${total.totalFilm }</cite>部</p>
                        </a>
                      </li>
                      <li class="layui-col-xs6">
                        <a lay-href="reg/OPD_REG_INFOq.html" class="layadmin-backlog-body">
                          <h3>总电影数</h3>
                          <p><cite id="totalMovie">${total.totalMovie }</cite>部</p>
                        </a>
                      </li>
                      <li class="layui-col-xs6">
                        <a lay-href="reg/" class="layadmin-backlog-body">
                          <h3>总电视剧数</h3>
                          <p><cite id="totalTV">${total.totalTV }</cite>部</p>
                        </a>
                      </li>
                      <li class="layui-col-xs6">
                        <a lay-href="opd/OPD_CHRG_DTL.html"  class="layadmin-backlog-body">
                          <h3>总影人数</h3>
                          <p><cite id="totalActor">${total.totalActor }</cite>人</p>
                        </a>
                      </li>
                    </ul>
                    
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="layui-col-md12" >
            <div class="layui-card" >
              <div class="layui-card-header">数据概览</div>
              <div class="layui-card-body" style="height:500px">
                
                <div class="layui-carousel layadmin-carousel layadmin-dataview" data-anim="fade" lay-filter="LAY-index-dataview">
                  <div carousel-item id="LAY-index-dataview">
                    <div>
						<div style="text-align: center;">
							各个月观看电影电视剧统计表（电视剧观看时间以结束观看时间计算）&nbsp;&nbsp;&nbsp;年份：
							<select id = "info_year" onchange="changeYear()">
								<option value="2017">2017</option>
								<option value="2018">2018</option>
								<option value="2019">2019</option>
								<option value="2020">2020</option>
								<option value="2021">2021</option>
							</select>
							<div id="film_info" style="width:100%;height:340px;"></div>   
						</div>
					</div>
                  </div>
                </div>
                
              </div>
            </div>
           
          </div>
        </div>
      </div>
      
      <div class="layui-col-md4">
        <div class="layui-card">
          <div class="layui-card-header">信息中心 <a onclick="newsall()" href="javascript:void(0)" class="ml-40 radius">更多...</a></div>
          <div class="layui-card-body layui-text" style="height: 185px">
          </div>
        </div>
        
        <div class="layui-card">
          <div class="layui-card-header">效果报告</div>
          <div class="layui-card-body layadmin-takerates">
            <div class="layui-progress" lay-showPercent="yes">
              <h3>网络挂号（日同比 28% <span class="layui-edge layui-edge-top" lay-tips="增长" lay-offset="-15"></span>）</h3>
              <div class="layui-progress-bar" lay-percent="15%"></div>
            </div>
            <div class="layui-progress" lay-showPercent="yes">
              <h3>移动支付（日同比 11% <span class="layui-edge layui-edge-bottom" lay-tips="下降" lay-offset="-15"></span>）</h3>
              <div class="layui-progress-bar" lay-percent="12%"></div>
            </div>
          </div>
        </div>
        
        <div class="layui-card">
          <div class="layui-card-header">好评监控</div>
          <div class="layui-card-body layadmin-takerates">
            <div class="layui-progress" lay-showPercent="no">
              <h3>态度</h3>
              <div class="layui-progress-bar" lay-percent="7.3/10">7.3</div>
            </div>
            <div class="layui-progress" lay-showPercent="yes">
              <h3>服务</h3>
              <div class="layui-progress-bar layui-bg-red" lay-percent="90%"></div>
            </div>
          </div>
        </div>
        
        <!-- <div class="layui-card">
          <div class="layui-card-header">产品动态</div>
          <div class="layui-card-body">
            <div class="layui-carousel layadmin-carousel layadmin-news" data-autoplay="true" data-anim="fade" lay-filter="news">
              <div carousel-item>
                <div><a href="" target="_blank" class="layui-bg-red">线下扫码支付可以使用了</a></div>
                <div><a href="" target="_blank" class="layui-bg-green">产品使用手册</a></div> 
                <div><a href="" target="_blank" class="layui-bg-blue">问题反馈区</a></div>
              </div>
            </div>
          </div>
        </div> -->

         
      </div>
      
    </div>
  </div>

  <script src="${pageContext.request.contextPath }/layui/layui.js?t=1"></script>  
  
 <script> 
 
  
  /* layui.config({
    base: '${pageContext.request.contextPath }/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index']); */
  
  layui.config({
	    base: '${pageContext.request.contextPath }/layuiadmin/' //静态资源所在路径
	  }).extend({
	    index: 'lib/index' //主入口模块
	  }).use(['index','admin', 'carousel','echarts'], function(){
	    $ = layui.$
	    ,admin = layui.admin
	    ,carousel = layui.carousel
	    ,element = layui.element
	    ,device = layui.device()
	    ,echarts = layui.echarts;
	    
	    $(function(){  
			//获取当前年份
			var date=new Date;
			now_year = date.getFullYear();
			//将统计年份默认为当前年份
			var info_years = $("#info_year option");
		    for(var i = 0;i<info_years.length;i++){
	    		if(info_years[i].value == now_year){
	    			info_years[i].selected = true;
	    		}
	    	}
		    
		});
		

	    //轮播切换
	    $('.layadmin-carousel').each(function(){
	      var othis = $(this);
	      carousel.render({
	        elem: this
	        ,width: '100%'
	        ,arrow: 'none'
	        ,interval: 5000
	        ,autoplay: true
	      });
	    });
	    
	    element.render('progress');
	    
		    var myChart = echarts.init(document.getElementById('film_info'));
			   // 异步加载数据
			   $.get('echart/getFilm_Info?year='+now_year).done(function (sdata) {
					sdata= eval("["+sdata+"]");//吧json转化eval
			        // 填入数据
				    myChart.setOption({
				       tooltip: {
				        trigger: 'axis'
				    },
				    legend: {
				        data:['电影','电视剧']
				    },
				    grid: {
				        left: '3%',
				        right: '4%',
				        bottom: '3%',
				        containLabel: true
				    },
				    xAxis: {
				        type: 'category',
				        boundaryGap: false,
				        data: sdata[0].datax.split(',')  //去x方向名称
				    },
				    yAxis: {
				        type: 'value'
				    },
				    series: [
				        {
				            name:'电影',
				            type:'line',
				            data: sdata[0].data1.split(',')  
				        },
				        {
				            name:'电视剧',
				            type:'line',
				            data: sdata[0].data2.split(',')  
				        }
				    ]
				    });
			});

	    
	  });
  
//切换查询年份
	function changeYear(){
		var info_year = $("#info_year option:selected").val();
	    var myChart = echarts.init(document.getElementById('film_info'));
		   // 异步加载数据
		   $.get('echart/getFilm_Info?year='+info_year).done(function (sdata) {
				sdata= eval("["+sdata+"]");//吧json转化eval
		        // 填入数据
			    myChart.setOption({
			       tooltip: {
			        trigger: 'axis'
			    },
			    legend: {
			        data:['电影','电视剧']
			    },
			    grid: {
			        left: '3%',
			        right: '4%',
			        bottom: '3%',
			        containLabel: true
			    },
			    xAxis: {
			        type: 'category',
			        boundaryGap: false,
			        data: sdata[0].datax.split(',')  //去x方向名称
			    },
			    yAxis: {
			        type: 'value'
			    },
			    series: [
			        {
			            name:'电影',
			            type:'line',
			            data: sdata[0].data1.split(',')  
			        },
			        {
			            name:'电视剧',
			            type:'line',
			            data: sdata[0].data2.split(',')  
			        }
			    ]
			    });
		});
	}
	
  
  </script>
</body>
</html>

