<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script src="${root }/public/js/basiccheck.js"></script>
<script>
var domid = frameElement.getAttribute("domid");
</script>
</head>
<body>
	<div class="commonWrap">
		<form id="addSchoolForm">
			<ul class="commonUL">
				<li>
					<label class="text"><b>学校信息：</b></label>
				</li>
				<li>
					<label class="text">学校名称：</label>
					<span class="cont">
						<input type="text" class="mr20" id="schoolName" needcheck nullmsg="请输入学校名称!" limit="1,40" limitmsg="很抱歉，学校名称最大长度为20个字！" />
					</span>
				</li>
				<li>
					<label class="text">所在地区：</label>
					<span class="cont" id="chooseArea">
						<select class="mr20" id="province">
							<option value="-1">-- 请选择 --</option>
						</select>
					</span>
				</li>
					<li>
					<label class="text">联系人：</label>
					<span class="cont">
						<input type="text" class="mr20" id="contact" needcheck nullmsg="请输入联系人!" limit="1,20" limitmsg="很抱歉，联系人最大长度为10个字！"/>
					</span>
				</li>
				<li>
					<label class="text">联系电话：</label>
					<span class="cont">
						<input type="text" class="mr20" id="phoneNum" needcheck nullmsg="请输入联系电话!" limit="1,20" limitmsg="很抱歉，联系电话超出最大长度20" reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" errormsg="联系电话格式不正确"/>
					</span>
				</li>
				<li>
					<label class="text">学段：</label>
					<span class="cont" id="semesterCheckbox">
					</span>
				
				</li>
				
				<li>
					<label class="text"><b>管理员信息：</b></label>
				</li>
				<li>
					<label class="text">用户名称：</label>
					<span class="cont">
						<input type="text" class="mr20" id="userName" needcheck nullmsg="请输入用户名称!" limit="6,18" limitmsg="很抱歉，用户名称长度需要是6到18个英文字符！" reg="^[0-9a-zA-Z|,|.|;|~|!|@|@|#|$|%|\^|&|*|(|)|_|+|-|=|\\|/|<|>]{6,18}$" errormsg="对不起，用户名称请输入英文字母、数字、符号（除特殊字符），或组合。"/>
					</span>
				</li>
				<li>
					<label class="text">姓名：</label>
					<span class="cont">
						<input type="text" class="mr20" id="realName" needcheck nullmsg="请输入姓名!" limit="1,20" limitmsg="很抱歉，姓名最大长度为10个字！"/>
					</span>
				</li>
				<li>
					<label class="text">电话：</label>
					<span class="cont">
						<input type="text" class="mr20" id="userPhoneNum" needcheck nullmsg="请输入电话!" limit="1,20" limitmsg="很抱歉，电话超出最大长度20" reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" errormsg="电话格式不正确"/>
					</span>
				</li>
				<li>
					<label class="text">备注：</label>
					<span class="cont">
						<input type="text" class="mr20" id="remark" needcheck allownull limit="0,40" limitmsg="很抱歉，备注最大长度为20个字！"/>
					</span>
				</li>
				<li>
					<label class="text">密码：</label>
					<span class="cont">
						<input type="text" value="666666" id="password" needcheck nullmsg="请输入密码!" limit="6,18" limitmsg="很抱歉，密码长度需要是6到18英文个字符！" reg="^[0-9a-zA-Z|,|.|;|~|!|@|@|#|$|%|\^|&|*|(|)|_|+|-|=|\\|/|<|>]{6,18}$" errormsg="对不起，密码请输入英文字母、数字、符号（除特殊字符），或组合。"/>&nbsp;&nbsp;
						<a href="javascript:;" class="btn btnGreen" onclick="setRandomPassword();">随机密码</a>
					</span>
				</li>
				<li>
					<label class="text">职位：</label>
					<span class="cont">
						<input type="text" class="mr20" id="location" needcheck nullmsg="请输入职位!" limit="1,20" limitmsg="很抱歉，职位最大长度为10个字！"/>
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
		//获取地区
		$.post("${root}/admin/orgUser/getAreaByparentId.do",{"parentId":"-1"},function(data){
			var html = '<option value="">-- 请选择 --</option>';
			for(var i = 0,j = data.length; i<j; i++){
				html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
			}
			$("#province").html(html);
		},'json');
		selectBind("chooseArea","${root}/admin/orgUser/getAreaByparentId.do","parentId");
		getAllSemester();
		
	});
	
	//调用验证框架，验证并提交
	new BasicCheck({
		form: $id("addSchoolForm"),
		ajaxReq : function(){
			var schoolName = $.trim($("#schoolName").val());
			var password = $.trim($("#password").val());
			var remark = $.trim($("#remark").val());
			var realName = $.trim($("#realName").val());
			var phoneNum = $.trim($("#phoneNum").val());
			var userName = $.trim($("#userName").val());
			var location = $.trim($("#location").val());
			var contact = $.trim($("#contact").val());
			var userPhoneNum = $.trim($("#userPhoneNum").val());
			var semesterChecked = $('input:checkbox[name="semesters"]:checked');
			var semesters = "";
			for(var i = 0;i<semesterChecked.length;i++) {
				if(i != 0) {
					semesters += ",";
				}
				var o = semesterChecked.eq(i);
				semesters += o.val();
			}
			
			if(semesters == "") {
				Win.alert("请选择学段");
				return;
			}
			
			var baseAreaId = getBaseAreaId('chooseArea');
			
			if(baseAreaId == "-1"){
				Win.alert("请选择行政区！");
				return;
			}
			
			// === 新增学校
			$.post("${root}/admin/schoolmgt/addSchool.do",
					{
					 'schoolName'		:	schoolName,
					 'password'			:	password,
					 'remark'			:	remark,
					 'realName'			:	realName,
					 'phoneNum'			:	phoneNum,
					 'userName'			:	userName,
					 'location'			:	location ,
					 'semesters'		:	semesters,
					 'userPhoneNum'		:	userPhoneNum,
					 'contact'		:	contact,
					 'baseAreaId'		:	baseAreaId
				},function(result){
					if(result.result) {
						Win.alert("添加成功！");
						parent.mySplit.reload();
						setTimeout("closeMe()",1000);
					} else {
						Win.alert(result.message);
					}
			},'json');
		},
		warm: function warm(o, msg) {
			Win.alert(msg);
		}
	});
	
	//获取所有学段
	function getAllSemester() {
		$.get("${root}/admin/schoolmgt/getAllSemester.do", function(result){
			var html = '';
			$.each(result, function(index, json){
				html += '<label style="margin-right:5px;"><input type="checkbox" name="semesters" value="'+json.baseSemesterId+'"/>'+json.semesterName+'</label>';
			});
			$("#semesterCheckbox").html(html);
		}, "json");
	}

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