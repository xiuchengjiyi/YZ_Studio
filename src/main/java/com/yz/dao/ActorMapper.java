package com.yz.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yz.model.Actor;
import com.yz.model.dto.ActorDTO;

/**
 * @author ZGD
 * @version 创建时间：2019年9月6日 上午8:18:23
 * 类说明
 */
public interface ActorMapper {
	//查询所有演员信息
	List<Actor> selectActorList(ActorDTO actorDTO);
	//查询演员数
	int selectActorCount(ActorDTO actorDTO);
	//新增演员
	int insertActor(Actor actor);
	//根据id查询演员信息
	Actor getActorByID(String ac_id);
	//根据id更新演员信息
	int updateActorById(Actor actor);
	//根据id将演员更新为删除状态
	int deleteActorById(String ac_id);
	//影视剧查询关联演员
	List<Actor> selectActorForFilm();
	//判断是否有重复演员插入
	List<Actor> checkActor(@Param("ac_name")String ac_name);
	//根据id获取演员信息包括作品
	Actor getActorWithFilmByID(String ac_id);

}
