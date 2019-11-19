package com.yz.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yz.dao.GameMapper;
import com.yz.model.Game;
import com.yz.model.Team;
import com.yz.model.dto.GameDTO;
import com.yz.service.GameService;
import com.yz.service.RecordService;
import com.yz.utils.Utils;

/**
 * @author ZGD
 * @version 创建时间：2019年11月13日 上午9:22:00 类说明
 */
@Service
public class GameServiceImpl implements GameService {
	
	@Autowired
	private GameMapper gameMapper;
	@Autowired
	private RecordService recordService;

	public JSONObject getGameList(GameDTO gameDTO) {
		
		JSONObject json = new JSONObject();
		List<Game> games = getGames(gameDTO);
		// 查出所有数据遍历
		JSONArray jsonArray = new JSONArray();
		for (int i = 0; i < games.size(); i++) {
			Game game = games.get(i);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("game_id", game.getGame_id());
			String game_date = game.getGame_date();
			//根据比赛时间判断状态
			String status = getGameStatus(game_date);
			map.put("status", status);
			
			map.put("game_date", game_date);
			map.put("game_type", game.getGame_type());
			map.put("home_score", game.getHome_score());
			map.put("away_score", game.getAway_score());
			map.put("home_team_id", game.getHome_team().getTeam_id());
			map.put("home_team_name", game.getHome_team().getTeam_name());
			// 图片路径获取图片
			String photo_path = game.getHome_team().getPhoto_path();
			map.put("home_team_photo", Utils.getPicture(photo_path));
			map.put("away_team_id", game.getAway_team().getTeam_id());
			map.put("away_team_name", game.getAway_team().getTeam_name());
			// 图片路径获取图片
			photo_path = game.getAway_team().getPhoto_path();
			map.put("away_team_photo", Utils.getPicture(photo_path));
			if (game.getWin_team() != null) {
				map.put("win_team_id", game.getWin_team().getTeam_id());
				map.put("win_team_name", game.getWin_team().getTeam_name());
				// 图片路径获取图片
				photo_path = game.getWin_team().getPhoto_path();
				map.put("win_team_photo", Utils.getPicture(photo_path));
			}
			map.put("season_id", game.getSeason().getSeason_id());
			map.put("season", game.getSeason().getSeason());

			jsonArray.add(map);

		}
		json.put("data", jsonArray);

		int count = gameMapper.getCount(gameDTO);
		json.put("count", count);
		json.put("code", 0);
		json.put("msg", "");
		return json;
	}
	
	/**
	 * 查询比赛信息
	 */
	public List<Game> getGames(GameDTO gameDTO) {
		Integer page = gameDTO.getPage();
		Integer limit = gameDTO.getLimit();
		if (page != null && limit != null) {
			gameDTO.setPage(page*limit-limit);
		}
		List<Game> list = gameMapper.getGames(gameDTO);
		return list;
	}
	/**
	 * 新增比赛
	 */
	@Transactional
	public int insertGame(GameDTO gameDTO) {
		Integer home_score = gameDTO.getHome_score();
		Integer away_score = gameDTO.getAway_score();
		if (home_score != null && away_score != null) {
			if (home_score > away_score) {//主队获胜
				gameDTO.setWin_team(gameDTO.getHome_team());
			}else{//客队队获胜
				gameDTO.setWin_team(gameDTO.getAway_team());
			}
		}
		String game_id = Utils.getGameID(gameDTO);
		gameDTO.setGame_id(game_id);
		
		int code = gameMapper.insertGame(gameDTO);
		
		//如果有比分，则修改战绩表
		if (gameDTO.getAway_score() != null && gameDTO.getHome_score() != null) {
			code = recordService.insertOrUpdateRecord(gameDTO);
		}
		
		return code;
	}
	
	
	//更新比赛分数
	@Transactional
	public int updateGameScore(GameDTO gameDTO) {
		Integer home_score = gameDTO.getHome_score();
		Integer away_score = gameDTO.getAway_score();
		if (home_score != null && away_score != null) {
			if (home_score > away_score) {//主队获胜
				gameDTO.setWin_team(gameDTO.getHome_team());
			}else{//客队队获胜
				gameDTO.setWin_team(gameDTO.getAway_team());
			}
		}
		int code = gameMapper.updateGameScore(gameDTO);
		code = recordService.insertOrUpdateRecord(gameDTO);
		return code;
	}
	//根据id查询比赛
	public Map<String, Object> getGameById(String game_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		Game game = gameMapper.getGameById(game_id);
		map.put("game_id", game.getGame_id());
		map.put("game_date", game.getGame_date());
		map.put("game_type", game.getGame_type());
		map.put("home_score", game.getHome_score());
		map.put("away_score", game.getAway_score());
		map.put("home_team_id", game.getHome_team().getTeam_id());
		map.put("home_team_name", game.getHome_team().getTeam_name());
		// 图片路径获取图片
		String photo_path = game.getHome_team().getPhoto_path();
		map.put("home_team_photo", Utils.getPicture(photo_path));
		map.put("away_team_id", game.getAway_team().getTeam_id());
		map.put("away_team_name", game.getAway_team().getTeam_name());
		// 图片路径获取图片
		photo_path = game.getAway_team().getPhoto_path();
		map.put("away_team_photo", Utils.getPicture(photo_path));
		if (game.getWin_team() != null) {
			map.put("win_team_id", game.getWin_team().getTeam_id());
			map.put("win_team_name", game.getWin_team().getTeam_name());
			// 图片路径获取图片
			photo_path = game.getWin_team().getPhoto_path();
			map.put("win_team_photo", Utils.getPicture(photo_path));
		}
		map.put("season_id", game.getSeason().getSeason_id());
		map.put("season", game.getSeason().getSeason());
		return map;
	}
	
	//根据比赛时间判断比赛状态
	private String getGameStatus(String game_date) {
		String status = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		//开始前10分钟之前为未开始，开始前10分钟为即将开始，比赛开始至之后2小时30分钟为进行中，之后为已结束
		Calendar calendar = Calendar.getInstance();
		try {
			calendar.setTime(sdf.parse(game_date));
			Date time1 = calendar.getTime();
			int code1 = now.compareTo(time1);
			calendar.add(Calendar.MINUTE, -10);//比赛时间前10分钟
			Date time2 = calendar.getTime();
			int code2 = now.compareTo(time2);
			calendar.add(Calendar.MINUTE, 160);//比赛时间前10分钟
			Date time3 = calendar.getTime();
			int code3 = now.compareTo(time3);
			if(code2<0){
				status = "未开始";
			}else if(code2 >= 0 && code1 < 0){
				status = "即将开始";
			}else if(code1 >= 0 && code3 < 0){
				status = "进行中";
			}else if(code3 >= 0){
				status = "已结束";
			}
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return status;
	}

}
