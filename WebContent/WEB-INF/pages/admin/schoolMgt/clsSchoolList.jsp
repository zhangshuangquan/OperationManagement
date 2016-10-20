<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
 <script src="${root }/public/js/customer.js" type="text/javascript"></script>
 <script src="${root}/public/js/ajaxfileupload.js" type="text/javascript"></script>
    
</head>
<body>
<h3 id="cataMenu">
	<a href="javascript:;">学校管理</a> &gt; <a href="javascript:;">学校列表</a>
</h3>
			
<div id="control">
	<div id="controlContent">
		<ul class="searchWrap">
				<li>
					<label class="text">行政区：</label>
					<span class="cont" id="chooseArea">
						<select class="mr20" id="province" name = "province">
							<option value="-1">请选择</option>
						</select>
					</span>
					<span>
						<label class="text">学段: </label>
						<select id="semesterSelect" >
						</select>
					</span>
					<span>
						<label class="labelText">学校名称：</label>
						<input type="text" name="schoolName" id="schoolNameId" />
						<input type="button" class="submit btn" name="query" onclick="getClsSchoolList();" value="查询" />
					</span>
				</li>
			</ul>
			
		<div class="totalPageBox">
				<div class="fr">
					<a  class="btn btnGreen" href="javascript:;" onclick="addSchool();" >创建学校</a>
					<a  class="btn btnGreen" style="margin-left:10px;" href="javascript:;" onclick="showFileUploadPage();" >批量导入</a>
				</div>
				总共<span class="totalNum" id="totalNum">0</span> 条数据
			</div>
			
		<table class="tableBox">
			<tr>
					<th width="5%">学校名称</th>
					<th width="8%">所在地区</th>
					<th width="10%">用户名</th>
					<th width="10%">姓名</th>
					<th width="8%">联系电话</th>
					<th width="8%">学段</th>
					<th width="8%">教室总数</th>
					<th width="8%">主讲教室数</th>
					<th width="8%">接收教室数</th>
					<th width="8%">操作</th>
			</tr>
	    	<tbody id="clsSchoolList"></tbody>
		</table>
		<div id="pageNavi"></div>
	</div>

</div>
<script>

$(document).ready(function(){
	getTopArea();
	getAllSemester();
	getClsSchoolList();
});

//获取顶级地区
function getTopArea() {
	$.post("${root}/admin/orgUser/getAreaByparentId.do",{"parentId":"-1"},function(data){
		var html = '<option value="-1">请选择</option>';
		for(var i = 0,j = data.length; i<j; i++){
			html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
		}
		$("#province").html(html);
	},'json');
	selectBind("chooseArea","${root}/admin/orgUser/getAreaByparentId.do","parentId");
}

//获取所有学段
function getAllSemester() {
	$.get("${root}/admin/schoolmgt/getAllSemester.do", function(result){
		result.unshift({"baseSemesterId":"", "semesterName":"请选择"});
		$.each(result, function(index, json){
			$("#semesterSelect").append("<option value='" + json.baseSemesterId + "'>" + json.semesterName + "</option>");
		});
	}, "json");
}

//分页获取学校列表
var mySplit = null;
function getClsSchoolList() {
	
	var baseAreaId = getBaseAreaId('chooseArea');
	var semesterId = $.trim($("#semesterSelect").val());
	var schoolName = $.trim($("#schoolNameId").val());
	
	var criteria = {"baseAreaId" : baseAreaId, "semesterId" : semesterId, "schoolName" : schoolName};
	var url = '${root}/admin/schoolmgt/getClsSchoolList.do';
	
	if(mySplit == null) {
		mySplit = new SplitPage({
		    node : $id("pageNavi"),
		    url :  url,
		    data : criteria,
		    count : 20,
		    callback : createShowingTable
		});	
	} else {
		mySplit.search(url, criteria);
	}
}

