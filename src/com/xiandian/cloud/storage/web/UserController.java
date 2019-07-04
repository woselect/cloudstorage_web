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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.xiandian.cloud.storage.bean.MessageBean;
import com.xiandian.cloud.storage.cons.Constants;
import com.xiandian.cloud.storage.domain.User;
import com.xiandian.cloud.storage.service.SwiftStorageService;
import com.xiandian.cloud.storage.service.UserService;
import com.xiandian.cloud.storage.util.MD5;
import com.xiandian.cloud.storage.sh.util.UtilTools;

/**
 * 用户涉及到的所有控制action
 * 
 * @author 云计算应用与开发项目组
 * @since  V2.0
 * 
 */
@Controller
public class UserController extends BaseController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private SwiftStorageService swiftStorageService;
	/**
	 * 登陆
	 * @param request
	 * @param response
	 * @param email
	 * @param password
	 */
	@RequestMapping("/login")
	@ResponseBody
	public Object login(HttpServletRequest request, HttpServletResponse response,
			String username, String password) {
		User user = userService.getUserByname(username);
		if (user == null) {
			return new MessageBean(false,Constants.ERROR_1);
		}
		MD5 md5 = new MD5();
		String inputstr = md5.getMD5ofStr(password);
		
		//测试swift链接配置是否成功----
		try
		{
			
		}
		catch(Exception e)
		{
			return new MessageBean(false,Constants.SUCCESS_10);
		}
		
		if (!inputstr.equals(user.getPassword())) {
			return new MessageBean(false,Constants.ERROR_2);
		}
		UtilTools.getConnectionSwift();
		setSessionUser(request, user);
		return new MessageBean(true,Constants.SUCCESS_1);
	}
	
	/**
	 * 退出
	 */
	@RequestMapping("/logout")
	public ModelAndView logout(HttpServletRequest request,
			HttpServletResponse response, String path) {
		setSessionUser(request, null);
		String url = "redirect:/index.html";
		return new ModelAndView(url);
	}
	
	/**
	 * 注册
	 * @param request
	 * @param response
	 * @param email
	 * @param password
	 */
	@RequestMapping("/regeister")
	@ResponseBody
	public Object regeister(HttpServletRequest request, HttpServletResponse response,
			String username,String realname,String email, String password) {
		User user = userService.getUserByname(username);
		if (user != null) {
			return new MessageBean(false,Constants.ERROR_3);
		}
		user = userService.save(username, realname, email,password);
		setSessionUser(request, user);
		
		swiftStorageService.createContainer(username);
		return new MessageBean(true,Constants.SUCCESS_2);
	}
	
	
	/**改的修改密码的方法1**/
	@RequestMapping("/updateuserinfo")
	@ResponseBody
	public Object updateuserinfo(HttpServletRequest request,HttpServletResponse response,
			String oldpassword,String newpassword){
		User user=getSessionUser(request);
		String password=user.getPassword();
		MD5 md5=new MD5();
		oldpassword =md5.getMD5ofStr(oldpassword);
		System.out.println("用户名："+user.getUsername());
		System.out.println("原密码："+oldpassword);
		System.out.println("新密码："+newpassword);
		System.out.println("数据库中密码："+password);
		if (password.equals(oldpassword)) {
			user.setPassword(md5.getMD5ofStr(newpassword));
			userService.update(user);
			return new MessageBean(true,Constants.SUCCESS_11);
		} else {
			return new MessageBean(false, Constants.ERROR_7);
		}
		}
	
	
	
	
	
}
