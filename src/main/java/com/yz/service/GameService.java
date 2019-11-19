package com.yz.service;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.yz.model.Game;
import com.yz.model.dto.GameDTO;

/**
 * @author ZGD
 * @version 创建时间：2019年11月13日 上午9:17:55
 * 类说明
 */
public interface GameService {
	//获取比赛信息返回json
	JSONObject getGameList(GameDTO gameDTO);
	//查询所有比赛
	List<Game> getGames(GameDTO gameDTO);
	//新增比赛
	int insertGame(GameDTO gameDTO);
	//根据id查询比赛
	Map<String, Object> getGameById(String game_id);
	//更新比赛分数
	int updateGameScore(GameDTO gameDTO);

}
