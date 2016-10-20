<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>

<link rel="stylesheet" href="${root}/public/css/responsiveslides.css">
<link rel="stylesheet" href="${root}/public/css/style.css">
<script type="text/javascript" src="${root}/public/js/jquery.js"></script>
<script type="text/javascript" src="${root}/public/js/responsiveslides.min.js"></script>
<script type="text/javascript">

$(function () {
  $("#slider4").responsiveSlides({
	auto: false,
	pager: false,
	nav: true,
	speed: 500,
	namespace: "callbacks",
	before: function () {
	  $('.events').append("<li>before event fired.</li>");
	},
	after: function () {
	  $('.events').append("<li>after event fired.</li>");
	}
  });

});
</script>

</head>
<body>

<div id="wrapper">
	<div class="callbacks_container">
		<ul class="rslides" id="slider4">
		<c:choose>
		  <c:when test="${picture!=null&&fn:length(picture)>0}">
		      <c:forEach var="attach" items="${picture}" varStatus="status">
		        <li>
				  <img src="${root}/images/${attach.attachment_Url}/${attach.name}" alt=""/><br/><br/>
				  <span style="font-weight:bold;font-size: 20px;">${status.index+1}/${fn:length(picture)}</span>
			      <br/><br/>
			      <!--  <input type="text" style="text-align:right; font-weight:bolder; font-size:15px; border:0;" value="图片名称："/> -->
			       <%-- <input type="text" style="font-weight:bolder; font-size:15px;border:0;" value="${fn:substring(attach.name,0,fn:indexOf(attach.name,'.'))}"/> --%>
			       <input type="text" style="text-align:center;font-weight:bold; font-size:18px;border:0;" value="${attach.remark}"/>
			   </li>
		    </c:forEach>
		  </c:when>
		  <c:otherwise>
		     	<li style="font-weight:bold;font-size: 20px;">暂无照片！</li>
		  </c:otherwise>
		</c:choose>

		</ul>
	</div>
</div>

</body>
</html>