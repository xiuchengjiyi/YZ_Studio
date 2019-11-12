package com.yz.dao;

import com.yz.model.User;

/**
 * @author ZGD
 * @version 创建时间：2019年10月18日 下午2:37:30
 * 类说明
 */
public interface UserMapper {
	//根据用户名查询用户是否存在
	User selectUser(String username);
	//新增用户
	int insertUser(User user);
}
