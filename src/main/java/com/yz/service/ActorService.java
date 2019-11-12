package com.yz.service;


import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.yz.model.Actor;
import com.yz.model.dto.ActorDTO;



/**
 * @author ZGD
 * @version 创建时间：2019年9月6日 上午8:45:34
 * 类说明
 */
public interface ActorService {
	//查询所有演员
	JSONObject getActorList(ActorDTO actorDTO);
	//新增演员
	int insertActor(Actor actor);
	//根据id更新演员信息
	int editActor(Actor actor);
	//根据id查询演员信息
	Map<String, Object> getActorByID(String ac_id);
	//根据id将演员更新为删除状态
	int deleteActorById(String ac_id);
	//查询所有演员
	List<Actor> getAll(ActorDTO actorDTO);
	//判断是否有重复演员插入
	JSONObject checkActor(String ac_name);
	//根据id获取演员信息包括作品
	Actor getActorDetail(String ac_id);

}
