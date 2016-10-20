<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
<script type="text/javascript">
	var domid = frameElement.getAttribute("domid");
</script>
<body>
<h3 id="cataMenu">
		<a href="javascript:;">项目管理</a> &gt; <a href="javascript:;">学校列表</a>
	</h3>
	<div id="control">
		<div id="controlContent">
			<ul class="searchWrap borderBox">
				<li class="clearfix" style="margin:5px 0 15px;">
					<label class="labelText">项目区域：</label>
					<span class="cont" id="chooseArea">
						<select class="mr20" id="province">
							<option value="">-- 请选择 --</option>
						</select>
					</span>
					<label class="labelText">项目名称：</label>
					<input type="text" id="projectName" name="projectName"/>
				</li>
				<li class="clearfix" style="margin:5px 0 15px;">
					<label class="labelText">学校区域：</label>
					<span class="cont" id="schoolchooseArea">
						<select class="mr20" id="schoolProvince">
						   <option value="">-- 请选择 --</option>
						</select>
					</span>
					<label class="labelText">学校：</label>
					<input type="hidden" id="sequence"/><!--添加排序的类别-->
					<input type="hidden" id="explorationProcess"/><!--添加排序的类别-->
					<input type="hidden" id="installProcess"/><!--添加排序的类别-->
					<input type="hidden" id="updateProcess"/><!--添加排序的类别-->
					<input type="text" name="scoolName" id="schoolName" />
					<input type="button" class="submit btn" name="query" onclick="search();" value="查询"  style="margin-left: 30px;"/>
				</li>
			</ul>
			<div class="totalPageBox">
				<div class="fr">
					<a id="addSchool" class="btn btnGreen" href="javascript:;">新增学校</a>
				    <a class="btn btnGreen" href="javascript:;" onclick="exportSchoolList();">导出</a>
				</div>
				<div>总共<span class="totalNum" id="totalNum">0</span> 条数据</div>
			</div>
		<table class="tableBox">
			<tr>
				<th width="12%">学校名称</th>
				<th width="12%">学校区域</th>
				<th width="14%">项目名称</th>
				<th width="8%">项目经理</th>
				<th width="8%">教室数</th>
				<th width="8%">工程师</th>
				<th width="6%">勘查进度<a sortType="status" sortdesc="ASC"  id="exploration" href="javascript:;">↑↓</a></th>
				<th width="6%">安装进度<a sortType="status" sortdesc="ASC"  id="install" href="javascript:;">↑↓</a></th>
				<th width="6%">调试进度<a sortType="status" sortdesc="ASC" class="sortBtn" href="javascript:;">↑↓</a></th>
				<th width="8%">进度更新时间<a sortType="status" sortdesc="ASC" id="update" href="javascript:;">↑↓</a></th>
				<th width="12%">操作</th>
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
			$("#schoolProvince").html(html);
		},'json');
	 
		selectBind("chooseArea","${root}/admin/area/getBaseAreaByParentId.do","parentId");		
		selectBind("schoolchooseArea","${root}/admin/area/getBaseAreaByParentId.do","parentId");
		
		 $('#chooseArea').on("change","select",function(){
				var areas = $("#chooseArea select");
				var baseAreaId = "";
				var baseAreaId1 = "";
				if(areas.length == 1){
					baseAreaId = $(areas[0]).val();
				}else{
					baseAreaId = $(areas[areas.length-2]).val();
					baseAreaId1 =$(areas[areas.length-1]).val();
					if("-1" != baseAreaId1){
						baseAreaId = baseAreaId1;
					}
				}
			 $.post("${root}/admin/projectmanager/getprojectbyarea.do",{"areaId":baseAreaId},function(data){
					var html = '<option value="">-- 请选择 --</option>';
					for(var i = 0,j = data.length; i<j; i++){
						html += '<option value="'+data[i].projectId+'">'+data[i].projectName+'</option>';
					}
					$("#project").html(html);
			 },'json');
		 
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
			 $("#exploration").click(function(){
				 
				 //把其他几个排序置为上下箭头
				    $("#install").attr("sortdesc", "ASC");
				    $("#install").html("↑↓");
				    
				    $(".sortBtn").attr("sortdesc", "ASC");
				    $(".sortBtn").html("↑↓");
				    
				    $("#update").attr("sortdesc", "ASC");
				    $("#update").html("↑↓");
				    
				    $("#sequence").val("");
				    $("#installProcess").val("");
					$("#updateProcess").val("");
					
					var explorationDesc = this.getAttribute("sortdesc");
					sortType = this.getAttribute("sortType");
					if(explorationDesc == "ASC"){
						$("#sortBtn").html("↑↓");
						this.setAttribute("sortdesc","DESC");
						$(this).html("↓");
					}else{
						this.setAttribute("sortdesc","ASC");
						$(this).html("↑");
					}
					$("#explorationProcess").attr("value", explorationDesc); //给默认的文本框填值
					search() ;
				
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
		
	 $("#addSchool").click(function(){
		Win.open({
		  id	: "addSchoolWin",
		  title : "新增学校" ,
		  width : 600,
		  height : 500,
		  url : "${root}/admin/schoolmanager/toaddschool.html",
		  mask: true
		});
	 });
	
	 var splitPage;
	 var flag="";
	 $("#sequence").attr("value",flag); //给默认的文本框填值
	 search(flag);
	
	
   });


 function getSchoolList(data,total){
		if(total || total != 0){
			if(data){
				$("#totalNum").html(total);
				var start = splitPage.req.start;
				var html ='';
				var school;
				for(var i = 0,j = data.length;i<j;i++){
					school = data[i];
					start++;
					html+='<tr>';
					html+='<td>'+school.schoolName+'</td>';
					html+='<td>'+school.areaPath+'</td>';
					html+='<td>'+school.projectName+'</td>';
					html+='<td>'+school.managerName+'</td>';
					if(school.classCount!=0){
					  html+='<td><a href="javascript:;" style="color:#4c7002;" onclick="showClassRoom(\''+school.clsSchoolId+'\')">'+school.classCount+'</a></td>';	
					}else{
					  html+='<td>'+school.classCount+'</td>';
					}
					if(school.engineerCount!=0){
						html+='<td><a href="javascript:;" style="color:#4c7002;" onclick="showEngineer(\''+school.clsSchoolId+'\')">'+school.engineerCount+'</a></td>';
					}else{
					    html+='<td>'+school.engineerCount+'</td>';
					}
					html+='<td>'+school.explorationProcess+'</td>';
					html+='<td>'+school.installProcess+'</td>';
					html+='<td>'+school.inspectProcess+'</td>';
					html+='<td>'+school.updateTime+'</td>';
				    html+='<td><a href="javascript:;" onclick="editSchool(\''+school.clsSchoolId+'\',\''+school.projectId+'\');">编辑</a>&nbsp;&nbsp;<a href="javascript:;"   onclick="deleteSchool(\''+school.clsSchoolId+'\');">删除</a></td>';
				    html+='</tr>';
				}
				$("#pageBody").html(html);
			}else{
				$("#pageBody").html("<tr><td colspan='11'>抱歉，未查询到相关记录!</td></tr>");
				$("#totalNum").html("0");
			}
		}else{
			$("#pageBody").html("<tr><td colspan='11'>抱歉，未查询到相关记录!</td></tr>");
			$("#totalNum").html("0");
		}
	}
    function search(sortDesc){
    	var sortDesc=$("#sequence").val();
    	var explorationDesc=$("#explorationProcess").val();
		var installDesc = $("#installProcess").val();
		var updateDesc = $("#updateProcess").val();
		var projectAreaId =getProjectArea();
		var clsSchoolAreaId = getSchoolArea();
		var projectName=$.trim($("#projectName").val());
		var clsSchoolName=$.trim($("#schoolName").val());
		$("#pager").html("");
		var config = {
				node:$id("pager"),
				url:"${root}/admin/schoolmanager/getschoollists.do",
				count : 20,
				type :"post",
				callback:getSchoolList,
				data:{
					projectAreaId:projectAreaId,
					clsSchoolAreaId:clsSchoolAreaId,
					projectName:projectName,
					sortDesc:sortDesc,
					explorationDesc:explorationDesc,
					installDesc : installDesc,
					updateDesc  : updateDesc,
					clsSchoolName:clsSchoolName
					
				}
			};
			splitPage = new SplitPage(config);
	}
    
    
    //导出学校列表
    function exportSchoolList(){
    	var sortDesc=$("#sequence").val();
    	var explorationDesc=$("#explorationProcess").val();
		var installDesc = $("#installProcess").val();
		var updateDesc = $("#updateProcess").val();
		var projectAreaId = getProjectArea();
		var clsSchoolAreaId = getSchoolArea();
		var projectName=$("#projectName").val();
		var clsSchoolName=$("#schoolName").val(); 
		var url = "${root }/admin/schoolmanager/exportschoollist.do?projectAreaId="+projectAreaId+"&sortDesc="+sortDesc
				+"&clsSchoolAreaId="+clsSchoolAreaId+"&projectName="+encodeURIComponent(projectName)
				+"&clsSchoolName="+encodeURIComponent(clsSchoolName)+"&explorationDesc="+explorationDesc+"&installDesc="+installDesc
				+"&updateDesc="+updateDesc;
		window.location.href = url;
	}


	//编辑学校
	function editSchool(clsSchoolId,projectId) {
		Win.open({
			id : "editClsSchoolId",
			title : "编辑学校",
			width : 600,
			height : 500,
			url : "${root}/admin/schoolmanager/toeditschool.html?schoolId="+clsSchoolId+"&projectId="+projectId
		});
	}

	//删除学校
	function deleteSchool(clsSchoolId) {
		Win.confirm({
			html : '<span class="dialog_Inner">确认要删除吗?</span>',
			mask : true
		}, function() {
			$.post('${root}/admin/schoolmanager/deleteschoolbyid.do', {
				"clsSchoolId" : clsSchoolId
			}, function(data) {
			if(data){
				if(data.result){
					Win.alert('删除成功！');
					splitPage.reload();
				}else{
					Win.alert(data.message);
				}
			}else{
				Win.alert("删除失败！");
			}
				
			}, "json");
		}, true);
	}

	//展示教室
    function showClassRoom(schoolId){
    	Win.open({
			id : "showClassroomWin",
			title : "教室列表",
			width : 700,
			height : 500,
			url : "${root}/admin/schoolmanager/toshowclassroom.html?schoolId="+schoolId,
			mask:true
		});
    } 
	
	//展示工程师
	function showEngineer(schoolId){
		Win.open({
			id : "showEngineerWin",
			title : "工程师列表",
			width : 600,
			height : 500,
			url : "${root}/admin/schoolmanager/toshowengineer.html?schoolId="+schoolId,
			mask:true
		});
	}
	
	
	//获取项目区域
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
	//获取学校区域
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
</script>
</body>
</html>