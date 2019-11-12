package com.yz.service;

import com.alibaba.fastjson.JSONObject;
import com.yz.model.User;

/**
 * @author ZGD
 * @version 创建时间：2019年10月18日 下午2:34:31
 * 类说明
 */
public interface UserService {
	
	//登陆校验
	JSONObject checkLogin(String username, String password);
	//检查用户名是否存在
	User selectUser(String username);
	//注册，新增用户
	int insert(String username, String password);
}
