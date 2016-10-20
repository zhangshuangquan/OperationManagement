<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
<head>
<style>
.text_center{
	text-align:center;
}
</style>
</head>
<body>
<div class="commonWrap pd10">
<form  action="">
	<label class="mr50">学科: ${evaStandard.subjectName }</label>
	<label class="mr50">撰写方: ${evaStandard.baseUserName}</label>
	<label class="mr50">满分：${evaStandard.totalScore }</label>
	<table  class="tableBox">
			<tr>
				<th width="20%" style="background:#EAF6F4 none repeat scroll 0% 0%">项目</td>
				<th width="70%" style="background:#EAF6F4 none repeat scroll 0% 0%">评价内容</td>
				<th width="10%" style="background:#EAF6F4 none repeat scroll 0% 0%">分数</td>
			</tr>
			<c:forEach items="${evaStandard.evaStandardItems}" var="item">
				<c:choose>
					<c:when test="${fn:length(item.standardItemChildren) == 0}">
						<tr>
							<td colspan="2" class="text_center">${item.standardItemName}</td>
							<%-- <td colspan="2">${item.standardItemName}sp;</td> --%>
							<td class="text_center">${item.score }</td>
						</tr>
					</c:when>
					<c:when test="${fn:length(item.standardItemChildren) == 1}">
						<tr>
							<td rowspan="1" class="text_center">${item.standardItemName}</td>
							<c:forEach items="${item.standardItemChildren}" var="child"  varStatus="status">
								<td>${child.content}</td>
								<td class="text_center">${child.score}</td>
							</c:forEach>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${item.standardItemChildren}" var="child"  varStatus="status">
							<c:if test="${status.index==0 }">
								<tr>
									<td rowspan="${fn:length(item.standardItemChildren)}" class="text_center">${item.standardItemName}</td>
									<td>${child.content}</td>
									<td class="text_center">${child.score}</td>
								</tr>
							</c:if >
							<c:if  test="${status.index>0 }">
								<tr>
									<td>${child.content}</td>
									<td class="text_center">${child.score}</td>
								</tr>
							</c:if>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</table>
</form>
</div>
</body>
</html>