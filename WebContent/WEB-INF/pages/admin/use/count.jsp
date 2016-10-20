<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>Insert title here</title>
</head>
<body>
	<center>
	<br>
	<br>
	<h4>总计</h4>
	<table style="width: 800px" border="1" >
		<thead>
			<tr>
				<th>签到</th>
				<th>项目</th>
				<th>学校</th>
				<th>教室</th>
				<th>供应商</th>
				<th>区域资源</th>
				<th>工单</th>
			</tr>
		</thead>
		<tbody align="center">
			<tr>
				<td>${count[0]}</td>
				<td>${count[1]}</td>
				<td>${count[2]}</td>
				<td>${count[3]}</td>
				<td>${count[4]}</td>
				<td>${count[5]}</td>
				<td>${count[6]}</td>
			</tr>
		</tbody>
	</table>
	
	<br>
	<br>
	
	<h4>上周新增</h4>
	<table style="width: 800px"  border="1">
		<thead>
			<tr>
				<th>签到</th>
				<th>项目</th>
				<th>学校</th>
				<th>教室</th>
				<th>供应商</th>
				<th>区域资源</th>
				<th>工单</th>
			</tr>
		</thead>
		<tbody align="center">
			<tr>
				<td>${zhoucount[0]}</td>
				<td>${zhoucount[1]}</td>
				<td>${zhoucount[2]}</td>
				<td>${zhoucount[3]}</td>
				<td>${zhoucount[4]}</td>
				<td>${zhoucount[5]}</td>
				<td>${zhoucount[6]}</td>
			</tr>
		</tbody>
	</table>
	</center>
</body>
</html>