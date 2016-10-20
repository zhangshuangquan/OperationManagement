<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
</head>
<body>
<h3 id="cataMenu">
		<a href="javascript:;">环境勘查与实施</a> &gt; <a href="javascript:;">环境勘查</a>
	</h3>
	<div id="control">
		<div id="controlContent">
			<ul class="searchWrap borderBox">
				<li class="clearfix" style="margin:5px 0 15px;">
			<label class="text">项目区域：</label>
				<span class="cont" id="chooseArea">
					<select class="mr20" id="province">
						<option value="-1">-- 请选择 --</option>
					</select>
				</span>
        	<label class="text">项目：</label>
				<span class="cont" id="chooseProject">
					<input type="text" id="projectName" name="projectName"  >
				</span>
        </li>
        
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="text">学校区域：</label>
				<span class="cont" id="schoolchooseArea">
					<select class="mr20" id="schoolprovince">
						<option value="-1">-- 请选择 --</option>
					</select>
				</span>
        	<label class="text">学校：</label>
				<span class="cont" id="chooseSchool">
					<input type="text" id="clsSchoolName" name="clsSchoolName"  >
				</span>
				
			
        	<input type="button" class="submit btn" name="query" onclick="search();" value="查询"  style="margin-left: 30px;"/>
        </li>
			</ul>
			<div class="totalPageBox">
				<div class="fr">
					<a id="addClassroom" class="btn btnGreen" href="javascript:;">新增教室</a>
				    <a class="btn btnGreen" href="javascript:;" onclick="exportclassroomList();">导出</a>
				</div>
				<div>总共<span class="totalNum" id="totalNum">0</span> 条数据</div>
			</div>
		<table class="tableBox">
			<tr>
				<th width="10%">教室名称</th>
				<th width="8%">教室类别</th>
				<th width="10%">学校区域</th>
				<th width="12%">学校</th>
				<!-- <th width="15%">项目</th> -->
				<th width="10%">联系人</th>
				<th width="10%">手机</th>
				<th width="10%">环境勘查报告</th>
				<th width="8%">状态</th>
				<th width="10%">勘查时间</th>
				<th width="12%">教室信息</th>
			</tr>
			<tbody id="pageBody">
			</tbody>
		</table>
		<div class="pageNavi" id="pager"></div>
		
		</div>
	</div>
	<script type="text/javascript">
	$(document).ready(function(){
		$.post("${root}/admin/area/getBaseAreaByParentId.do",{"parentId":"-1"},function(data){
			var html = '<option value="">-- 请选择 --</option>';
			for(var i = 0,j = data.length; i<j; i++){
			     html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
				
			}
			$("#province").html(html);
			$("#schoolprovince").html(html);
		},'json');
		selectBind("chooseArea","${root}/admin/area/getBaseAreaByParentId.do","parentId");		
		selectBind("schoolchooseArea","${root}/admin/area/getBaseAreaByParentId.do","parentId");		
		$("#showUserList").click(function(){
			parent.Win.open({id:"showUserListWin",url:"${root}/admin/projectmanager/toshowmanagerlist.html",title:"人员列表",width:500,height:400,mask:true}).css('left:1000px;top:300px');
		});
		
		var splitPage;
		search();
	});
	
	
	function getclassroomList(data,total){
		if(total || total != 0){
			if(data){
				$("#totalNum").html(total);
				var start = splitPage.req.start;
				var html ='';
				var classroom;
				for(var i = 0,j = data.length;i<j;i++){
					classroom = data[i];
					start++;
					html+='<tr>';
					html+='<td>'+classroom.roomName+'</td>';
					html+='<td>'+classroom.roomType+'</td>';
					html+='<td>'+classroom.schoolArea+'</td>';
					html+='<td>'+classroom.clsSchoolName+'</td>';
					/* html+='<td>'+classroom.projectName+'</td>'; */
					html+='<td>'+(classroom.contactPersonName==null?'-':classroom.contactPersonName)+'</td>';
					html+='<td>'+(classroom.contactPersonPhone==null?'-':classroom.contactPersonPhone)+'</td>';
					html+='<td><a href="javascript:;" onclick="showEnvironmentReport(\''+classroom.clsClassroomId+'\')">查看</a>&nbsp;&nbsp;<a href="javascript:;" onclick="editEnvironmentReport(\''+classroom.clsClassroomId+'\')">编辑</a></td>';
					html+='<td>'+(classroom.explorationProcess=='0%'?'未完结':'已完结')+'</td>';
					html+='<td>'+classroom.explorationTime+'</td>';
				    html+='<td><a href="javascript:;" onclick="viewclassroom(\''+classroom.clsClassroomId+'\');">详情</a>&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="editclassroom(\''+classroom.clsClassroomId+'\');">编辑</a>&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="delclassroom(\''+classroom.clsClassroomId+'\');">删除</a></td>';
					/* if('admin'==baseUser.adminUserId.trim()){
						html+='</td>';
					}else{
						html+='<a href="javascript:;" class="delLink" onclick="deleteclassroom(\''+baseUser.adminUserId+'\');" style="">删除</a></td>';	
					} */
				}
				$("#pageBody").html(html);
			}else{
				$("#pageBody").html("<tr><td colspan='14'>抱歉，未查询到相关记录!</td></tr>");
				$("#totalNum").html("0");
			}
		}else{
			$("#pageBody").html("<tr><td colspan='14'>抱歉，未查询到相关记录!</td></tr>");
			$("#totalNum").html("0");
		}
	}
	function getCreateRealName(createRealName){
		if(createRealName == null || createRealName == 'null' || createRealName == ''){
			return '无';
		}
		return createRealName;
	}
	
	function getUserType(adminFlag){
		if('Y' == adminFlag){
			return '超级管理员';
		}else{
			return '用户';
		}
	}
	function getState(locked){
		if('Y' == locked){
			return '关闭';
		}else{
			return '开启';
		}
	}
	
	function deleteclassroom(id){
		Win.confirm({'id':'deleteConfirm','html':'确认要删除吗?'},function(){
			$.post("${root}/admin/adminuser/",{'adminUserId':id},function(data){
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
	
	$("#addClassroom").click(function(){
		Win.open({id:"addClassroomWin",url:"${root}/admin/classroom/toadd.html",title:"新增教室",width:600,height:400,mask:true});
	});
	
	function viewclassroomdetail(classroomId){
		Win.open({id:"viewClassroomdetailWin",url:"${root}/admin/classroom/viewclassroomdetail.html?classroomId="+classroomId,title:"安装进展详情",width:800,height:500,mask:true});
	}
	
	function viewclassroom(classroomId){
		Win.open({id:"viewClassroomWin",url:"${root}/admin/classroom/viewclassroom.html?classroomId="+classroomId,title:"教室详情",width:370,height:300,mask:true});
	}
	
	function editclassroom(classroomId){
		Win.open({id:"editClassroomWin",url:"${root}/admin/classroom/toeditclassroom.html?classroomId="+classroomId,title:"编辑教室",width:600,height:400,mask:true});
	}
	
	function delclassroom(classroomId){
		Win.confirm({'id':'deleteConfirm','html':'确认要删除吗?'},function(){
			$.post("${root}/admin/classroom/delclassroom.do",{'classroomId':classroomId},function(data){
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
	function search(){
		var projectAreaId = getProjectArea();
		var clsSchoolAreaId = getSchoolArea();
		var projectName=$.trim($("#projectName").val());
		var clsSchoolName=$.trim($("#clsSchoolName").val()); 
		var implementationProgress = $("#implementationProgress").val();
		var isTrain = $("#isTrain").val();
		var isStart = $("#isStart").val();
		var isExplore = 'explore'; /*环境勘查*/
		$("#pager").html("");
		var config = {
				node:$id("pager"),
				url:"${root}/admin/classroom/getclassroomlist.do",
				count : 20,
				type :"post",
				callback:getclassroomList,
				data:{
					projectAreaId:projectAreaId,
					clsSchoolAreaId:clsSchoolAreaId,
					projectName:projectName,
					clsSchoolName:clsSchoolName,
					implementationProgress:implementationProgress,
					isTrain:isTrain,
					isStart:isStart,
					isExplore :isExplore
				}
			};
			splitPage = new SplitPage(config);
	}
	
	function exportclassroomList(){
		var projectAreaId = getProjectArea();
		var clsSchoolAreaId = getSchoolArea();
		var projectName=$.trim($("#projectName").val());
		var clsSchoolName=$.trim($("#clsSchoolName").val()); 
		var implementationProgress = $("#implementationProgress").val();
		var isTrain = $("#isTrain").val();
		var isStart = $("#isStart").val();
		var url = "${root}/admin/classroomenvir/exportclassroomlist.do?projectAreaId="+projectAreaId
				+"&isExplore=explore&clsSchoolAreaId="+clsSchoolAreaId+"&projectName="+encodeURIComponent(projectName)
				+"&clsSchoolName="+encodeURIComponent(clsSchoolName);
		window.location.href = url;
	}
	6
	function classroomImport(){
		Win.open({id:"uploadExcel",width:500,height:260,title:"批量导入机构用户",url:"${root}/admin/commons/importUserPage.do?userType=area",mask:true});
	}
	
	function getProjectArea(){
		var areas = $("#chooseArea select");
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
		return baseAreaId;
	}
	function getSchoolArea(){
		var areas = $("#schoolchooseArea select");
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
		return baseAreaId;
	}
	function showEnvironmentReport(classroomId){
		Win.open({
		    id:"showEnvironmentWin",
		    url:"${root}/admin/classroominspect/toshowenvironment.html?classroomId="+classroomId,
		    title:"环境勘查报告",
		    width:900,
		    height:500,
		    mask:true
		});
	}
	function editEnvironmentReport(classroomId){
		Win.open({
		    id:"editEnvironmentWin",
		    url:"${root}/admin/classroominspect/toeditenvironment.html?classroomId="+classroomId,
		    title:"环境勘查报告",
		    width:950,
		    height:500,
		    mask:true
		});
	}
	</script>
</body>
</html>