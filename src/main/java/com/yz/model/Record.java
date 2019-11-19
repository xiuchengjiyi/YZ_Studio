package com.yz.model;
/**
 * @author ZGD
 * @version 创建时间：2019年11月15日 下午4:35:48
 * 类说明：战绩表
 */
public class Record {
	
	private String team_id;//球队id
	private String team_name;//球队名
	private String season;//赛季id
	private String branch;//分部
	private Integer win;//赢场数
	private Integer lost;//负场数
	private String win_rate;//胜率
	private String shengCha;//胜差
	public String getTeam_id() {
		return team_id;
	}
	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public Integer getWin() {
		return win;
	}
	public void setWin(Integer win) {
		this.win = win;
	}
	public Integer getLost() {
		return lost;
	}
	public void setLost(Integer lost) {
		this.lost = lost;
	}
	public String getWin_rate() {
		return win_rate;
	}
	public void setWin_rate(String win_rate) {
		this.win_rate = win_rate;
	}
	public String getShengCha() {
		return shengCha;
	}
	public void setShengCha(String shengCha) {
		this.shengCha = shengCha;
	}
	public String getSeason() {
		return season;
	}
	public void setSeason(String season) {
		this.season = season;
	}
	public String getBranch() {
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
	}
	
	

}
