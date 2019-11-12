package com.yz.web;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.yz.model.Actor;
import com.yz.model.Film;
import com.yz.model.Nationality;
import com.yz.model.dto.ActorDTO;
import com.yz.model.dto.FilmDTO;
import com.yz.service.ActorService;
import com.yz.service.FilmService;
import com.yz.service.NationalityService;
import com.yz.utils.Utils;

/**
 * @author ZGD
 * @version 创建时间：2019年9月5日 下午3:09:38 类说明
 */
@Controller
@RequestMapping("/film")
public class FilmController {
	
	@Autowired
	private FilmService filmService;
	@Autowired
	private NationalityService nationalityService;
	@Autowired
	private ActorService actorService;

	@RequestMapping(value = "/{path}", method = RequestMethod.GET)
	public String goPage(@PathVariable String path,Model model, String film_id,
			HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		if (film_id != null && !"".equals(film_id)) {
			//ac_id不为空则为前往编辑页面，查询该演员信息传到页面
			Map<String, Object> film = filmService.getFlimByID(film_id);

			model.addAttribute("film",film);
			model.addAttribute("flag","edit");
		}else{
			model.addAttribute("flag","insert");
		}
		//获取所有制片地区和演员
		List<Nationality> nationalitys = nationalityService.getAll(0,100);
		List<Actor> actors = actorService.getAll(new ActorDTO());
		model.addAttribute("nationalitys", nationalitys);
		model.addAttribute("actors", actors);
		
		return "/film/" + path;
	}

	@RequestMapping(value = "/films", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String getFilmList(Model model,FilmDTO filmDTO, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		
		JSONObject json = filmService.getAllFilms(filmDTO);
		
		//获取所有制片地区和演员
		List<Nationality> nationalitys = nationalityService.getAll(0,100);
		
		List<Actor> actors = actorService.getAll(new ActorDTO());
		model.addAttribute("nationalitys", nationalitys);
		model.addAttribute("actors", actors);

		return json.toString();

	}
	
	/**
	 * 前往新增/编辑页面
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月29日下午4:37:27
	 * @param model
	 * @param film_id
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	/*@RequestMapping(value = "/addMovie", method = RequestMethod.GET)
	public String goAddActor(Model model, String film_id,
			HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		if (film_id != null && !"".equals(film_id)) {
			//ac_id不为空则为前往编辑页面，查询该演员信息传到页面
			Map<String, Object> film = filmService.getFlimByID(film_id);

			model.addAttribute("film",film);
			model.addAttribute("flag","edit");
		}else{
			model.addAttribute("flag","insert");
		}
		//获取所有制片地区和演员
		List<Nationality> nationalitys = nationalityService.getAll(0,100);
		List<Actor> actors = actorService.getAll(0,10000);
		model.addAttribute("nationalitys", nationalitys);
		model.addAttribute("actors", actors);
		
		return "/film/addMovie";
	}*/
	
	/**
	 * 新增影视剧
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月29日下午4:36:45
	 * @param film：主体
	 * @param actor_ids：主演id
	 * @param place_ids：制片地区id
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/insertFilm", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String addActor(Film film, String actor_ids, String place_ids, String danwei, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		int code = filmService.insertFilm(film,actor_ids,place_ids,danwei);
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
	 * 更新影视剧
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月30日上午10:29:23
	 * @param film
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/editFilm", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String editFilm(Film film, String actor_ids, String place_ids,String danwei, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		int code = filmService.editFilm(film,actor_ids,place_ids,danwei);
		
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
	
	/**
	 * 更新推荐字段
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年11月4日下午2:07:19
	 * @param filmDTO
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/updateRecommend", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String updateRecommend(FilmDTO filmDTO, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		// 解决中文乱码问题
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		int code = filmService.updateRecommend(filmDTO);
		
		return null;
	}
	

	
	
	/**
	 * 影视海报上传
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月29日下午4:25:59
	 * @param file
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

		JSONObject json = Utils.uplodPicture(file, "FilmPicture");

		return json.toString();
	}
}
