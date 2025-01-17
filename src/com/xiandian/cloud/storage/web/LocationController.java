/*
 * Copyright (c) 2014, 2016, XIANDIAN and/or its affiliates. All rights reserved.
 * XIANDIAN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 *
 */
package com.xiandian.cloud.storage.web;

import java.util.List;

import org.openstack4j.api.OSClient.OSClientV3;
import org.openstack4j.model.common.Identifier;
import org.openstack4j.model.compute.Server;
import org.openstack4j.openstack.OSFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * 所有的跳转action
 * 
 * @author 云计算应用与开发项目组
 * @since  V2.0
 * 
 */
@Controller
public class LocationController extends BaseController {

	/**
	 * 跳转到注册页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/toregeister")
	public ModelAndView toregeister() {
		ModelAndView view = new ModelAndView();
		view.setViewName("/regeister");
		return view;
	}
	
	@RequestMapping("/aaa")
	public ModelAndView aaa() {
		ModelAndView view = new ModelAndView();
		
		OSClientV3 os = OSFactory.builderV3()
                .endpoint("http://172.24.21.10:5000/v3")
                .credentials("admin", "000000", Identifier.byName("admin"))
                .scopeToProject(Identifier.byId("78ff7b3430fd44128467ef7a764c9f03"))
                .authenticate();
		
		List<? extends Server> serverList = os.compute().servers().list();
		for(Server server : serverList){
			System.out.println(server.getName());
		}
		
		
		view.setViewName("/aaa");
		return view;
	}
	
	/**
	 * 跳转到用户管理页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/grxx")
	public ModelAndView grxx() {
		ModelAndView view = new ModelAndView();
		view.setViewName("/grxx");
		return view;
	}
}
