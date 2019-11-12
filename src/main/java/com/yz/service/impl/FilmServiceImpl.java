package com.yz.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import sun.misc.BASE64Encoder;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yz.dao.FilmMapper;
import com.yz.model.Actor;
import com.yz.model.Film;
import com.yz.model.Nationality;
import com.yz.model.dto.FilmDTO;
import com.yz.service.FilmService;
import com.yz.utils.Utils;

/**
 * @author ZGD
 * @version 创建时间：2019年10月25日 下午2:57:07
 * 类说明
 */
@Service
public class FilmServiceImpl implements FilmService {
	
	@Autowired
	private FilmMapper filmMapper;

	/**
	 * 查询所有影视剧数据，并以layui的数据格式返回
	 */
	public JSONObject getAllFilms(FilmDTO filmDTO) {
		JSONObject json = new JSONObject();
		
		List<Film> films = selectAllFilms(filmDTO);
		JSONArray jsonArray = new JSONArray();
		
		for (int i = 0; i < films.size(); i++) {
			Film film = films.get(i);
			Map<String, Object> map = new HashMap<String, Object>();
			List<Actor> list = film.getActors();
			String actors = "";
			String nationalities = "";
			//遍历主演
			if(list != null){
				for (int j = 0; j < list.size(); j++) {
					if (j == 0) {
						actors += list.get(j).getAc_name();
					}else{
						actors += " / " + list.get(j).getAc_name();
					}
				}
			}
			//遍历制片地区
			map.put("actors", actors);
			List<Nationality> list2 = film.getNationalities();
			if (list2 != null) {
				for (int j = 0; j < list2.size(); j++) {
					String nationality = list2.get(j).getNationality();
					if("1".equals(list2.get(j).getNat_id())){
						nationality = "中国大陆";
					}
					if (j == 0) {
						nationalities += nationality;
					}else{
						nationalities += " / " + nationality;
					}
				}
			}
			map.put("nationalities", nationalities);
			map.put("film_id", film.getFilm_id());
			map.put("film_name", film.getFilm_name());
			map.put("film_english", film.getFilm_english());
			map.put("film_type", film.getFilm_type());
			map.put("run_date", film.getRun_date());
			map.put("start_date", film.getStart_date());
			map.put("end_date", film.getEnd_date());
			//处理票房
			String piaofang = film.getPiaofang();
			if(piaofang != null && !"".equals(piaofang)){
				if(piaofang.length()>=9){
					//票房过亿
					map.put("piaofang", Double.parseDouble(piaofang)/100000000);
					map.put("danwei", "Y");
				}else {
					//票房没过亿
					map.put("piaofang", Double.parseDouble(piaofang)/10000);
					map.put("danwei", "W");
				}
			}
			map.put("db_score", film.getDb_score());
			map.put("jishu", film.getJishu());
			map.put("recommend", film.getRecommend());
			map.put("is_cinema", film.getIs_cinema());
			//海报路径获取图片
			String post_path = film.getPost_path();
			map.put("post_path", post_path);
			map.put("post_picture", Utils.getPicture(post_path));
			//电影票路径获取图片
			String ticket_path = film.getTicket_path();
			map.put("ticket_path", ticket_path);
			map.put("ticket_picture", Utils.getPicture(ticket_path));
			
			jsonArray.add(map);
		}
		
		json.put("data", jsonArray);
		//获取数量
		int count = filmMapper.getCount(filmDTO);
		json.put("count", count);
		json.put("code", 0);
		json.put("msg", "");
		
		return json;
	}

