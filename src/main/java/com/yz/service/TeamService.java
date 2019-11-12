package com.yz.service;

import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.yz.model.Team;

/**
 * @author ZGD
 * @version 创建时间：2019年11月12日 下午2:28:08
 * 类说明:球队service类
 */
public interface TeamService {

	//查询所有球队信息并以json格式返回
	JSONObject getTeamList(Team team);
	//查询所有球队信息
	List<Team> getTeams(Team team);
	//新增球队
	int insertTeam(Team team);
	
	

}
