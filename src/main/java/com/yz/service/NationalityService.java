package com.yz.service;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.yz.model.Nationality;

/**
 * @author ZGD
 * @version 创建时间：2019年10月23日 下午3:03:05
 * 类说明:国家及地区
 */
public interface NationalityService {
	//查询所有数据
	JSONObject selectAll(Integer page, Integer limit);
	List<Nationality> getAll(Integer page, Integer limit);
	//根据id查询单条数据
	Map<String, Object> getNationalityByID(String nat_id);
	//新增
	int insertNationality(Nationality nationality);
	//更加id更新信息
	int editNationality(Nationality nationality);

}
