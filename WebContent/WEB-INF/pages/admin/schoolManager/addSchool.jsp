<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
 <form id="addSchoolForm">
		<ul class="commonUL">
				<li class="clearfix" style="margin:5px 0 8px;">
					<label class="text">项目区域：</label>
					<span class="cont" id="chooseArea">
						<select class="mr20" id="province" needcheck nullMsg="请选择项目区域!">
							<option value="-1">请选择</option>
						</select>
					</span>
				</li>
				<li class="clearfix">
					<label class="text">项目： </label>
					<span class="cont" id="chooseProject">
						<select class="mr20" id="project" needcheck nullMsg="请选择项目!" >
                            <option value="-1">请选择</option>
						</select>
					</span>
			    </li>
			    <li class="clearfix" style="margin:5px 0 8px;">
					<label class="text">学校区域：</label>
					<span class="cont" id="schoolchooseArea">
						 <select class="mr20" id="schoolProvince" needcheck nullMsg="请学校区域!" >
                            <option value="-1">请选择</option>
						</select>
					</span>
				</li>
				<li>
				    <label class="text">学校名称：</label>
					<span>
						<input type="text" id="schoolName" needcheck nullmsg="请输入学校名称!"/>
					</span>
			    </li>
			    <li>
					<span>
						<label class="text">联系人：</label>
						<input type="text" id="contact" needcheck nullmsg="请输入联系人!"/>
					</span>
			    </li>
			    <li>
						<label class="text">联系电话：</label>
					<span>
						<input type="text" id="phone" needcheck nullmsg="请输入联系电话!" reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" errormsg="联系电话格式不正确！"/>
					</span>
			    </li>
			   
			    <li>
					<hr/>
				    <label class="text">可选工程师：</label>
					<span id="Engs">
						
					</span>
				</li>
				<li class="center" style="margin-top:20px;">
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
				   var html='<div style="margin-left:80px;width:460px;">';
					for(var i=0;i<data.length;i++){
					   html+='<input type="checkbox" name="user" id="'+data[i].adminUserId+'" value="'+data[i].realName+'"/>&nbsp;'+data[i].realName+'&nbsp;&nbsp;';
					}
			        html+='</div>';
					$("#Engs").html(html);
			 },'json');
		 
		   }); 
	  });
	 
	 var domid =frameElement.getAttribute("domid");
	   $("#cancel").click(function(){
	         parent.Win.wins[domid].close();
	 });

	//添加学校
	new BasicCheck({
		form: $id("addSchoolForm"),
		ajaxReq : function(){
			var projectId=$("#project").val();
			var schoolName = $.trim($("#schoolName").val());
			var contact = $.trim($("#contact").val());
			var phone = $.trim($("#phone").val());
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
			
			if(projectId=="-1"){
				Win.alert("请选择项目！");
				return;
			}
			if(baseAreaId == "-1"){
				Win.alert("请选择学校区域！");
				return;
			}
			
			 var s='';
			   $("input[type=checkbox]").each(function(){
				   if($(this).prop("checked")){
					   s+=$(this).attr("id");
					   s+=",";
				   }
				   
			   });
			   var str=s.substring(0,s.length-1);
			
			// === 新增项目
			$.post("${root}/admin/schoolmanager/addschool.do",
					{
					 'projectId'        :   projectId,
					 'schoolName'		:	schoolName,
					 'contact'		    :	contact,
					 'phone'            :   phone,
					 'baseAreaId'       :   baseAreaId,
					 'engineer'         :   str
				},function(data){
				if(data){
					if(!data.result) {
						Win.alert(data.message) ;
					} else {
						if(data.result){
							Win.alert("添加成功！");
							setTimeout("closeMe()",1000);
							parent.splitPage.reload();
							
						}else{
							Win.alert("添加失败！");
						}
					}
					
				}else{
					Win.alert("添加失败！");
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