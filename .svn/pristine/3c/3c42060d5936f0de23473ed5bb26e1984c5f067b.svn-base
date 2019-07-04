/*
 * Copyright (c) 2014, 2016, XIANDIAN and/or its affiliates. All rights reserved.
 * XIANDIAN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 *
 */
package com.xiandian.cloud.storage.dao;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.xiandian.cloud.storage.domain.User;

/**
 * 用户的dao层
 * 
 * @author 云计算应用与开发项目组
 * @since  V1.4
 * 
 */
@Repository
public class UserDao extends BaseDao<User> {
	
	public User getUserByname(String username)
	{
		String hql = "from User where username = ?";
		List<User> users = find(hql,username);
	    if (users==null || users.size() == 0) {
			return null;
		}else{
			return users.get(0);
		}
	}
	
	public User getUserByid(int id)
	{
		String hql = "from User where id = ?";
		List<User> users = find(hql,id);
	    if (users==null || users.size() == 0) {
			return null;
		}else{
			return users.get(0);
		}
	}
	
	public List<User> getAll() {
		String hql = "from User";
		return find(hql);
	}
}