	/**
	 * 查询所有影视剧数据
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月30日上午9:41:13
	 * @param filmDTO
	 * @param page
	 * @param limit
	 * @return
	 */
	private List<Film> selectAllFilms(FilmDTO filmDTO) {
		filmDTO.setPage(filmDTO.getPage()*filmDTO.getLimit()-filmDTO.getLimit());
		
		List<Film> films = filmMapper.selctAllFilms(filmDTO);
		return films;
	}
	
	
	/**
	 * 新增影视剧
	 */
	@Transactional
	public int insertFilm(Film film, String actor_ids, String place_ids,String danwei) {
		//生成随机ac_id
		String film_id = Utils.getOnlyID(film.getRun_date());
		film.setFilm_id(film_id);
		film.setIs_delete("0");
		//处理票房亿和万的问题
		String piaofang = film.getPiaofang();
		if(piaofang != null && !"".equals(piaofang)){
			if("Y".equals(danwei)){
				//单位为亿
				piaofang = String.valueOf(Double.parseDouble(piaofang)*100000000);
			}else if("W".equals(danwei)){
				//单位为万
				piaofang = String.valueOf(Double.parseDouble(piaofang)*10000);
			}
			film.setPiaofang(piaofang);
		}
		
		int count = filmMapper.insertFilm(film);
		if(count > 0){
			//将演员插入演员电影关联表
			String[] actors = actor_ids.split("/");
			for (int i = 0; i < actors.length; i++) {
				count = filmMapper.insertFilmActor(film_id,actors[i]);
			}
		}
		if(count > 0){
			//将制片地区插入制片地区电影关联表
			String[] nats = place_ids.split("/");
			for (int i = 0; i < nats.length; i++) {
				count = filmMapper.insertFilmNationality(film_id,nats[i]);
			}
		}
		return count;
	}

	
	/**
	 * 更新
	 */
	@Transactional
	public int editFilm(Film film, String actor_ids, String place_ids,String danwei) {
		//处理票房亿和万的问题
		String piaofang = film.getPiaofang();
		if(piaofang != null && !"".equals(piaofang)){
			if("Y".equals(danwei)){
				//单位为亿
				piaofang = String.valueOf(Double.parseDouble(piaofang)*100000000);
			}else if("W".equals(danwei)){
				//单位为万
				piaofang = String.valueOf(Double.parseDouble(piaofang)*10000);
			}
			film.setPiaofang(piaofang);
		}
		int count = filmMapper.updateFilmByID(film);
		if(count > 0 ){
			//根据film_id获取更新前所有主演
			List<String> oldActor_ids = filmMapper.getAc_idByFilm_id(film.getFilm_id());
			boolean is_ok = checkData(actor_ids,oldActor_ids);
			if (!is_ok) {
				//如果主演有改动，则先删除该电影所有主演，再新增新主演
				count = filmMapper.deleteActorsByFilm_id(film.getFilm_id());
					//将演员插入演员电影关联表
					String[] actors = actor_ids.split("/");
					for (int i = 0; i < actors.length; i++) {
						count = filmMapper.insertFilmActor(film.getFilm_id(),actors[i]);
					}
			}
			
			//根据film_id获取更新前所有主演
			List<String> oldNat_ids = filmMapper.getNat_idByFilm_id(film.getFilm_id());
			is_ok = checkData(place_ids,oldNat_ids);
			if (!is_ok) {
				//如果主演有改动，则先删除该电影所有主演，再新增新主演
				count = filmMapper.deleteNatsByFilm_id(film.getFilm_id());
					//将制片地区插入制片地区电影关联表
					String[] nats = place_ids.split("/");
					for (int i = 0; i < nats.length; i++) {
						count = filmMapper.insertFilmNationality(film.getFilm_id(),nats[i]);
					}
			}
			
		}
		return count;
	}

	

