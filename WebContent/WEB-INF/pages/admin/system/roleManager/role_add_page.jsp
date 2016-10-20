<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../common/meta.jsp"%>
<link href="${root }/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root }/public/calendar/WdatePicker.js"></script>
<script type="text/javascript">
	var domid = frameElement.getAttribute("domid");
</script>
</head>
<body>
	<form id="adminRole">
		<div class="commonWrap">
		<ul class="commonUL">
				<li>
		        <label class="text">角色名称：</label>
		        <span class="cont">
		        	 <input type="text" id="roleName" name="roleName" class="mr20" needcheck nullmsg="请输入角色名称！" limit="1,20" limitmsg="很抱歉，角色名称最大长度为10个字！" />
		        </span>
	       	</li>
	       	<li>
		        <label class="text">备注：</label>
		        <span class="cont">
		        	<input type="text" id="roleDesc" name="roleDesc" needcheck allownull limit="0,40" limitmsg="很抱歉，备注最大长度为20个字!" />
		        </span>
	       	</li>
	       	<li>
		        <label class="text">功能：</label>
		        <span class="cont">
		          		<c:forEach items="${multiMap }" var="map">
	          				<label>
	          						<span id="${map.key }">${map.key }</span>
	          				</label>
					       	<div class="pl20 mb10">
					       			<c:forEach items="${map.value }" var="permssion">
						       			<label><input type="checkbox" id="${permssion.adminPermissionId  }" name="adminRolePermissions" value="${permssion.adminPermissionName }" />${permssion.adminPermissionName }</label>
					       			</c:forEach>
					       	</div>
		          		</c:forEach>
		        </span>
	       	</li>
	       	<li class="center">
	       		<input type="submit" class="submit btn mr10"  value="确定" />
	       		<input type="button" class="btn btnGray" onclick="closeMe()" value="取消" />
	       	</li>
		</ul>
	</div>
	</form>
</body>
<script type="text/javascript">
	<!-- ====================================  js调用区域  ===================================================== -->
	// === 返回的数据flag为false则不能执行插入，true可以执行插入
	function checkAdminRoleName(adminRoleName) {
		if(adminRoleName != "") {
			$.post("checkAdminRoleName.do",{
				adminRoleName	:	adminRoleName
			},function(data){
				if(!data.flag) {
					Win.alert("很抱歉，角色名称已经存在，请重新输入！") ;
					return false ;
				}else{
					return true;
				} 
			}, "json") ;
		}else{
			return true;
		}
	}
	
	// === 关闭窗口
	function closeMe(){
		parent.Win.wins[domid].close();
	} ;
	
	// === Ajax提交
	new BasicCheck({
		form: $id("adminRole"),
		addition : function(){
			return true;
		},
		ajaxReq : function(){
			// === 定义对象
			// === 定义对象
			var roleName = $.trim($("#roleName").val()) ;
			var roleDesc = $.trim($("#roleDesc").val()) ;
			var obj = {
					roleName	:	roleName ,
					roleDesc	:	roleDesc 
			} ;
			
			var adminUserRoles = [] ;
			$("input[name=adminRolePermissions]:checked").each(function() {
				var r = {
						adminPermissionId		:	$(this).attr("id") ,
						adminPermissionName		:	$(this).attr("value") 
				} ;
				adminUserRoles.push(r) ;
			}) ;
			
			obj['adminUserRoles'] = adminUserRoles ;
			$.post("addAdminRole.html", {
				adminRoles : JSON.stringify(obj)
			} ,function(data) {
				if(!data.isExist) {
					Win.alert("很抱歉，角色名称已经存在，请重新输入！") ;
				} else {
					if(data.flag) {
						closeMe() ;
						Win.alert("新增角色成功！") ;
					} else {
						Win.alert("新增角色失败！") ;
					}
				}
			},"json") ; 
		},
		warm: function warm(o, msg) {
			Win.alert(msg);
		}
	});
	
	// ======================================================== 权限复选框的选中状态的控制 ==================================================
	
</script>
</html>