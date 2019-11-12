package com.yz.dao;

import java.util.List;

import com.yz.model.Team;

/**
 * @author ZGD
 * @version 创建时间：2019年11月12日 下午2:29:52
 * 类说明
 */
public interface TeamMapper {
	//根据条件查询所有球队信息
	List<Team> getTeams(Team team);
	//根据条件查询球队数
	int getCount(Team team);
	//新增球队
	int insertTeam(Team team);


}
