package com.yz.web;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yz.model.Actor;
import com.yz.model.Nationality;
import com.yz.service.ActorService;
import com.yz.service.NationalityService;
import com.yz.utils.Utils;

/**
 * 国家及地区controller类
 * @author Lenovo
 */
@Controller
@RequestMapping("/nationality")
public class NationalityController {

	@Autowired
	private NationalityService nationalityService;

	@RequestMapping(value = "/{path}", method = RequestMethod.GET)
	public String goPage(@PathVariable String path) {
		return "/nationality/" + path;
	}

	/**
	 * 前往新增国家及地区页面
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月24日上午9:25:02
	 * @param model
	 * @param nat_id
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/addNationality", method = RequestMethod.GET)
	public String AddNationality(Model model, String nat_id,
			HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		if (nat_id != null && !"".equals(nat_id)) {
			//ac_id不为空则为前往编辑页面，查询该演员信息传到页面
			Map<String, Object> nationality = nationalityService.getNationalityByID(nat_id);

			model.addAttribute("nationality",nationality);
			model.addAttribute("flag","edit");
		}else{
			model.addAttribute("flag","insert");
		}
		
		return "/nationality/addNationality";
	}

	/**
	 * 查询所有国家及地区信息
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月24日上午9:24:37
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/nationalitys", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String getNationalitys(HttpServletRequest request,
			HttpServletResponse response ,Integer page,Integer limit) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		JSONObject json = nationalityService.selectAll(page*limit-limit,limit);
		return json.toString();
	}

	/**
	 * 新增
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月24日下午2:53:03
	 * @param nationality
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/insertNationality", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String insertNationality(Nationality nationality, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		int code = nationalityService.insertNationality(nationality);
		JSONObject json = new JSONObject();
		if (code != 0) {
			json.put("code", code);
			json.put("message", "新增成功！");
		}else{
			json.put("code", code);
			json.put("message", "新增失败！");
		}
		

		return json.toString();
	}
	
	/**
	 * 更新
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月24日下午2:53:12
	 * @param nationality
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/editNationality", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String editActor(Nationality nationality, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		int code = nationalityService.editNationality(nationality);
		
		JSONObject json = new JSONObject();
		if (code != 0) {
			json.put("code", code);
			json.put("message", "更新成功！");
		}else{
			json.put("code", code);
			json.put("message", "更新失败！");
		}
		

		return json.toString();
	}
	
	/*@RequestMapping(value = "/deleteActor", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String deleteActor(String ac_id, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		int code = nationalityService.deleteActorById(ac_id);
		
		JSONObject json = new JSONObject();
		if (code != 0) {
			json.put("code", code);
			json.put("message", "删除成功！");
		}else{
			json.put("code", code);
			json.put("message", "删除失败！");
		}
		

		return json.toString();
	}*/

	/**
	 * 获取单条演员信息
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月23日上午11:39:00
	 * @param ac_id
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 *//*
	@RequestMapping(value = "/getActor", method = RequestMethod.GET)
	@ResponseBody
	public String getActorByID(String ac_id, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		Map<String, Object> actor = actorService.getActorByID(ac_id);

		return actor.toString();
	}

	*/
	/**
	 * 图片上传
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月22日下午2:17:06
	 * @param file：图片文件名
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	@ResponseBody
	public String uploadPictrue(
			@RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		JSONObject json = Utils.uplodPicture(file, "NationalityPicture");

		return json.toString();
	}

}
