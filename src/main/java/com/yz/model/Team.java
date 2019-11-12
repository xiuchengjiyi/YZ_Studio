package com.yz.model;
/**
 * @author ZGD
 * @version 创建时间：2019年11月12日 下午2:30:17
 * 类说明：球队model类
 */
public class Team {

	private Integer team_id;//球队id
	private String team_name;//球队名
	private String english_name;//英文名
	private String location_city;//所在城市
	private String branch;//所属分部 1:东部2：西部
	private String area;//赛区1：西南2：西北3：太平洋4：东南5：中部6：大西洋
	private String photo_path;//队标存放路径
	private Integer page;//
	private Integer limit;
	public Integer getTeam_id() {
		return team_id;
	}
	public void setTeam_id(Integer team_id) {
		this.team_id = team_id;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getEnglish_name() {
		return english_name;
	}
	public void setEnglish_name(String english_name) {
		this.english_name = english_name;
	}
	public String getLocation_city() {
		return location_city;
	}
	public void setLocation_city(String location_city) {
		this.location_city = location_city;
	}
	public String getBranch() {
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getPhoto_path() {
		return photo_path;
	}
	public void setPhoto_path(String photo_path) {
		this.photo_path = photo_path;
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
