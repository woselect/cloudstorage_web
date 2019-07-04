<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>
<body>

	<table class="table  mb-0">
    <thead>
		<tr>
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
			<td>${fb.name}</td>
			<td class="table-fileposition table-path">${fb.path}</td>
			<td>${fb.length}</td>
			<td>${fb.lastmodified }</td>
		</tr>
		</c:forEach>
	</tbody>

	</table>	

</body>
</html>