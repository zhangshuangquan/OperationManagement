<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../common/meta.jsp"%>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script src="${root }/public/js/basiccheck.js"></script>
<script>
var domid = frameElement.getAttribute("domid");
</script>
</head>
<body>
	<div class="commonWrap">
		<form id="editSchoolUserForm">
			<ul class="commonUL">
				<li>
					<label class="text">账号名称：</label>
					<span class="cont">
						<input type="text" name="uid" class="mr20" id="userName" value="${baseUser.userName }" disabled="disabled" needcheck nullmsg="请输入账号名称!" limit="6,18" limitmsg="很抱歉，账号名称长度需要是6到18个字符！" reg="^[0-9a-zA-Z|,|.|;|~|!|@|@|#|$|%|\^|&|*|(|)|_|+|-|=|\\|/|<|>]{6,18}$" errormsg="对不起，账号名称请输入英文字母、数字、符号（除特殊字符），或组合。"/>
					</span>
				</li>
				<li>
					<label class="text">密码：</label>
					<span class="cont">
						<input type="text" value="" id="password" limit="6,18" needcheck allownull limitmsg="很抱歉，密码长度需要是6到18个英文字符" reg="^[0-9a-zA-Z|,|.|;|~|!|@|@|#|$|%|\^|&|*|(|)|_|+|-|=|\\|/|<|>]{6,18}$" errormsg="对不起，密码请输入英文字母、数字、符号（除特殊字符），或组合。"/>&nbsp;&nbsp;
						<a href="javascript:;" class="btn btnGreen" onclick="setRandomPassword();">随机密码</a>
					</span>
				</li>
				<li>
					<label class="text">备注：</label>
					<span class="cont">
						<input type="text" name="uid" class="mr20" id="remark" value="${baseUser.remark}" needcheck allownull limit="0,40" limitmsg="很抱歉，备注最大长度为20个字!"/>
					</span>
				</li>
				<li>
					<label class="text">姓名：</label>
					<span class="cont">
						<input type="text" name="uid" class="mr20" id="realName" value="${baseUser.realName }" needcheck nullmsg="请输入姓名!" limit="1,20" limitmsg="很抱歉，姓名最大长度为10个字!"/>
					</span>
				</li>
				<li>
					<label class="text">职位：</label>
					<span class="cont">
						<input type="text" name="position" class="mr20" value="${baseUser.position }" id="position" needcheck nullmsg="请输入职位!" limit="1,20" limitmsg="很抱歉，职位最大长度为10个字！"/>
					</span>
				</li>
				<li>
					<label class="text">联系电话：</label>
					<span class="cont">
						<input type="text" name="uid" class="mr20" id="phoneNum"  value="${baseUser.contactPhone }" needcheck nullmsg="请输入联系电话!" reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" errormsg="联系电话格式不正确！"/>
					</span>
				</li>
				<li>
					<label class="text">状态：</label>
					<span class="cont">
						<input type="radio" checked="checked" name="locked" value="N">开启&nbsp;&nbsp;&nbsp;
						<input type="radio" name="locked" value="Y">关闭
					</span>
				</li>
				<li>
					<label class="text">行政区：</label>
						<span class="cont">
						<c:forEach items="${baseAreas }" var="area" varStatus="idx">
							<c:choose>
								<c:when test="${idx.index+1 == baseAreas.size() }">
									${area.areaName }
								</c:when>
								<c:otherwise>
									${area.areaName }--
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</span>
				</li>
				<li>
				<label class="text">学校：</label>
				<span class="cont">
					${clsSchool.schoolName }
				</span>
				</li>
				<li>
					<label class="text">功能：</label> 
					<span class="cont">
						<label><input type="checkbox" name="permGrant" value="1"/>课程表</label>
						<label><input type="checkbox" name="permGrant" value="2"/>直播课堂</label>
						<label><input type="checkbox" name="permGrant" value="3"/>课堂巡视</label>
						<label><input type="checkbox" name="permGrant" value="4"/>资源管理</label>
						<br />
						<label><input type="checkbox" name="permGrant" value="5"/>教研活动</label>
						<label><input type="checkbox" name="permGrant" value="6"/>统计分析</label>
						<label><input type="checkbox" name="permGrant" value="7"/>用户管理</label>
						<label><input type="checkbox" name="permGrant" value="10"/>教师管理</label>
						<label><input type="checkbox" name="permGrant" value="11"/>教室管理</label>
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
		var isLocked = '${baseUser.locked}' ;
		if(isLocked == 'Y') {
			$("input[name=locked][value=Y]").prop("checked", true) ;
		} else {
			$("input[name=locked][value=N]").prop("checked", true) ;
		}
		
		var permGrant = '${baseUser.permGrant}' ;
		for(var i = 0; i<permGrant.split(",").length; i++) {
			$("input[name=permGrant]").each(function(index){
				var per = $(this).val() ;
				if(per == permGrant.split(",")[i]) {
					$(this).prop("checked", true) ;
				}
			}) ;
		}
	});
	
	new BasicCheck({
		form: $id("editSchoolUserForm"),
		ajaxReq : function(){
			var baseUserId = '${baseUser.baseUserId}';
			var password = $.trim($("#password").val());
			var remark = $.trim($("#remark").val());
			var realName = $.trim($("#realName").val());
			var phoneNum = $.trim($("#phoneNum").val());
			var locked = $('input:radio[name="locked"]:checked').val();
			var pgs = $('input:checkbox[name="permGrant"]:checked');
			var position = $.trim($("#position").val());
			var permGrant = ",";
			for(var i = 0;i<pgs.length;i++) {
				var o = pgs.eq(i);
				permGrant += o.val()+",";
			}
			
			// === 编辑学校
			$.post("${root}/admin/schoolUser/editSchoolBaseUser.do",
					{
					 'baseUserId'		:	baseUserId,
					 'password'			:	password,
					 'realName'			:	realName,
					 'permGrant'			:	permGrant,
					 'locked'				:	locked,
					 'remark'				:	remark,
					 'contactPhone'		:	phoneNum ,
					 'position'			:	position
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
	
	// === 关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
	</script>
</html>