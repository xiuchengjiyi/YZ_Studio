package com.yz.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sun.misc.BASE64Encoder;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yz.dao.ActorMapper;
import com.yz.model.Actor;
import com.yz.model.Film;
import com.yz.model.dto.ActorDTO;
import com.yz.service.ActorService;
import com.yz.utils.Utils;

/**
 * @author ZGD
 * @version 创建时间：2019年9月6日 上午8:51:20
 * 类说明
 */
@Service
public class ActorServiceImpl implements ActorService {
	@Autowired
	private ActorMapper actorMapper;
	
	public JSONObject getActorList(ActorDTO actorDTO) {
		JSONObject jsonObject = new JSONObject();
		List<Actor> list = getAll(actorDTO);
		byte[] data = null;
		//查出所有数据遍历
		JSONArray jsonArray = new JSONArray();
		for (int i = 0; i < list.size(); i++) {
			Actor actor = list.get(i);
			Map<String, Object> actors = new HashMap<String, Object>();
			actors.put("ac_id", actor.getAc_id());
			actors.put("ac_name", actor.getAc_name());
			actors.put("english_name", actor.getEnglish_name());
			actors.put("sex", actor.getSex());
			actors.put("birthday", actor.getBirthday());
			actors.put("birth_place", actor.getNationality().getNationality());
			actors.put("age", Utils.getAge(actor.getBirthday()));
			//图片路径获取图片
			String ac_picture = actor.getAc_picture();
			actors.put("ac_picture", Utils.getPicture(ac_picture));
			actors.put("count", actor.getCount());
			actors.put("avg_score", actor.getAvg_score());
			
			jsonArray.add(actors);
			
		}
		jsonObject.put("data", jsonArray);
		int count = actorMapper.selectActorCount(actorDTO);
		jsonObject.put("count", count);
		jsonObject.put("code", 0);
		jsonObject.put("msg", "");
		
		return jsonObject;
	}
	
	
	/**
	 * 
	 */
	public List<Actor> getAll(ActorDTO actorDTO) {
		Integer page = actorDTO.getPage();
		Integer limit = actorDTO.getLimit();
		if(page != null && limit != null){
			actorDTO.setPage(page*limit-limit);
		}
		
		List<Actor> list = actorMapper.selectActorList(actorDTO);
		return list;
	}



	/**
	 * 新增演员
	 */
	public int insertActor(Actor actor) {
		//生成随机ac_id
		String ac_id = Utils.getOnlyID(actor.getBirthday());
		actor.setAc_id(ac_id);
		//根据生日算年龄
		String age = Utils.getAge(actor.getBirthday());
		actor.setAge(age);
		actor.setIs_delete("0");
		
		
		int code =  actorMapper.insertActor(actor);
		return code;
	}
	
	
	/**
	 * 根据id更新演员信息
	 */
	public int editActor(Actor actor) {
		//根据生日算年龄
		String age = Utils.getAge(actor.getBirthday());
		actor.setAge(age);
		int code = actorMapper.updateActorById(actor);
		return code;
	}
	
	/**
	 * 根据id将演员更新为删除状态
	 */
	public int deleteActorById(String ac_id) {
		int code = actorMapper.deleteActorById(ac_id);
		return code;
	}

	/**
	 * 根据id查询演员信息
	 */
	public Map<String, Object> getActorByID(String ac_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		Actor actor = actorMapper.getActorByID(ac_id);
		
		map.put("ac_id", actor.getAc_id());
		map.put("ac_name", actor.getAc_name());
		map.put("english_name", actor.getEnglish_name());
		map.put("sex", actor.getSex());
		map.put("birthday", actor.getBirthday());
		map.put("birth_place", actor.getNationality().getNat_id());
		map.put("age", Utils.getAge(actor.getBirthday()));
		//图片路径获取图片
		String ac_picture = actor.getAc_picture();
		map.put("ac_picture", Utils.getPicture(ac_picture));
		map.put("ac_picture_path", ac_picture);
		
		return map;
	}
	
	/**
	 * 根据id获取演员信息包括作品
	 */
	public Actor getActorDetail(String ac_id) {
		Actor actor = actorMapper.getActorWithFilmByID(ac_id);
		//图片路径获取图片
		String ac_picture = actor.getAc_picture();
		actor.setAc_picture(Utils.getPicture(ac_picture));
		List<Film> newFilms = new ArrayList<Film>();
		List<Film> films = actor.getFilms();
		for (int i = 0; i < films.size(); i++) {
			Film film = films.get(i);
			String post_path = film.getPost_path();
			film.setPost_path(Utils.getPicture(post_path));
			newFilms.add(film);
		}
		actor.setFilms(newFilms);
		actor.setAge(Utils.getAge(actor.getBirthday()));
		return actor;
	}


	/**
	 * 判断是否有重复演员插入
	 */
	public JSONObject checkActor(String ac_name) {
		JSONObject json = new JSONObject();
		List<Actor> list = actorMapper.checkActor(ac_name);
		if (list.size() > 0) {
			String message = "";
			json.put("code", "1");
			for (int i = 0; i < list.size(); i++) {
				if (i == 0) {
					message += list.get(i).getAc_name();
				}else {
					message += "、"+list.get(i).getAc_name();
				}
			}
			json.put("message", message);
		}
		return json;
	}

	

}