	/**
	 * 根据id查询单条数据
	 */
	public Map<String, Object> getFlimByID(String film_id) {
		Film film = filmMapper.getFilmByID(film_id);
		Map<String, Object> map = new HashMap<String, Object>();
		List<Actor> list = film.getActors();
		String actor_names = "";
		String actor_ids = "";
		String place_names = "";
		String place_ids = "";
		//遍历主演
		if(list != null){
			for (int j = 0; j < list.size(); j++) {
				if (j == 0) {
					actor_names += list.get(j).getAc_name();
					actor_ids += list.get(j).getAc_id();
				}else{
					actor_names += "/" + list.get(j).getAc_name();
					actor_ids += "/" + list.get(j).getAc_id();
				}
			}
		}
		map.put("actor_names", actor_names);
		map.put("actor_ids", actor_ids);
		//遍历制片地区
		List<Nationality> list2 = film.getNationalities();
		if (list2 != null) {
			for (int j = 0; j < list2.size(); j++) {
				if (j == 0) {
					place_names += list2.get(j).getNationality();
					place_ids += list2.get(j).getNat_id();
				}else{
					place_names += "/" + list2.get(j).getNationality();
					place_ids += "/" + list2.get(j).getNat_id();
				}
			}
		}
		map.put("place_names", place_names);
		map.put("place_ids", place_ids);
		map.put("film_id", film.getFilm_id());
		map.put("film_name", film.getFilm_name());
		map.put("film_english", film.getFilm_english());
		map.put("film_type", film.getFilm_type());
		map.put("run_date", film.getRun_date());
		map.put("start_date", film.getStart_date());
		map.put("end_date", film.getEnd_date());
		//处理票房
		String piaofang = film.getPiaofang();
		if(piaofang != null && !"".equals(piaofang)){
			if(piaofang.length()>=9){
				//票房过亿
				map.put("piaofang", Double.parseDouble(piaofang)/100000000);
				map.put("danwei", "Y");
			}else {
				//票房没过亿
				map.put("piaofang", Double.parseDouble(piaofang)/10000);
				map.put("danwei", "W");
			}
		}
		map.put("jishu", film.getJishu());
		map.put("db_score", film.getDb_score());
		map.put("recommend", film.getRecommend());
		map.put("is_cinema", film.getIs_cinema());
		//海报路径获取图片
		String post_path = film.getPost_path();
		map.put("post_path", post_path);
		map.put("post_picture", Utils.getPicture(post_path));
		//电影票路径获取图片
		String ticket_path = film.getTicket_path();
		map.put("ticket_path", ticket_path);
		map.put("ticket_picture", Utils.getPicture(ticket_path));
		return map;
	}
	
	//查询评分最高的10部影视作品
	public List<Film> getTop10() {
		List<Film> list2 = new ArrayList<Film>();
		List<Film> list = filmMapper.getTop10();
		for (int i = 0; i < list.size(); i++) {
			Film film = list.get(i);
			//海报路径获取图片
			String post_path = film.getPost_path();
			film.setPost_path(Utils.getPicture(post_path));
			list2.add(film);
		}
		return list2;
	}

	/**
	 * 更新推荐字段
	 */
	public int updateRecommend(FilmDTO filmDTO) {
		int code = filmMapper.updateRecommend(filmDTO);
		return code;
	}
	

	/**
	 * 判断两个集合是否相等
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月30日上午11:30:02
	 * @param actor_ids
	 * @param oldActor_ids
	 * @return
	 */
	private boolean checkData(String actor_ids, List<String> oldActor_ids) {
		String old = "";
		for (int i = 0; i < oldActor_ids.size(); i++) {
			old += oldActor_ids.get(i);
		}
		String[] split = actor_ids.split("/");
		List<String> newActor_ids = new ArrayList<String>();
		for (int i = 0; i < split.length; i++) {
			newActor_ids.add(split[i]);
		}
		newActor_ids.sort(new Comparator<String>() {
			public int compare(String o1, String o2) {
				return o1.compareTo(o2);
			}
		});
		String news = "";
		for (int i = 0; i < newActor_ids.size(); i++) {
			news += newActor_ids.get(i);
		}
		if(old.equals(news)){
			return true;
		}else{
			return false;
		}
		
		
	}

}
