<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
</head>
<body>
<div class="commonWrap pd10">
<form  action="">
	<label class="mr50">学科:${evaStandard.subjectName }</label>
	<label class="mr50">撰写方:${evaStandard.baseUserName }</label>
	<label class="mr50">满分：${evaStandard.totalScore }</label>
	<table  class="tableBox">
			<tr>
				<td width="20%">项目</td>
				<td width="70%">评价内容</td>
				<td width="10%">分数</td>
			</tr>
			<c:forEach items="${evaStandard.evaStandardItems}" var="item">
				<c:choose>
					<c:when test="${fn:length(item.standardItemChildren) == 0}">
						<tr>
							<th colspan="2">${item.standardItemName}</th>
							<%-- <td colspan="2">${item.standardItemName}sp;</td> --%>
							<td>${item.score }</td>
						</tr>
					</c:when>
					<c:when test="${fn:length(item.standardItemChildren) == 1}">
						<tr>
							<th rowspan="1">${item.standardItemName}</th>
							<c:forEach items="${item.standardItemChildren}" var="child"  varStatus="status">
								<td>${child.content}</td>
								<td>${child.score}</td>
							</c:forEach>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${item.standardItemChildren}" var="child"  varStatus="status">
							<c:if test="${status.index==0 }">
								<tr>
									<th rowspan="${fn:length(item.standardItemChildren)}">${item.standardItemName}</th>
									<td>${child.content}</td>
									<td>${child.score}</td>
								</tr>
							</c:if >
							<c:if  test="${status.index>0 }">
								<tr>
									<td>${child.content}</td>
									<td>${child.score}</td>
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