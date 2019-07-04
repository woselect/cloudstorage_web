/*
 * Copyright (c) 2014, 2016, XIANDIAN and/or its affiliates. All rights reserved.
 * XIANDIAN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 *
 */
package com.xiandian.cloud.storage.web;

import javax.servlet.http.HttpServletRequest;

import com.xiandian.cloud.storage.cons.Constants;
import com.xiandian.cloud.storage.domain.User;

/**
 * 所有controller的基类
 * 
 * @author 云计算应用与开发项目组
 * @since  V1.4
 * 
 */
public class BaseController {
	
	
	/**
	 * 获取保存在Session中的用户对象
	 * 
	 * @param request
	 * @return
	 */
	protected User getSessionUser(HttpServletRequest request) {
		User user = (User)request.getSession().getAttribute(Constants.USER_CONTEXT);
		return user;
	}
	
	/**
	 * 保存用户对象到Session中
	 * @param request
	 * @param user
	 */
	protected void setSessionUser(HttpServletRequest request,User  user) {
		request.getSession().setAttribute(Constants.USER_CONTEXT,
				user);
	}
	
}
