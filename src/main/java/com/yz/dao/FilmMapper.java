package com.yz.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.alibaba.fastjson.JSONObject;
import com.yz.model.Film;
import com.yz.model.dto.FilmDTO;

/**
 * @author ZGD
 * @version 创建时间：2019年10月25日 下午2:57:41
 * 类说明
 */
public interface FilmMapper {

	//查询所有影视剧信息
	List<Film> selctAllFilms(FilmDTO filmDTO);
	//查询数量
	int getCount(FilmDTO filmDTO);
	//新增影视剧
	int insertFilm(Film film);
	//将主演插入演员电影关联表
	int insertFilmActor(@Param("film_id")String film_id, @Param("ac_id")String ac_id);
	//将制片地区插入制片地区电影关联表
	int insertFilmNationality(@Param("film_id")String film_id, @Param("nat_id")String nat_id);
	//根据id查询单条数据
	Film getFilmByID(String film_id);
	//根据id更新数据
	int updateFilmByID(Film film);
	//根据film_id获取更新前所有主演
	List<String> getAc_idByFilm_id(String film_id);
	//根据film_id删除该电影所有主演
	int deleteActorsByFilm_id(String film_id);
	//根据film_id获取更新前所有制片地区
	List<String> getNat_idByFilm_id(String film_id);
	//根据film_id删除该电影所有制片地区
	int deleteNatsByFilm_id(String film_id);
	//更新推荐字段
	int updateRecommend(FilmDTO filmDTO);
	//查询评分最高的10部影视作品
	List<Film> getTop10();

}
