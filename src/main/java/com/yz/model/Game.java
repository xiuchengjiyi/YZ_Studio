package com.yz.model;


/**
 * @author ZGD
 * @version 创建时间：2019年11月12日 下午2:30:17
 * 类说明：球队model类
 */
public class Game {

	private String game_id;//比赛id
	private String game_date;//比赛时间
	private String game_type;//比赛类型1：常规赛2：季后赛3：季前赛
	private Season season;//赛季
	private Team home_team;//主队id
	private Team away_team;//客队id
	private Team win_team;//获胜id
	private Integer home_score;//主队得分
	private Integer away_score;//客队得分
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
	public Season getSeason() {
		return season;
	}
	public void setSeason(Season season) {
		this.season = season;
	}
	public Team getHome_team() {
		return home_team;
	}
	public void setHome_team(Team home_team) {
		this.home_team = home_team;
	}
	public Team getAway_team() {
		return away_team;
	}
	public void setAway_team(Team away_team) {
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
	public Team getWin_team() {
		return win_team;
	}
	public void setWin_team(Team win_team) {
		this.win_team = win_team;
	}
	
	
	
}
