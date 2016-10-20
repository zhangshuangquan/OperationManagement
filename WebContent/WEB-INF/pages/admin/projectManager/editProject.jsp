<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../../common/meta.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script src="${root }/public/js/basiccheck.js"></script>
<script src="${root }/public/js/map.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
	var domid = frameElement.getAttribute("domid");
</script>
</head>
<body>
<div class="commonWrap">
		<form id="editProjectForm">
			<ul class="commonUL">
				<li>
					<label class="text">项目名称：</label>
					<span class="cont">
					    <input type="hidden" name="projectId"  id="projectId"  value="${data.project.projectId}" class="mr20"/>
						<input type="text" name="projectName"  id="projectName"  value="${data.project.projectName}" class="mr20" needcheck nullmsg="请输入项目名称!"/>
					</span>
				</li>
				<li>
					<label class="text">项目编号：</label>
					<span class="cont">
						<input type="text" name="projectCode" id="projectCode" value="${data.project.projectCode }" needcheck nullmsg="请输入项目编号!"/>
					</span>
				</li>
				<li>
					<label class="text">区域：</label>
					<span class="cont" id="chooseArea">
						${data.project.areaPath}
					</span>
				</li>
				<li>
					<label class="text" style="width:100px;">计划开始时间：</label>
					<span class="cont">
						<input id="planBeginTime" needcheck allownull  type="text" class="Wdate" name="planBeginTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'planEndTime\')}'});" value="<fmt:formatDate value="${data.project.planBeginTime}" pattern="yyyy-MM-dd"/>" />     
					</span>
				</li>
				<li>
					<label class="text" style="width:100px;">计划结束时间：</label>
					<span class="text">
						<input id="planEndTime" needcheck allownull  type="text" class="Wdate" name="planEndTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'planBeginTime\')}'});" value="<fmt:formatDate value="${data.project.planEndTime}" pattern="yyyy-MM-dd"/>" />
					</span>
				</li>
				<li>
					<label class="text" style="width:100px;">实施开始时间：</label>
					<span class="cont">
						<input id="implementBeginTime" needcheck allownull  type="text" class="Wdate" name="implementBeginTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'implementEndTime\')}'});" value="<fmt:formatDate value="${data.project.implementBeginTime}" pattern="yyyy-MM-dd"/>" />
					</span>
				</li>
				<li>
					<label class="text" style="width:100px;">实施结束时间：</label>
					<span class="cont">
						<input id="implementEndTime" needcheck allownull  type="text" class="Wdate" name="implementEndTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'implementBeginTime\')}'});" value="<fmt:formatDate value="${data.project.implementEndTime}" pattern="yyyy-MM-dd"/>" />
					</span>
				</li>
				<li>
				<li>
					<label class="text">项目经理：</label>
					<span class="cont">
						<a id="showManagerList" class="btn btnGreen" href="javascript:;">请选择</a>
					    <span id="manager"><span id="${data.manager.adminUserId}" class="m">${data.manager.realName}</span></span>
					   
					</span>
				</li>
				<li>
					<label class="text">工程师：</label>
					<span class="cont">
						<a id="showEngineerList" class="btn btnGreen" href="javascript:;">请选择</a>
						<span id="engineer">
						
						  <c:forEach var="en" items="${data.engineer}" varStatus="status">
						    <c:choose>
						      <c:when test="${status.index<fn:length(data.engineer)-1}">
						        <span id="${en.adminUserId}" class="e">${en.realName}</span>
						        <span id="${en.adminUserId}a">,</span>
						      </c:when>
						      <c:otherwise>						   
						        <span id="${en.adminUserId}" class="e">${en.realName}</span>
						     </c:otherwise>
						    </c:choose>
						   </c:forEach>
						
						</span>
					</span>
				</li>
				<li class="center">
					<input type="submit" class="submit btn mr10" value="提交"/>
					<input type="button" class="btn btnGray" onclick="closeMe()" value="取消"  />
				</li>
			</ul>
		</form>
	</div>
