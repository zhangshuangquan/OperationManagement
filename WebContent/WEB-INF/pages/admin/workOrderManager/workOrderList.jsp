<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
</head>
<body>
<h3 id="cataMenu">
		<a href="javascript:;">售后维护保障记录</a> &gt; <a href="javascript:;">工单管理</a>
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
					  <input type="text" id="projectName" name="projectName"  >
				   </span>
				   <label class="labelText">维修人员：</label>
				   <span class="cont" id="chooseProject">
					  <input type="text" id="serviceman" name="serviceman"  >
				   </span>
				   <label class="labelText">最新状态：</label>
        	        <span class="cont" >
					<select class="mr20" id="state">
						<option value="">-- 请选择 --</option>
						<option value="客户来电">客户来电</option>
						<option value="派工流程">派工流程</option>
						<option value="任务分配">任务分配</option>
						<option value="上门维修">上门维修</option>
						<option value="问题解决">问题解决</option>
						<option value="售后回访">售后回访</option>
					</select>
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
				
				<label class="labelText">联系人：</label>
				<span class="cont">
					<input type="text" id="contact" name="contact"  >
				</span>
				<label class="labelText">联系电话：</label>
				<span class="cont">
					<input type="text" id="contactPhone" name="phone"  >
				</span>
       
        	<input type="button" class="submit btn" name="query" onclick="search();" value="查询"  style="margin-left: 30px;"/>
        </li>
        
			</ul>
			<div class="totalPageBox">
				<div class="fr">
					<a id="addAfterSaleRecord" class="btn btnGreen" href="javascript:;">新增</a>
				    <a class="btn btnGreen" href="javascript:;" onclick="exportWorkOrderList();">导出</a>
				</div>
				<div>总共<span class="totalNum" id="totalNum">0</span> 条数据</div>
			</div>
		<table class="tableBox">
			<tr>
				<th width="7%">单号</th>
				<th width="5%">学校名称</th>
				<th width="10%">学校区域</th>
				<th width="5%">联系人</th>
				<th width="5%">联系电话</th>
				<th width="10%">项目</th>
				<th width="5%">最新状态</th>
				<th width="5%">工单提交人</th>
				<th width="5%">维修人员</th>
				<th width="5%">售后保障表</th>
				<th width="5%">设备寄送</th>
				<th width="5%">图片附件</th>
				<th width="11%">操作</th>
				<th width="17%">备注</th>
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
	
	
	function getWorkOrderList(data,total){
		if(total || total != 0){
			if(data){
				$("#totalNum").html(total);
				var start = splitPage.req.start;
				var html ='';
				var classroom;
				for(var i = 0,j = data.length;i<j;i++){
					workOrder = data[i];
					var download='javascript:;';
					var load='javascript:;';
					var conStr="color:gray;";
					if(workOrder.attachmentURL!=null&&workOrder.name!=null){
						conStr="color:#4c7002;";
						download='${root}/images/'+workOrder.attachmentURL+'/'+encodeURIComponent(workOrder.name);
					}
					/* if(workOrder.numcount==0){
						conStr="color:#4c7002;";
						download='${root}/images/'+workOrder.attachmentURL+'/'+workOrder.name;
					} */
					start++;
					html+='<tr>';
					html+='<td>'+workOrder.orderNum+'</td>';
					html+='<td>'+workOrder.schoolName+'</td>';
					html+='<td>'+workOrder.schoolPath+'</td>';
					html+='<td>'+(workOrder.contact==null?'-':workOrder.contact)+'</td>';
					html+='<td>'+(workOrder.phone==null?'-':workOrder.phone)+'</td>';
					html+='<td>'+workOrder.projectName+'</td>';
					html+='<td><span>'+(workOrder.maxdate==null?'':workOrder.maxdate)+'</span><br/><span>'+(workOrder.maxdatestr==null?'-':workOrder.maxdatestr)+'</span></td>';
					html+='<td>'+workOrder.submitRealName+'</td>';
					html+='<td>'+workOrder.engineer+'</td>';
					html+='<td><a href='+download+' style='+conStr+' >下载</a></td>';
					html+='<td>'+(workOrder.equipNum==null?0:workOrder.equipNum)+'</td>';
					if(workOrder.numcount==0){
						html+='<td><a href="javascript:;" style="color:gray;");">查看</a>&nbsp;&nbsp;<a href="javascript:;" style="color:gray;">下载</a></td>';
					}else{
					  html+='<td><a href="javascript:;" onclick="viewPicture(\''+workOrder.maintenanceOrderId+'\');">查看</a>&nbsp;&nbsp;<a href="javascript:;" onclick="downloadPicture(\''+workOrder.maintenanceOrderId+'\');">下载</a></td>';
						
					}
				    html+='<td><a href="javascript:;" onclick="viewWorkOrder(\''+workOrder.maintenanceOrderId+'\');">查看</a>&nbsp;&nbsp;<a href="javascript:;" onclick="editWorkOrder(\''+workOrder.maintenanceOrderId+'\');">编辑</a>&nbsp;&nbsp;<a href="javascript:;" onclick="delWorkOrder(\''+workOrder.maintenanceOrderId+'\');">删除</a>&nbsp;&nbsp;<a href="javascript:;" onclick="getSignInfo(\''+workOrder.maintenanceOrderId+'\');">签到信息</a></td>';
				    html+='<td>'+(workOrder.remark==null?'-':workOrder.remark)+'</td>';
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
	
	
	
	$("#addAfterSaleRecord").click(function(){
		Win.open({
			id:"addAfterSaleWin",
			url:"${root}/admin/workorder/toaddaftersale.html",
			title:"售后保障记录",
			width:850,
			height:500,
			mask:true
	    });
	});
	
	//查看图片
	function viewPicture(maintenanceOrderId){
		Win.open({
			id:"addAfterSaleWin",
			url:"${root}/admin/workorder/toviewpicture.html?maintenanceOrderId="+maintenanceOrderId,
			title:"图片附件查看",
			width:800,
			height:500,
			mask:true
	    });
	}
	
	//查看工单
	function viewWorkOrder(maintenanceOrderId){
		Win.open({
			id:"viewWorkOrderWin",
			url:"${root}/admin/workorder/viewworkorder.html?maintenanceOrderId="+maintenanceOrderId,
			title:"售后保障记录",
			width:850,
			height:500,
			mask:true
		});
	}
	
	//显示签到信息
	function getSignInfo(maintenanceOrderId){
		Win.open({id:"addOrgUserWin",url:"${root}/admin/personsigncontroller/jumptoworkersigninfo.do?maintenanceOrderId="+maintenanceOrderId,title:"签到历史记录",width:600,height:400,mask:true});
	}
	
	//编辑工单
	function editWorkOrder(maintenanceOrderId){
		Win.open({
			id:"editWorkOrderWin",
			url:"${root}/admin/workorder/toeditworkorder.html?maintenanceOrderId="+maintenanceOrderId,
		    title:"售后保障记录",
		    width:850,
		    height:500,
		    mask:true
		});
	}
	
	//删除工单
	function delWorkOrder(maintenanceOrderId){
		Win.confirm({'id':'delWorkOrder','html':'确认要删除吗?'},function(){
			$.post("${root}/admin/workorder/delworkorder.do",
					{'maintenanceOrderId':maintenanceOrderId},
					function(data){
				if(data){
					if(data.result){
						Win.alert(data.message);
						splitPage.reload();
					}else{
						Win.alert(data.message);
					}
				}else{
					Win.alert(data.message);
				}
			});
		},function(){});
	}
	
	function downloadPicture(maintenanceOrderId){
		Win.open({
			id:"downloadPictureWin",
			url:"${root}/admin/workorder/todownloadpicture.html?maintenanceOrderId="+maintenanceOrderId,
		    title:"图片附件下载",
		    width:600,
		    height:500,
		    mask:true
		});
	}
	
	
	
	function search(){
		var projectAreaId = getProjectArea();
		var clsSchoolAreaId = getSchoolArea();
		var projectName=$.trim($("#projectName").val());
		var clsSchoolName=$.trim($("#clsSchoolName").val()); 
		var serviceman=$.trim($("#serviceman").val());
		var contact=$.trim($("#contact").val());
		var phone=$.trim($("#contactPhone").val());
		var isState=$("#state").val();
		$("#pager").html("");
		var config = {
				node:$id("pager"),
				url:"${root}/admin/workorder/getworkorderlist.do",
				count : 20,
				type :"post",
				callback:getWorkOrderList,
				data:{
					projectAreaId   : projectAreaId,
					clsSchoolAreaId :clsSchoolAreaId,
					projectName     :projectName,
					clsSchoolName   :clsSchoolName,
					repair          :serviceman,
					contact         :contact,
					phone           :phone,
					isState         :isState
				}
			};
			splitPage = new SplitPage(config);
	}
	
	function exportWorkOrderList(){
		var projectAreaId = getProjectArea();
		var clsSchoolAreaId = getSchoolArea();
		var projectName=$.trim($("#projectName").val());
		var clsSchoolName=$.trim($("#clsSchoolName").val()); 
		var serviceman=$.trim($("#serviceman").val());
		var contact=$.trim($("#contact").val());
		var phone=$.trim($("#contactPhone").val());
		var isState=$("#state").val();
		var url ="${root}/admin/workorder/exportworkorderlist.do?projectAreaId="+projectAreaId
				+"&clsSchoolAreaId="+clsSchoolAreaId
				+"&projectName="+encodeURIComponent(projectName)
				+"&clsSchoolName="+encodeURIComponent(clsSchoolName)
				+"&repair="+encodeURIComponent(serviceman)
				+"&contact="+encodeURIComponent(contact)
				+"&phone="+encodeURIComponent(phone)
				+"&isState="+encodeURIComponent(isState);
		window.location.href = url;
	}
	
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
	</script>
</body>
</html>