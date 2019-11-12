package com.yz.dao;

import java.util.List;

import com.yz.model.Echart;
import com.yz.model.dto.TotalDTO;

/**
 * @author ZGD
 * @version 创建时间：2019年11月7日 下午3:23:56
 * 类说明
 */
public interface EchartMapper {

	//根据年份统计各个月影视数据
	List<Echart> getFilm_Info(Echart echart);
	//获取影视数
	TotalDTO getTotal();

}
