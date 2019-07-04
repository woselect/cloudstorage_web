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
						<a class="list-group-item active" id="r_active" href="home.action"><span
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
												type="button"  id="delete" onclick="del()">
												<i class="font-icon glyphicon glyphicon-trash"
													style="color: #888"></i>删除
											</button>
											<a class="btn btn-default" type="button"
												style="display: none;" 
												href="javascript:void(0)" id="download" onclick="downloadfile()"
												style="background: #F6F6F6;"> <i
												class="font-icon glyphicon glyphicon-download-alt"
												style="color: #888"></i>下载</a>
											<button class="btn btn-default" style="display: none;"
												type="button" id="rename" onclick="rename()">
												<i class="font-icon glyphicon glyphicon-pencil"
													style="color: #888"></i>重命名
											</button>
											<a class='btn btn-default' style="display: none;"
												href="javascript:void(0);" id="download"> <span
												class="glyphicon glyphicon-download-alt"><span>下载文件</a>
											<a href="javascript:void(0);" class='btn btn-default'
												style="display: none;" id="copy" onclick="copy()"> <span
												class="glyphicon glyphicon-file"></span>复制
											</a> 
											<a href="javascript:void(0);" class='btn btn-default'
												style="display: none;" id="move" onclick="move()"> <span
												class="glyphicon glyphicon-transfer"></span>移动
											</a> 
											<a href="javascript:void(0);" class='btn btn-default'
												 id="paste" onclick="paste()" >
												<span class="glyphicon glyphicon-pencil"></span>粘贴
											</a> 
											<a class='btn btn-default' style="display: none"
												id="Dataanalysis" target="_blank"> </a>
											<ul
												style="position: relative; float: left; padding-left: 0px">
												<li class="dropdown" style="list-style: none"><a
													class="dropdown-toggle btn btn-default"
													data-toggle="dropdown" id="selectColumn"
													style="display: none; border-radius: 0px; padding: 4px 12px;"
													href="javascript:void(0);">数据分析</a>
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
											</ul>

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
							createUploader();
							
							/** 加载完后就判断粘贴按钮是否显示**/
							var operFlag="${sessionScope.operFlag}";
							alert("operFlag类型："+operFlag);
							if (operFlag == "" || operFlag ==null) {
								document.getElementById("paste").style.display="none";
							} else {
                                document.getElementById("paste").style.display="block";
							}
							
						});
		
		
		/**改的关于复选框 显示重命名、下载、删除、移动、复制按钮   的方法**/
		function show(){
			alert("点击了复选框");
			var obj=document.getElementById("tab");
			var singeSelectFlag=false;
			var allSelectFlag=true;
			for (var i= 0;  i< obj.rows.length; i++) {
				var  ch=obj.rows[i].cells[0].childNodes[0].childNodes[5];
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
		
		
		


		//上传文件
		function createUploader() {
			var uploader = new qq.FineUploader(
					{
						element : document.getElementById('result-uploader'),
						request : {
							endpoint : 'uploadfile.action'
						},
						text : {
							uploadButton : '<i class="glyphicon glyphicon-plus"></i>上传文件'
						},
						template : '<div class="qq-uploader">'
								+ '<pre class="qq-upload-drop-area"><span>{dragZoneText}</span></pre>'
								+ '<div class="qq-upload-button btn btn-default btn-sm" style="background: #F6F6F6;border: 1px solid rgb(206, 206, 206);display: inline;top: 3px;padding: 5px 15px 7px 15px;width: 100%;position: relative;overflow: hidden;border-radius: 0;">{uploadButtonText}</div>'
								+ '<span class="qq-drop-processing" style="display:none"><span>{dropProcessingText}</span>'
								+ '<span class="qq-drop-processing-spinner"></span></span>'
								+ '<ul class="qq-upload-list" style="margin-top: 10px; text-align: center;display:none"></ul>'
								+ '</div>',
						classes : {
							success : 'alert alert-success',
							fail : 'alert alert-error'
						},
						callbacks : {
							onComplete : function(id, fileName, responseJSON) {
								if (responseJSON.success) {
									var fielpath = responseJSON.other;
									createfile(fileName, fielpath);
								}
							}
						}
					});
		}
		/** 改的上传的1   **/
		function createfile(fileName, filepath) {
			var data={
					path:"${path}",
					name:fileName,
					filepath:filepath
			};
			$.ajax({
				url:"createfile.action",
				type:"post",
				data:data,
				success:function(s){    
					location.reload();
					alert("上传成功！");
				}
			});

		}
	
		/**改的添加函数 创建目录1**/
	   function createDirectory(){
			var  name=prompt("请输入要创建的目录名：");
			if (name==null || name=="") {
				alert("目录名不能为空！")
			} else if(name.indexOf("/")>= 0 || name.indexOf(".")>=0){
				alert("创建的目录名中不能含 . 或/")
			}else{
				var path="${path}";
				var dirname=name;
				data={
					path:path,  
					name:dirname
				};
				$.ajax({
					url:"createdir.action",
					type:"post",
					data:data,
					success:function (s){
						if (s.success) {
							location.reload();
						} else {
							s.msg;
						}
						
					}
					
				});
				
			}
			
		}
		
		
		
		
		
		
		
		
		/**改的搜索的方法1**/
		function searchfile(){      
			var list;
		    var key=$("#navbarInput-01").val();
		    if(key=="" || key==null){
		    	alert("搜索内容不能为空！！");
		    	return;
		    	
		    }
		    var data={key:key};
		    $.ajax({
		    	url:"search.action",
		    	type:"post",
		    	data:data,
		    	async:false,//同步
		    	dataType:"html",//接收响应的数据类型，响应的是一个页面，所以用html
		    	
		    	success:function(data){
		    		alert("搜索好了");
		    		$("#search-span").attr("class","open>.cloudanys");//显示隐藏的控件，只能修改class
		    		$("#search-result").html(data);//把响应的页面放到一个div中显示
		    		
		    	}
		    });
		    
			
		}
		
		
		
		
		/**改的删除的方法1**/
		function del(){
			if(confirm("你确定要删除所选的文件吗？")){
				var tab=document.getElementById("tab");
				var data='[';
				var isDir;
				for (var i = 0; i < tab.rows.length; i++) {
					var ch=tab.rows[i].childNodes[0].childNodes[5];
					if(ch.checked ==true){
						var cells=tab.rows[i].cells;
						var path=cells[2].innerHTML;//文件路 径单元格节点
						path=decodeURIComponent(path);//解码 '/'将被解码成%2F
						var fileNameNode=cells[1];//文件名单元格节点
						var name;
						var img=fileNameNode.getElementsByTagName("img");//获得文件名单元格中img标签的对象的集合
						if (img.length>0) {//存在img标签说明是()目录
							isDir=true;
							name=$(fileNameNode.childNodes[0].childNodes[3].childNodes[0]).val();
						} else {
                            isDir=false;
                            name=fileNameNode.childNodes[0].innerText;
						}
						data +='{"path":"'+path+'","name":"'+name+'","isDir":"'+isDir+'"}';
						if (i<tab.rows.length-1) {
							data+=',';
						}
						
					}
					
				}
				data+=']';
				alert("data:"+data);
				var data=eval('('+data+')');
				$.ajax({
					url:"delete.action",
					type:"post",
					contentType:"application/json; charset=tuf-8",
					data:JSON.stringify(data),
					success:function(s){
						if (s.success) {
							alert("删除成功！");
							location.reload();
						} else {
     						alert(s.msg);
						}
					}
				});
				
			}
			
		}
		
		
		
		
		
		
		
		/**改的重命名的方法1**/
		function rename(){
			var tab =document.getElementById("tab");
			var j=0;//勾选的重命名文件的个数
			var a;
			for (var i = 0; i < tab.rows.length; i++) {
				var ch=tab.row[i].cells[0].childNodes[0].childNodes[5];
				if(ch.checked ==true){
					j++;
					a=i;
				}
			}
			if (j== 1) {
				var name=prompt("请输入新的文件名/文件夹名:");
				if (name.indexOf("/") >=0) {
					alert("文件名货文件夹名不能包含符号'/'！");
				} else if(name!="" && name!=null){
				    var path=tab.rows[a].cells[2].innerHTML;//cells[2]位第二单元格，即路径的值
					path =decodeURIComponent(path);//解码 '/'将被解码成%2F
				    var td=tab.rows[a].cells[1];//文件、文件夹名字单元格
					var img=tab.getElementsByTagName("img");
					var isDir;
					if (img.length>0) {
						isDir =true;
					} else {
						isDir =false;
					}
					var flag=true;
					//增加出错处理
					if (isDir) {//目录中不能包含.
						if (name.indexOf(".")>=0) {
							alert("文件夹名中不能包含符号.");
							flag=false;
						}
						
					}else if (!isDir) {//文件名后缀必须一致
						var fileDot =name.lastIndexOf(".");
						if (name.lastIndexOf(".")!=name.indexOf(".")) {
							alert("新文件名包含多个.");
							flag=false;
						} else {
							var pathDot =path.lastIndexOf(".");
							var fileSuffix=name.substring(fileDot+1, name.length);//文件后缀
							var pathSuffix=path.substring(pathDot+1,path.length);//路径后缀
							if (fileSuffix.toLowerCase() != pathSuffix.toLowerCase()) {
								alert("新文件名的后缀与老文件不一致");
								flag=false;
							} else {
								var pathSplit =path.lastIndexOf("/");
								var pathNamePre=path.substring(pathSplit+1, pathDot);
								var namePre =name.substring(0, fileDot);
								if(pathNamePre == namePre){
									alert("新文件名与老文件名相同！");
									flag=false;
								}
							}

						}
						
					}
					if(flag){//可以改
						var data={
							path:path,
							name:name,
							isDir:isDir
					    };
						$.ajax({
							url:"rename.action",
							type:"post",
							data:data,
							success:function (s){
								if (s.success) {
									location.reload();//刷新页面
								} else {
									alert(s.msg);
								}
							}
						});
					}
					
					
				}
			} else {
				alert("您确信能同时对多个文件进行重命名操作吗？");
				var elems=document.getElementsByName("check");
				//清除所有选项
				for (var i = 0; i < elems.length; i++) {
					if(elems[i].type == "checkox")
						elems[i].checked=false;
				}
				hideButton();

			}
			
		}
	  
		
		
		
		
		
		
		
		
		
		/**改的移动或者是复制1 被copy 和move调用**/
		function copyormove(){
			var tab=document.getElementById("tab");
			for (var i = 0; i < tab.rows.length; i++) {
				var ch=tab.rows[i].cells[0].childNodes[0].childNodes[5];
				if (ch.checked ==true) {
					var path=tab.rows[i].cells[2].innerHTML;//文件路径单元格节点
					var name;
					var isDir;
					path=decodeURIComponent(path);  //解码 '/'将被解码成%2F 
				    var fileNameNode=tab.rows[i].cells[1];//文件名单元格节点
				    var img=fileNameNode.getElementsByTagName("img");//获得文件名单元格中img标签对象的集合
				    if (img.length>0) {//存在img标签，说明是目录
						isDir=true;
				        name=$(fileNameNode.childNodes[0].chlidNodes[3].childNodes[0]).val();
					} else {
						isDir=false;
				        name=fileNameNode.childNodes[0].innerText;
					}
				    copyOrMoveData +=path+">"+isDir+",";//大于号隔开
				    copyOrMoveFileName +=name+',';
				    
				}
			}
			copyOrMoveFileName = copyOrMoveFileName.substring(0, copyOrMoveFileName.length-1);//去掉最后的
			copyOrMoveData = copyOrMoveData.substring(0, copyOrMoveData.length-1);//去掉最后的
			document.getElementById("paste").style.display="block";//显示粘贴按钮
			
		}
		
		
		
		
		/**改的复制的方法1**/
		var copyOrMoveData="";
		var sourcePath;//保存复制前的路径信息，粘贴时，与之相比较，如果相同，则不允许粘贴
		var copyOrMoveFileName='';
		
		function copy(){
			sourcePath="${path}";//源路径
			copyormove();//调方法
			var oper="copy";
			alert("copyOrMoveData:"+copyOrMoveData);
			var data={
					filePath:copyOrMoveData,
					fileName:copyOrMoveFileName,
					oper:oper,
					sourcePath:sourcePath
			};
			$.ajax({
				url:"copyormove.action",
				type:"post",
				data:data,
				success: function (s){
					if (s.success) {
						location.reload();//刷新页面
					} else {
						alert(s.msg);
					}
				}
			});
			
			
		}
		
		
		/**改的移动的方法1**/
		function move (){
			sourcePath ="${path}";
			copyormove();
			var oper = "move";
			alert("copyOrMoveData:"+copyOrMoveData);
			var data={
				filePath : copyOrMoveData,
				fileName : copyOrMoveFileName,
				oper     : oper,
				sourcePath:sourcePath
				
			};
			$.ajax({
				url: "copyormove.action",
				type:"post",
				data:data,
				success: function (s){
					if (s.success) {
						location.reload();//刷新页面
					} else {
						alert(s.msg);
					}
				}
			});
			
		}
		
		
		
		
		
		
		
	   /**改的粘贴的方法1**/
	   function paste (){
		   //首先判断是否粘贴在同一位置
		   var path="${path}";//获取path的值，path设置在第四行
		   alert("粘贴");
		   var sourceFilePath = "${sessionScope.sourceFilePath}";
		   var sourceFileName ="${sessionScope.sourceFileName}";
		   var operFlag ="${sessionScope.operFlag}";
		   var old="${sessionScope.sourcePath}";
		   if (path == old) {
			alert("不能粘贴在同一路径下！");
		} else {
          var tab =document.getElementById("tab");
          var split = sourceFileName.split(',');
          var i=0;//如果tab中没有数据，则循环不会执行
          for (; i < tab.rows.length; i++) {
        	  var name;
        	  path=decodeURIComponent(path);  //解码 '/'将被解码成%2F 
			  var fileNameNode=tab.rows[i].cells[1];//文件名单元格节点
			  var img=fileNameNode.getElementsByTagName("img");//获得文件名单元格中img标签对象的集合
			  if (img.length>0) {//存在img标签，说明是目录
				  isDir =true;
			      name=$(fileNameNode.childNodes[0].childNodes[3].childNodes[0]).val();
				
			} else {
				isDir =false;
				name=fileNameNode.childNodes[0].innerText;  
			}
			for (var j = 0; j < split.length; j++) {
				if (split[j] ==name) {//文件已存在
					var mymessage =confirm("文件已存在，确定要覆盖吗？");
				    if (mymessage == true) {//覆盖
						alert("覆盖！");
						var data ={
								oldpath:sourceFilePath,
								newpath:path
						};
						var url;
						if (operFlag =="copy")
							url ="paste.action";
						else if(operFlag =="move")
							url ="move.action";
						
                        $.ajax({
                        	url:url,
                        	type:"post",
                        	data:data,
                        	success: function (s){
                        		hideButton();
                        		copyOrMoveData ="";//数据清空
                        		if (s.success) {
									alert("粘贴成功！");
									location.reload();
								} else {
									alert(s.msg);
								}
                        	}
                        });
						
						
					}
				    else if (mymessage == false) {//不覆盖
						alert("不覆盖！");
				    	hideButton();
				    	copyOrMoveData="";//数据清空
				    	location.reload();
					}
				    
				    
				    
				    
				
				
					
				} else {//文件不存在
					var data={
						oldpath:sourceFilePath,
						newpath:path
				    };
					var url;
					if(operFlag == "copy")
						url ="paste.action";
					else if(operFlag =="move")
						url = "move.action";
					$.ajax({
						url:url,
						type:"post",
						data:data,
						success: function (s){
							hideButton();
							copyOrMoveData="";//数据清空
							if (s.success) {
								alert("粘贴成功！");
								location.reload();
							} else {
								alert(s.msg);
							}
						}
					});
				}
			}
		  }
          if (i == 0) {//当前文件夹下没有数据
		  	var data={
        		oldpath:sourceFilePath,
        		newpath:path
            };	        	  
        	var url;
        	if(operFlag =="copy")  
        	    url ="paste.action";
        	else if(operFlag =="move")
				url ="move.action";
        	$.ajax({
        		url:url,
        		type:"post",
        		data:data,
        		success: function (s){
        			hideButton();
        			copyOrMoveData ="";//数据清空
        			if (s.success) {
						alert("粘贴成功！");
						location.reload();
					} else {
						alert(s.mag);
					}
        		}
        	});
        	
        	
		}
          
          
		}
	   }	
		
		
		
	 /**改的下载的方法1**/
	 function downloadfile(){
		 var tab =document.getElementById("tab");
		 var data="";
		 var flag =true;
		 for (var i = 0; i < tab.rows.length; i++) {
			var ch=tab.rows[i].cells[0].childNodes[0].childNodes[5];
			if (ch.checked == true) {
				var path=tab.rows[i].cells[1].innerHTML;//文件单元格节点
				path =decodeURIComponent(path);//解码 '/'将被解码成%2F 
				var fileNameNode = tab.rows[i].cells[1];//文件名单元格节点
				var  img=fileNameNode.getElementsByTagName("img");//获得文件名单元格中img标签对象的集合
				if (img.length >0) {//选中的是目录
					alert("不能下载目录！");
				//必须使用下述的语句将download 清空，否则下次选中目录时，也会下载上次下载过的文件
				$("#download").attr("href","javascript :void(0);");
				flag =false;
				} else {
				  data +=path +",";
				}
			}
		}
		if (flag ==true) {
			data =data.substring(0, data.length-1);//去掉最后的逗号
			$("#download").attr("href","download.action?paths="+data);
		}
	    var elems =document.getElementsByName("check");
	    //清除所有选项
	    for (var i = 0; i < elems.length; i++) {
			if(elems[i].type =="checkbox")
				elems[i].checked =false;
		}
		hideButton();
		window.location.reload();
	 }
		
		//可能少一个'}'
		
		
		
		
	</script>
</body>
</html>
