/*
 * Copyright (c) 2014, 2016, XIANDIAN and/or its affiliates. All rights reserved.
 * XIANDIAN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 *
 */
package com.xiandian.cloud.storage.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiandian.cloud.storage.domain.User;
import com.xiandian.cloud.storage.service.UserService;
import com.xiandian.cloud.storage.util.MD5;

/**
 * 提供登录认证的方法
 * 
 * @author 云计算应用与开发项目组
 * @since  V2.0
 * 
 */
@Controller
public class RestController {

	@Autowired
	private UserService userService;
	
	@RequestMapping(method = RequestMethod.GET, value = "/check/{username}/{pwd}", headers = "Accept=application/xml, application/json")
	public @ResponseBody
	String check(HttpServletRequest request, HttpServletResponse response,@PathVariable String username,@PathVariable String pwd) {
		
		User user = userService.getUserByname(username);
		if (user == null) {
			return "fail";
		}
		MD5 md5 = new MD5();
		String inputstr = md5.getMD5ofStr(pwd);
		if (!inputstr.equals(user.getPassword())) {
			return "fail";
		}
		
		return "success";
	}
	
	@RequestMapping(method=RequestMethod.GET, value="/test", headers="Accept=application/xml, application/json")
	public @ResponseBody String test() {
		return "helloworld";
	}
}
