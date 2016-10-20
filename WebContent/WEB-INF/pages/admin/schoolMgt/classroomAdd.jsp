<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script src="${root }/public/js/basiccheck.js"></script>
<script>

var domid = frameElement.getAttribute("domid");

</script>
<style>
 
.commonUL li label.text{width:90px;}
</style>
<head>
<body>
	<div class="commonWrap">
		<form id="addClassroom" name="addClassroom">
			<input type="hidden" name=clsSchoolId id="clsSchoolId" value="${clsSchoolId}"/>
			<ul class="commonUL">
				<li>
				</li>
				<li>
					<label class="text">教室类型：</label>
					<span class="cont">
						<select class="mr20" name="classroomType" id="classroomType" onchange="changeClassroomType();">
							<option value="-1">请选择</option>
							<option value="MASTER">主讲教室</option>
							<option value="RECEIVE">接收教室</option>
						</select>
					</span>
				</li>
				
				<li id="remoteSwitchLiId" style="display:none;">
					<label class="text">远程导播：</label>
					<span class="cont">
						<input type="radio"  name="remoteSwitch" onclick="toggleDetail('Y')" value="Y">开启&nbsp;&nbsp;
						<input type="radio"  name="remoteSwitch" onclick="toggleDetail('N')" checked value="N">关闭
					</span>
				</li>
				<li class="remoteSwitch_detail" style="display:none;">
					<label class="text">硬件导播台：</label>
					<span class="cont">
						<input type="radio"  name="handDirectedSwitch" value="Y">开启&nbsp;&nbsp;
						<input type="radio"  name="handDirectedSwitch" checked value="N">关闭
					</span>
				</li>
				<li class="remoteSwitch_detail" style="display:none;">
					<label class="text">主控机Server：</label>
					<span class="cont">
						<input type="text" id="wenUploadUrl" name="wenUploadUrl" maxlength="60" value="">
					</span>
				</li>
				<li class="remoteSwitch_detail" style="display:none;">
					<label class="text">导播PMS：</label>
					<span class="cont">
						<input type="text" id="pmsRemoteUrl" name="pmsRemoteUrl" maxlength="60" value="">
					</span>
				</li>
				<li id="classroomModeLiId" style="display:none;">
					<label class="text">模式：</label>
					<span class="cont">
						<input type="radio"  name="classroomMode" checked value="1">标准版教室&nbsp;&nbsp;
						<input type="radio"  name="classroomMode" value="2">集成版教室
					</span>
				</li>
				
				<li>
					<label class="text">学生人数：</label>
					<span class="cont">
						<input type="text" id="studentNumId" name="studentNum" maxlength="3" value="">
					</span>
				</li>
				
				<li class="center">
					<input type="button" class="submit btn mr10" onclick="doSubmit();" value="确定" /> 
					<input type="button" class="btn btnGray" onclick="closeMe()" value="取消" />
				</li>
			</ul>
		</form>
		</div>
	<script>
		$(document).ready(function() {
			
		}) ;

		function doSubmit(){
			
			var classroomType = $("#classroomType").val();
			if(classroomType == '-1'){
				Win.alert("请选择教室类型！");
				return false;
			}
			
			var studentNum = $("#studentNumId").val();
			
			if(studentNum == '' || studentNum == '0') {
				Win.alert("学生人数不能为0");
				return false; 
			} else if(!isUnsignedInteger(studentNum)){
				Win.alert("学生人数必须为数字类型");
				return false; 
			} else if (studentNum > 500) {
				Win.alert("学生人数不能超过500");
				return false; 
			}
			
			$.post('${root}/admin/classroom/addClassroom.do', $("#addClassroom").serializeArray(), function(data){
				if(data){
					if(data.result){
						Win.alert("添加成功");
						parent.mySplit.reload();
						setTimeout("closeMe()",1000);
					}
				}else{
					Win.alert("编辑失败!");
				}
			});
		}


		function closeMe() {
			parent.Win.wins[domid].close();
		}

		function isUnsignedInteger(a)
		{
		    var   reg =/(^[1-9]\d*$)/;
		    return reg.test(a);
		}
		

		// === 重置密码
		function setRandomPassword(){
			var password = getRandomPassword();
			$("#password").val(password);
		}
		
		//改变教室类型
		function changeClassroomType() {
			var classroomType = $("#classroomType").val();
			if('MASTER' == classroomType) {
				$('#remoteSwitchLiId').show();
				$('#classroomModeLiId').show();
				var remoteSwitchChecked = $('input:radio[name="remoteSwitch"]:checked');
				
				if(remoteSwitchChecked.val() == 'Y') {
					$(".remoteSwitch_detail").show();
				}
				
			} else {
				$('#remoteSwitchLiId').hide();
				$('#classroomModeLiId').hide();
				$(".remoteSwitch_detail").hide();
			}
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
</body>

</html>