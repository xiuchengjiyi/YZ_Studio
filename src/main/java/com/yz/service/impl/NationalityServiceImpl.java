package com.yz.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sun.misc.BASE64Encoder;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yz.dao.NationalityMapper;
import com.yz.model.Nationality;
import com.yz.service.NationalityService;

/**
 * @author ZGD
 * @version 创建时间：2019年10月23日 下午3:04:32
 * 类说明
 */
@Service
public class NationalityServiceImpl implements NationalityService {
	
	@Autowired
	private NationalityMapper nationalityMapper;
	
	public JSONObject selectAll(Integer page, Integer limit){
		JSONObject json = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		
		List<Nationality> list = getAll(page,limit);
		byte[] data = null;
		for (int i = 0; i < list.size(); i++) {
			Nationality nationality = list.get(i);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("nat_id", nationality.getNat_id());
			map.put("nationality", nationality.getNationality());
			map.put("en_nationality", nationality.getEn_nationality());
			String flag_path = nationality.getFlag_path();
			map.put("flag_path", flag_path);
			if (flag_path != null && !"".equals(flag_path)) {
				File file = new File(flag_path);
				InputStream in = null;
				try {
					in = new FileInputStream(file);
					data = new byte[in.available()];
					in.read(data);
					in.close();
					BASE64Encoder encoder = new BASE64Encoder();
					String encode = encoder.encode(data);
					map.put("flag_picture", encode);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			jsonArray.add(map);
		}
		json.put("data", jsonArray);
		int count = nationalityMapper.selectCount();
		json.put("count", count);
		json.put("code", 0);
		json.put("msg", "");
		
		return json;
	}
	
	public List<Nationality> getAll(Integer page, Integer limit){
		List<Nationality> list = nationalityMapper.selectAll(page,limit);
		
		return list;
	}

	/**
	 * 根据id查询单条数据
	 */
	public Map<String, Object> getNationalityByID(String nat_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		Nationality nationality = nationalityMapper.getNationalityByID(nat_id);
		map.put("nat_id", nationality.getNat_id());
		map.put("nationality", nationality.getNationality());
		map.put("en_nationality", nationality.getEn_nationality());
		String flag_path = nationality.getFlag_path();
		map.put("flag_path", flag_path);
		if (flag_path != null && !"".equals(flag_path)) {
			File file = new File(flag_path);
			InputStream in = null;
			try {
				in = new FileInputStream(file);
				byte[] data = new byte[in.available()];
				in.read(data);
				in.close();
				BASE64Encoder encoder = new BASE64Encoder();
				String encode = encoder.encode(data);
				map.put("flag_picture", encode);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return map;
	}
	/**
	 * 新增
	 */
	public int insertNationality(Nationality nationality) {
		int code = nationalityMapper.insertNationality(nationality);
		return code;
	}
	
	/**
	 * 更新
	 */
	public int editNationality(Nationality nationality) {
		int code = nationalityMapper.updateNationality(nationality);
		return code;
	}

}
