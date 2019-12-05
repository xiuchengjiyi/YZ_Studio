package com.yz.model;

import java.util.List;

/**
 * @author ZGD
 * @version 创建时间：2019年9月5日 下午3:53:33
 * 类说明
 */
public class Actor {
	
	private String ac_id;//id
	private String ac_name;//姓名
	private String english_name;//英文名
	private String sex;//性别 0：女  1：男
	private String birthday;//出生日期
	private String birth_place;//出生地
	private Nationality nationality;
	private String age;//年龄
	private String ac_picture;//图片存放路径
	private String is_delete;//0：正常 1：删除
	private String cre_time;
	private List<Film> films;//参演作品
	private Integer count;//作品数
	private String avg_score;//作品豆瓣平均分
	
	public String getAc_id() {
		return ac_id;
	}
	public void setAc_id(String ac_id) {
		this.ac_id = ac_id;
	}
	public String getAc_name() {
		return ac_name;
	}
	public void setAc_name(String ac_name) {
		this.ac_name = ac_name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getEnglish_name() {
		return english_name;
	}
	public void setEnglish_name(String english_name) {
		this.english_name = english_name;
	}
	public String getBirth_place() {
		return birth_place;
	}
	public void setBirth_place(String birth_place) {
		this.birth_place = birth_place;
	}
	public String getAc_picture() {
		return ac_picture;
	}
	public void setAc_picture(String ac_picture) {
		this.ac_picture = ac_picture;
	}
	public String getIs_delete() {
		return is_delete;
	}
	public void setIs_delete(String is_delete) {
		this.is_delete = is_delete;
	}
	public Nationality getNationality() {
		return nationality;
	}
	public void setNationality(Nationality nationality) {
		this.nationality = nationality;
	}
	public String getCre_time() {
		return cre_time;
	}
	public void setCre_time(String cre_time) {
		this.cre_time = cre_time;
	}
	public List<Film> getFilms() {
		return films;
	}
	public void setFilms(List<Film> films) {
		this.films = films;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public String getAvg_score() {
		return avg_score;
	}
	public void setAvg_score(String avg_score) {
		this.avg_score = avg_score;
	}

}
