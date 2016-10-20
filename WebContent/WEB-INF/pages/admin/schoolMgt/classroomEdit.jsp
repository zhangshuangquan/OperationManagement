<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
<style>
.commonUL li label.text{width:90px;}
</style>
<script>
var domid = frameElement.getAttribute("domid");

$(document).ready(function() {
	<c:if test="${'MASTER' ne classroom.roomType}">
		$("#remoteSwitchLiId").hide();
	</c:if>
	<c:if test="${'MASTER' eq classroom.roomType }">
	$("#classroomModeLiId").show();
	<c:if test="${'Y' eq classroom.remoteSwitch}">
		$(".remoteSwitch_detail").show();
	</c:if>
</c:if>
	
}) ;

function doSubmit(){
	
	var roomName = $.trim($("#roomName").val());
	if(roomName == ''){
		Win.alert("请输入教室名称！");
		return false;
	}
	
	if(roomName.length > 20) {
		Win.alert("很抱歉，教室名称最大长度为20个字！") ;
		return false ;
	}
	
	var hasSameName = false;
	var roomId = $("#classroomId").val();
	$.ajax({
		 url: '${root}/admin/classroom/checkUnique.do',
		 type: 'GET',
		 async:false,
		 data: {roomName:roomName , roomId:roomId},
		 success: function(data) {
			 hasSameName = data.result;
		 },
		 error: function(data) {
             alert("error:"+data.responseText);
        }
	});
	
	if(hasSameName){
		Win.alert("很抱歉，同一学校教室名称不可重复！");
		return false;
	}
	
	var roomType = $("#roomTypeId").val();
	if(roomType == '-1'){
		Win.alert("请选择教室类型！");
		return false;
	}
	
	var studentNum = $("#studentNumId").val();
	
	if(studentNum == 0 ){
		Win.alert("学生人数不能为0！");
		return false; 
	}
	
	if(!isUnsignedInteger(studentNum)){
		Win.alert("学生人数必须为数字类型！");
		return false; 
	}
	
	
	if(studentNum > 500 ){
		Win.alert("学生人数不能超过500！");
		return false; 
	}
	
	var password = $("#password").val();
	if(password == ''){
		Win.alert("请输入教室密码！");
		return false;
	}
	
	if(password.length < 6 || password.length > 18){
		Win.alert("很抱歉，教室密码长度需要是6到18个英文字符！");
		return false;
	}
	
	
	$.post('${root}/admin/classroom/edit/confirm.do', $("#editClassroom").serializeArray(), function(data){
		if(data){
			if(data.result){
				closeMe() ;
			}
		}else{
			Win.alert("编辑失败!");
		}
	});
}


function closeMe() {
	parent.Win.wins[domid].close();
}

function   isUnsignedInteger(a)
{
    var   reg =/(^[1-9]\d*$)/;
    return reg.test(a);
}

//开启或关闭远程导播
function toggleDetail(open) {
	if('Y' == open) {
		$(".remoteSwitch_detail").show();
	} else {
		$(".remoteSwitch_detail").hide();
	}
}

</script>
</head>
<body>
	<div class="commonWrap">
		<form id="editClassroom" name="editClassroom">
			<input type="hidden" name="classroomId" id="classroomId" value="${classroom.clsClassroomId }"/>
			<ul class="commonUL">
				<li>
				</li>
				<li>
					<label class="text">教室名称：</label>
					<span class="cont">
						<input type="text" id="roomName" name="roomName"  value="${classroom.roomName }">&nbsp;&nbsp;
					</span>
				</li>
				<li>
					<label class="text">教室类型：</label>
					<span class="cont">
						<c:if test="${'MASTER' == classroom.roomType }">
									主讲教室
							</c:if>
							<c:if test="${'RECEIVE' == classroom.roomType }">
									接收教室
							</c:if>
						    <input type="hidden" value="${classroom.roomType }" name="roomType" id="roomTypeId" />
					</span>
				</li>
				<li>
					<label class="text">密码：</label>
					<span class="cont">
						<input id="password" name ="password" type="text" value="${classroom.password }"  class="mr20">
					</span>
				</li>
				<li>
					<label class="text">教室地址：</label>
					<span class="cont">
						${onlineClassUrl}/class/room/${classroom.skey}.html
					</span>
				</li>
				<li id="remoteSwitchLiId">
					<label class="text">远程导播：</label>
					<span class="cont">
						<input type="radio"  name="remoteSwitch" onclick="toggleDetail('Y')" value="Y"
							<c:if test="${'Y' == classroom.remoteSwitch }">
										checked
							</c:if>	
						>开启&nbsp;&nbsp;
						<input type="radio"  name="remoteSwitch" onclick="toggleDetail('N')" value="N"
							<c:if test="${'N' == classroom.remoteSwitch }">
										checked
							</c:if>	
						>关闭
					</span>
				</li>
				<li class="remoteSwitch_detail" style="display:none;">
					<label class="text">硬件导播台：</label>
					<span class="cont">
						<input type="radio"  name="handDirectedSwitch" value="Y"
						<c:if test="${'Y' == classroom.handDirectedSwitch }">
										checked
							</c:if>	
						>开启&nbsp;&nbsp;
						<input type="radio"  name="handDirectedSwitch" value="N"
						<c:if test="${'N' == classroom.handDirectedSwitch }">
										checked
						</c:if>	
						>关闭
					</span>
				</li>
				<li class="remoteSwitch_detail" style="display:none;">
					<label class="text">主控机Server：</label>
					<span class="cont">
						<input type="text" id="wenUploadUrl" name="wenUploadUrl" maxlength="60" value="${classroom.wenUploadUrl }">
					</span>
				</li>
				<li class="remoteSwitch_detail" style="display:none;">
					<label class="text">导播PMS：</label>
					<span class="cont">
						<input type="text" id="pmsRemoteUrl" name="pmsRemoteUrl" maxlength="60" value="${classroom.pmsRemoteUrl }">
					</span>
				</li>
				<li id="classroomModeLiId" style="display:none;">
					<label class="text">模式：</label>
					<span class="cont">
						<input type="radio"  name="classroomMode" value="1"
						<c:if test="${'1' == classroom.classroomMode }">
										checked
						</c:if>	
						>标准版教室&nbsp;&nbsp;
						<input type="radio"  name="classroomMode" value="2"
						<c:if test="${'2' == classroom.classroomMode }">
										checked
						</c:if>	
						>集成版教室
					</span>
				</li>
				
				<li>
					<label class="text">学生人数：</label>
					<span class="cont">
						<input type="text" id="studentNumId" name="studentNum" maxlength="3" value=${classroom.studentNum }>
					</span>
				</li>
				
				<li class="center">
					<input type="button" class="submit btn mr10" onclick="doSubmit();" value="确定" /> 
					<input type="button" class="btn btnGray" onclick="closeMe()" value="取消" />
				</li>
			</ul>
		</form>
		</div>
</body>

</html>