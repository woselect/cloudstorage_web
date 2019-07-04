
<%@ page language="java" pageEncoding="UTF-8"%>
<div class="main">
	<div class="main-left" style="z-index: 1;">
		<div class="main-left" style="z-index: 1;">
			<div class="list-group category" style="margin: 10px;">
				<a class="list-group-item " id="r_active" href="home.action"><span
					class="glyphicon glyphicon-home left-icon"></span>&nbsp;&nbsp;全部文件</a>
				<a class="list-group-item " href="category.action?type=2"><span
					class="glyphicon glyphicon-file left-icon"> </span>&nbsp;&nbsp;我的文档</a>
				<a class="list-group-item " href="category.action?type=1"><span
					class="glyphicon glyphicon-picture left-icon"></span>&nbsp;&nbsp;我的图片</a>
				<a class="list-group-item " href="category.action?type=3"><span
					class="glyphicon glyphicon-film left-icon"></span>&nbsp;&nbsp;我的视频</a>
				<a class="list-group-item " href="category.action?type=4"><span
					class="glyphicon glyphicon-music left-icon"></span>&nbsp;&nbsp;我的音乐</a>
				<a class="list-group-item" href="category.action?type=5"><span
					class="glyphicon glyphicon-inbox left-icon"></span>&nbsp;&nbsp;其他</a>
				<a class="list-group-item" href="category.action?type=5"><span
					class="glyphicon glyphicon-inbox left-icon"></span>&nbsp;&nbsp;我的分享</a>
				<a class="list-group-item active" href="garbage.action"><span
					class="glyphicon glyphicon-trash left-icon"></span>&nbsp;&nbsp;垃圾箱</a>
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
</div>



<!-- <div class="col-sm-3 col-md-2 sidebar " id="leftshow">
				<ul class="nav nav-sidebar mb-0" id="toggle">
					<li><a href="home.action"><span class="menu-icons fa fa-home left-icon"></span>&nbsp;&nbsp;全部文件</a></li>
					<li><a href="category.action?type=2"><span class="glyphicon glyphicon-file left-icon"></span>&nbsp;&nbsp;我的文档</a></li>
					<li><a href="category.action?type=1"><span class="glyphicon glyphicon-picture left-icon"></span>&nbsp;&nbsp;我的图片</a></li>
					<li><a href="category.action?type=3"><span class="glyphicon glyphicon-film left-icon"></span>&nbsp;&nbsp;我的视频</a></li>
					<li><a href="garbage.action"><span class="menu-icons fa fa-refresh left-icon"></span>&nbsp;&nbsp;回收站</a></li>
					<li class="left-line"></li>
					<li><a href="grxx.action"><span class="glyphicon glyphicon-cog left-icon"></span>&nbsp;&nbsp;设置</a></li>
					<li class="left-line"></li>
				</ul>
				<div class="mt-10">
					<div class="my-capacity">我的容量:</div>
					<div class="addmy-capacity">
						<a href="javascript:void(0);" class="capacity">扩容</a>
					</div>
					<div class="progress">
						<div class="progress-bar"></div>
					</div>
				</div>
			</div> -->