//组装显示学校表格
function createShowingTable(data, total) {
	$(".totalNum").html(total);
	var dataArray = data;
	
	var tableStr = "";
	var len = dataArray.length;
	if (len > 0) {
		for ( var i = 0; i < len; i++) {
			var mainClassroomCount = dataArray[i].mainClassroomCount;
			var receiveClassroomCount = dataArray[i].receiveClassroomCount;
			var allClassroomCount = mainClassroomCount + receiveClassroomCount;
			tableStr = tableStr + "<tr><td>" + dataArray[i].schoolName
			+ "</td><td>" + dataArray[i].areaName
			+ "</td><td>" + dataArray[i].userName
			+ "</td><td>" + dataArray[i].realName
			+ "</td><td>" + dataArray[i].phone
			+ "</td><td>" + dataArray[i].baseSemesterNames
			+ "</td><td><a href=\"javascript:void(0);\" onclick=\"showClassroomList('"+dataArray[i].clsSchoolId+"','ALL')\">" + allClassroomCount
			+ "</a></td><td><a href=\"javascript:void(0);\" onclick=\"showClassroomList('"+dataArray[i].clsSchoolId+"','MASTER')\">" + mainClassroomCount
			+ "</a></td><td><a href=\"javascript:void(0);\" onclick=\"showClassroomList('"+dataArray[i].clsSchoolId+"','RECEIVE')\">" + receiveClassroomCount
			+ "</a></td><td> " +
	        	"<a href=\"javascript:void(0);\" onclick='editClsSchool(\""+dataArray[i].clsSchoolId+"\")'>编辑</a> &nbsp;"  +
	        	"<a href=\"javascript:void(0);\" onclick='addClassroom(\""+dataArray[i].clsSchoolId+"\")'>添加教室</a> &nbsp;"  +
	        	"<a class=\"delLink\" href=\"javascript:void(0);\" onclick='deleteSchool(\""+dataArray[i].clsSchoolId+"\")'>删除学校</a>" 
			+ "</td></tr>";
		} 
	} else {
		tableStr += '<tr><td colspan="10">抱歉，未查询到相关记录</td></tr>';
	}
		
	$("#clsSchoolList").html(tableStr);
	window.scrollTo(0,0);
}

//添加学校
function addSchool() {
	Win.open({id:"addSchoolWin",url:"addSchoolPage.html",title:"创建学校",width:600,height:500,mask:true});
}

//添加教室
function addClassroom(clsSchoolId){
	Win.open({
		id	   : "addClssroomId" ,
		title : "新增教室" ,
		width : 600,
		height : 400,
		url : "${root}/admin/schoolmgt/addClassroomPage.html?clsSchoolId=" + clsSchoolId
	});
}

//编辑学校
function editClsSchool(clsSchoolId){
	Win.open({
		id	   : "editClsSchoolId" ,
		title : "编辑学校" ,
		width : 600,
		height : 500,
		url : "${root}/admin/schoolmgt/editClsSchoolPage.html?clsSchoolId=" + clsSchoolId
	});
}

//删除学校
function deleteSchool(clsSchoolId) {
	Win.confirm({html : '<span class="dialog_Inner">确认要删除吗?</span>',mask:true}, function () {
		$.post('${root}/admin/schoolmgt/deleteSchoolById.do', {"clsSchoolId" : clsSchoolId}, function(result){
			if(result.result) {
				Win.alert("删除成功");
				getClsSchoolList();
			} else {
				Win.alert(result.message);
			}
		}, "json");
	},true
	);
}

//显示上传窗口
function showFileUploadPage(){
	Win.open({id:'uploadExcel',width:500,height:260,title:"批量新增学校",url:"${root}/admin/schoolmgt/importSchoolPage.do",mask:true});
}

//显示教室
function showClassroomList(clsSchoolId, classroomType) {
	Win.open({
		id	   : "showClassroomList" ,
		title : "教室列表" ,
		width : 750,
		height : 450,
		url : "${root}/admin/classroom/showClassroomList.html?clsSchoolId=" + clsSchoolId +"&classroomType=" + classroomType,
		afterClose:function() {
			mySplit.reload() ;
		}
	});
}
	
</script>
</body>
</html>