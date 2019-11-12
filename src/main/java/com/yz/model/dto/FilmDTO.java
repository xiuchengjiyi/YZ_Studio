package com.yz.model.dto;

/**
 * @author ZGD
 * @version 创建时间：2019年11月4日 上午8:50:19
 * 类说明
 */
public class FilmDTO {
	
	private String film_id;//影视剧id
	private String film_name;//影视剧名
	private String film_english;//英文名
	private String film_type;//1：电影 2：电视剧
	private String run_date;//上映日期
	private String start_date;//开始看日期
	private String end_date;//看完日期
	private String post_path;//海报存放路径
	private String jishu;//集数（针对电视剧）
	private String piaofang;//票房（针对电影）
	private String db_score;//豆瓣评分
	private String recommend;//1：推荐 2:不推荐
	private String is_delete;//0：正常 1：已删除
	private String cre_time;//创建时间
	private String up_time;//修改时间
	private String is_cinema;//1：影院观看 2：否
	private String ticket_path;//电影票照片存放路径
	private String ac_id;//主演
	private String nat_id;//制片地区
	private Integer page;//页数
	private Integer limit;//每页数据条数
	private String rank;//排序方式 1：评分（高到低）2：评分（低到高）3：票房
	
	
	public String getFilm_id() {
		return film_id;
	}
	public void setFilm_id(String film_id) {
		this.film_id = film_id;
	}
	public String getFilm_name() {
		return film_name;
	}
	public void setFilm_name(String film_name) {
		this.film_name = film_name;
	}
	public String getFilm_english() {
		return film_english;
	}
	public void setFilm_english(String film_english) {
		this.film_english = film_english;
	}
	public String getFilm_type() {
		return film_type;
	}
	public void setFilm_type(String film_type) {
		this.film_type = film_type;
	}
	public String getRun_date() {
		return run_date;
	}
	public void setRun_date(String run_date) {
		this.run_date = run_date;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getPost_path() {
		return post_path;
	}
	public void setPost_path(String post_path) {
		this.post_path = post_path;
	}
	public String getJishu() {
		return jishu;
	}
	public void setJishu(String jishu) {
		this.jishu = jishu;
	}
	public String getPiaofang() {
		return piaofang;
	}
	public void setPiaofang(String piaofang) {
		this.piaofang = piaofang;
	}
	public String getDb_score() {
		return db_score;
	}
	public void setDb_score(String db_score) {
		this.db_score = db_score;
	}
	public String getRecommend() {
		return recommend;
	}
	public void setRecommend(String recommend) {
		this.recommend = recommend;
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
	public String getUp_time() {
		return up_time;
	}
	public void setUp_time(String up_time) {
		this.up_time = up_time;
	}
	public String getIs_cinema() {
		return is_cinema;
	}
	public void setIs_cinema(String is_cinema) {
		this.is_cinema = is_cinema;
	}
	public String getTicket_path() {
		return ticket_path;
	}
	public void setTicket_path(String ticket_path) {
		this.ticket_path = ticket_path;
	}
	public String getAc_id() {
		return ac_id;
	}
	public void setAc_id(String ac_id) {
		this.ac_id = ac_id;
	}
	public String getNat_id() {
		return nat_id;
	}
	public void setNat_id(String nat_id) {
		this.nat_id = nat_id;
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
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}

	
}
