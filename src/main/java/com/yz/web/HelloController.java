package com.yz.web;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.yz.model.Film;
import com.yz.model.Record;
import com.yz.model.User;
import com.yz.model.dto.TotalDTO;
import com.yz.service.EchartService;
import com.yz.service.FilmService;
import com.yz.service.RecordService;
import com.yz.service.UserService;

/**
 * @author ZGD
 * @version 创建时间：2019年9月5日 上午8:29:48 类说明
 */
@Controller
public class HelloController {
	@Autowired
	private UserService userService;
	@Autowired
	private EchartService echartService;
	@Autowired
	private FilmService filmService;
	@Autowired
	private RecordService recordService;

	/**
	 * 前往主页
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月18日下午3:51:09
	 * @return
	 */
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String toHello() {
		return "index";
	}
	
	/**
	 * 前往欢迎页面
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年11月7日下午2:01:28
	 * @return
	 */
	@RequestMapping(value = "/welcome", method = RequestMethod.GET)
	public String toWelcome(Model model) {
		//查询各类影视总数
		TotalDTO total = echartService.getTotal();
		model.addAttribute("total", total);
		//查询评分Top10
		List<Film> films = filmService.getTop10();
		model.addAttribute("films", films);
		//查询NBA球队战绩
		Record record = new Record();
		record.setSeason("1");
		record.setBranch("1");
		List<Record> east_records = recordService.getRecords(record);
		model.addAttribute("east_records", east_records);
		record.setBranch("2");
		List<Record> west_records = recordService.getRecords(record);
		model.addAttribute("west_records", west_records);
		return "welcome";
	}
	
	/**
	 * 前往登陆页面
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月18日下午3:51:22
	 * @return
	 */
	@RequestMapping(value = "/toLogin", method = RequestMethod.GET)
	public String toLogin() {
		return "login";
	}
	
	@RequestMapping(value = "/login/toRegist", method = RequestMethod.GET)
	public String toRegist() {
		return "regist";
	}

	/**
	 * 登陆校验
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月18日下午3:51:33
	 * @param username
	 * @param password
	 * @param session
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST,produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String checkLogin(String username, String password,
			HttpSession session, HttpServletResponse response,
			HttpServletRequest request) {
		try {
			request.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 登陆校验
		JSONObject json = userService.checkLogin(username, password);
		if ("1".equals(json.get("code"))) {
			// 登陆成功将username存入session
			session.setAttribute("username", username);
		}
		return json.toString();
	}
	
	/**
	 * 注册
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月22日上午9:43:32
	 * @param username
	 * @param password
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/login/regist", method = RequestMethod.POST,produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String regist(String username, String password, HttpServletResponse response,
			HttpServletRequest request) {
		try {
			request.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 注册
		int code = userService.insert(username, password);
		
		return String.valueOf(code);
	}
	
	/**
	 * 检查用户名是否存在
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月22日上午9:49:43
	 * @param username
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/login/checkUsername", method = RequestMethod.POST,produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String checkUsername(String username, HttpServletResponse response,
			HttpServletRequest request) {
		try {
			request.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		JSONObject json = new JSONObject();
		// 登陆校验
		User user = userService.selectUser(username);
		if(user != null){
			json.put("code", "1");
		}else{
			json.put("code", "0");
		}
		
		return json.toString();
	}

}
