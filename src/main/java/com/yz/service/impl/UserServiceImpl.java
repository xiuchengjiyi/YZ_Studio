package com.yz.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yz.dao.ActorMapper;
import com.yz.dao.UserMapper;
import com.yz.model.Actor;
import com.yz.model.User;
import com.yz.service.ActorService;
import com.yz.service.UserService;
import com.yz.utils.Utils;

/**
 * @author ZGD
 * @version 创建时间：2019年9月6日 上午8:51:20
 * 类说明
 */
@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserMapper userMapper;
	
	/**
	 * 登陆校验
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月18日下午3:12:58
	 * @param username 用户名
	 * @param password 密码
	 * @return json
	 */
	public JSONObject checkLogin(String username, String password){
		JSONObject json = new JSONObject();
		
		//先查询该用户名是否存在
		User user = selectUser(username);
		if (user != null) {//该用户名存在，校验密码是否正确
			if (password.equals(user.getPassword())) {
				//密码正确，登陆成功
				json.put("code", "1");
				json.put("message", "登陆成功");
			}else {
				json.put("code", "0");//密码不正确
				json.put("message", "密码不正确");
			}
		}else{
			json.put("code", "0");//用户不存在
			json.put("message", "该用户名不存在");
		}
		
		return json;
	}
	
	/**
	 * 查询该用户名是否存在
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月18日下午3:12:03
	 * @param username 用户名
	 * @return user类
	 */
	public User selectUser(String username){
		return userMapper.selectUser(username);
	}

	/**
	 * 新增用户
	 */
	public int insert(String username, String password){
		//获取随机User_id
		String user_id = Utils.getRandomID();
		User user = new User();
		user.setUser_id(user_id);
		user.setUsername(username);
		user.setPassword(password);
		
		int code = userMapper.insertUser(user);
		
		return code;
	}

}
