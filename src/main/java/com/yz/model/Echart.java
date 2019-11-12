package com.yz.model;
/**
 * @author ZGD
 * @version 创建时间：2019年11月7日 下午3:11:06
 * 类说明：echarts统计类
 */
public class Echart {
	
	private String year;//统计的年份
	private String month;//统计的月份
	private Integer countForFilm1;//统计影视数据1
	private Integer countForFilm2;//统计影视数据2
	private String film_type;//统计的影视剧类型
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public Integer getCountForFilm1() {
		return countForFilm1;
	}
	public void setCountForFilm1(Integer countForFilm1) {
		this.countForFilm1 = countForFilm1;
	}
	public Integer getCountForFilm2() {
		return countForFilm2;
	}
	public void setCountForFilm2(Integer countForFilm2) {
		this.countForFilm2 = countForFilm2;
	}
	public String getFilm_type() {
		return film_type;
	}
	public void setFilm_type(String film_type) {
		this.film_type = film_type;
	}
	
	

}
