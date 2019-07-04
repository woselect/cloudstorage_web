/*
 * Copyright (c) 2014, 2016, XIANDIAN and/or its affiliates. All rights reserved.
 * XIANDIAN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 *
 */
package com.xiandian.cloud.storage.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xiandian.cloud.storage.dao.UserDao;
import com.xiandian.cloud.storage.domain.User;
import com.xiandian.cloud.storage.util.MD5;
import com.xiandian.cloud.storage.util.UtilTools;

/**
 * 用户管理服务器，负责查询用户、注册用户等操作
 * 
 * @author 云计算应用与开发项目组
 * @since  V2.0
 * 
 */
@Service
public class UserService {
	
	@Autowired
	private UserDao userDao;
	
	/**
	 * 根据用户名查找用户
	 * @param mail
	 * @return
	 */
	public User getUserByname(String username)
	{
		return userDao.getUserByname(username);
	}
	
	public User getUserByid(int id)
	{
		return userDao.getUserByid(id);
	}
	/**
	 * 保存用户
	 * @param user
	 */
	public User save(String username,String realname, String email,	String password)
	{
		User user = new User();
		user.setEmail(email);
		MD5 md5 = new MD5();
		user.setPassword(md5.getMD5ofStr(password));
		user.setUsername(username);
		user.setRealname(realname);
		user.setJoindate(UtilTools.timeTostrHMS(new Date()));
		user.setLastdate(UtilTools.timeTostrHMS(new Date()));
		userDao.save(user);
		
		return user;
	}
	
	/**
	 * 更新用户
	 * @param user
	 */
	public void update(User user)
	{
		userDao.update(user);
	}
	
	public List<User> getAll()
	{
		return userDao.getAll();
	}
}
