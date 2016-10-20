<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../common/meta.jsp" %>
<link href="${root}/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
</head>
<body>
<h3 id="cataMenu">
	<a href="toOpenProfile.html">开课概况</a> >
	<a href="javascript:;">
		<c:if test="${type eq 'SCH' }">
		   ${schoolInfo.schoolName }开课详情
		</c:if>
		<c:if test="${type ne 'SCH' }">
		   ${areaInfo.areaName }开课详情
		</c:if>
	</a>
</h3>		
<div id="control">
	<c:if test="${classroomType eq 'MASTER' && classType ne 'Y'}">
		<h3 class="cataMenu navMenu mb10">
			<span class="tabMenu">
				<a class="tabItem" href="javascript:switchTab(0)">开课统计</a> 
				<a class="tabItem" href="javascript:switchTab(1)">未创建课表的主讲教室</a>
				<a class="tabItem selected" href="javascript:switchTab(2)">创建课表未开课的主讲教室</a>
			</span>
		</h3>
	</c:if>
	<c:if test="${classroomType eq 'RECEIVE' && classType ne 'Y'}">
		<h3 class="cataMenu">
			<span class="tabMenu">
				<a class="tabItem" href="javascript:switchTab(0)">开课统计</a> 
				<a class="tabItem" href="javascript:switchTab(3)">未听课的接收教室</a>
			</span>
		</h3>
	</c:if>
	<div id="controlContent">
        <div class="content-in">
	        <div class="totalPageBox">
		    	<span class="fr">
		    		<a id="exportBtn" class="btn btnOrange" href="javascript:;">导出</a> 
		    	</span>	
		    	总共<em class="totalNum">0</em>条数据
		    </div>
		    <table class="tableBox center">
				<tr>
					<th width="30%">学校名称</th>
					<th width="30%">主讲教室名称</th>
					<th width="20%">联系人</th>
					<th width="20%">电话</th>
				</tr>
			</table>
			<div id="pageNavi" class="pageNavi"></div>
        </div>
    </div>
</div>
<script type="text/javascript">
	var startDt = '${startDt}';
	var endDt = '${endDt}';
	var classroomType = '${classroomType}';
	var classType = '${classType}';
	var areaId = '${areaId}';
	var type = '${type}';	
	
	function switchTab(index){
		var link = "toAreaOpenProfileDetail.html";
		switch (index)
	   	 {
	   	     case 0:
	   	    	link="toAreaOpenProfileDetail.html";
	    	    break;
	    	 case 1:
	    		 link="toAreaUnsetClsroomDetail.html";
	    	    break;
	    	 case 2:
	    		 link="toAreaUnopenClsroomDetail.html";
	    	    break;
	    	 case 3:
	    		 link="toAreaUnrecClsroomDetail.html";
	    		break;
	   	 }
		$("#tempDataForm").attr("action",link);
		$("#tempDataForm").submit();
	}

	function showList(data,totalCnt,param){
		var len = data.length;
		var html = '';
		if(len>0){
			for(var i = 0; i< len; i++){
				var obj = data[i];
				html += '<tr>';
				html += '<td>'+obj.schoolName+'</td>';
				html += '<td>'+obj.classroomName+'</td>';
				html += '<td>'+obj.contactPerson+'</td>';
				html += '<td>'+obj.contactPhone+'</td>';
				html += '</tr>';
			}
		} else {
			html += '<tr><td colspan="4">抱歉！没有搜索到您想要的信息！</td></tr>';
		}
		$(".tableBox tr:first").nextAll().remove();	
		$(".tableBox tr:first").after(html);
		$(".totalNum").html(totalCnt);
	}
	
	function search(){
		var url  = "${root}/admin/statisticsAnaly/getUnopenClsroomDetail.do";	
		var param  = {
				classroomType:classroomType,
				classType:classType,
				startDt:startDt,
				endDt:endDt,
				areaId:areaId,
				type:type
		};
		mySplit.search(url,param);
	}
	
	function exportData(){
		$("#tempDataForm").attr("action","exportUnopenClsroomDetail.html");
		$("#tempDataForm").submit();
	}
	
	var mySplit = null;
	
	 $(document).ready(function(){
		 $("#exportBtn").click(exportData);
		 $("#query").click(search);	 

		   mySplit = new SplitPage({
			    node : $id("pageNavi"),
			    url : "${root}/admin/statisticsAnaly/getUnopenClsroomDetail.do",
			    data:{
			    	classroomType:classroomType,
			    	classType:classType,
					startDt:startDt,
					endDt:endDt,
					areaId:areaId,
					type:type
				},
			    count : 20,
			    callback : showList,
			    type : 'post'
			}); 
	 });
</script>
<form id="tempDataForm" action="exportUnopenClsroomDetail.html" method="post">
	<input id="p_startDt" name="startDt" type="hidden" value="${startDt}"/>
	<input id="p_endDt" name="endDt"  type="hidden" value="${endDt}"/>
	<input id="p_classroomType" name="classroomType"  type="hidden" value="${classroomType}"/>
	<input id="p_classType" name="classType"  type="hidden" value="${classType}"/>
	<input id="p_areaId" name="areaId" type="hidden" value="${areaId}"/>
	<input id="p_type" name="type" type="hidden" value="${type}" />
</form>
</body>
</html>