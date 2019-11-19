package com.yz.model.dto;

import com.yz.model.Team;

/**
 * @author ZGD
 * @version 创建时间：2019年11月12日 下午2:30:17
 * 类说明：球队model类
 */
public class GameDTO {

	private String game_id;//比赛id
	private String game_date;//比赛时间
	private String game_type;//比赛类型1：常规赛2：季后赛3：季前赛
	private String season;
	private String home_team;//主队id
	private String away_team;//客队id
	private Integer home_score;//主队得分
	private Integer away_score;//客队得分
	private String win_team;//获胜球队id
	private String select_team;//查询的球队id
	private Integer page;//
	private Integer limit;
	public String getGame_id() {
		return game_id;
	}
	public void setGame_id(String game_id) {
		this.game_id = game_id;
	}
	public String getGame_date() {
		return game_date;
	}
	public void setGame_date(String game_date) {
		this.game_date = game_date;
	}
	public String getGame_type() {
		return game_type;
	}
	public void setGame_type(String game_type) {
		this.game_type = game_type;
	}
	public String getSeason() {
		return season;
	}
	public void setSeason(String season) {
		this.season = season;
	}
	public String getHome_team() {
		return home_team;
	}
	public void setHome_team(String home_team) {
		this.home_team = home_team;
	}
	public String getAway_team() {
		return away_team;
	}
	public void setAway_team(String away_team) {
		this.away_team = away_team;
	}
	public Integer getHome_score() {
		return home_score;
	}
	public void setHome_score(Integer home_score) {
		this.home_score = home_score;
	}
	public Integer getAway_score() {
		return away_score;
	}
	public void setAway_score(Integer away_score) {
		this.away_score = away_score;
	}
	public String getWin_team() {
		return win_team;
	}
	public void setWin_team(String win_team) {
		this.win_team = win_team;
	}
	public String getSelect_team() {
		return select_team;
	}
	public void setSelect_team(String select_team) {
		this.select_team = select_team;
	}
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getLimit() {
		return limit;
	}
	public void setLimit(Integer limit) {
		this.limit = limit;
	}
	
	
	
}
