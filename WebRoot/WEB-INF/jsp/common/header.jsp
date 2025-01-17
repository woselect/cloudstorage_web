<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<div class="topbar col-md-12" style="z-index:1;">
	<div class="content">
		<div class="top_left">
			<!-- <a href="javascript:void(0)" class="topbar_menu title" draggable="false"><i class="fa fa-cloud"></i>Cloud</a> -->
			<a href="javascript:void(0)" class="topbar_menu title"
				draggable="false"> <img src="assets/images/logo.png"
				alt="NO image" class="gridview-img  " style="width: 17% ; margin-left: 10px;float:left;"><p style="font-size: 14px;font-family:Microsoft YaHei"> JavaEE Web云应用开发</p> </a> <a
				class="topbar_menu this" target="_self" draggable="false"
				href="home.action"><i class="font-icon menu-explorer"></i>文件管理</a>
			<!-- <a class="topbar_menu this" target="_self" draggable="false"  href="togroup.action" ><i class="font-icon menu-explorer"></i>群分享</a> -->
		</div>
		<div class="top_right">
			<div class="menu_group">
				<a href="#" id="topbar_user" data-toggle="dropdown" class="topbar_menu" draggable="false"><i class="font-icon icon-user"></i>${USER_CONTEXT.username}&nbsp;<b class="caret"></b></a>
				<ul class="dropdown-menu menu-topbar_user pull-right animated menuShow" role="menu" aria-labelledby="topbar_user">
						<li><a href="grxx.action" draggable="false"><i class="font-icon fa fa-sign-out"></i>个人信息</a></li>
					<li><a href="logout.action" draggable="false"><i class="font-icon fa fa-sign-out"></i>退出</a></li>
				</ul>			
			</div>
		</div>
		<div style="clear:both"></div>
	</div>
</div>
<div class="frame-header col-md-12">
		<div class="header-content">
			<div class="header-left">
				<div class="btn-group btn-group-sm">
					<button onclick="javascript:history.go(-1);" class="btn btn-default" id="history_back" title="后退" type="button">
						<i class="font-icon fa fa-arrow-left"></i>
					</button>
					<button onclick="javascript:history.go(1);" class="btn btn-default" id="history_next" title="前进" type="button">
						<i class="font-icon fa fa-arrow-right"></i>
					</button>
					<button onclick="javascript:location.reload();" class="btn btn-default" id="refresh" title="强制刷新" type="button">
						<i class="font-icon fa fa-refresh"></i>
					</button>
				</div>
			</div><!-- /header left -->
			
			<div class="header-middle">
				<a href="home.action">
					<button class="btn btn-default"  id="home" title="我的文档">
						<i class="font-icon fa fa-home"></i>
					</button>
				</a>

				<div id="yarnball" title="点击进入编辑状态" style="display: block;">
				<ul class="yarnball" style="left: 3px; width: 859px;">
				<li class="yarnlet first"><a title="" href="home.action" style="z-index:2;">
				<span class="left-yarn"></span>
				<span class="address_ico groupSelf"></span>
				<span class="title_name" style="top: -2px;position: relative;">全部</span>
				</a></li>
				<c:if test="${type == 2}">
				<li class="yarnlet "><a title="" href="category.action?type=2" style="z-index:1;"><span class="title_name">文档</span></a></li>
				</c:if>
				<c:if test="${type == 1}">
				<li class="yarnlet "><a title="" href="category.action?type=1" style="z-index:1;"><span class="title_name">图片</span></a></li>
				</c:if>
				<c:if test="${type == 3}">
				<li class="yarnlet "><a title="" href="category.action?type=3" style="z-index:1;"><span class="title_name">视频</span></a></li>
				</c:if>
				<c:if test="${type == 4}">
				<li class="yarnlet "><a title="" href="category.action?type=4" style="z-index:1;"><span class="title_name">音乐</span></a></li>
				</c:if>
				<c:if test="${type == 5}">
				<li class="yarnlet "><a title="" href="category.action?type=5" style="z-index:1;"><span class="title_name">其他</span></a></li>
				</c:if>
				<c:if test="${type == 6}">
				<li class="yarnlet "><a title="" href="shareFile.action" style="z-index:1;"><span class="title_name">我的分享</span></a></li>
				</c:if>
				<c:if test="${type == 7}">
				<li class="yarnlet "><a title="" href="garbage.action" style="z-index:1;"><span class="title_name">垃圾箱</span></a></li>
				</c:if>
			
                </ul>
                </div>
				<div id="yarnball_input" style="display: none;"><input type="text" name="path" value="" class="path" id="path"></div>
	
			</div>

			 <div class="header-right">
				<input type="text" name="seach" id="navbarInput-01">
				<a class="btn btn-default" id="searchfiles" title="搜索" type="button" onclick="searchfile()">
					<i class="font-icon fa fa-search"></i>
				</a>
			</div> 
		</div>
	</div>
	
<!-- 	<div class="navbar navbar-inverse navbar-fixed-top header-background" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">变换导航</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="home.action"> <img src='images/logo.png' class="header-img">
				</a>
			</div>

			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown" id="accountmenu"><a class="dropdown-toggle" data-toggle="dropdown"
						href="javascript:void(0);"><span class="glyphicon glyphicon-user"></span></a>
						<ul class="dropdown-menu">
							<li><a href="grxx.action">个人信息</a></li>
							<li class="divider"></li>
							<li><a href="logout.action">注销</a></li>
						</ul></li>
				</ul>
				<div class="navbar-form navbar-right header-border" role="search">
					<div class="form-group">
						<div class="input-group">
							<input class="form-control search-bgcolor" id="navbarInput-01" type="search" placeholder="搜索我的文件..."> 
							<span class="input-group-btn"> <a href="javascript:void(0);"
								type="submit" class="btn search-bgcolor" onclick="searchfile()" id="searchfiles"><span
									class="fui-search"></span></a>
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div> -->