package com.yz.service;

import com.alibaba.fastjson.JSONObject;
import com.yz.model.Echart;
import com.yz.model.dto.TotalDTO;

/**
 * @author ZGD
 * @version 创建时间：2019年11月7日 下午3:20:39
 * 类说明
 */
public interface EchartService {

	//用echarts统计影视数据，并按规定格式返回
	JSONObject getFilm_Info(Echart echart);
	//获取影视总数
	TotalDTO getTotal();

}
