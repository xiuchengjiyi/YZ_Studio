package com.yz.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yz.model.Nationality;

/**
 * @author ZGD
 * @version 创建时间：2019年10月23日 下午3:05:34
 * 类说明
 */
public interface NationalityMapper {
	//查询所有数据
	List<Nationality> selectAll(@Param("page")Integer page, @Param("limit")Integer limit);
	//查询数量
	int selectCount();
	//新增
	int insertNationality(Nationality nationality);
	//根据id查询单条数据
	Nationality getNationalityByID(String nat_id);
	//根据id更新信息
	int updateNationality(Nationality nationality);
	//影视剧查询关联制片地区
	List<Nationality> selectNationalityForFilm();
}
