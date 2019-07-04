<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<!--[if IE 7]><html class="ie7 lte9 lte8 lte7" lang="zh-cn"><![endif]-->
<!--[if IE 8]><html class="ie8 lte9 lte8" lang="zh-cn"><![endif]-->
<!--[if IE 9]><html class="ie9 lte9" lang="zh-cn"><![endif]-->
<!--[if gt IE 9]><!-->
<html lang="zh-cn">
<!--<![endif]-->
<head>
<title>注册账号</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>登录平台</title>
<link href="assets/stylesheets/style-app.css" rel="stylesheet">
<link href="assets/stylesheets/style-app-extend1.css" rel="stylesheet">
</head>
<body class="not-signedin view-signup hide-wip lang_zh-cn">
	<a class="nav-skip" href="#content">跳过本内容页</a>
	<!-- view -->
	<div class="wrapper wrapper-view">
		<div class="wrapper-header wrapper" id="view-top">
			<header class="primary" role="banner">
				<div class="wrapper wrapper-l">
					<h1 class="branding"></h1>
				</div>
				<div class="wrapper wrapper-r">
					<nav class="nav-account nav-is-signedin nav-dd ui-right">
						<ol>
							<li class="nav-item nav-not-signedin-signin"><a class="action action-signin" href="index.html">登录</a></li>
						</ol>
					</nav>
				</div>
			</header>
		</div>
		<div id="page-alert"></div>
		<div id="content">
			<div class="wrapper-content wrapper">
				<section class="content">
					<header>
						<h1 class="title title-1">注册</h1>
						<a href="index.html" class="action action-signin">如果您已经有云存储账号，请直接登录</a>
					</header>
					<article class="content-primary" role="main">
						<form id="register_form" method="post">
							<div id="register_error" name="register_error" class="message message-status message-status error"></div>
							<fieldset>
								<legend class="sr">注册考试所需的信息</legend>
								<ol class="list-input">
									<li class="field text required" id="field-email"><label for="email">电子邮件地址</label> <input id="email"
										type="email" name="email" placeholder="例如：zahngsan@163.com" /></li>
									<li class="field text required" id="field-name"><label for="name">全名</label> <input id="name" type="text"
										name="name" placeholder="例如 ：张三" /></li>
									<li class="field text required" id="field-username"><label for="username">用户名</label> <input id="username"
										type="text" name="username" placeholder="例如：zhangsan" /> <span class="tip tip-stacked">这将会被用于登陆云存储平台</span></li>
									<li class="field text required" id="field-password"><label for="password">密码</label> <input id="password"
										type="password" name="password" /></li>
								</ol>
							</fieldset>

							<div class="form-actions">
								<button type="button" class="action action-primary" onclick="tregeister();">创建我的账号 &amp;开始创建</button>
							</div>

							<!-- no honor code for CMS, but need it because we're using the lms student object -->
							<input name="honor_code" type="checkbox" value="true" checked="true" hidden="true">
						</form>
					</article>
					<aside class="content-supplementary" role="complimentary">
						<h2 class="sr">关于云存储平台的常见问题</h2>

						<div class="bit">
							<h3 class="title-3">云存储平台是为谁服务的？</h3>
							<p>云存储平台面向任何希望使用云存储的用户，这些用户通常是院系教师、助教及教学技术小组。</p>
						</div>

						<div class="bit">
							<h3 class="title-3">在云存储平台创建需要掌握哪些技术？</h3>
							<p>对几乎所有熟悉云网盘(例如百度云，360网盘)的人而言，云存储平台都是很容易使用的。当然我们会一如既往地为您提供帮助，不要犹豫赶快加入吧。</p>
						</div>
					</aside>
				</section>
			</div>
		</div>

		<div class="wrapper-footer wrapper">
			<footer class="primary" role="contentinfo">
				<div class="colophon">
					<p>Copyright © 2014 南京第五十五所技术开发有限公司</p>
				</div>
				<nav class="nav-peripheral">
					<ol>
						<li class="nav-item nav-peripheral-tos"><a data-rel="edx.org" href="#">服务条款</a></li>
						<li class="nav-item nav-peripheral-pp"><a data-rel="edx.org" href="#">隐私政策</a></li>
					</ol>
				</nav>
			</footer>
		</div>
	</div>
	<!-- javascript -->
	<script src="assets/javascripts/jquery.min.js"></script>
	<script src="assets/javascripts/index.js"></script>
	<script>
		//注册
		function tregeister() {
			var email = $("#email").val();
			var password = $("#password").val();
			var username = $("#username").val();
			var name = $("#name").val();
			var data = {
				username : username,
				realname : name,
				email : email,
				password : password
			};
			$.ajax({
				url : "regeister.action",
				type : "post",
				data : data,
				success : function(s) {
					if (s.success) {
						//alert('aaaa');
						location.href = "home.action";
					} else {
						alert(s.msg);
					}
				}
			});
		}
	</script>
</body>
</html>
