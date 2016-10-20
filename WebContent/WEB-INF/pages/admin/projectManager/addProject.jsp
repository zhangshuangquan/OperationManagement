<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
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
		<form id="addProjectForm">
			<ul class="commonUL">
				<li>
					<label class="text">项目名称：</label>
					<span class="cont">
						<input type="text" name="projectName" class="mr20" id="projectName" needcheck nullmsg="请输入项目名称!"/>
					</span>
				</li>
				<li>
					<label class="text">项目编号：</label>
					<span class="cont">
						<input type="text" name="projectCode" id="projectCode" needcheck nullmsg="请输入项目编号!"/>
					</span>
				</li>
				<li>
					<label class="text">区域：</label>
					<span class="cont" id="chooseArea">
						<select class="mr20" id="province" needcheck nullMsg="请选择项目区域!">
							<option value="-1">-- 请选择 --</option>
						</select>
					</span>
				</li>
				<li>
					<label class="text" style="width:100px;">计划开始时间：</label>
					<span class="cont">
						<input id="planBeginTime" needcheck allownull  type="text" class="Wdate" name="planBeginTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'planEndTime\')}'});" value="" />     
					</span>
				</li>
				<li>
					<label class="text" style="width:100px;">计划结束时间：</label>
					<span class="text">
						<input id="planEndTime" needcheck allownull  type="text" class="Wdate" name="planEndTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'planBeginTime\')}'});" value="" />
					</span>
				</li>
				<li>
					<label class="text" style="width:100px;">实施开始时间：</label>
					<span class="cont">
						<input id="implementBeginTime" needcheck allownull  type="text" class="Wdate" name="implementBeginTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'implementEndTime\')}'});" value="" />
					</span>
				</li>
				<li>
					<label class="text" style="width:100px;">实施结束时间：</label>
					<span class="cont">
						<input id="implementEndTime" needcheck allownull  type="text" class="Wdate" name="implementEndTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'implementBeginTime\')}'});" value="" />
					</span>
				</li>
				<li>
					<label class="text">项目经理：</label>
					<span class="cont">
						<a id="showManagerList" class="btn btnGreen" href="javascript:;">请选择</a>
					    <span id="manager"></span>
					</span>
				</li>
				<li>
					<label class="text">工程师：</label>
					<span class="cont">
						<a id="showEngineerList" class="btn btnGreen" href="javascript:;">请选择</a>
						<span id="engineer"></span>
					</span>
				</li>
				<li class="center">
					<input type="submit" class="submit btn mr10" value="确定" id="addSchool" />
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
			parent.Win.open({id:"showManagerListWin",
				url:"${root}/admin/projectmanager/toshowmanagerlist.html?managerId="+managerId+"&managerName="+managerName,
				title:"人员列表",
				width:700,
				height:600,
				mask:true}).css('left:950px;top:200px');
		});
		$("#showEngineerList").click(function(){
			if($(".e")!=null){
				 parent.editEngs={};
				  $(".e").each(function (){
					  parent.editEngs[this.id]=this.innerHTML;
				    });  
				}
			parent.Win.open({id:"showEngineerListWin",
				url:"${root}/admin/projectmanager/toshowengineerlist.html",
				title:"人员列表",
				width:700,
				height:600,
				mask:true}).css('left:950px;top:200px');
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
		form: $id("addProjectForm"),
		ajaxReq : function(){
			var projectName = $.trim($("#projectName").val());
			var projectCode = $.trim($("#projectCode").val());
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
			if(baseAreaId == "-1"){
				Win.alert("请选择行政区！");
				return;
			}
			var managerId=$(".m").attr("id");
			var str='';
			$(".e").each(function(){
				str+=$(this).attr("id");
				str+=",";
			});
			var s=str.substring(0,str.length-1);
			if(managerId==null){
				Win.alert("请选择项目经理！");
				return;
			}
		    
		   var planBeginTime = $("#planBeginTime").val();
		   var planEndTime = $("#planEndTime").val();
		   var implementBeginTime = $("#implementBeginTime").val();
		   var implementEndTime = $("#implementEndTime").val();
			
			
			
			
			// === 新增项目
			$.post("${root}/admin/projectmanager/addproject.do",
					{
					 'projectName'      :   projectName,
					 'projectCode'		:	projectCode,
					 'baseAreaId'		:	baseAreaId,
					 'managerId'        :   managerId,
					 'planBeginTime'    :   planBeginTime,
					 'planEndTime'      :   planEndTime,
				  'implementBeginTime'  :   implementBeginTime,
				  'implementEndTime'    :   implementEndTime,
					 'engineer'         :   s
					
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