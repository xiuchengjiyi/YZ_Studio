package com.yz.model.dto;
/**
 * @author ZGD
 * @version 创建时间：2019年11月8日 下午1:36:19
 * 类说明：统计类
 */
public class TotalDTO {
	
	private Integer totalFilm;//总影视数
	private Integer totalMovie;//总电影数
	private Integer totalTV;//总电视剧数
	private Integer totalActor;//总演员数
	private String team_id;//统计战绩：球队id
	private String team_name;//统计战绩：球队名
	private Integer countGame;//统计战绩数
	
	public Integer getTotalFilm() {
		return totalFilm;
	}
	public void setTotalFilm(Integer totalFilm) {
		this.totalFilm = totalFilm;
	}
	public Integer getTotalMovie() {
		return totalMovie;
	}
	public void setTotalMovie(Integer totalMovie) {
		this.totalMovie = totalMovie;
	}
	public Integer getTotalTV() {
		return totalTV;
	}
	public void setTotalTV(Integer totalTV) {
		this.totalTV = totalTV;
	}
	public Integer getTotalActor() {
		return totalActor;
	}
	public void setTotalActor(Integer totalActor) {
		this.totalActor = totalActor;
	}
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
	public Integer getCountGame() {
		return countGame;
	}
	public void setCountGame(Integer countGame) {
		this.countGame = countGame;
	}
	
	

}
