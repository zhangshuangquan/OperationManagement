<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../common/meta.jsp"%>
<link href="${root }/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
<script src="${root }/public/js/basiccheck.js"></script>
<script>
var domid = frameElement.getAttribute("domid");
</script>
</head>
<body>
	<div class="commonWrap">
		<form id="addTeaUserForm">
		<ul class="commonUL">
			<li>
				<label class="text">账号名称：</label>
				<span class="cont">
					<input type="text" name="userName" class="mr20" id="userName" needcheck nullmsg="请输入账号名称!" limit="6,36" limitmsg="很抱歉，账号名称长度需要是6到18个英文字符！" reg="^[0-9a-zA-Z|,|.|;|~|!|@|@|#|$|%|\^|&|*|(|)|_|+|-|=|\\|/|<|>]{6,18}$" errormsg="对不起，账号名称请输入英文字母、数字、符号（除特殊字符），或组合。"/>
				</span>
			</li>
			<li>
				<label class="text">密码：</label>
				<span class="cont">
					<input type="text" name="password" value="666666" id="password" needcheck nullmsg="请输入密码!" limit="6,18" limitmsg="很抱歉，密码长度需要是6到18个英文字符" reg="^[0-9a-zA-Z|,|.|;|~|!|@|@|#|$|%|\^|&|*|(|)|_|+|-|=|\\|/|<|>]{6,18}$" errormsg="对不起，密码请输入英文字母、数字、符号（除特殊字符），或组合。"/>&nbsp;&nbsp;
					<a href="javascript:;" class="btn btnGreen" onclick="setRandomPassword();">随机密码</a>
				</span>
			</li>
			<li>
				<label class="text">备注：</label>
				<span class="cont">
					<input type="text" name="remark" class="mr20" id="remark" needcheck allownull limit="0,40" limitmsg="很抱歉，备注最大长度为20个字!"/>
				</span>
			</li>
			<li>
				<label class="text">姓名：</label>
				<span class="cont">
					<input type="text" name="realName" class="mr20" id="realName" needcheck nullmsg="请输入姓名!" limit="1,20" limitmsg="很抱歉，姓名长度为1到10个字"/>
				</span>
			</li>
			<li>
				<label class="text">职位：</label>
				<span class="cont">
					<input type="text" name="position" class="mr20" id="position" needcheck nullmsg="请输入职位!" limit="1,20" limitmsg="很抱歉，职位长度需要为1到10个字"/>
				</span>
			</li>
			<li>
				<label class="text">联系电话：</label>
				<span class="cont">
					<input type="text" name="contactPhone" class="mr20" id="phoneNum" needcheck nullmsg="请输入联系电话!" reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" errormsg="联系电话格式不正确！"/>
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
				<label class="text">功能：</label>
				<span class="cont">
					<label><input type="checkbox" id="createEvaFlag"/>发起评课议课</label>
				</span>
			</li>
			<li>
				<label class="text">行政区：</label>
				<span class="cont" id="areaSelect">
					<select class="mr20" id="province">
						<option value="-1">请选择</option>
					</select>
				</span>
			</li>
			<li>
				<label class="text">学校：</label>
				<span class="cont">
					<select class="mr20" id="schoolSelect">
						<option value="-1">请选择</option>
					</select>
				</span>
			</li>
			<li>
				<label class="text">任课信息：</label>
				<span class="cont">
					<select class="mr20" id="classLevel">
						<option value="-1">请选择</option>
					</select>
					<select class="mr20" id="subject">
						<option value="-1">请选择</option>
					</select>
					<a href="javascript:;" class="btn btnGreen" onclick="addInfo()">添加</a>
				</span>
			</li>
			<li>
	       		<label class="text">&nbsp;</label>
	       		<span class="cont" id="information">
	       		
	       		</span>
	       	 </li>
			<li class="center">
				<input type="submit" class="submit btn mr10" value="确定" />
				<input type="button" class="btn btnGray" onclick="closeMe()" value="取消" />
			</li>
		</ul>
		</form>
	</div>
