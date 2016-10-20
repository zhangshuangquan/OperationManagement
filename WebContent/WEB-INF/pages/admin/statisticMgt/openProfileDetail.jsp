<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../common/meta.jsp" %>
<link href="${root}/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
<link media="all" type="text/css" rel="stylesheet" href="${root}/public/css/pop.css"/>
<script src="${root}/public/js/pop.js" type="text/javascript"></script>
<style>
.td-lesson-pointer {
cursor: pointer;
}
</style>
</head>
<body>
<h3 id="cataMenu">
		<a href="toOpenProfile.html">开课概况</a> >
		<a href="javascript:;">
			<c:if test="${type eq 'SCH' }">
			   ${schoolInfo.schoolName }
			   <c:if test="${classroomType eq 'MASTER'}">
			    开课详情
			   </c:if>
			   <c:if test="${classroomType ne 'MASTER'}">
			    听课详情
			   </c:if>
			</c:if>
			<c:if test="${type ne 'SCH' }">
			   ${areaInfo.areaName }
			   <c:if test="${classroomType eq 'MASTER'}">
			    开课详情
			   </c:if>
			   <c:if test="${classroomType ne 'MASTER'}">
			    听课详情
			   </c:if>
			</c:if>
		</a>
</h3>		
<div id="control">
	<c:if test="${classroomType eq 'MASTER' && classType ne 'Y'}">
		<h3 class="cataMenu  navMenu mb10">
			<span class="tabMenu">
				<a class="tabItem selected" href="javascript:switchTab(0)">开课统计</a> 
				<a class="tabItem" href="javascript:switchTab(1)">未创建课表的主讲教室</a>
				<a class="tabItem" href="javascript:switchTab(2)">创建课表未开课的主讲教室</a>
			</span>
		</h3>
	</c:if>
	<c:if test="${classroomType eq 'RECEIVE' && classType ne 'Y'}">
		<h3 class="cataMenu" style="margin-top: 5px;">
			<span class="tabMenu">
				<a class="tabItem selected" href="javascript:switchTab(0)">开课统计</a> 
				<a class="tabItem" href="javascript:switchTab(3)">未听课的接收教室</a>
			</span>
		</h3>
	</c:if>
	<div id="controlContent">
        <div class="content-in">
			<ul class="searchWrap deepBgWrap borderBox">
				 <li>
					 <c:if test="${type ne 'SCH' }">
					   <label class="labelText">学校：</label>
				         <select class="mr20" id="school">
				            <option value="0">全部</option>
				            <c:forEach var="sch" items="${schoolList}">
				              <option value="${sch.id}">${sch.name }</option>
				            </c:forEach>
			       		</select>
					 </c:if>
			         <label class="labelText">状态：</label>
			         <select class="mr20" id="status">
			            <option value="0">全部</option>
			            <c:forEach var="sta" items="${status}">
			              <option value="${sta.key}">${sta.value }</option>
			            </c:forEach>
		       		</select>
			        <input type="button" class="submit btn query" id="query" value="查询" />
		       	</li>
		    </ul>
	        <div class="totalPageBox">
		    	<span class="fr">
		    		<a id="exportBtn" class="btn btnOrange" href="javascript:;">导出</a> 
		    	</span>	
		    	总共<em class="totalNum">0</em>条数据
		    </div>
		    <table class="tableBox center">
				<tr>
				    <th width="20%">学校名称</th>
				    <c:if test="${classroomType eq 'MASTER' }">
					  <th id="titleTh" width="20%">主讲教室名称</th>
					</c:if>
					<c:if test="${classroomType eq 'RECEIVE' }">
					  <th id="titleTh" width="20%">接收教室名称</th>
					</c:if>
					<th width="10%">课表名称</th>
					<th width="10%">排课日期</th>
					<th width="10%">周次</th>
					<th width="10%">星期</th>
					<th width="10%">节次</th>
					<th width="10%">状态</th>
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
	
	popUi.init();
	popUi.onShow = function ($td, showFn) {
		popUi.html('<div class="clearfix">'+htmlencode($($td).attr("dir"))+'<br /><br /></div>');
		showFn();
	};
	popUi.onHide = function () {
		this.html('');
	};
	popUi.bindEvent('.td-lesson-pointer');
	
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
	
	function formSeq(seqIndex){
	   	 var x="一";
	   	 seqIndex = seqIndex * 1;
	   	 switch (seqIndex)
	   	 {
		    	 case 1:
		    	   x="一";
		    	   break;
		    	 case 2:
		    	   x="二";
		    	   break;
		    	 case 3:
		    	   x="三";
		    	   break;
		    	 case 4:
		    	   x="四";
		    	   break;
		    	 case 5:
		    	   x="五";
		    	   break;
		    	 case 6:
		    	   x="六";
		    	   break;
		    	 case 7:
		    	   x="七";
		    	   break;
		    	 case 8:
		    	   x="八";
		    	   break;
	   	 }
	   	 return x;
	}
	
	function formStatus(code){
		var statusName = "有效授课";
		if(code == 'VALID'){
			statusName = "有效授课";
		} else if(code == 'INVALID'){
			statusName = "无效授课";
		} else if(code == 'REASONABLE_MISSED'){
			statusName = "因故停课";
		} else if(code == 'UNREASONABLE_MISSED'){
			statusName = "无故停课";
		}
		return statusName;
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
				html += '<td>'+obj.scheduleName+'</td>';
				html += '<td>'+obj.scheduleDate+'</td>';
				html += '<td>'+obj.weekSeq+'</td>';
				html += '<td>'+formSeq(obj.daySeq)+'</td>';
				html += '<td>'+formSeq(obj.classSeq)+'</td>';
				if(obj.status == 'REASONABLE_MISSED'){
					html += '<td class="td-lesson-pointer" dir="'+obj.cancelReason+'">'+formStatus(obj.status)+'</td>';
				} else {
					html += '<td>'+formStatus(obj.status)+'</td>';
				}
				html += '</tr>';
			}
		} else {
			html += '<tr><td colspan="8">抱歉！没有搜索到您想要的信息！</td></tr>';
		}
		$(".tableBox tr:first").nextAll().remove();	
		$(".tableBox tr:first").after(html);
		$(".totalNum").html(totalCnt);
	}
	
	function search(){
		var url  = "${root}/admin/statisticsAnaly/getClassOpenProfileDetail.do";	
		var status = $("#status").val();
		var schoolId= $("#school").size() > 0?$("#school").val():'0';
		var param  = {
				classroomType:classroomType,
				classType:classType,
				startDt:startDt,
				endDt:endDt,
				areaId:areaId,
				type:type,
				status:status,
				schoolId:schoolId
		};
		mySplit.search(url,param);
	}
	
	function exportData(){
		var status = $("#status").val();
		var schoolId= $("#school").size() > 0?$("#school").val():'0';
		$("#p_status").val(status);
		$("#p_schoolId").val(schoolId);
		$("#tempDataForm").attr("action","exportClassOpenProfileDetail.html");
		$("#tempDataForm").submit();
	}
	
	var mySplit = null;
	
	 $(document).ready(function(){
		 $("#exportBtn").click(exportData);
		 $("#query").click(search);	 

		   mySplit = new SplitPage({
			    node : $id("pageNavi"),
			    url : "${root}/admin/statisticsAnaly/getClassOpenProfileDetail.do",
			    data:{
			    	classroomType:classroomType,
			    	classType:classType,
					startDt:startDt,
					endDt:endDt,
					areaId:areaId,
					type:type,
					status:'0',
					schoolId:'0'
				},
			    count : 20,
			    callback : showList,
			    type : 'post'
			}); 
	 });
</script>
<form id="tempDataForm" action="exportClassOpenProfileDetail.html" method="post">
	<input id="p_startDt" name="startDt" type="hidden" value="${startDt}"/>
	<input id="p_endDt" name="endDt"  type="hidden" value="${endDt}"/>
	<input id="p_classroomType" name="classroomType"  type="hidden" value="${classroomType}"/>
	<input id="p_classType" name="classType"  type="hidden" value="${classType}"/>
	<input id="p_areaId" name="areaId" type="hidden" value="${areaId}"/>
	<input id="p_type" name="type" type="hidden" value="${type}" />
	<input id="p_status" name="status" type="hidden" value="0" />
	<input id="p_school" name="schoolId" type="hidden" value="0" />
</form>
</body>
</html>