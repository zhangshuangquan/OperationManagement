<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../../common/meta.jsp" %>
    <link href="${root}/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
     <script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
     <script src="${root}/public/js/jsTree.js" type="text/javascript"></script>
    <style>
		.labelTextEdit {
			width: 240px;
		    display: inline-block;
		    min-width: 80px;
		    text-align: right;
		}
        .c-r{overflow: hidden;}
        .original-qs{padding: 0 20px;}
        .original-qs li{margin-bottom: 10px;}
        .chase-ask{font-size: 14px;color: #50732d;}
        .chase-ask h3{padding: 5px 20px;border-top: 1px solid #ccc;border-bottom: 1px solid #ccc;margin-bottom: 5px;}
    </style>
</head>
<body class="chase-ask">
	<h4>基本信息</h4>
    <ul class="searchWrap">
        <li class="clearfix" style="margin:5px 0 15px;">
        	<label class="labelText">学校区域：</label>
                 <span>  ${classroom.schoolArea }                 </span>
           <label class="labelText"> 学校：</label>
                <span>
                    ${classroom.clsSchoolName}                </span>
            <label class="labelText">教室：</label>
                <span>
                   ${classroom.roomName}                </span>
            <label class="labelText">教室类别：</label>
                <span>
                    ${classroom.roomType}                </span>
        </li>
        <li class="clearfix" >
            <label class="labelText">联系人：</label>
                 <span>
                    ${classroom.contactPersonName}                </span>
           	<label class="labelText" style="margin-left:55px;">	手机：</label>
                <span>
                    ${classroom.contactPersonPhone}               </span>
        </li>
     </ul>
     <ul class="commonUL borderBox">
     	<li class="clearfix" style="margin:5px 0 15px;">
     		<label class="labelTextEdit">工程师：</label>${classroom.installUserName}</span>
     	</li>
        <li class="clearfix" >
            <label class="labelTextEdit">TeamviewID：</label>
            
                <span>
                    ${classroom.teamviewid}                </span>
           <label class="labelTextEdit">Teamview密码：</label>
                <span class="c-r">
                    ${classroom.teamviewpsd }</span>
        </li>
        <li class="clearfix" >
            <label class="labelTextEdit">在线课堂服务器地址：</label>
                <span>
                    ${classroom.zxktService}                </span>
        </li>
        <li class="clearfix" >
            <label class="labelTextEdit">在线课堂服务器账号、密码：</label>
                <span>
                    ${classroom.zxktUserNamePsd}                </span>
        </li>
        <li class="clearfix" >
            <label class="labelTextEdit">导播/插件版本：</label>
            
                <span>
                    ${classroom.dbcjVersion}                </span>
 			<label class="labelTextEdit">产品版本号：</label>
                <span>
                	
                    ${classroom.projectVersion }    </span>
        </li>
        <li class="clearfix" >
            <label class="labelTextEdit">实施进展：</label>
                <span>${classroom.implementationProgress}</span>
 			<label class="labelTextEdit">实施时间：</label>
 			  <c:choose>
 			    <c:when test="${classroom.implementationTimeBegin==null&&classroom.implementationTimeEnd==null}">
 			        <span></span>
 			    </c:when>
 			    <c:otherwise>
 			     <c:choose>
 			       <c:when test="${classroom.implementationTimeBegin==null||classroom.implementationTimeEnd==null}">
 			             <span>
                    <fmt:formatDate value="${classroom.implementationTimeBegin }" pattern="yyyy-MM-dd"/>  <fmt:formatDate value="${classroom.implementationTimeEnd }" pattern="yyyy-MM-dd"/>
                </span>
 			       
 			       </c:when>
 			       <c:otherwise>
 			             <span>
                    <fmt:formatDate value="${classroom.implementationTimeBegin }" pattern="yyyy-MM-dd"/> 至  <fmt:formatDate value="${classroom.implementationTimeEnd }" pattern="yyyy-MM-dd"/>
                </span>
 			       </c:otherwise>
 			     </c:choose>
 			      
 			    
 			    </c:otherwise>
 			  </c:choose>
               
        </li>
        <li class="clearfix" >
            <label class="labelTextEdit">主材设备序列号：</label>
            
                <span>
                    ${classroom.zcsbNum}                </span>
            <label class="labelTextEdit">产品质保期：</label>
                <span>
                    ${classroom.productWarrantyPeriod }    </span>
        </li>
        <li class="clearfix" >
            <label class="labelTextEdit">监管平台地址（内外网）：</label>
                <span>
                    ${classroom.jgptAddress}                </span>
        </li>
        <li class="clearfix" >
            <label class="labelTextEdit">监管平台服务器地址：</label>
            
                <span>
                    ${classroom.jgptService}                </span>
        </li>
        <li class="clearfix" >
            <label class="labelTextEdit">监管平台服务器账号、密码：</label>
                <span>
                    ${classroom.jgptNamePsd}               </span>
        </li>
        <li class="clearfix" >
            <label class="labelTextEdit">服务器配置：</label>
                <span>
                    ${classroom.serviceInfo}                </span>
             <label class="labelTextEdit" style="margin-left:7px;">网络配置：</label>
                <span>
                    ${classroom.netInfo}</span>
        </li>
         <li class="clearfix" >
            <label class="labelTextEdit">黑板样式：</label>
                <span>
                    ${classroom.blackboard}                </span>
           <label class="labelTextEdit" style="margin-left:7px;">讲台配置：</label>
                <span>
                    ${classroom.platform}                 </span>
        </li>
         <li class="clearfix" >
            <label class="labelTextEdit">班班通情况：</label>
            
                <span>
                    ${classroom.bbtInfo}                </span>
          <label class="labelTextEdit" style="margin-left:7px;">是否打标签：</label>
                <span>
                    ${classroom.isSign}                 </span>
        </li>
         <li class="clearfix" >
            <label class="labelTextEdit">调试状态：</label>
            
                <span>
                    ${classroom.status}                </span>
           <label class="labelTextEdit" style="margin-left:7px;">是否已培训：</label>
                <span>
                    ${classroom.isTrain}                 </span>
        </li>
         <li class="clearfix" >
            <label class="labelTextEdit">培训讲师：</label>
                <span>
                    ${classroom.trainTeacher}                </span>
             <label class="labelTextEdit" style="margin-left:7px;">是否验收：</label>
                <span>
                    ${classroom.isCheck}                 </span>
        </li>
         <li class="clearfix" >
            <label class="labelTextEdit">培训时间：</label>
                <span>
                     <fmt:formatDate value="${classroom.trainTime}" pattern="yyyy-MM-dd"/> 
                                 </span>
              <label class="labelTextEdit" style="margin-left:7px;">开课情况：</label>
                <span>
                    ${classroom.isStart}                 </span>
        </li>
         <li class="clearfix" >
            <label class="labelTextEdit">备注：</label>
                <span>
                    ${classroom.remark}                </span>
        </li>
        <%-- <li class="clearfix" >
          
              <table class="tableBox center">
                 <tr><th>图片名称</th><th>图片描述</th><th>图片下载</th></tr>
                 <c:choose>
                   <c:when test="${requestScope.attList!=null&&requestScope.attList.size()>0}">
                     <c:forEach items="${requestScope.attList}" var="attachment">
                        <tr><td>${attachment.name}</td>
                        <td>${attachment.remark==null?"-":attachment.remark}</td>
                        <td><a href="${root}/images/${attachment.attachment_Url}/${attachment.name}">下载</a></td>
                        </tr>
                     </c:forEach>
                   </c:when>
                   <c:otherwise>
                          <tr><td colspan="3">抱歉，未查询到相关记录!</td></tr>
                   </c:otherwise>
                 
                 </c:choose>
                 
              </table>
           
        </li> --%>
    </ul>
     <ul class="searchWrap">
         <li class="clearfix" style="margin:25px 20px 5px;">
          <span class="mr20">共<span class="red" id="number">${attList.size()}</span>张照片</span>
          <span class="mr20"><a href="javascript:;" class="uploadBox btn mr20" onclick="viewPicture();">查看</a></span>
     </li>
     </ul>


<script type="text/javascript">

	 //查看图片
		function viewPicture(){
		   var size = '${attList.size()}';
		   var classroomId = '${classroom.clsClassroomId}';
		   if(size > 0){
			   parent.Win.open({
					id:"viewPicture",
					url:"${root}/admin/classroominspect/toviewphoto.do?flag=back&identify=detail&classroomId="+classroomId,
					title:"查看照片",
					width:750,
					height:550,
					mask:true
			    });
		   }else{
			   Win.alert("暂无照片！");
		   }
		  
		}
</script>
</body>
</html>