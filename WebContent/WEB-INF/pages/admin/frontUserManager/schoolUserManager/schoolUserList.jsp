<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../common/meta.jsp"%>
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
					<label class="labelText">账号类型：</label>
					<select class="mr20" id="adminFlag">
						<option value="-1">-- 请选择 --</option>
						<option value="Y">超级管理员</option>
						<option value="N">用户</option>
					</select>
					<label class="labelText">行政区：</label>
						<span id="areaSelect">
							<select class="mr20" id="select1">
								<option value="-1">-- 请选择 --</option>
							</select>
						</span>
					<label class="labelText">
						<input type="checkbox" name="permGrant" id="containFlag"/>&nbsp;包含下级机构
					</label>
					<label class="labelText">学段：</label>
					<label>
						<span id="semester">
							<select class="mr20" id="semesterId">
								<option value="-1">-- 请选择 --</option>
								<c:forEach items="${baseSemesters }" var="sem">
									<option value="${sem.baseSemesterId }">${sem.semesterName }</option>
								</c:forEach>
							</select>
						</span>
					</label>
					<label>学校：</label>
					<input type="text" name="schoolName" id="schoolName" placeholder="请输入学校名称" />
				</li>
				<li>
					<label class="labelText">账号名称：</label>
					<input type="text" name="userName" placeholder="请输入账号名称" id="userName" />
					<label class="labelText">状态：</label>
					<select class="mr20" id="locked">
						<option value="-1">-- 请选择 --</option>
						<option value="N">开启</option>
						<option value="Y">关闭</option>
					</select>
					<input type="button" class="submit btn" name="query" onclick="search();" value="查询" />
				</li>
			</ul>
			
			<div class="totalPageBox">
			<div class="fr">
				<a id="addSchoolUser" class="btn btnGreen" href="javascript:;">新增帐号</a>
				<a id="addSchoolUserBatch" class="btn btnGreen" href="javascript:;">批量新增</a>
				<a id="exportSchoolUser" class="btn btnGreen" href="javascript:;">导出</a>
			</div>
			<div>总共<span class="totalNum" id="totalNum">0</span> 条数据</div>
			</div>
		<table class="tableBox">
			<tr>
				<th width="5%">序号</th>
				<th width="10%">账号名称</th>
				<th width="10%">职位</th>
				<th width="8%">账号类型</th>
				<th width="15%">行政区</th>
				<th width="13%">学校名称</th>
				<th width="8%">学段</th>
				<th width="8%">创建人</th>
				<th width="8%">状态</th>
				<th width="12%">操作</th>
			</tr>
			<tbody id="pageBody">
			</tbody>
		</table>
		<div class="pageNavi" id="pager"></div>
		
		</div>
	</div>
	<script type="text/javascript">
	// ================================================================ 函数调用区域 =====================================================
		var splitPage;
		$(document).ready(function(){
			var defaultAreaOp = '<option value="-1">-- 请选择 --</option>';
			$.post("${root}/admin/orgUser/getAreaByparentId.do",{"parentId":"-1"},function(data){
				var html = defaultAreaOp;
				for(var i = 0,j = data.length; i<j; i++){
					html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
				}
				$("#select1").html(html);
			},'json');
			
			selectBind("areaSelect","${root}/admin/orgUser/getAreaByparentId.do","parentId");
			
			search() ;
		});
	
	 // === 获取下拉联动ID
	 function getBaseAreaId(){
		
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
		 return baseAreaId;
	 }
	 
	 // === 新增学校
	 $("#addSchoolUser").click(function(){
		 Win.open({id:"addSchoolUserWin",url:"addSchoolUserPage.html",title:"新增账号",width:600,height:400,mask:true});
	 }) ;
	 
	 // === 编辑学校用户
	 function editSchoolUser(baseSchoolUserId) {
		 Win.open({id:"editSchoolUserWin",url:"editSchoolBaseUserPage.html?baseSchoolUserId="+baseSchoolUserId,title:"编辑账号",width:600,height:400,mask:true});
	 }
	 
	 // === 删除学校用户
	 function deleteSchoolUser(baseSchoolUserId) {
		 Win.confirm({'id':'deleteConfirm','html':'确认要删除吗?'},function(){
			 $.post("deleteSchoolUser.do", {baseSchoolUserId:baseSchoolUserId}, function(data){
				 if(data.result) {
					Win.alert('删除成功');
					spliPageReloadAfterDelete(splitPage);
				 } else{
					 Win.alert('删除失败！');
				 }
			 }, "json") ;
		 }, function(){}) ;
	 }
	 
	 // === 执行查询学校列表
	 function search(){
			var containFlag = "NO";
			if($('#containFlag').is(':checked')){
				containFlag = 'YES';
			}else{
				containFlag = 'NO';
			}
			
		 	var obj = {
		 			adminFlag		:	$("#adminFlag").val() ,
		 			semesterId		:	$("#semesterId").val() ,
		 			areaId			:	getBaseAreaId() ,
		 			schoolName		:	$("#schoolName").val() ,
		 			userName		:	$("#userName").val() ,
		 			locked			:	$("#locked").val() ,
		 			containFlag	:	containFlag
		 	} ;
			$("#pager").html("");
			var config = {
					node		:	$id("pager"),
					url			:	"${root}/admin/schoolUser/showSchoolBaseUserList.do",
					count 		: 	20,
					type 		:	"post",
					callback 	: 	getSchoolUserList,
					data		:	obj
				}
				splitPage = new SplitPage(config);
		}
	 
	  // === 获取学校列表信息
	 function getSchoolUserList(data,total){
			if(total || total != 0){
				if(data){
					$("#totalNum").html(total);
					var start = splitPage.req.start;
					var html ='';
					var baseSchoolUser;
					for(var i = 0,j = data.length;i<j;i++){
						baseSchoolUser = data[i];
						start++;
						html+='<tr>';
						html+='<td>'+start+'</td>';
						html+='<td>'+baseSchoolUser.userName+'</td>';
						html+='<td>'+baseSchoolUser.position+'</td>';
						html+='<td>'+baseSchoolUser.userType+'</td>';
						html+='<td>'+baseSchoolUser.areaName+'</td>';
						html+='<td>'+baseSchoolUser.schoolName+'</td>';
						html+='<td>'+baseSchoolUser.semesterName+'</td>';
						html+='<td>'+baseSchoolUser.createUserName+'</td>';
						html+='<td>'+baseSchoolUser.locked+'</td>';
						html+='<td><a href="javascript:;" onclick="editSchoolUser(\''+baseSchoolUser.baseUserId+'\');">编辑</a>&nbsp;&nbsp;';
						if("Y" == baseSchoolUser.adminFlag){
							html+='</td>';
						}else{
							html+='<a href="javascript:;" class="delLink" onclick="deleteSchoolUser(\''+baseSchoolUser.baseUserId+'\');">删除</a></td>';
						}
					}
					$("#pageBody").html(html);
				}else{
					$("#pageBody").html("<tr><td colspan='10'>抱歉，未查询到相关记录!</td></tr>");
					$("#totalNum").html("0");
				}
			}else{
				$("#pageBody").html("<tr><td colspan='10'>抱歉，未查询到相关记录!</td></tr>");
				$("#totalNum").html("0");
			}
		}
	  
	  // === 条件导出Excel
	  $("#exportSchoolUser").click(function(){
		 var containFlag = "NO";
		 if($('#containFlag').is(':checked')){
			containFlag = 'YES';
		 }else{
			containFlag = 'NO';
		 }
			
		 var obj = {
		 		adminFlag		:	$("#adminFlag").val() ,
		 		semesterId	:	$("#semesterId").val() ,
		 		areaId			:	getBaseAreaId() ,
		 		schoolName	:	$("#schoolName").val() ,
		 		userName		:	$("#userName").val() ,
		 		locked			:	$("#locked").val() ,
		 		containFlag	:	containFlag
		 } ;
		 	
		 var paramsStr = JSON.stringify(obj) ;
		 window.location.href = "exportSchoolUser.html?params="+paramsStr ;
	  }) ; 
	  
	  // === 批量新增页面
	  $("#addSchoolUserBatch").click(function(){
		  Win.open({id:'uploadExcel',width:500,height:260,title:"批量新增学校用户",url:"${root}/admin/commons/importUserPage.do?userType=school",mask:true});
	  }) ;
	</script>
</body>
</html>