</body>
<script>
$(document).ready(function(){
	$.post("${root}/admin/orgUser/getAreaByparentId.do",{"parentId":"-1"},function(data){
		var html = '<option value="-1">请选择</option>';
		for(var i = 0,j = data.length; i<j; i++){
			html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
		}
		$("#province").html(html);
	},'json');
	
	selectBind("areaSelect","${root}/admin/orgUser/getAreaByparentId.do","parentId");

	$('#areaSelect').on("change","select",function(){
		var areas = $("#areaSelect select");
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
			var html = '<option value="-1">请选择</option>';
			for(var i = 0,j = data.length; i<j; i++){
				html += '<option value="'+data[i].clsSchoolId+'" baseSemesterIds="'+data[i].baseSemesterIds+'">'+data[i].schoolName+'</option>';
			}
			$("#schoolSelect").html(html);
			$("#classLevel").html('<option value="-1">请选择</option>');
			$("#subject").html('<option value="-1">请选择</option>');
		},'json');
		
	});
	
	$('#schoolSelect').change(function(){
		
		var parentId = $(this).val();
		var baseSemesterIds= $(this).find("option:selected").attr('baseSemesterIds');
		
		$.post("${root}/admin/teaUser/getClasslevelBySemesterIds.do",{"baseSemesterIds":baseSemesterIds},function(data){
			var html = '<option value="-1">请选择</option>';
			for(var i = 0,j = data.length; i<j; i++){
				html += '<option value="'+data[i].baseClasslevelId+'">'+data[i].classlevelName+'</option>';
			}
			$("#classLevel").html(html);
			$("#subject").html('<option value="-1">请选择</option>');
		},'json');
	});
	
	$('#classLevel').change(function(){
		var parentId = $(this).val();
		
		$.post("${root}/admin/teaUser/getSubjectByClasslevelId.do",{"classlevelId":parentId},function(data){
			var html = '<option value="-1">请选择</option>';
			for(var i = 0,j = data.length; i<j; i++){
				html += '<option value="'+data[i].baseSubjectId+'">'+data[i].subjectName+'</option>';
			}
			$("#subject").html(html);
		},'json');
		
		});
		
});

	var list = {};
	new BasicCheck({
		form: $id("addTeaUserForm"),
		addtion : function(){
			
		},
		ajaxReq : function(){
			var userName = $.trim($("#userName").val());
			var password = $.trim($("#password").val());
			var remark = $.trim($("#remark").val());
			var realName = $.trim($("#realName").val());
			var position = $.trim($("#position").val());
			var phoneNum = $.trim($("#phoneNum").val());
			var locked = $('input:radio[name="locked"]:checked').val();
			
			var createEvaFlag = "N";
			if($("#createEvaFlag").prop("checked")==true){
				createEvaFlag = "Y";
			}
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
			var schoolId = $("#schoolSelect").val();
			
			var classlevelId = $("#classLevelId").val();
			var subject = $("#subject").val();
			
			if(baseAreaId == "-1"){
				Win.alert("请选择行政区");
				return false;
			}
			
			if(schoolId == "-1"){
				Win.alert("请选学校");
				return;
			}
			
			addValue();
			var infromations = getInformation();
			if(infromations == ""){
				Win.alert("请添加至少一条任课信息");
				return;
			}
			
			$.post("${root}/admin/teaUser/addTeaUser.do",
					{'userName':userName,
					 'password':password,
					 'remark':remark,
					 'realName':realName,
					 'position':position,
					 'contactPhone':phoneNum,
					 'locked':locked,
					 'createEvaFlag':createEvaFlag,
					 'baseAreaId':baseAreaId,
					 'schoolId':schoolId,
					 'infos':infromations
				},function(data){
				if(data){
					if(data.result){
						Win.alert("添加成功！");
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

	
	function addInfo(){
		var classLevel = $("#classLevel").val();
		var subject = $("#subject").val();
		var textName = $("#classLevel").find("option:selected").text() + "("+$("#subject").find("option:selected").text() + ")";
		if(classLevel == '-1'){
			Win.alert("请选择年级！");
			return false;
		}
		if(subject == '-1'){
			Win.alert("请选择学科！");
			return false;
		}
		var information = classLevel + "@" + subject;
		/*
		 if(information in list){
			Win.alert("不能重复添加!");
			return false;
		}else{
			list[information] = information;
		} */
		if($tag("button[value="+information+"]").length > 0) return;
		var html = '<label class="itemDel"><button type="button" name="na1ss" value="'+information+'">'+textName+'</button></label>';
		$("#information").append(html);
		
	}
	
	function addValue(){
		list = {};
		$("#information button").each(function(index, element){
			var temp = $(this).val();
			list[temp] = temp;
		});
		
	}
	
	/* 格式化任课信息参数 */
	function getInformation(){
		var info = "";
		for(var p in list){
			if(info==""){
				info = p.toString();
			}else{
				info =info + "," + p.toString();
			}
		}
		
		return info;
	}

	function closeMe() {
		parent.Win.wins[domid].close();
	}
	
	function setRandomPassword(){
		var password = getRandomPassword();
		$("#password").val(password);
	}
</script>
</html>