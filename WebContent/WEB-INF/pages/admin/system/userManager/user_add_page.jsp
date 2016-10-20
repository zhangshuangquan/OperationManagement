<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../common/meta.jsp"%>
<link href="${root }/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root }/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
<script type="text/javascript">
	var domid = frameElement.getAttribute("domid");
</script>
</head>
<body>
	<form id="adminUser">
		<div class="commonWrap">
		<ul class="commonUL">
				<li>
		        <label class="text">账号名称：</label>
		        <span class="cont">
		        	 <input type="text" id="userName" name="userName" needcheck nullmsg="请输入账号名称!" limit="6,18" limitmsg="很抱歉，账号名称长度需要是6到18个英文字符！" reg="^[0-9a-zA-Z|,|.|;|~|!|@|@|#|$|%|\^|&|*|(|)|_|+|-|=|\\|/|<|>]{6,18}$" errormsg="对不起，账号名称请输入英文字母、数字、符号（除特殊字符），或组合。" class="mr20" />
		        </span>
	       	</li>
				<li>
		        <label class="text">密码：</label>
		        <span class="cont">
		        	 <input type="text" id="password" name="password" value="666666" class="mr20" needcheck nullmsg="请输入密码!" limit="6,18" limitmsg="很抱歉，密码长度需要是6到18个英文字符" reg="^[0-9a-zA-Z|,|.|;|~|!|@|@|#|$|%|\^|&|*|(|)|_|+|-|=|\\|/|<|>]{6,18}$" errormsg="对不起，密码请输入英文字母、数字、符号（除特殊字符），或组合。" />
		        	 <input type="button" id="randomPass" class="btn btnGreen" value="随机密码">
		        </span>
	       	</li>
	       	<li>
		        <label class="text">备注：</label>
		        <span class="cont">
		        	<input type="text" id="remark" name="remark" needcheck allownull limit="0,40" limitmsg="很抱歉，备注最大长度为20个字!" />
		        </span>
	       	</li>
	       	<li>
			     <label class="text">姓名：</label>
		        <span class="cont">
			        <input type="text" id="realName" name="realName" class="mr20" needcheck nullmsg="请输入姓名!" limit="1,20" limitmsg="很抱歉，姓名最大长度为10个字!" />
		         </span>
	       	</li>
	       	<li>
       			<label class="text">联系电话：</label>
       			<span class="cont">
		       		<input type="text" id="contact" name="contact" needcheck nullmsg="请输入联系电话!" reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" errormsg="联系电话格式不正确！" />
		       	</span>
	       	</li>
	       	<li>
		        <label class="text">角色：</label>
		        <span class="cont">
		        		<c:forEach items="${adminRoles }" var="adminRole">
				       	<label><input type="checkbox" id="${adminRole.adminRoleId  }" name="adminUserRoles" value="${adminRole.roleName }" />${adminRole.roleName }</label>
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
	$("#randomPass").unbind("click") ;
	$("#randomPass").bind("click", function() {
		var randomPass = getRandomPassword() ;
		$("#password").val(randomPass) ;
	}) ;
	
	// === 关闭窗口
	function closeMe(){
		parent.Win.wins[domid].close();
	} ;
	
	
	// === Ajax提交
	new BasicCheck({
		form: $id("adminUser"),
		addition : function(){
			return true;
		},
		ajaxReq : function(){
			// === 定义对象
			var userName = $.trim($("#userName").val()) ;
			var password = $.trim($("#password").val()) ;
			var realName = $.trim($("#realName").val()) ;
			var remark	= $.trim($("#remark").val()) ;
			var contact  = $.trim($("#contact").val()) ;
			var obj = {
					userName	:	userName ,
					password	:	password ,
					realName	:	realName ,
					remark		:	remark ,
					contact	:	contact
			} ;
			
			var adminUserRoles = [] ;
			$("input[name=adminUserRoles]:checked").each(function() {
				var r = {
						adminRoleId		:	$(this).attr("id") ,
						adminRoleName	:	$(this).attr("value") 
				} ;
				adminUserRoles.push(r) ;
			}) ;
			
			obj['adminUserRoles'] = adminUserRoles ; 
			$.post("addAdminUser.html", {
				adminRoles : JSON.stringify(obj)
			} ,function(data) {
				if(!data.isExist) {
					Win.alert("很抱歉，账号名称已经存在，请重新输入！") ;
				} else {
					if(data.flag) {
						closeMe() ;
						Win.alert("新增用户成功！") ;
					} else {
						Win.alert("新增用户失败！") ;
					}
				}
			},"json") ; 
		},
		warm: function warm(o, msg) {
			Win.alert(msg);
		}
	});
</script>
</html>