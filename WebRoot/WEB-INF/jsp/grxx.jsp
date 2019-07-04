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
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title>先电云存储</title>
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<link href="assets/stylesheets/bootstrap.min.css" rel="stylesheet">
<link href="assets/stylesheets/dashboard.css" rel="stylesheet">
<link href="assets/stylesheets/font-awesome.css" rel="stylesheet">
<link href="assets/stylesheets/flat-ui.css" rel="stylesheet">
<link href="assets/stylesheets/main.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="common/header.jsp"></jsp:include>	
	<div class="container-fluid">
		<div class="row">
           <jsp:include page="common/left.jsp"></jsp:include>
			<div class="leftclose main col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2">
				<div class="col-md-12">
					<a href="javascript:void(0);" class="toggle-nav" id="toggle-left"><i class="fa fa-bars"></i></a>
					<h7> <b>账户安全中心</b></h7>
					<hr class="grxx-line">
					<h7><b>我的信息</b></h7>
					<div class="accounts-summery" >
						<div class="media-inf">
							<div class="media-object">
								<img src="assets/images/user.jpg">
							</div>
							<div class="media-cont">
								<div class="hd">
									<h7>用户名：</h7>
									<p class="dis-inline" >${USER_CONTEXT.username}</p>
								</div>
								<div class="hd">
									<h7>全名：</h7>
									<p class="dis-inline">${USER_CONTEXT.realname}</p>
								</div>
								<div class="bd">
									<div class="zone-info mt-10">
										<a href="javascript:void(0);" id="changepassword">修改密码</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<hr class="grxx-line">
					<h7> <b>我的容量</b></h7>
					<div class="accounts-summery">
						<div class="media-inf">
							<div class="media-cont">
								<div class="hd">
									<h7>当前容量：</h7>
									<p class="dis-inline">${USER_CONTEXT.capacity}</p>
								</div>
								<div class="bd">
									<div class="zone-info mt-10">
										<a href="javascript:void(0);" class="capacity">购买容量</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--  密码框    -->
	<div class="lightboxOverlay1"></div>
	<div class="password-lightbox">
		<div class="container pl-266">
			<div class="password-box">
				<p>密码修改</p>
				<div class="lb-closeContainer">
					<a class="lb-close1" href="javascript:void(0);" ><span class="glyphicon glyphicon-remove"></span></a>
				</div>
			</div>
			<div class="pwd-content">
				<div class="mt-50 ml-13">
					<div>
						<p class="dis-inline">登陆密码:</p>
						<input class="quc-input quc-input-password quc-inputsize" type="password" name="password" maxlength="20" placeholder="请输入您的登录密码"
							id="old_password">
					</div>
					<div>
						<p class="dis-inline">新密码:</p>
						<input class="quc-input quc-input-password quc-newsize" type="password" name="password" maxlength="20" placeholder="请输入您的新密码"
							id="new_password">
					</div>
					<button class="btn btn-primary buycapacitysub" onclick="changepwd();">提交</button>
				</div>
			</div>
		</div>
	</div>
	<!--  购买容量    -->
    <jsp:include page="common/buystore.jsp"></jsp:include>
	<!-- JavaScript-->
	<script src="assets/javascripts/jquery.min.js"></script>
	<script src="assets/javascripts/bootstrap.min.js"></script>
	<script src="assets/javascripts/checkbox.js"></script>
	<script src="assets/javascripts/common.js"></script>
	<script type="text/javascript">
		//导航栏选中效果 	
		$(".nav li a").each(function() {
			$this = $(this);
			if ($this[0].href == String(window.location)) {
				$this.parent().addClass("active");
			}
		});

		$(document).ready(function() {
			$("#toggle-left").click(function() {
				if ($(".leftclose").hasClass("col-md-offset-2")){
					$("#leftshow").animate({left : '-700px'}, "15")
					$(".leftclose").removeClass("col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 ");
				} else {
					$(".leftclose").addClass("col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 ");
					$("#leftshow").animate({left : '0px'})
				}
			});	
			
			$("#changepassword").click(function() {
				$(".lightboxOverlay1").fadeIn();
				$(".lightbox").fadeIn();
				$(".password-lightbox").fadeIn();
				
			});
			
			$(".lb-close1").click(function() {
				$(".lightboxOverlay1").fadeOut();
				$(".lightbox").fadeOut();
				$(".password-lightbox").fadeOut();
			});
		});

		//修改密码
		function changepwd() {
			var oldpassword = $("#old_password").val();
			var newpassword = $("#new_password").val();
			var data = {
				oldpassword : oldpassword,
				newpassword : newpassword
			};
			$.ajax({
				url : "updateuserinfo.action",
				type : "post",
				data : data,
				success : function(s) {
					if (s.success) {
						location.reload();
					}
					alert(s.msg);
				}
			});
		}
	</script>
</body>
</html>