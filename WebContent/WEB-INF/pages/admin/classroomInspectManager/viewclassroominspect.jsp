<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
    <link href="${root}/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
     <script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
     <script src="${root}/public/js/jsTree.js" type="text/javascript"></script>
	<style>
	    .tableWrap{width:381px; margin-right:20px; float:left;margin-top:10px;}
	    .tableWrap:nth-of-type(2n){ margin-right:0px;}
		.tableTitle{height:20px;line-height:20px;padding-left:20px}
		.searchTop {border: 1px solid #333;}
	</style>
</head>
<body class="chase-ask">
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
	           	<label class="labelText" style="margin-left:49px;">手机：</label>
	                <span>
	                    ${classroom.contactPersonPhone}               </span>
	        </li>
	  </ul>
	<div class=" marginauto">
		<div class="searchTop clearfix" style="border;1px solid #ccc">
	 	<div class="fl w200" style=' width:400px;height:100px; border-right:1px solid ; '>
           <h4>本地调试情况</h4>
           <ul class="searchWrap">
           	<li class="clearfix">
           		<label class="labelText">调试人：</label>
	                 <span>
	                    ${classroom.testerName}                </span>
           		<label class="labelText">调试完成时间：</label>
	                 <span>
	                 	<fmt:formatDate value="${classroom.testerTime}" pattern="yyyy-MM-dd"/>               </span>
           	</li>
           	<li class="clearfix">
           		<label class="labelText">备注：</label>
	                 <span>
	                    ${classroom.testerRemark}               </span>
           	</li>
           </ul>
	 	</div>
	 	<div class="" style="overflow:hidden;height:100px;">
	 		<h4>联调情况</h4>
           <ul class="searchWrap">
           	<li class="clearfix">
           		<label class="labelText">联调人：</label>
	                 <span>
	                    ${classroom.helpTesterName}                </span>
           		<label class="labelText">联调时间：</label>
	                 <span>
	                 	<fmt:formatDate value="${classroom.helpTesterTime}" pattern="yyyy-MM-dd"/>               </span>
	            <label class="labelText">联调结果：</label>
	                 <span>
	                    ${classroom.helpTesterResult}               </span>
           	</li>
           	<li class="clearfix">
           		<label class="labelText">备注：</label>
	                 <span>
	                    ${classroom.helpTesterRemark}                </span>
           	</li>
           </ul>
	 	
	 	</div>
		</div>
	</div>
   <div class="content">
   		<c:set var="itype" value="-1"></c:set>
   		<c:set var="inum" value="0"></c:set>
   		<c:forEach items="${classroominspect }" var="ci" varStatus="status">
   			<c:if test="${ci.classroomInspect.type != itype }">
	   				<c:if test="${itype != '-1'}">
	   						</tbody>
      					 </table>
      					 </div>
	   				</c:if>
   					<c:set var="inum" value="0"></c:set>
					<div class="tableWrap">
					  <div class="tableTitle">
									 ${ci.classroomInspect.typeName}&nbsp;&nbsp; <fmt:formatDate value="${ci.updateTime }" pattern="yyyy-MM-dd"/>
								</div>
				   				<table class="tableBox center">
								<thead><tr>
									<th width="5%">序号</th>
									<th width="10%">检测项</th>
									<th width="10%">检测结果</th>
								</tr>
								</thead><tbody id="pageBody">
								<c:set var="itype" value="${ci.classroomInspect.type}"></c:set>			
			   			</c:if>
			   			
			   			<c:set var="inum" value="${inum+1 }" />
			   			<tr><td>${inum }</td><td>${ci.classroomInspect.name}</td><td>${ci.result}</td></tr>
					
   			
   		</c:forEach>
   		</tbody>
      	</table>
      	 <%-- <ul >
    	 <li>
           <c:if test="${requestScope.attList!=null}">
              <table class="tableBox center">
			<tr>
			    <th>图片名称</th>
				<th>图片描述</th>
				<th>图片下载</th>
			</tr>
			<tbody id="pageBody">
			<c:choose>
			  <c:when test="${requestScope.attList!=null&&requestScope.attList.size()>0}">
			      <c:forEach items="${requestScope.attList}" var="attachment">
                 <tr>
                     <td>${attachment.name}</td>
                     <td>${attachment.remark==null?"-":attachment.remark}</td>
                     <td><a href="${root}/images/${attachment.attachment_Url}/${attachment.name}">下载</a></td>
                 </tr>
                 </c:forEach>
			  </c:when>
			   <c:otherwise>
			        <tr><td colspan="3">抱歉，未查询到相关记录!</td></tr>
			   </c:otherwise>
			</c:choose>
			
			</tbody>
		 </table> 
           </c:if>
        </li>
   </ul> --%>
    <ul class="searchWrap">
         <li class="clearfix" style="margin:25px 20px 5px;">
          <span class="mr20">共<span class="red" id="number">${attList.size()}</span>张照片</span>
          <span class="mr20"><a href="javascript:;" class="uploadBox btn mr20" onclick="viewPicture();">查看</a></span>
     </li>
     </ul>
      	</div>
   <script type="text/javascript">

	 //查看图片
		function viewPicture(){
		   var size = '${attList.size()}';
		   var classroomId = '${classroom.clsClassroomId}';
		   if(size > 0){
			   parent.Win.open({
					id:"viewPicture",
					url:"${root}/admin/classroominspect/toviewphoto.do?flag=back&identify=inspect&classroomId="+classroomId,
					title:"查看照片",
					width:800,
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