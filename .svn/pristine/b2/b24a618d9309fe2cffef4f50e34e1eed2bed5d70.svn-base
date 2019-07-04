<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<div class="topbar" style="z-index: 1;">
	<div class="content">
		<div class="top_left">
			<a href="javascript:void(0)" class="topbar_menu title"
				draggable="false"><i class="fa fa-cloud"></i>Cloud</a> <a
				class="topbar_menu this" target="_self" draggable="false"
				type="button" href="home.action"><i
				class="font-icon menu-explorer"></i>文件管理</a> <a class="topbar_menu this"
				target="_self" draggable="false" type="button" href="togroup.action"><i
				class="font-icon menu-explorer"></i>群分享</a>
		</div>
		<div class="top_right">

			<div class="menu_group">
				<a href="#" id="topbar_user" data-toggle="dropdown"
					class="topbar_menu" draggable="false"><i
					class="font-icon icon-user"></i>${USER_CONTEXT.username}&nbsp;<b
					class="caret"></b></a>
				<ul
					class="dropdown-menu menu-topbar_user pull-right animated menuShow"
					role="menu" aria-labelledby="topbar_user">
					<li><a href="logout.action" draggable="false"><i
							class="font-icon fa fa-sign-out"></i>退出</a></li>
				</ul>
			</div>

		</div>
		<div style="clear: both"></div>
	</div>
</div>
<div class="frame-header">
	<div class="header-content">
		<div class="header-left">
			<div class="btn-group btn-group-sm">
				<button onclick="javascript:history.go(-1);" class="btn btn-default"
					id="history_back" title="后退" type="button">
					<i class="font-icon fa fa-arrow-left"></i>
				</button>
				<button onclick="javascript:history.go(1);" class="btn btn-default"
					id="history_next" title="前进" type="button">
					<i class="font-icon fa fa-arrow-right"></i>
				</button>
				<button onclick="javascript:location.reload();"
					class="btn btn-default" id="refresh" title="强制刷新" type="button">
					<i class="font-icon fa fa-refresh"></i>
				</button>
			</div>
		</div>
		<!-- /header left -->

		<div class="header-middle">
			<a href="home.action">
				<button class="btn btn-default" id="home" title="我的文档">
					<i class="font-icon fa fa-home"></i>
				</button>
			</a>

			<div id="yarnball" title="点击进入编辑状态" style="display: block;">
				<ul class="yarnball" style="left: 3px; width: 859px;">
					<li class="yarnlet first"><a title="" href="togroup.action"
						style="z-index: 2;"> <span class="left-yarn"></span> <span
							class="address_ico groupSelf"></span> <span class="title_name"
							style="top: -2px; position: relative;">群组管理</span>
					</a></li>
				</ul>
			</div>
			<div id="yarnball_input" style="display: none;">
				<input type="text" name="path" value="" class="path" id="path">
			</div>
		</div>
	</div>
</div>