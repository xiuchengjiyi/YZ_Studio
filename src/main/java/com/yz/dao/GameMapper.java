package com.yz.dao;

import java.util.List;

import com.yz.model.Game;
import com.yz.model.dto.GameDTO;

/**
 * @author ZGD
 * @version 创建时间：2019年11月13日 上午9:40:10
 * 类说明
 */
public interface GameMapper {
	//查询比赛场次
	int getCount(GameDTO gameDTO);
	//查询所有比赛
	List<Game> getGames(GameDTO gameDTO);
	//新增比赛
	int insertGame(GameDTO gameDTO);
	//根据id查询比赛
	Game getGameById(String game_id);
	//更新比赛分数
	int updateGameScore(GameDTO gameDTO);

}
