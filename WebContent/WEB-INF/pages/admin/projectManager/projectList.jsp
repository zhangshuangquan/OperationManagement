<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script src="${root }/public/js/basiccheck.js"></script>
<script type="text/javascript">
	var domid = frameElement.getAttribute("domid");
</script>
<body>
<h3 id="cataMenu">
		<a href="javascript:;">项目管理</a> &gt; <a href="javascript:;">项目列表</a>
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
				  <label class="labelText">项目名称：</label>
					 <span>
					   <input type="hidden" id="sequence"/><!--添加排序的类别-->
					   <input type="hidden" id="explorationProcess"/><!--添加排序的类别-->
					   <input type="hidden" id="installProcess"/><!--添加排序的类别-->
					   <input type="hidden" id="updateProcess"/><!--添加排序的类别-->
					   <input type="text" name="projectName" id="projectName" />
					 </span>
			   </li>
			     <li class="clearfix" style="margin:5px 0 15px;">
					<label class="labelText">项目经理：</label>
					<span>
					   <input type="text" name="managerName" id="managerName" />
					</span>
					<input type="button" class="submit btn" name="query" onclick="search();" value="查询"  style="margin-left: 30px;"/>
				</li>
			</ul>
			<div class="totalPageBox">
				<div class="fr">
					<a id="addProject" class="btn btnGreen" href="javascript:;">新增项目</a>
				    <a class="btn btnGreen" href="javascript:;" onclick="exportProjectList();">导出</a>
				</div>
				<div>总共<span class="totalNum" id="totalNum">0</span> 条数据</div>
			</div>
		<table class="tableBox">
			<tr>
				<th width="10%">项目编号</th>
				<th width="12%">项目名称</th>
				<th width="12%">项目区域</th>
				<th width="8%">项目经理</th>
				<th width="8%">学校数</th>
				<th width="8%">教室数</th>
				<th width="6%">勘查进度<a sortType="status" sortdesc="ASC"  id="exploration" href="javascript:;">↑↓</a></th>
				<th width="6%">安装进度<a sortType="status" sortdesc="ASC"  id="install" href="javascript:;">↑↓</a></th>
				<th width="6%">调试进度<a sortType="status" sortdesc="ASC" class="sortBtn" href="javascript:;">↑↓</a></th>
				<th width="8%">进度更新时间<a sortType="status" sortdesc="ASC" id="update" href="javascript:;">↑↓</a></th>
				<th width="5%">工程师</th>
				<th width="10%">操作</th>
			</tr>
			<tbody id="pageBody">
			</tbody>
		</table>
		<div class="pageNavi" id="pager"></div>
		
		</div>
	</div>
	<script type="text/javascript">
	var baseAreaId = "";
	 $(document).ready(function(){
		$.post("${root}/admin/area/getBaseAreaByParentId.do",{"parentId":"-1"},function(data){
			var html = '<option value="">-- 请选择 --</option>';
			for(var i = 0,j = data.length; i<j; i++){
				html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
			}
			$("#province").html(html);
		},'json');
		
		selectBind("chooseArea","${root}/admin/area/getBaseAreaByParentId.do","parentId");
		
		$("#addProject").click(function(){
			Win.open({
				id:"addProjectWin",
				url:"${root}/admin/projectmanager/toaddproject.html",
				title:"新增项目",
				width:650,
				height:450,
				mask:true
			});
		});
		
		
		$('#chooseArea').on("change","select",function(){
			var areas = $("#chooseArea select");
			
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
		});
		var splitPage;
		var flag="";
		$("#sequence").attr("value", flag); //给默认的文本框填值
		 search();
		
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
	 
	function getProjectList(data,total){
		if(total || total != 0){
			if(data){
				$("#totalNum").html(total);
				var start = splitPage.req.start;
				var html ='';
				var project;
				for(var i = 0,j = data.length;i<j;i++){
					project = data[i];
					start++;
					html+='<tr>';
					html+='<td>'+project.projectCode+'</td>';
					html+='<td>'+project.projectName+'</td>';
					html+='<td>'+project.areaName+'</td>';
					html+='<td>'+project.managerName+'</td>';
					if(project.schoolCount!=0){
						html+='<td><a href="javascript:;" style="color:#4c7002;" onclick="showSchoolList(\''+project.projectId+'\')">'+project.schoolCount+'</a></td>';
					
					}else{
					    html+='<td>'+project.schoolCount+'</td>';
					}
					if(project.classCount!=0){
						html+='<td><a href="javascript:;" style="color:#4c7002;"  onclick="showClassList(\''+project.projectId+'\')">'+project.classCount+'</a></td>';
					}else{
      					html+='<td>'+project.classCount+'</td>';
				    }
					html+='<td>'+project.explorationProcess+'</td>';
					html+='<td>'+project.installProcess+'</td>';
					html+='<td>'+project.inspectProcess+'</td>';
					html+='<td>'+project.updateTime+'</td>';
					if(project.engineerCount!=0){
						html+='<td><a href="javascript:;" style="color:#4c7002;" onclick="showEngineerList(\''+project.projectId+'\')">'+project.engineerCount+'</a></td>';
					}else{
					    html+='<td>'+project.engineerCount+'</td>';
					}
				    html+='<td><a href="javascript:;" onclick="editProject(\''+project.projectId+'\');">编辑</a>&nbsp;&nbsp;';
				    html+='<a href="javascript:;" onclick="deleteProject(\''+project.projectId+'\');">删除</a></td>';
				    html+='</tr>';
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
	
	//编辑项目
	function editProject(projectId){
		Win.open({
			id:"editProjectWin",
			url:"${root}/admin/projectmanager/toeditproject.html?projectId="+projectId,
		    title:"编辑项目",
		    width:600,
		    height:400,
		    mask:true
		    });
	}
	function search(sortDesc){
		var sortDesc=$("#sequence").val();
		var explorationDesc=$("#explorationProcess").val();
		var installDesc = $("#installProcess").val();
		var updateDesc = $("#updateProcess").val();
		var projectName = $.trim($("#projectName").val());
		var managerName=$.trim($("#managerName").val());
		$("#pager").html("");
		var config = {
				node:$id("pager"),
				url:"${root}/admin/projectmanager/getprojectlists.do",
				count : 20,
				type :"post",
				callback:getProjectList,
				data:{
					areaId:baseAreaId,
					projectName:projectName,
					sortDesc:sortDesc,
					explorationDesc:explorationDesc,
					installDesc : installDesc,
					updateDesc  : updateDesc,
					managerName:managerName
					
				}
			};
			splitPage = new SplitPage(config);
	}
	
	//导出项目
	function exportProjectList(){
		var sortDesc=$("#sequence").val();
		var explorationDesc=$("#explorationProcess").val();
		var installDesc = $("#installProcess").val();
		var updateDesc = $("#updateProcess").val();
		var projectName = $.trim($("#projectName").val());
		var managerName=$.trim($("#managerName").val());
		var url = "${root }/admin/projectmanager/exportprojectlist.do?projectName="+encodeURIComponent(projectName)
				+"&managerName="+encodeURIComponent(managerName)
				+"&areaId="+baseAreaId+"&sortDesc="+sortDesc+"&explorationDesc="+explorationDesc+"&installDesc="+installDesc
				+"&updateDesc="+updateDesc;
		window.location.href = url;
	}
	
	//在项目列表中展示学校
	function showSchoolList(projectId){
	    Win.open({
	    	id:"showSchoolListWin",
	    	width:700,
	    	height:500,
	    	title:"学校列表",
	    	url:"${root}/admin/schoolmanager/toshowschool.do?projectId="+projectId,
	    	mask:true
	    });
	}
	
	//在项目列表中展示教室
	function showClassList(projectId){
		  Win.open({
		    	id:"showClassListWin",
		    	width:700,
		    	height:500,
		    	title:"教室列表",
		    	url:"${root}/admin/schoolmanager/toshowclass.do?projectId="+projectId,
		    	mask:true
		    });
		
	}
	
	//在项目列表中展示工程师
	function showEngineerList(projectId){
		    Win.open({
		    	id:"showEngineerListWin",
		    	width:600,
		    	height:500,
		    	title:"工程师列表",
		    	url:"${root}/admin/projectmanager/toshowengineer.do?projectId="+projectId,
		    	mask:true
		    });
	}
	
	//在项目列表中删除项目
	function deleteProject(projectId){
		Win.confirm({'id':'deleteConfirm','html':'确认要删除吗?'},function(){
			$.post("${root}/admin/projectmanager/deleteproject.do",{'projectId':projectId},function(data){
				if(data){
					if(data.result){
						Win.alert('删除成功！');
						splitPage.reload();
					}else{
						Win.alert(data.message);
					}
				}else{
					Win.alert('删除失败！');
				}
			});
		},function(){});
	}
	</script>
</body>
</html>