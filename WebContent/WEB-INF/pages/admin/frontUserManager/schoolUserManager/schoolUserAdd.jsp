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
		<form id="addSchoolUserForm">
			<ul class="commonUL">
				<li>
					<label class="text">账号名称：</label>
					<span class="cont">
						<input type="text" name="uid" class="mr20" id="userName" needcheck nullmsg="请输入账号名称!" limit="6,18" limitmsg="很抱歉，账号名称长度需要是6到18个英文字符！" reg="^[0-9a-zA-Z|,|.|;|~|!|@|@|#|$|%|\^|&|*|(|)|_|+|-|=|\\|/|<|>]{6,18}$" errormsg="对不起，账号名称请输入英文字母、数字、符号（除特殊字符），或组合。"/>
					</span>
				</li>
				<li>
					<label class="text">密码：</label>
					<span class="cont">
						<input type="text" value="666666" id="password" needcheck nullmsg="请输入密码!" limit="6,18" limitmsg="很抱歉，密码长度需要是6到18个英文字符" reg="^[0-9a-zA-Z|,|.|;|~|!|@|@|#|$|%|\^|&|*|(|)|_|+|-|=|\\|/|<|>]{6,18}$" errormsg="对不起，密码请输入英文字母、数字、符号（除特殊字符），或组合。"/>&nbsp;&nbsp;
						<a href="javascript:;" class="btn btnGreen" onclick="setRandomPassword();">随机密码</a>
					</span>
				</li>
				<li>
					<label class="text">备注：</label>
					<span class="cont">
						<input type="text" name="uid" class="mr20" id="remark" needcheck allownull limit="0,40" limitmsg="很抱歉，备注最大长度为20个字!"/>
					</span>
				</li>
				<li>
					<label class="text">姓名：</label>
					<span class="cont">
						<input type="text" name="uid" class="mr20" id="realName" needcheck nullmsg="请输入姓名!" limit="1,20" limitmsg="很抱歉，姓名最大长度为10个字"/>
					</span>
				</li>
				<li>
					<label class="text">职位：</label>
					<span class="cont">
						<input type="text" name="position" class="mr20" id="position" needcheck nullmsg="请输入职位!" limit="1,20" limitmsg="很抱歉，职位最大长度为10个字！"/>
					</span>
				</li>
				<li>
					<label class="text">联系电话：</label>
					<span class="cont">
						<input type="text" name="uid" class="mr20" id="phoneNum" needcheck nullmsg="请输入联系电话!" reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" errormsg="联系电话格式不正确！"/>
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
					<span class="cont" id="chooseArea">
						<select class="mr20" id="province">
							<option value="-1">-- 请选择 --</option>
						</select>
					</span>
				</li>
				<li>
				<label class="text">学校：</label>
				<span class="cont">
					<select class="mr20" id="schoolSelect">
						<option value="-1">-- 请选择 --</option>
					</select>
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
		$.post("${root}/admin/orgUser/getAreaByparentId.do",{"parentId":"-1"},function(data){
			var html = '<option value="">-- 请选择 --</option>';
			for(var i = 0,j = data.length; i<j; i++){
				html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
			}
			$("#province").html(html);
		},'json');
		selectBind("chooseArea","${root}/admin/orgUser/getAreaByparentId.do","parentId");
		
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
			$.post("${root}/admin/teaUser/getSchoolByAreaId.do",{"areaId":baseAreaId},function(data){
				var html = '<option value="">-- 请选择 --</option>';
				for(var i = 0,j = data.length; i<j; i++){
					html += '<option value="'+data[i].clsSchoolId+'" baseSemesterIds="'+data[i].baeSemesterIds+'">'+data[i].schoolName+'</option>';
				}
				$("#schoolSelect").html(html);
			},'json');
		});
	});

	new BasicCheck({
		form: $id("addSchoolUserForm"),
		ajaxReq : function(){
			var userName = $.trim($("#userName").val());
			var password = $.trim($("#password").val());
			var remark = $.trim($("#remark").val());
			var realName = $.trim($("#realName").val());
			var phoneNum = $.trim($("#phoneNum").val());
			var position = $.trim($("#position").val());
			var locked = $('input:radio[name="locked"]:checked').val();
			var pgs = $('input:checkbox[name="permGrant"]:checked');
			var schoolId = $("#schoolSelect").val() ;
			var permGrant = ",";
			for(var i = 0;i<pgs.length;i++) {
				var o = pgs.eq(i);
				permGrant += o.val()+",";
			}
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
			
			if(schoolId == "-1") {
				Win.alert("请选择学校!") ;
				return ;
			}
			
			// === 新增学校
			$.post("${root}/admin/schoolUser/addSchoolBaseUser.do",
					{
					 'userName'			:	userName,
					 'baseAreaId'		:	baseAreaId,
					 'password'			:	password,
					 'realName'			:	realName,
					 'permGrant'			:	permGrant,
					 'locked'				:	locked,
					 'remark'				:	remark,
					 'schoolId'			:	schoolId ,
					 'contactPhone'		:	phoneNum ,
					 'position'			:	position
				},function(data){
				if(data){
					if(!data.result) {
						Win.alert("很抱歉，账号名称已存在，请重新输入！") ;
					} else {
						if(data.flag){
							Win.alert("添加成功！");
							parent.splitPage.reload();
							setTimeout("closeMe()",1000);
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
	
	// === 关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
	</script>
</html>