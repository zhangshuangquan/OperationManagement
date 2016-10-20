<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
 <script src="${root }/public/js/customer.js" type="text/javascript"></script>
 <script src="${root}/public/js/ajaxfileupload.js" type="text/javascript"></script>
<script>
    
    $(document).ready(function(){
    	$.post("${root}/admin/classroom/getAreaByParentId.do",{"parentId":"-1"},function(data){
    		var html = '<option value="-1">请选择</option>';
    		for(var i = 0,j = data.length; i<j; i++){
    			html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
    		}
    		$("#provinceId").html(html);
    	},'json');
    	selectBind("areaSelectId","${root}/admin/classroom/getAreaByParentId.do","parentId");
    });
		
	function createShowingTable(data,total,req) {
			$(".totalNum").html(total);
			 //获取后台传过来的jsonData,并进行解析  
			//alert("-----   进入当前的数据展现:" + data.pageCount);
			var dataArray = data;
			
			//此处需要让其动态的生成一个table并填充数据  
			var tableStr = "";
			var len = dataArray.length;
			if (len > 0) {
				for ( var i = 0; i < len; i++) {
					tableStr = tableStr + "<tr><td>" +  (i+1+req.start)
					+ "</td><td>" + dataArray[i].roomName
					+ "</td><td>" + dataArray[i].roomType
					+ "</td><td>" + dataArray[i].schoolName
					+ "</td><td>" + dataArray[i].areaPath
					+ "</td><td>" + dataArray[i].semeser
					+ "</td><td> " +
			        	"<a href=\"javascript:editClassroom('" + dataArray[i].clsClassroomId  + "');\">编辑</a> &nbsp;"  +
			        	"<a class=\"delLink\" href=\"javascript:deleteClassroom('"  +dataArray[i].clsClassroomId + "');\">删除</a>" 
					+ "</td></tr>";
				} 
			} else {
				tableStr += '<tr><td colspan="7">抱歉，未查询到相关记录</td></tr>';
			}
				
			$("#clsClassroom").html(tableStr);
			window.scrollTo(0,0);
		}
	    
		
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
		
		function deleteClassroom(classroomId){

	    	Win.confirm({html : '<span class="dialog_Inner">确认要删除吗?</span>',mask:true},function(){
	    		$.ajax({
		    		 url: '${root}/admin/classroom/remove.do?classroomId=' + classroomId ,
		    		 type: 'PUT',
		    		 success: function(data) {
		    			 if(data.result){
		    				 mySplit.reload();
		    			 }else{
		    				 Win.alert(data.message);
		    			 }
		    		 }
		    	});
			},true);	
		}
		
		var criteria = {
				"schoolName"	:	""
		};
	
		function doSearch(){
			var schoolName = $("#schoolNameId").val() ;
			var areas = $("#areaSelectId select");
			var semesterId =  $("#semesterId").val();
			var areaLength = areas.length;
			var baseAreaId = "";
			var baseAreaId1 = "";
			if(areaLength == 1){
				baseAreaId = $(areas[0]).val();
			}else{
				baseAreaId = $(areas[areaLength-2]).val();
				baseAreaId1 =$(areas[areaLength-1]).val();
				if("-1" != baseAreaId1){
					baseAreaId = baseAreaId1;
				}
			}
			
			var url = '${root}/admin/classroom/searchPageList.do';
			var criteria = {
					"schoolName" : schoolName,
					"baseAreaId" : baseAreaId,
					"semesterId" : semesterId
			};
			mySplit.search(url , criteria) ;
		}

		
		function exportClassroomList(){
			
			var schoolName = $("#schoolNameId").val() ;
			var areas = $("#areaSelectId select");
			var semesterId =  $("#semesterId").val();
			var areaLength = areas.length;
			var baseAreaId = "";
			var baseAreaId1 = "";
			if(areaLength == 1){
				baseAreaId = $(areas[0]).val();
			}else{
				baseAreaId = $(areas[areaLength-2]).val();
				baseAreaId1 =$(areas[areaLength-1]).val();
				if("-1" != baseAreaId1){
					baseAreaId = baseAreaId1;
				}
			}
			
			var url = "${root }/admin/classroom/exportClassroomList.html?schoolName=" + encodeURIComponent(encodeURIComponent(schoolName))
			+ "&baseAreaId=" + baseAreaId +"&semesterId=" + semesterId;
			window.location.href = url;
		}
		
		function showFileInput(){
			Win.open({id:'uploadExcel',width:500,height:260,title:"批量新增教室",url:"${root}/admin/classroom/importRoomPage.html",mask:true});
		}
		
		String.prototype.endWith=function(endStr){
		   var d=this.length-endStr.length;
		   return (d>=0&&this.lastIndexOf(endStr)==d);
		};
    </script>
</head>
<body>
<h3 id="cataMenu">
	<a href="javascript:;">学校管理</a> &gt; <a href="javascript:;">教室列表</a>
</h3>
<div id="control">
	<div id="controlContent">
		<ul class="searchWrap">
				<li>
					<label>行政区：</label>
					<span class="cont" id="areaSelectId">
						<select class="mr20" id="provinceId" name= "province">
							<option value="-1">请选择</option>
						</select>
					</span>
					
					<span>
						<label class="labelText">学段：</label>
						<select id="semesterId" name="semester">
							<option value="">请选择</option>
							<c:forEach items="${semesters }" var="semester">
								<option value="${semester.baseSemesterId }">${semester.semesterName }</option>
							</c:forEach>
						</select>
					</span>
					
					<span>
						<label class="labelText">学校名称：</label>
						<input type="text" name="schoolName" id="schoolNameId" />
						<input type="button" class="submit btn" name="query" onclick="doSearch();" value="查询" />
					</span>
					
					
				</li>
			</ul>
			
		<div class="totalPageBox">
			<div class="fr">
				<a  class="btn btnGreen" href="javascript:;" onclick="showFileInput();" >批量导入</a>
				<a  class="btn btnGreen" href="javascript:;" onclick="exportClassroomList();">导出</a>
			</div>
			总共<span class="totalNum" id="totalNum">0</span> 条数据
		</div>
			
		<table class="tableBox">
			<tr>
					<th width="5%">序号</th>
					<th width="10%">教室名称</th>
					<th width="10%">教室类型</th>
					<th width="8%">学校名称</th>
					<th width="8%">所在地区</th>
					<th width="8%">学段</th>
					<th width="8%">操作</th>
			</tr>
	    	<tbody id="clsClassroom"></tbody>
		</table>
		<div id="pageNavi"></div>
	</div>
</div>
<script>

var mySplit = new SplitPage({
    node : $id("pageNavi"),
    url :  '${root}/admin/classroom/searchPageList.do',
    data : criteria,
    count : 20,
    callback : createShowingTable
});	

</script>
</body>
</html>