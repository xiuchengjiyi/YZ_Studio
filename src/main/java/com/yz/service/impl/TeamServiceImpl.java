package com.yz.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yz.dao.TeamMapper;
import com.yz.model.Actor;
import com.yz.model.Team;
import com.yz.service.TeamService;
import com.yz.utils.Utils;

/**
 * @author ZGD
 * @version 创建时间：2019年11月12日 下午2:29:11
 * 类说明
 */
@Service
public class TeamServiceImpl implements TeamService {
	
	@Autowired
	private TeamMapper teamMapper;

	//查询所有球队信息并以json格式返回
	public JSONObject getTeamList(Team team) {
		JSONObject json = new JSONObject();
		List<Team> teams = getTeams(team);
		//查出所有数据遍历
		JSONArray jsonArray = new JSONArray();
		for (int i = 0; i < teams.size(); i++) {
			Team team2 = teams.get(i);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("team_id", team2.getTeam_id());
			map.put("team_name", team2.getTeam_name());
			map.put("english_name", team2.getEnglish_name());
			map.put("location_city", team2.getLocation_city());
			map.put("branch", team2.getBranch());
			map.put("area", team2.getArea());
			//图片路径获取图片
			String photo_path = team2.getPhoto_path();
			map.put("photo", Utils.getPicture(photo_path));
			
			jsonArray.add(map);
			
		}
		json.put("data", jsonArray);
		
		int count = teamMapper.getCount(team);
		json.put("count", count);
		json.put("code", 0);
		json.put("msg", "");
		return json;
	}

	public List<Team> getTeams(Team team) {
		Integer page = team.getPage();
		Integer limit = team.getLimit();
		if (page != null && limit != null) {
			team.setPage(page*limit-limit);
		}
		List<Team> teams = teamMapper.getTeams(team);
		return teams;
	}

	//新增球队
	public int insertTeam(Team team) {
		int code = teamMapper.insertTeam(team);
		return code;
	}
	
	
	

}
