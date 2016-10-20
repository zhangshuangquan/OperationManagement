<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta name="renderer" content="webkit">
<title>运营服务平台</title>
<%
	String contextPath = request.getContextPath();
	if (contextPath.equals("/"))
		request.getSession().setAttribute("root", "");
	else
		request.getSession().setAttribute("root", contextPath);
	request.setAttribute("mailReg", "^([a-zA-Z0-9]+[_|\\-|\\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\\-|\\.]?)*[a-zA-Z0-9]+\\.[a-zA-Z]{2,3}$");
	request.setAttribute("userRealNameReg", "^[\\u4E00-\\u9FA5]+$");
	request.setAttribute("telephoneReg", "^(0[1-9]\\d{1,2}\\-)?[1-9]\\d{6,7}$");
	request.setAttribute("mobileReg", "^1[3|4|5|8][0-9]\\d{8}$");
	request.setAttribute("userIdReg", "^[0-9a-zA-Z]{6,20}$");
	request.setAttribute("passwordReg", "^.{6,18}$");
	String str = request.getHeader("User-Agent");
	if(str.indexOf("Android")>0 || str.indexOf("iPad")>0 || str.indexOf("Macintosh")>0){
		request.setAttribute("systype", "pad");
	}else{
		request.setAttribute("systype", "pc");
	}
	if(str.indexOf("Android")>0){
		request.setAttribute("phoneType", "Android");
	}else if(str.indexOf("iPad")>0 || str.indexOf("Macintosh")>0){
		request.setAttribute("phoneType", "ios");
	}else{
		request.setAttribute("phoneType", "all");
	}
%>
<link media="all" type="text/css" rel="stylesheet" href="${root }/public/css/reset.css"/>
<link type="text/css" rel="stylesheet" href="${root }/public/css/header.css" media="screen">
<link type="text/css" rel="stylesheet" href="${root }/public/css/global.css" media="screen">
<script src="${root }/public/js/jquery.js" type="text/javascript"></script> 
<script src="${root }/public/js/extend.js" type="text/javascript"></script>
<script src="${root }/public/js/litewin.js" type="text/javascript"></script>
<script src="${root }/public/js/basiccheck.js" type="text/javascript"></script>
<script src="${root }/public/js/splitpage.js" type="text/javascript"></script>
<script src="${root }/public/js/common.js" type="text/javascript"></script>
<link type="text/css" rel="stylesheet" href="${root }/public/calendar/skin/WdatePicker.css" media="screen">
<script src="${root }/public/calendar/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
	var ROOT =  '${root }';
	$(document).on('ajaxComplete', function (jqXHR, xhr) {<%-- 判断ajax请求连接是否登录 --%>
		var responseText = xhr.responseText;
		var start = responseText.indexOf("<script>top.location='");
		if(start>-1 && start < 10){
			top.location="${root}/login.html";
		}
	});
</script>