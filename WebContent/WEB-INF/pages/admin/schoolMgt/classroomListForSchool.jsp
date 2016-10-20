<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script src="${root }/public/js/basiccheck.js"></script>
<script>

var domid = frameElement.getAttribute("domid");

</script>
<head>
<body>
	<div class="commonWrap" style="text-align:center">
		<input type="hidden" name=clsSchoolId id="clsSchoolId" value="${clsSchoolId}"/>
		<input type="hidden" name=classroomType id="classroomType" value="${classroomType}"/>
		<table class="tableBox" style="width:90%;margin-left:37px;">
			<tr>
					<th>序号</th>
					<th width="20%">教室名称</th>
					<th>教室类型</th>
					<th width="20%">学校名称</th>
					<th>操作</th>
			</tr>
	    	<tbody id="classroomlist"></tbody>
		</table>
		<div id="pageNavi"></div>
	</div>
	<script>
		$(document).ready(function() {
			getClassroomBySchoolId();
		}) ;
		
		//分页显示教室
		var mySplit = null;
		function getClassroomBySchoolId() {
			
			var clsSchoolId = $("#clsSchoolId").val();
			var classroomType = $("#classroomType").val();
			
			var criteria = {"clsSchoolId" : clsSchoolId, "classroomType" : classroomType};
			var url = '${root}/admin/classroom/getClassroomBySchoolId.do';
			
			if(mySplit == null) {
				mySplit = new SplitPage({
				    node : $id("pageNavi"),
				    url :  url,
				    data : criteria,
				    count : 10,
				    callback : createShowingTable
				});	
			} else {
				mySplit.search(url, criteria);
			}
		}
		
		//组装教室表格
		function createShowingTable(data, total, req) {
			var dataArray = data;
			
			var tableStr = "";
			var len = dataArray.length;
			if (len > 0) {
				for ( var i = 0; i < len; i++) {
					tableStr = tableStr + "<tr><td>" + (i + 1 + req.start)
					+ "</td><td>" + dataArray[i].roomName
					+ "</td><td>" + dataArray[i].roomType
					+ "</td><td>" + dataArray[i].schoolName
					+ "</td><td> " +
					"<a href=\"javascript:editClassroom('" + dataArray[i].clsClassroomId  + "');\">编辑</a> &nbsp;"  +
			        	"<a class=\"delLink\" href=\"javascript:deleteClassroom('"  +dataArray[i].clsClassroomId + "');\">删除教室</a>"  
					+ "</td></tr>";
				} 
			} else {
				tableStr += '<tr><td colspan="5">无满足条件教室信息</td></tr>';
			}
				
			$("#classroomlist").html(tableStr);
		}
		
		//编辑教室
		function editClassroom(classroomId){
			Win.open({
				id	   : "editClassroomId" ,
				title : "编辑教室" ,
				width : 600,
				height : 400,
				url : "${root}/admin/classroom/edit.html?classroomId=" + classroomId , 
				afterClose:function() {
					mySplit.reload() ;
				}
			});
		}
		
		//删除教室
		function deleteClassroom(classroomId){

	    	Win.confirm({html : '<span class="dialog_Inner">确认要删除吗?</span>',mask:true},function(){
	    		$.ajax({
		    		 url: '${root}/admin/classroom/remove.do?classroomId=' + classroomId ,
		    		 type: 'PUT',
		    		 success: function(data) {
		    			 mySplit.reload() ;
		    		 }
		    	});
			},true);	
		}

	</script>
</body>

</html>