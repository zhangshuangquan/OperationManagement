<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root}/public/js/customer.js"></script>
</head>
<body>
<h3 id="cataMenu">
		<a href="javascript:;">项目管理</a> &gt; <a href="javascript:;">教室列表</a>
	</h3>
	<div id="control">
		<div id="controlContent">
			<ul class="searchWrap borderBox">
				<li class="clearfix" style="margin:5px 0 15px;">
			<label class="labelText">项目区域：</label>
				<span class="cont" id="chooseArea">
					<select class="mr20" id="province">
						<option value="-1">-- 请选择 --</option>
					</select>
				</span>
        	<label class="labelText">项目：</label>
				<span class="cont" id="chooseProject">
				<input type="hidden" id="sequence"/><!--添加排序的类别-->
				<input type="hidden" id="installProcess"/><!--添加排序的类别-->
			    <input type="hidden" id="updateProcess"/><!--添加排序的类别-->
			    <input type="text" id="projectName" name="projectName"  >
				</span>
        </li>
        
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="labelText">学校区域：</label>
				<span class="cont" id="schoolchooseArea">
					<select class="mr20" id="schoolprovince">
						<option value="-1">-- 请选择 --</option>
					</select>
				</span>
        	<label class="labelText">学校：</label>
				<span class="cont" id="chooseSchool">
					<input type="text" id="clsSchoolName" name="clsSchoolName"  >
				</span>
				
			<input type="button" class="submit btn" name="query" onclick="search();" value="查询"  style="margin-left: 30px;"/>
        </li>
        <!-- <li class="clearfix" style="margin:5px 0 15px;">
        	<label class="labelText">实施进展：</label>
        	<span class="cont" >
					<select class="mr20" id="implementationProgress">
						<option value="">-- 请选择 --</option>
						<option value="已完成">已完成</option>
						<option value="未完成">未完成</option>
					</select>
			</span>
			<label class="labelText" style="margin-left:10px;">培训状态：</label>
        	<span class="cont" >
					<select class="mr20" id="isTrain">
						<option value="">-- 请选择 --</option>
						<option value="已培训">已培训</option>
						<option value="未培训">未培训</option>
					</select>
			</span>
			<label class="labelText" style="margin-left:10px;">开课情况：</label>
        	<span class="cont" >
					<select class="mr20" id="isStart">
						<option value="">-- 请选择 --</option>
						<option value="已开课">已开课</option>
						<option value="未开课">未开课</option>
					</select>
			</span>
        </li> -->
        
        
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
				<th width="12%">教室名称</th>
				<th width="6%">教室类别</th>
				<th width="10%">学校区域</th>
				<th width="10%">学校</th>
				<th width="12%">项目</th>
				<th width="6%">联系人</th>
				<th width="8%">手机</th>
				<th width="6%">环境勘查报告</th>
				<th width="6%">安装进度<a sortType="status" sortdesc="ASC"  id="install" href="javascript:;">↑↓</a></th>
				<th width="6%">调试进度<a sortType="status" sortdesc="ASC" class="sortBtn" href="javascript:;">↑↓</a></th>
				<th width="8%">进度更新时间<a sortType="status" sortdesc="ASC" id="update" href="javascript:;">↑↓</a></th>
				<!-- <th width="6%">培训状态</th>
				<th width="6%">开课情况</th> -->
				<th width="10%">操作</th>
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
		 var flag="";
		 $("#sequence").attr("value",flag); //给默认的文本框填值
		 search(flag);
	});
	
	
	 /* 对表格头进行点击正反排序 */
	$(".sortBtn").click(function(){
		
		//把其他几个排序置为上下箭头
	    $("#install").attr("sortdesc", "ASC");
	    $("#install").html("↑↓");
	    
	    $("#exploration").attr("sortdesc", "ASC");
	    $("#exploration").html("↑↓");
	    
	    $("#update").attr("sortdesc", "ASC");
	    $("#update").html("↑↓");
	    
	    $("#installProcess").val("");
		$("#updateProcess").val("");
		$("#explorationProcess").val("");
		
		sortDesc = this.getAttribute("sortdesc");
		sortType = this.getAttribute("sortType");
		if(sortDesc == "ASC"){
			$(".sortBtn").html("↑↓");
			this.setAttribute("sortdesc","DESC");
			$(this).html("↓");
		}else{
			this.setAttribute("sortdesc","ASC");
			$(this).html("↑");
		}
		$("#sequence").attr("value",sortDesc); //给默认的文本框填值
		search(sortDesc) ;
	
	});
	$("#install").click(function(){
		
		//把其他几个排序置为上下箭头
	    $("#exploration").attr("sortdesc", "ASC");
	    $("#exploration").html("↑↓");
	    
	    $(".sortBtn").attr("sortdesc", "ASC");
	    $(".sortBtn").html("↑↓");
	    
	    $("#update").attr("sortdesc", "ASC");
	    $("#update").html("↑↓");
	    
	    $("#sequence").val("");
	    $("#explorationProcess").val("");
		$("#updateProcess").val("");
		
		
		var installDesc = this.getAttribute("sortdesc");
		sortType = this.getAttribute("sortType");
		if(installDesc == "ASC"){
			$("#sortBtn").html("↑↓");
			this.setAttribute("sortdesc","DESC");
			$(this).html("↓");
		}else{
			this.setAttribute("sortdesc","ASC");
			$(this).html("↑");
		}
		$("#installProcess").attr("value", installDesc); //给默认的文本框填值
		search() ;
	
	});
	$("#update").click(function(){
		
		//把其他几个排序置为上下箭头
	    $("#exploration").attr("sortdesc", "ASC");
	    $("#exploration").html("↑↓");
	    
	    $(".sortBtn").attr("sortdesc", "ASC");
	    $(".sortBtn").html("↑↓");
	    
	    $("#install").attr("sortdesc", "ASC");
	    $("#install").html("↑↓");
	    
	    $("#sequence").val("");
	    $("#explorationProcess").val("");
	    $("#installProcess").val("");
	    
		var updateDesc = this.getAttribute("sortdesc");
		sortType = this.getAttribute("sortType");
		if(updateDesc == "ASC"){
			$("#sortBtn").html("↑↓");
			this.setAttribute("sortdesc","DESC");
			$(this).html("↓");
		}else{
			this.setAttribute("sortdesc","ASC");
			$(this).html("↑");
		}
		$("#updateProcess").attr("value", updateDesc); //给默认的文本框填值
		search() ;
	
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
					html+='<td>'+classroom.projectName+'</td>';
					html+='<td>'+(classroom.contactPersonName==null?'-':classroom.contactPersonName)+'</td>';
					html+='<td>'+(classroom.contactPersonPhone==null?'-':classroom.contactPersonPhone)+'</td>';
					html+='<td>'+(classroom.explorationProcess=='0%'?'<a href="javascript:;" onclick="showEnvironmentReport(\''+classroom.clsClassroomId+'\')">未完结</a>':'<a href="javascript:;" onclick="showEnvironmentReport(\''+classroom.clsClassroomId+'\');">已完结</a>')+'</td>';
					html+='<td>'+(classroom.installProcess=='0%'?'0%':'<a href="javascript:;" onclick="viewclassroomdetail(\''+classroom.clsClassroomId+'\');">'+classroom.installProcess+'</a>')+'</td>';
					html+='<td>'+(classroom.inspectProcess=='0%'?'0%':'<a href="javascript:;" onclick="viewclassroominspect(\''+classroom.clsClassroomId+'\');">'+classroom.inspectProcess+'</a>')+'</td>';
					/* html+='<td>'+(classroom.isTrain==null?'-':classroom.isTrain)+'</td>';
					html+='<td>'+(classroom.isStart==null?'-':classroom.isStart)+'</td>'; */
					html+='<td>'+classroom.updateTime+'</td>';
				    html+='<td><a href="javascript:;" onclick="viewclassroom(\''+classroom.clsClassroomId+'\');">查看</a>&nbsp;&nbsp;<a href="javascript:;" onclick="editclassroom(\''+classroom.clsClassroomId+'\');">编辑</a>&nbsp;&nbsp;<a href="javascript:;" onclick="delclassroom(\''+classroom.clsClassroomId+'\');">删除</a></td>';
				}
				$("#pageBody").html(html);
			}else{
				$("#pageBody").html("<tr><td colspan='12'>抱歉，未查询到相关记录!</td></tr>");
				$("#totalNum").html("0");
			}
		}else{
			$("#pageBody").html("<tr><td colspan='12'>抱歉，未查询到相关记录!</td></tr>");
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
	
	/////////////
	function viewclassroomdetail(classroomId){
		//Win.open({id:"viewClassroomdetailWin",url:"${root}/admin/classroom/viewclassroomdetail.html?classroomId="+classroomId,title:"安装进展详情",width:800,height:500,mask:true});
		Win.open({id:"viewClassroomdetailWin",url:"${root}/admin/classroominspect/viewclassroomdetail.html?classroomId="+classroomId,title:"安装进展详情",width:800,height:550,mask:true});
	}
	
	function viewclassroominspect(classroomId){
		Win.open({id:"viewClassroomInspectWin",url:"${root}/admin/classroominspect/viewclassroominspect.html?classroomId="+classroomId,title:"调试状态查看",width:800,height:550,mask:true});
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
	function search(sortDesc){
		var sortDesc=$("#sequence").val();
		var installDesc = $("#installProcess").val();
		var updateDesc = $("#updateProcess").val();
		var projectAreaId = getProjectArea();
		var clsSchoolAreaId = getSchoolArea();
		var projectName=$.trim($("#projectName").val());
		var clsSchoolName=$.trim($("#clsSchoolName").val()); 
		var implementationProgress = $("#implementationProgress").val();
		var isTrain = $("#isTrain").val();
		var isStart = $("#isStart").val();
		$("#pager").html("");
		var config = {
				node:$id("pager"),
				url:"${root}/admin/classroom/getclassroomlist.do?sortDesc="+sortDesc,
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
					installDesc : installDesc,
					updateDesc  : updateDesc,
					isStart:isStart
				}
			};
			splitPage = new SplitPage(config);
	}
	
	function exportclassroomList(){
		var sortDesc=$("#sequence").val();
		var installDesc = $("#installProcess").val();
		var updateDesc = $("#updateProcess").val();
		var projectAreaId = getProjectArea();
		var clsSchoolAreaId = getSchoolArea();
		var projectName=$("#projectName").val();
		var clsSchoolName=$("#clsSchoolName").val(); 
		//var implementationProgress = $("#implementationProgress").val();
		/* var isTrain = $("#isTrain").val();
		var isStart = $("#isStart").val(); */
		var url = "${root }/admin/classroom/exportclassroomlist.do?projectAreaId="+projectAreaId+"&sortDesc="+sortDesc
				+"&clsSchoolAreaId="+clsSchoolAreaId+"&projectName="+encodeURIComponent(projectName)
				+"&clsSchoolName="+encodeURIComponent(clsSchoolName)
				/*+"&implementationProgress="+encodeURIComponent(implementationProgress)
				 +"&isTrain="+encodeURIComponent(isTrain)
				+"&isStart="+encodeURIComponent(isStart) */
				+"&installDesc="+installDesc
		        +"&updateDesc="+updateDesc;;
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
		    title:"环境勘察报告",
		    width:900,
		    height:600,
		    mask:true
		});
	}
	</script>
</body>
</html>