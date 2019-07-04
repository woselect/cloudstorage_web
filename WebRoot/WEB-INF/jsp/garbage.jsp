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
<link href="assets/stylesheets/bootstrap.min.css" media="all" rel="stylesheet"
	type="text/css" />
<link href="assets/stylesheets/style.css" media="all" rel="stylesheet" type="text/css" />
<link href="assets/stylesheets/disk.css" media="all" rel="stylesheet" type="text/css" />
<link href="assets/stylesheets/font-awesome.css" media="all" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="assets/stylesheets/zTreeStyle.css" type="text/css">
<style>
</style>
</head>

<body onkeydown="keyLogin()">
	<jsp:include page="common/header.jsp"></jsp:include>
	<div class="main">
		<div class="main-left" style="z-index: 1;">
			<div class="main-left" style="z-index: 1;">
				<div class="list-group category" style="margin: 10px;">
					<div id="ahref">
						<a class="list-group-item" id="r_active" href="home.action"><span
							class="glyphicon glyphicon-home left-icon"></span>&nbsp;&nbsp;全部文件</a>
						<a class="list-group-item " href="category.action?type=2" ><span
							class="glyphicon glyphicon-file left-icon"> </span>&nbsp;&nbsp;我的文档</a>
						<a class="list-group-item " href="category.action?type=1" ><span
							class="glyphicon glyphicon-picture left-icon"></span>&nbsp;&nbsp;我的图片</a>
						<a class="list-group-item " href="category.action?type=3" ><span
							class="glyphicon glyphicon-film left-icon"></span>&nbsp;&nbsp;我的视频</a>
						<a class="list-group-item " href="category.action?type=4" ><span
							class="glyphicon glyphicon-music left-icon"></span>&nbsp;&nbsp;我的音乐</a>
						<a class="list-group-item" href="category.action?type=5" ><span
							class="glyphicon glyphicon-inbox left-icon"></span>&nbsp;&nbsp;其他</a>

						<a class="list-group-item active" href="garbage.action"><span
							class="glyphicon glyphicon-trash left-icon"></span>&nbsp;&nbsp;垃圾箱</a>
					</div>
				</div>
				<div class="main-left-use">

					<div class="progress progress-u progress-xs">
						<div class="progress-bar progress-bar-blue" id="progress-bar"
							role="progressbar" aria-valuemin="0" aria-valuemax="100" style=""></div>
					</div>      
					<h3 class="heading-xs" style="font-size: 10px; padding: 0 10px">
						容量：<span class="" id="totle"></span><span
							class="capacity pull-right"><a href="javascript:void(0)">扩容</a></span>
					</h3>

				</div>
			</div>
		</div>
		<div class="main-right"
			style="left: 199px; position: fixed; top: 89px; right: 0; bottom: 32px; overflow: auto;">
			<div class="col-md-12" style="padding: 0">
				<div class="tools">
					<div class="tools-left">
						<div class="main-left" style="z-index: 1;">
							<div class="main-left" style="z-index: 1;">
								<div class="list-group category" style="margin: 10px;">
									<a class="list-group-item active" id="r_active"
										href="home.action"><span
										class="glyphicon glyphicon-home left-icon"></span>&nbsp;&nbsp;全部文件</a>
									<a class="list-group-item " ><span
										class="glyphicon glyphicon-file left-icon"> </span>&nbsp;&nbsp;我的文档</a>
									<a class="list-group-item " ><span
										class="glyphicon glyphicon-picture left-icon"></span>&nbsp;&nbsp;我的图片</a>
									<a class="list-group-item " ><span
										class="glyphicon glyphicon-film left-icon"></span>&nbsp;&nbsp;我的视频</a>
									<a class="list-group-item " ><span
										class="glyphicon glyphicon-music left-icon"></span>&nbsp;&nbsp;我的音乐</a>
									<a class="list-group-item"><span
										class="glyphicon glyphicon-inbox left-icon"></span>&nbsp;&nbsp;其他</a>
									<a class="list-group-item" href="garbage.action"><span
										class="glyphicon glyphicon-trash left-icon"></span>&nbsp;&nbsp;垃圾箱</a>
								</div>
								<div class="main-left-use">

									<div class="progress progress-u progress-xs">
										<div class="progress-bar progress-bar-blue" id="progress-bar"
											role="progressbar" aria-valuemin="0" aria-valuemax="100"
											style=""></div>
									</div>
									<h3 class="heading-xs" style="font-size: 10px; padding: 0 10px">
										容量：<span class="" id="totle"></span><span
											class="capacity pull-right"><a
											href="javascript:void(0)">扩容</a></span>
									</h3>

								</div>
							</div>
						</div>
						<div class="main-right"
							style="left: 199px; position: fixed; top: 89px; right: 0; bottom: 32px; overflow: auto;">
							<div class="col-md-12" style="padding: 0">
								<div class="tools">
									<div class="tools-left">
										<!-- 文件功能 -->
										<div class="btn-group btn-group-sm kod_path_tool fl-left">
											<div id="result-uploader" class="right upload-filemain fl"
												style="float: left"></div>
											<button class="btn btn-default" type="button" id="recovery" onclick="recoveryFile()">
												<i class="font-icon fa  fa-folder-open-o"	
													style="color: #888"></i>还原文件
											</button>
											<button class="btn btn-default" 
												type="button"  id="delete" onclick="delAll()">
												<i class="font-icon glyphicon glyphicon-trash"
													style="color: #888"></i>清空回收站
											</button>
											

										</div>
										<div class="clearfix"></div>
									</div>
								</div>
							</div>
							<div class="col-md-12" style="top: 2px; z-index: 99999999;">
								<div class="btn-toolbar  main-btnbar pull-right"
									style="position: fixed; right: 21px; margin-top: 1px">
									<div class="btn-group" id="searchnone" style="display: block">
										<a class="btn btn-default active"
											href="home.action?path=${path}" id="btn"><span
											class="glyphicon glyphicon-th-list"></span></a> <a
											class="btn btn-default " 
											id="btn1"><span class="glyphicon glyphicon-th-large"></span></a>
									</div>
								</div>
							</div>

							<div class="col-md-12" style="padding: 0; top: 45px">
								<div class=" panel-col lesson-manage-panel"
									style="min-height: 700px; border: 0px solid transparent;">
									<div class="col-md-12 tableth">
										<div class="hide" id="search-span" style="color: #ADADAD">搜索结果:
											<div id="search-result"></div>
										</div>
										<table class="table  mb-0">
											<thead>
												<tr>
													<th class="table-checkbox"
														style="position: relative; left: 13px;"><label
														class="checkbox checkbox-position" style="min-height: 0"
														for="checkbox1"> <span class="icons icon-span">
																<span class="first-icon fui-checkbox-unchecked"></span>
																<span class="second-icon fui-checkbox-checked"></span>
														</span> <input name="chkAll" type="checkbox" id="operAll"
															onClick="getAll()" value="checkbox" class="main-check">
													</label></th>
													<th class="mainfile-name">文件名</th>
													<th class="hide table-fileposition mainfile-position">文件位置</th>
													<th class="mainfile-size">大小</th>
													<!-- <th class="mainfile-size" id="share_th">分享</th> -->
													<th class="mainchange-date">修改日期</th>
												</tr>
											</thead>
											<tbody id="tab">
												<c:forEach var="fb" items="${list}">
													<tr>
														<td style="top: -6px; position: relative; left: 13px;"><label
															class="checkbox table-checkboxposition" for="checkbox1">
																<span class="icons main-icons"> <span
																	class="first-icon fui-checkbox-unchecked"></span> <span
																	class="second-icon fui-checkbox-checked"></span>
															</span> <input type="checkbox" name='check'
																class="main-tabinput" onclick="show()">
														</label></td>
														<td><span style="display: block"><c:if
																	test="${fb.isdirectory == true}">
																	<img src="assets/images/0.png" class="objimg">
																	<a href="home.action?path=${fb.path}"><input
																		name="objimg" type="text" style="display: none"
																		value="${fb.name}">
																</c:if>${fb.name}<c:if test="${fb.isdirectory == true}">
																	</a>
																</c:if></span>
															<div class="edit-name" style="display: none;">
																<input class="box" type="text" value="${fb.name}">
																<a class="sure" href="javascript:void(0);"
																	onclick="sure()"><span
																	class="glyphicon glyphicon-ok"></span></a> <a
																	class="cancel ml-10" onclick="cancel()"
																	href="javascript:void(0);"> <span
																	class="glyphicon glyphicon-remove"></span></a>
															</div></td>
														<td class="hide table-fileposition table-path">${fb.path}</td>
														<td>${fb.length}</td>

														<%-- <td id="share_td"><c:if test="${fb.length != null}">
																<a type="button"
																	onclick="share('${fb.name}','${fb.path}',${fb.isdirectory},'${fb.length}') "><img
																	src="assets/images/share2.png" width=20px height=20px /></a>
															</c:if></td> --%>

														<!-- <td id="share_td"><a onclick="share();">1</td> -->
														<td>${fb.lastmodified }</td>
													</tr>
												</c:forEach>
											</tbody>

										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>	
		</div>
	</div>
	<div style="height:50px;position:absolute;bottom:0px;left: 38%;float: right;z-index: 100;">  ©2017南京第五十五所技术开发有限公司 版权所有  版本号：V2.0</div>
					<!--  购买容量    -->
					<jsp:include page="common/buystore.jsp"></jsp:include>

					<!--  JavaScript-->
					<script src="assets/javascripts/jquery.min.js"></script>
					<script src="assets/javascripts/bootstrap.min.js"></script>
					<script src="assets/javascripts/fineuploader.js"></script>
					<script src="assets/javascripts/checkbox.js"></script>
					<!-- <script src="assets/javascripts/common.js"></script> -->
					<script src="assets/javascripts/jquery.zclip.min.js"></script>
					<script type="text/javascript">


		

		$(document).ready(function() {
						});
		
		
		/**改的关于复选框 显示重命名、下载、删除、移动、复制按钮   的方法**/
		function show(){
			alert("点击了复选框");
			var obj=document.getElementById("tab");
			var singeSelectFlag=false;
			var allSelectFlag=true;
			for (var i= 0;  i< abj.rows.length; i++) {
				var  ch=abj.rows[i].cells[0].childNodes[0].childNodes[5];
				if (ch.checked==true) {
					disButton();//显示按钮
					singeSelectFlag=true;
				} else {
					allSelectFlag=false;
				}
			}
			if(singeSelectFlag==false)
				hideButton();//隐藏按钮
			if (allSelectFlag==false) {
				document.getElementById("operAll").checked =false;
			} else {
				document.getElementById("operAll").checked =true;
			}
			
			
		}
		
		/**改的隐藏复制等按钮 show()、getAll()调用**/
		function hideButton(){
			document.getElementById("delete").style.display="none";
			document.getElementById("download").style.display="none";
			document.getElementById("rename").style.display="none";
			document.getElementById("copy").style.display="none";
			document.getElementById("move").style.display="none";
			document.getElementById("paste").style.display="none";
		}
		/**改的显示复制等按钮  show()、getAll()调用**/
		function disButton(){
			document.getElementById("delete").style.display="block";
			document.getElementById("download").style.display="block";
			document.getElementById("rename").style.display="block";
			document.getElementById("copy").style.display="block";
			document.getElementById("move").style.display="block";
		}
		
		
		
		
		/**改的全选的方法  与 show()相关 **/
		function getAll(){
			var obj=document.getElementById("tab");
			for (var i = 0; i < obj.rows.length; i++) {
				var ch=obj.rows[i].cells[0].childNodes[0].childNodes[5];
				//alert(ch.checked);
				ch.checked=document.getElementById("operAll").checked;
			}
			if (document.getElementById("operAll").checked) {
				disButton();
			} else {
				hideButton();
			}
			
		}
	    /***改得还原文件的方法1**/
		function recoveryFile(){
	    	alert("还原文件!");
	    	var recoveryData = "";
	    	var tab =document.getElementById("tab");
	    	for (var i = 0; i < tab.rows.length; i++) {
				var ch =tab.rows[i].cells[0].childNodes[0].childNodes[5];
				if (ch.checked ==true) {
					var path =tab.rows[i].cells[2].innerHTML;//文件路径单元格节点
					var name;
					var isDir;
					path =decodeURIComponent(path);
					var fileNameNode =tab.rows[i].cells[1];//文件名单元格节点
					var img =fileNameNode .getElementsByTagName("img");//获得文件名单元格中img标签对象点额集合
					if (img.length>0) {//存在img标签，说明是目录
						isDir = true;
					    name=$(fileNameNode.childNodes[0].childNodes[3].cjildNdes[0]).val();
						
					} else {
						isDir = false;
					    name=fileNameNode.childNodes[0].innerText;
					} 
					recoveryData = path+">"+isDir +",";//大于号隔开			
				}
	    		
			}
	    	recoveryData =recoveryData.substring(0, recoveryData.length-1);//去掉最后的,
	    	alert("recoveryData"+recoveryData);
	    	var data ={filepath :recoveryData};
	    	$.ajax({
	    		url : "recovery.action",
	    		type: "post",
	    		data :data,
	    		success :function (s){
	    			if (s.success) {
						location.reload();
					} else {
						alert(s.msg);
					}
	    		}
	    	});
	    	
	    }

	    /**清空回收站的方法1***/
	    function delAll(){
	    	alert("开始清空回收站……");
	    	var data ="";
	    	$.ajax({
	    		url : "delAll.action",
	    		type: "post",
	    		data:data,
	    		success: function(s){
	    			if (s.success) {
						location.reload();
					} else {
						alert(s.msg);
					}
	    		}
	    	});
	    	
	    }
	    
	    
	    
	    
		
		
		
	</script>
</body>
</html>
