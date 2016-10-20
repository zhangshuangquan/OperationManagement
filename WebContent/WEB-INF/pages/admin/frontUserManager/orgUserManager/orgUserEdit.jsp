<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../common/meta.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script src="${root }/public/js/basiccheck.js"></script>
<script>
var domid = frameElement.getAttribute("domid");
</script>
</head>
<body>
	<div class="commonWrap">
		<form id="addOrgUserForm">
			<ul class="commonUL">
				<li>
					<label class="text">账号名称：</label>
					<span class="cont">
						<input type="text" name="uid" class="mr20" id="userName" value="${requestScope.data.baseUser.userName }" disabled="disabled"/>
					</span>
				</li>
				<li>
					<label class="text">密码：</label>
					<span class="cont">
						<input type="text" id="password" needcheck allownull limit="6,18" limitmsg="很抱歉，密码长度需要是6到18个英文字符！" reg="^[0-9a-zA-Z|,|.|;|~|!|@|@|#|$|%|\^|&|*|(|)|_|+|-|=|\\|/|<|>]{6,18}$" errormsg="对不起，密码请输入英文字母、数字、符号（除特殊字符），或组合。"/>&nbsp;&nbsp;
						<a href="javascript:;" class="btn btnGreen" onclick="setRandomPassword();">随机密码</a>
					</span>
				</li>
				<li>
					<label class="text">备注：</label>
					<span class="cont">
						<input type="text" value="${requestScope.data.baseUser.remark }" name="uid" class="mr20" id="remark" needcheck allownull limit="0,40" limitmsg="很抱歉，备注最大长度为20个字!"/>
					</span>
				</li>
				<li>
					<label class="text">姓名：</label>
					<span class="cont">
						<input type="text" value="${requestScope.data.baseUser.realName }" class="mr20" id="realName" needcheck nullmsg="请输入姓名!" limit="1,20" limitmsg="很抱歉，姓名最大长度为10个字！"/>
					</span>
				</li>
				<li>
					<label class="text">职位：</label>
					<span class="cont">
						<input type="text"  value="${requestScope.data.baseUser.position }" name="position" class="mr20" id="position" needcheck nullmsg="请输入职位!" limit="1,20" limitmsg="很抱歉，职位最大长度为10个字"/>
					</span>
				</li>
				<li>
					<label class="text">联系电话：</label>
					<span class="cont">
						<input type="text" value="${requestScope.data.baseUser.contactPhone }" class="mr20" id="phoneNum" needcheck nullmsg="请输入联系电话!" reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" errormsg="联系电话格式不正确！"/>
					</span>
				</li>
				<li>
					<label class="text">状态：</label>
					<span class="cont">
						<input type="radio" <c:if test="${requestScope.data.baseUser.locked eq 'N' }">checked="checked"</c:if> name="locked" value="N">开启&nbsp;&nbsp;&nbsp;
						<input type="radio" <c:if test="${requestScope.data.baseUser.locked ne 'N' }">checked="checked"</c:if> name="locked" value="Y">关闭
					</span>
				</li>
				<li>
					<label class="text">行政区：</label>
					${requestScope.data.areaNames}
				</li>
				<c:if test="${requestScope.data.baseUser.adminFlag eq 'N' }">
					<li>
						<label class="text">功能：</label> 
						<span class="cont">
							<label><input type="checkbox" name="permGrant" <c:if test="${fn:contains(requestScope.data.baseUser.permGrant, ',1,')}"> checked="checked"</c:if> value="1"/>课程表</label>
							<label><input type="checkbox" name="permGrant" <c:if test="${fn:contains(requestScope.data.baseUser.permGrant, ',2,')}"> checked="checked"</c:if> value="2"/>直播课堂</label>
							<label><input type="checkbox" name="permGrant" <c:if test="${fn:contains(requestScope.data.baseUser.permGrant, ',3,')}"> checked="checked"</c:if> value="3"/>课堂巡视</label>
							<label><input type="checkbox" name="permGrant" <c:if test="${fn:contains(requestScope.data.baseUser.permGrant, ',4,')}"> checked="checked"</c:if> value="4"/>资源管理</label><br>
							<label><input type="checkbox" name="permGrant" <c:if test="${fn:contains(requestScope.data.baseUser.permGrant, ',5,')}"> checked="checked"</c:if> value="5"/>教研活动</label>
							<label><input type="checkbox" name="permGrant" <c:if test="${fn:contains(requestScope.data.baseUser.permGrant, ',6,')}"> checked="checked"</c:if> value="6"/>统计分析</label>
							<label><input type="checkbox" name="permGrant" <c:if test="${fn:contains(requestScope.data.baseUser.permGrant, ',7,')}"> checked="checked"</c:if> value="7"/>用户管理</label>
							<label><input type="checkbox" name="permGrant" <c:if test="${fn:contains(requestScope.data.baseUser.permGrant, ',8,')}"> checked="checked"</c:if> value="8"/>下级管理</label>
							<label><input type="checkbox" name="permGrant" <c:if test="${fn:contains(requestScope.data.baseUser.permGrant, ',9,')}"> checked="checked"</c:if> value="9"/>学校管理</label>
						</span>
					</li>
				</c:if>
				<li class="center">
					<input type="submit" class="submit btn mr10" value="确定" />
					<input type="button" class="btn btnGray" onclick="closeMe()" value="取消" />
				</li>
			</ul>
		</form>
	</div>
</body>
<script>
new BasicCheck({
	form: $id("addOrgUserForm"),
	ajaxReq : function(){
		var baseUserId = '${requestScope.data.baseUser.baseUserId}';
		var password = $.trim($("#password").val());
		var remark = $.trim($("#remark").val());
		var realName = $.trim($("#realName").val());
		var phoneNum = $.trim($("#phoneNum").val());
		var position = $.trim($("#position").val());
		var locked = $('input:radio[name="locked"]:checked').val();
		var pgs = $('input:checkbox[name="permGrant"]:checked');
		var permGrant = ",";
		for(var i = 0;i<pgs.length;i++) {
			var o = pgs.eq(i);
				permGrant += o.val()+",";
		}
		$.post("${root}/admin/orgUser/updateOrgUser.do",
				{'baseUserId':baseUserId,
				 'password':password,
				 'realName':realName,
				 'permGrant':permGrant,
				 'locked':locked,
				 'remark':remark,
				 'contactPhone':phoneNum,
				 'position':position
			},function(data){
			if(data){
				if(data.result){
					Win.alert("编辑成功！");
					parent.splitPage.reload();
					setTimeout("closeMe()",1000);
				}else{
					Win.alert(data.message);
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
function setRandomPassword(){
	var password = getRandomPassword();
	$("#password").val(password);
}

function closeMe() {
	parent.Win.wins[domid].close();
}
</script>
</html>