</body>
<script>
	// ======================================================  函数调用区域  =================================================
	$(document).ready(function(){
		$.post("${root}/admin/area/getBaseAreaByParentId.do",{"parentId":"-1"},function(data){
			var html = '<option value="">-- 请选择 --</option>';
			for(var i = 0,j = data.length; i<j; i++){
			     html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
				
			}
			$("#province").html(html);
		},'json');
		selectBind("chooseArea","${root}/admin/area/getBaseAreaByParentId.do","parentId");		
		
		$("#showManagerList").click(function(){
			var managerId=$("#manager").children().attr("id");
			var managerName=$("#manager").children().text();
            var projectId=$("#projectId").val();
			parent.Win.open({
				id:"showManagerListWin",
				url:"${root}/admin/projectmanager/toshowmanagerlist.html?managerId="+managerId+"&managerName="+managerName+"&projectId="+projectId,
				title:"人员列表",
				width:700,
				height:600,
				mask:true}).css('left:950px;top:200px');
			
		});
		
		$("#showEngineerList").click(function(){
			var projectId=$("#projectId").val();
			if($(".e")!=null){
			/* //没有父页面
			 parent.editEngs={};
			 $(".e").each(function (){
				  editEngs[this.id]=this.innerHTML;
			   });*/
				parent.editEngs={};
				  $(".e").each(function (){
					  parent.editEngs[this.id]=this.innerHTML;
				    });  
			} 
			parent.Win.open({
				id:"showEngineerListWin",
				url:"${root}/admin/projectmanager/toshowengineerlist.html?projectId="+projectId,
				title:"人员列表",
				width:700,
				height:600,
				mask:true
			}).css('left:950px;top:200px');
		});
		
		
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
		});
	});

	
	
	
	
	
	new BasicCheck({
		form: $id("editProjectForm"),
		ajaxReq : function(){
			var projectId=$("#projectId").val();
			var projectName = $.trim($("#projectName").val());
			var projectCode = $.trim($("#projectCode").val());
			var managerId=$(".m").attr("id");
			
			var s='';
			var str='';
			if($(".e").attr("id")==null){
		       $("#engineer").children().each(function(){
		    	    str+=$(this).attr("id");
					str+=",";
		       });
		       s=str.substring(0,str.length-1);
			}else{
				$(".e").each(function(){
					str+=$(this).attr("id");
					str+=",";
				});
				s=str.substring(0,str.length-1);
			}
			if(managerId==null){
				Win.alert("请选择项目经理！");
				return;
			}
			
			 var planBeginTime = $("#planBeginTime").val();
			 var planEndTime = $("#planEndTime").val();
			 var implementBeginTime = $("#implementBeginTime").val();
			 var implementEndTime = $("#implementEndTime").val();
			
			// === 编辑项目
			$.post("${root}/admin/projectmanager/updateproject.do",
					{
				     'projectId'        :   projectId,
					 'projectName'      :   projectName,
					 'projectCode'		:	projectCode,
					 'managerId'        :   managerId,
					 'planBeginTime'    :   planBeginTime,
					 'planEndTime'      :   planEndTime,
				  'implementBeginTime'  :   implementBeginTime,
				  'implementEndTime'    :   implementEndTime,
					 'engineer'         :   s
				},function(data){
				if(data){
					if(!data.result.result) {
						if(data.result.message=='工程师已分配在学校无法删除!'){
							Win.alert(data.result.message) ;
						}else{
							Win.alert(data.result.message) ;
							setTimeout("closeMe()",2000);
						}
					} else {
						if(data.result.result){
							Win.alert("编辑成功！");
							setTimeout("closeMe()",1000);
							parent.splitPage.reload();
							
						}else{
							Win.alert("编辑失败！");
						}
					}
					
				}else{
					Win.alert("编辑失败！");
				}
			},'json');
		},
		warm: function warm(o, msg) {
			Win.alert(msg);
		}
	});
	// === 重置密码
	function setRandomPassword(){
		var password = getRandomPassword();
		$("#password").val(password);
	}
	
	//关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
	
	parent.showManager = function (data) {
		$("#manager").html('<span id='+data.managerId+' class="m">'+data.realName+'</span>');
	}

	parent.showEngineer = function (data) {
        var map=data.engineer;
        var html='';
        map.each(function(key,value,index){
        	html+='<span id='+key+' class="e">'+value+'</span>';
        	html+='<span id='+key+'a>,</span>';
        });
        $("#engineer").html(html);
        $("#engineer").children().last().remove();
	}
	
	</script>
</html>