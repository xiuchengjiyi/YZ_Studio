package com.yz.model.dto;

import java.util.List;

import com.yz.model.Film;
import com.yz.model.Nationality;

/**
 * @author ZGD
 * @version 创建时间：2019年11月5日 下午2:50:03
 * 类说明
 */
public class ActorDTO {
	
	private String ac_id;//id
	private String ac_name;//姓名
	private String english_name;//英文名
	private String sex;//性别 0：女  1：男
	private String birthday;//出生日期
	private String birth_place;//出生地
	private String age;//年龄
	private String ac_picture;//图片存放路径
	private String is_delete;//0：正常 1：删除
	private String cre_time;
	private Integer page;
	private Integer limit;
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
	public String getEnglish_name() {
		return english_name;
	}
	public void setEnglish_name(String english_name) {
		this.english_name = english_name;
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
	public String getBirth_place() {
		return birth_place;
	}
	public void setBirth_place(String birth_place) {
		this.birth_place = birth_place;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
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
	public String getCre_time() {
		return cre_time;
	}
	public void setCre_time(String cre_time) {
		this.cre_time = cre_time;
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
