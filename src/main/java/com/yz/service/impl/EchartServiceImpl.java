package com.yz.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.yz.dao.EchartMapper;
import com.yz.model.Echart;
import com.yz.model.dto.TotalDTO;
import com.yz.service.EchartService;

/**
 * @author ZGD
 * @version 创建时间：2019年11月7日 下午3:21:49
 * 类说明
 */
@Service
public class EchartServiceImpl implements EchartService{
	
	@Autowired
	private EchartMapper echartMapper;

	/**
	 * 用echarts统计影视数据，并按规定格式返回
	 */
	public JSONObject getFilm_Info(Echart echart) {
		JSONObject json = new JSONObject();
		String datax="";
		String data1="";
		String data2="";
		//查询电影数据
		echart.setFilm_type("1");
		List<Echart> list = echartMapper.getFilm_Info(echart);
		for (int i = 0; i < list.size(); i++) {
			Echart dataEchart = list.get(i);
			if("".equals(datax)){
				datax += dataEchart.getMonth()+"月";
				data1 += dataEchart.getCountForFilm1();
			}else {
				datax += ","+dataEchart.getMonth()+"月";
				data1 += ","+dataEchart.getCountForFilm1();
			}
		}
		//查询电视剧数据
		echart.setFilm_type("2");
		list = echartMapper.getFilm_Info(echart);
		for (int i = 0; i < list.size(); i++) {
			Echart dataEchart = list.get(i);
			if("".equals(data2)){
				data2 += dataEchart.getCountForFilm1();
			}else {
				data2 += ","+dataEchart.getCountForFilm1();
			}
		}
		json.put("datax", datax);
		json.put("data1", data1);
		json.put("data2", data2);
		
		return json;
	}

	//获取影视总数
	public TotalDTO getTotal() {
		TotalDTO total = echartMapper.getTotal();
		return total;
	}
	
	

}
