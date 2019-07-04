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
                        <a class="list-group-item" href="category.action?type=5"><span
				           class="glyphicon glyphicon-inbox left-icon"></span>&nbsp;&nbsp;我的分享</a>
						<a class="list-group-item" href="garbage.action"><span
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
											<button class="btn btn-default" type="button" id="newdir" onclick="createDirectory()">
												<i class="font-icon fa  fa-folder-open-o"	
													style="color: #888"></i>新建文件夹
											</button>
											<button class="btn btn-default" style="display: none;"
												type="button"  id="delete" >
												<i class="font-icon glyphicon glyphicon-trash"
													style="color: #888"></i>删除
											</button>
											<a class="btn btn-default" type="button"
												style="display: none;" 
												href="javascript:void(0)" id="download"
												style="background: #F6F6F6;"> <i
												class="font-icon glyphicon glyphicon-download-alt"
												style="color: #888"></i>下载</a>
											<button class="btn btn-default" style="display: none;"
												type="button" id="rename">
												<i class="font-icon glyphicon glyphicon-pencil"
													style="color: #888"></i>重命名
											</button>
											<a class='btn btn-default' style="display: none;"
												href="javascript:void(0);" id="download"> <span
												class="glyphicon glyphicon-download-alt"><span>下载文件</a>
											<a href="javascript:void(0);" class='btn btn-default'
												style="display: none;" id="copy" > <span
												class="glyphicon glyphicon-file"></span>复制
											</a> 
											<a href="javascript:void(0);" class='btn btn-default'
												style="display: none;" id="move" > <span
												class="glyphicon glyphicon-transfer"></span>移动
											</a> 
											<a href="javascript:void(0);" class='btn btn-default'
												style="display: none;" id="rename" >
												<span class="glyphicon glyphicon-pencil"></span>重命名
											</a> 
											<a class='btn btn-default' style="display: none"
												id="Dataanalysis" target="_blank"> </a>
											<ul
												style="position: relative; float: left; padding-left: 0px">
												<li class="dropdown" style="list-style: none"><a
													class="dropdown-toggle btn btn-default"
													data-toggle="dropdown" id="selectColumn"
													style="display: none; border-radius: 0px; padding: 4px 12px;"
													hr   ef="javascript:void(0);">数据分析</a>
													<ul class="dropdown-menu cloudanys"
														style="margin-top: 4px !important;">  
														<li><a href="javascript:void(0);"
															onclick="analysis1.action">词云分析</a></li>
														<li class="divider"></li>
														<li><a href="javascript:void(0);"
															onclick="analysis2.action">柱状分析</a></li> 
														<li class="divider"></li>
														<li><a href="javascript:void(0);"
															onclick="analysis3.action">气泡分析</a></li>
													</ul></li>
											</ul>n  

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
													<th class="table-fileposition mainfile-position">文件位置</th>
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
														<td class="table-fileposition table-path">${fb.path}</td>
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
					
					
					var  type;
					$(document).ready(function (){
						type=${type};
						if (type==1) 
							$("#image").attr("class","list-group-item active");
						else if (type==2) 
							$("#doc").attr("class","list-group-item active");
						else if (type==3) 
							$("#media").attr("class","list-group-item active");
						else if (type==4) 
							$("#mp3").attr("class","list-group-item active");
						else if (type==5) 
							$("#other").attr("class","list-group-item active");
						
					});
					
					
					
					
					
					
					

	</script>
</body>
</html>
