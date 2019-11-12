package com.yz.service;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.yz.model.Film;
import com.yz.model.dto.FilmDTO;

/**
 * @author ZGD
 * @version 创建时间：2019年10月25日 下午2:56:26
 * 类说明
 */
public interface FilmService {

	//获取所有影视剧信息，并返回layui所要的参数格式
	JSONObject getAllFilms(FilmDTO filmDTO);
	//根据id查询条数据
	Map<String, Object> getFlimByID(String film_id);
	//新增影视剧
	int insertFilm(Film film, String actor_ids, String place_ids, String danwei);
	//更新影视剧
	int editFilm(Film film, String actor_ids, String place_ids,String danwei);
	//更新推荐字段
	int updateRecommend(FilmDTO filmDTO);
	//查询评分最高的10部影视作品
	List<Film> getTop10();

}
