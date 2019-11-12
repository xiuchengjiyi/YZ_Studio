package com.yz.web;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.List;
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
import com.mysql.fabric.xmlrpc.base.Data;
import com.yz.model.Actor;
import com.yz.model.Nationality;
import com.yz.model.dto.ActorDTO;
import com.yz.service.ActorService;
import com.yz.service.NationalityService;
import com.yz.utils.Utils;

/**
 * @author ZGD
 * @version 创建时间：2019年9月5日 下午3:09:52 类说明
 */
@Controller
@RequestMapping("/actor")
public class ActorController {

	@Autowired
	private ActorService actorService;
	@Autowired
	private NationalityService nationalityService;

	@RequestMapping(value = "/{path}", method = RequestMethod.GET)
	public String goPage(@PathVariable String path,Model model) {
		//获取所有制片地区和演员
		List<Nationality> nationalitys = nationalityService.getAll(0,100);
		model.addAttribute("nationalitys", nationalitys);
		return "/actor/" + path;
	}

	/**
	 * 前往新增/编辑演员信息页面
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月23日上午11:36:18
	 * @param model
	 * @param ac_id
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/addActor", method = RequestMethod.GET)
	public String goAddActor(Model model, String ac_id,
			HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		if (ac_id != null && !"".equals(ac_id)) {
			//ac_id不为空则为前往编辑页面，查询该演员信息传到页面
			Map<String, Object> actor = actorService.getActorByID(ac_id);

			model.addAttribute("actor",actor);
			model.addAttribute("flag","edit");
		}else{
			model.addAttribute("flag","insert");
		}
		
		List<Nationality> nationalitys = nationalityService.getAll(0,100);
		model.addAttribute("nationalitys", nationalitys);
		
		return "/actor/addActor";
	}

	/**
	 * 查询所有演员信息
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月23日上午11:38:08
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/actors", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String getActors(HttpServletRequest request,
			HttpServletResponse response, ActorDTO actorDTO) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		JSONObject actorList = actorService.getActorList(actorDTO);
		
		return actorList.toString();
	}

	/**
	 * 新增演员信息
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月23日上午11:38:34
	 * @param actor
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/insertActor", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String addActor(Actor actor, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		int code = actorService.insertActor(actor);
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
	 * 更新演员信息
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月23日上午11:39:34
	 * @param actor
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/editActor", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String editActor(Actor actor, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		int code = actorService.editActor(actor);
		
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
	
	@RequestMapping(value = "/deleteActor", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String deleteActor(String ac_id, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		int code = actorService.deleteActorById(ac_id);
		
		JSONObject json = new JSONObject();
		if (code != 0) {
			json.put("code", code);
			json.put("message", "删除成功！");
		}else{
			json.put("code", code);
			json.put("message", "删除失败！");
		}
		

		return json.toString();
	}

	/**
	 * 获取单条演员信息
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月23日上午11:39:00
	 * @param ac_id
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
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
	
	/**
	 * 前往演员详情页面
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年11月5日上午10:04:01
	 * @param ac_id
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/actorDetail", method = RequestMethod.GET,produces = "text/html;charset=UTF-8")
	public String actorDetail(Model model,String ac_id, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		//获取该演员详细信息
		Actor actor = actorService.getActorDetail(ac_id);
		
		model.addAttribute("actor", actor);

		return "/actor/actorDetail";
	}
	
	/**
	 * 检查是否有相同数据存在
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月30日下午3:28:00
	 * @param ac_name
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/checkActor", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String checkActor(String ac_name, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		JSONObject json = actorService.checkActor(ac_name);

		return json.toString();
	}

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

		JSONObject json = Utils.uplodPicture(file, "ActorPicture");

		return json.toString();
	}

}
