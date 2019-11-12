package com.yz.model;
/**
 * @author ZGD
 * @version 创建时间：2019年10月18日 下午2:40:25
 * 类说明:国家及地区类
 */
public class Nationality {
	
	private String nat_id;
	private String nationality;//国家及地区名
	private String en_nationality;//英文名
	private String flag_path;//国旗图片存放路径
	public String getNat_id() {
		return nat_id;
	}
	public void setNat_id(String nat_id) {
		this.nat_id = nat_id;
	}
	public String getNationality() {
		return nationality;
	}
	public void setNationality(String nationality) {
		this.nationality = nationality;
	}
	public String getEn_nationality() {
		return en_nationality;
	}
	public void setEn_nationality(String en_nationality) {
		this.en_nationality = en_nationality;
	}
	public String getFlag_path() {
		return flag_path;
	}
	public void setFlag_path(String flag_path) {
		this.flag_path = flag_path;
	}
	

}
