package com.yz.web;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.yz.model.Echart;
import com.yz.service.EchartService;

/**
 * @author ZGD
 * @version 创建时间：2019年11月7日 下午3:19:19
 * 类说明：echarts统计获取数据控制类
 */
@Controller
@RequestMapping(value = "echart")
public class EchartController {

	@Autowired
	private EchartService echartService;
	
	/**
	 * 用echarts统计影视数据，并按规定格式返回
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年11月7日下午3:04:08
	 * @param year
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/getFilm_Info", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String getFilm_Info(Echart echart, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		JSONObject json = echartService.getFilm_Info(echart);
		
		return json.toString();
	}
}
