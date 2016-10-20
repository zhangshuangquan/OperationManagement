<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../../common/meta.jsp" %>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script src="${root }/public/js/basiccheck.js"></script>

<script>
  var domid = frameElement.getAttribute("domid");
</script>
<html>
<head>
</head>
<body>		
<div id="commonWrap">
 <form id="editSchoolForm">
		<ul class="commonUL">
				<li class="clearfix" style="margin:5px 0 8px;">
					<label class="text">项目区域：</label>
					<span class="cont" id="chooseArea">
						<select class="mr20" id="province">
							<option value="-1">请选择</option>
						</select>
					</span>
				</li>
				<li class="clearfix">
					<label class="text">项目： </label>
					<span class="cont" id="chooseProject">
						<select class="mr20" id="project" needcheck nullMsg="请选择项目!" >
                            <option value="${edit.schools.projectId}">${edit.schools.projectName}</option>
						</select>
					</span>
			    </li>
			    <li class="clearfix" style="margin:5px 0 8px;">
					<label class="text">学校区域：</label>
					<span class="cont" id="schoolchooseArea">
						<span>${edit.schools.areaPath}</span>
					</span>
				</li>
				<li>
				    <label class="text">学校名称：</label>
					<span>
						<input type="text" id="schoolName" value="${edit.schools.schoolName}" needcheck nullmsg="请输入学校名称!"/>
					</span>
			    </li>
			    <li>
					<span>
						<label class="text">联系人：</label>
						<input type="text" id="contact" value="${edit.schools.contact }"   needcheck nullmsg="请输入联系人!"/>
					</span>
			    </li>
			    <li>
						<label class="text">联系电话：</label>
					<span>
						<input type="text" id="phone" value="${edit.schools.phone}"     needcheck nullmsg="请输入联系电话!" reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" errormsg="联系电话格式不正确！"/>
					</span>
			    </li>
			   
			    <li>
					<hr/>
				    <label class="text">可选工程师：</label>
					<span id="Engs">
					
					<div style="margin-left:80px;width:460px;">
					 <c:forEach var="engs" items="${edit.engs}">
						 <c:set var="flag" value="true" />
						   <c:forEach var="eng" items="${edit.eng}">
						        <c:if test="${engs.adminUserId==eng.adminUserId&&flag }">
						            <c:set var="flag" value="false" />
						        </c:if>
						   </c:forEach>
						    <c:choose>
						      <c:when test="${flag==true}">
						           <input type="checkbox" name="user" id="${engs.adminUserId}" value="${engs.realName}"/>&nbsp;${engs.realName}&nbsp;&nbsp;
						      </c:when>
						       <c:otherwise>
						            <input type="checkbox" name="user" id="${engs.adminUserId}" value="${engs.realName}" checked/>&nbsp;${engs.realName}&nbsp;&nbsp;
						       </c:otherwise>
						    </c:choose>
						  
						 
					 </c:forEach>
					 </div>
					</span>
				</li>
				<li class="center">
					<input type="submit" class="submit btn mr10" value="确定" id="addSchool" />
					<input type="button" class="btn btnGray" id="cancel" value="取消"  />
				</li>
			</ul>
	   </form>
	</div>
</body>
<script>
	 $(document).ready(function() {
		$.post("${root}/admin/area/getBaseAreaByParentId.do", {"parentId" :"-1"}, function(data) {
			 var html = '<option value="">请选择</option>';
			 for (var i = 0, j = data.length; i < j; i++) {
				html += '<option value="'+data[i].id+'">'+ data[i].name + '</option>';
			 }
			 $("#province").html(html);
			 $("#schoolProvince").html(html);
			}, 'json');
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
	 //获取可选工程师
	 $('#chooseProject').on("change",function(){
			var projectId = $("#project").val();
			if(projectId=="-1"){
		          Win.alert("请选择项目！");
		          return ;
			}
			 $.post("${root}/admin/schoolmanager/getenginnerlist.do",{"projectId":projectId},function(data){
				   var html='';
					for(var i=0;i<data.length;i++){
					   html+='<input type="checkbox" name="user" id="'+data[i].adminUserId+'" value="'+data[i].realName+'"/>&nbsp;'+data[i].realName+'&nbsp;&nbsp;';
					}
					$("#Engs").html(html);
			 },'json');
		 
		   }); 
	  });
	 
	 var domid =frameElement.getAttribute("domid");
	   $("#cancel").click(function(){
	         parent.Win.wins[domid].close();
	 });

	//编辑学校
	new BasicCheck({
		form: $id("editSchoolForm"),
		ajaxReq : function(){
			var schoolId='${edit.schools.clsSchoolId}';
			var projectId=$("#project").val();
			var schoolName = $.trim($("#schoolName").val());
			var contact = $.trim($("#contact").val());
			var phone = $.trim($("#phone").val());
			//var areas = $("#schoolchooseArea select");
			/* var areaLength = areas.length;
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
			} */
			if(projectId=="-1"){
				Win.alert("请选择项目！");
				return;
			}
			/* if(baseAreaId == "-1"){
				Win.alert("请选择学校区域！");
				return;
			} */
		   var s='';
		   $("input[type=checkbox]").each(function(){
			   if($(this).prop("checked")){
				   s+=$(this).attr("id");
				   s+=",";
			   }
			   
		   });
		   var str=s.substring(0,s.length-1);

			// === 编辑学校
			$.post("${root}/admin/schoolmanager/editschool.do",
					{
				     'clsSchoolId'      :   schoolId, 
					 'projectId'        :   projectId,
					 'schoolName'		:	schoolName,
					 'contact'		    :	contact,
					 'phone'            :   phone,
					 'engineer'         :   str
				},function(data){
				if(data){
					if(!data.result.result) {
						Win.alert(data.result.message) ;
						setTimeout("closeMe()",2000);
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
			
	//关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
	
/* 	var engs='${edit.eng}';
	
	//复选框事件
    function change(id){
    	var ischecked=$("#"+id).is(':checked');		
    	if(ischecked){
    		s+=id;
     	    s+=",";
    	}else{
    		 $("#"+id).prop("checked",false);
    		 s='';
    		
    	}
    	
    	  
    } */
			
			
			

	//编辑学校
	function editClsSchool(clsSchoolId) {
		Win.open({
			id : "editClsSchoolId",
			title : "编辑学校",
			width : 600,
			height : 500,
			url : "${root}/admin/schoolmgt/editClsSchoolPage.html?clsSchoolId="
					+ clsSchoolId
		});
	}

	//删除学校
	function deleteSchool(clsSchoolId) {
		Win.confirm({
			html : '<span class="dialog_Inner">确认要删除吗?</span>',
			mask : true
		}, function() {
			$.post('${root}/admin/schoolmgt/deleteSchoolById.do', {
				"clsSchoolId" : clsSchoolId
			}, function(result) {
				if (result.result) {
					Win.alert("删除成功");
					getClsSchoolList();
				} else {
					Win.alert(result.message);
				}
			}, "json");
		}, true);
	}
</script>
</html>