<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../common/meta.jsp"%>
<link href="${root }/public/calendar/skin/WdatePicker.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="${root }/public/calendar/WdatePicker.js"></script>
	<script type="text/javascript" src="${root }/public/js/customer.js"></script>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">用户管理</a> &gt; <a href="javascript:;">账号管理</a>
	</h3>
	<div id="control">
		<div id="controlContent">
			<ul class="searchWrap borderBox">
				<li>
					<label class="labelText">行政区：</label>
					<span id="areaSelect">
						<select class="mr20" id="level1" index="1">
							<option value="-1">请选择</option>
						</select>
					</span>
					<label class="labelText">学段：</label>
					<select class="mr20" id="semester">
						<option value="-1">请选择</option>
					</select>
					<label class="labelText">学校：</label>
					<input type="text" name="school" id="school" />
				</li>
				<li>
					<label class="labelText">账号名称：</label>
					<input type="text" name="userName" id="userName" />
					<label class="labelText">年级：</label>
					<select class="mr20" id="classLevel">
						<option value="-1">请选择</option>
					</select>
					<label class="labelText">学科：</label>
					<select class="mr20" id="subject">
						<option value="-1">请选择</option>
					</select>
					<label class="labelText">状态：</label>
					<select class="mr20" id="locked">
						<option value="-1">请选择</option>
						<option value="N">开启</option>
						<option value="Y">关闭</option>
					</select>
					<input type="button" class="submit btn" name="query" onclick="search()" value="查询" />
				</li>
			</ul>
			
			<div class="totalPageBox">
			<div class="fr">
				<a id="addTeaUser" class="btn btnGreen" href="javascript:;">新增帐号</a>
				<a id="addTeaUserBatch" class="btn btnGreen" href="javascript:;">批量新增</a>
				<a id="exportOrgUser" class="btn btnGreen" href="javascript:;" onclick="exportTeaUserList()">导出</a>
			</div>
			<div>总共<span class="totalNum">0</span> 条数据</div>
			</div>
		<table class="tableBox">
			<tr>
				<th width="5%">序号</th>
				<th width="10%">账号名称</th>
				<th width="10">职位</th>
				<th width="10%">创建人</th>
				<th width="20%">行政区</th>
				<th width="14%">校</th>
				<th width="6%">状态</th>
				<th width="8%">发起评课议课</th>
				<th width="12%">操作</th>
			</tr>
		</table>
		<div id="pageNavi" class="pageNavi"></div>
		
		</div>
	</div>
	
	<script type="text/javascript">
	
	var splitPage = new SplitPage({
	    node : $id("pageNavi"),
	    url : "${root}/admin/teaUser/getTeaUserList.do",
	    data:{
	    		baseAreaId:'-1',
	    		semesterId:'-1',
	    		schoolName:'',
	    		userName:'',
	    		classLevelId:'-1',
	    		subjectId:'-1',
	    		locked:$("#locked").val()
		},
	    count : 20,
	    callback : showList,
	    type : 'post'
	});
	
	function showList(data,totalCnt){
		var len = data.length;
		var html = '';
		if(len>0){
			for(var i = 0; i< len; i++){
				var resObj = data[i];
				html += '<tr>';
				html += '<td>'+(i+1)+'</td>';
				html += '<td>'+resObj.userName+'</td>';
				html += '<td>'+resObj.position+'</td>';
				html += '<td>'+resObj.createRealName+'</td>';
				html += '<td>'+resObj.areaNames+'</td>';
				html += '<td>'+resObj.schoolName+'</td>';
				html += '<td>'+getState(resObj.locked)+'</td>';
				html += '<td>'+getEvaFlag(resObj.createEvaFlag)+'</td>';
				html += '<td>';
				html += '<a href="javascript:;" onclick="toEditTeaUser(\''+resObj.baseUserId+'\');">编辑 </a>';
				html+='<a href="javascript:;" class="delLink" onclick="deleteTeaUser(\''+resObj.baseUserId+'\');">删除</a></td>';
				html += '</td>';
				html += '</tr>';
			}
		} else {
			html += '<tr><td colspan="9">抱歉，未查询到相关记录!</td></tr>';
		}
		$(".tableBox tr").not(":first").remove();
		$(".tableBox").append(html);
		$(".totalNum").html(totalCnt);
	}
	
	function search(){
		var url  = "${root}/admin/teaUser/getTeaUserList.do";
		var areas = $("#areaSelect select");
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
		var semesterId = $("#semester").val();
		var schoolName = $("#school").val();
		var userName = $("#userName").val();
		var classLevelId = $("#classLevel").val();
		var subjectId = $("#subject").val();
		var locked = $("#locked").val();
		var param = {
				baseAreaId:baseAreaId,
				semesterId:semesterId,
				schoolName:schoolName,
				userName:userName,
				classLevelId:classLevelId,
				subjectId:subjectId,
				locked:locked
		};
		splitPage.search(url,param);
	}
	
	function getState(locked){
		if('Y' == locked){
			return '关闭';
		}else{
			return '开启';
		}
	}
	
	function getEvaFlag(flag){
		if('Y' == flag){
			return '是';
		}else{
			return '否';
		}
	}
	
	function deleteTeaUser(id){
		Win.confirm({'id':'deleteConfirm','html':'确认要删除吗?'},function(){
			$.post("${root}/admin/teaUser/deleteBaseUserById.do",{'baseUserId':id},function(data){
				if(data){
					if(data.result){
						Win.alert('删除成功');
						splitPage.reload();
					}else{
						Win.alert('删除失败！');
					}
				}else{
					Win.alert('删除失败！');
				}
			});
		},function(){});
	}
	
	function toEditTeaUser(id){
		Win.open({id:"addTeaUserWin",url:"${root}/admin/teaUser/toEditTeaUser.html?baseUserId="+id,title:"编辑账号",width:600,height:400,mask:true});
	}
	
	 // === 批量新增页面
	  $("#addTeaUserBatch").click(function(){
		  Win.open({id:'uploadExcel',width:500,height:260,title:"批量新增教师用户",url:"${root}/admin/commons/importUserPage.do?userType=teacher",mask:true});
	  }) ;
	
	function exportTeaUserList(){
		var areas = $("#areaSelect select");
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
		var semesterId = $("#semester").val();
		var schoolName = $("#school").val();
		var userName = $("#userName").val();
		var classLevelId = $("#classLevel").val();
		var subjectId = $("#subject").val();
		var locked = $("#locked").val();
		var param  = {
				baseAreaId:baseAreaId,
				semesterId:semesterId,
				schoolName:schoolName,
				userName:userName,
				classLevelId:classLevelId,
				subjectId:subjectId,
				locked:locked
		};
		 var params = JSON.stringify(param) ;
		var url = "${root }/admin/teaUser/exportTeaUserList.do?params="+params;
		window.location.href = url;
	}
	
	$(document).ready(function(){
		$.post("${root}/admin/orgUser/getAreaByparentId.do",{"parentId":"-1"},function(data){
			var html = '<option value="-1">请选择</option>';
			for(var i = 0,j = data.length; i<j; i++){
				html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
			}
			$("#level1").html(html);
		},'json');
		
		selectBind("areaSelect","${root}/admin/orgUser/getAreaByparentId.do","parentId");
		
		
		$.post("${root}/admin/teaUser/getAllSemester.do",function(data){
			var html = '<option value="-1">请选择</option>';
			for(var i = 0,j = data.length; i<j; i++){
				html += '<option value="'+data[i].baseSemesterId+'">'+data[i].semesterName+'</option>';
			}
			$("#semester").html(html);
		},'json');
		
		$('#semester').change(function(){
			var parentId = $(this).val();
			if(parentId=='-1'){
				$("#classLevel").html('<option value="-1">请选择</option>');
				$("#subject").html('<option value="-1">请选择</option>');
			}else{
				$.post("${root}/admin/teaUser/getClasslevelBySemesterId.do",{"semesterId":parentId},function(data){
					var html = '<option value="-1">请选择</option>';
					for(var i = 0,j = data.length; i<j; i++){
						html += '<option value="'+data[i].baseClasslevelId+'">'+data[i].classlevelName+'</option>';
					}
					$("#classLevel").html(html);
				},'json');
			}
		});
		
		$('#classLevel').change(function(){
			var parentId = $(this).val();
			if(parentId=='-1'){
				$("#subject").html('<option value="-1">请选择</option>');
			}else{
				$.post("${root}/admin/teaUser/getSubjectByClasslevelId.do",{"classlevelId":parentId},function(data){
					var html = '<option value="-1">请选择</option>';
					for(var i = 0,j = data.length; i<j; i++){
						html += '<option value="'+data[i].baseSubjectId+'">'+data[i].subjectName+'</option>';
					}
					$("#subject").html(html);
				},'json');
			}
		});
		
		$("#addTeaUser").click(function(){
			Win.open({id:"addTeaUserWin",url:"${root}/admin/teaUser/toAddTeaUser.html",title:"新增账号",width:600,height:400,mask:true});
		});
		
	});
	
	</script>
</body>
</html>