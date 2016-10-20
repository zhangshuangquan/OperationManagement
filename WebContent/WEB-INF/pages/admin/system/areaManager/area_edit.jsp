<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="../../../common/meta.jsp"%>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
</head>
<body>
	<form id="addArea">
	<div class="commonWrap pd10">
		<ul class="commonUL">
			<input type="hidden" value="${area.baseAreaId }" name="baseAreaId"/>
			<input type="hidden" value="${user.baseUserId }" name="baseUserId"/>
			<li>
		        <label class="text">行政区名称：</label>
		        <span class="cont">
		        	 <input type="text" name="areaName" id="areaName" value="${area.areaName }" needcheck nullmsg="请输入行政区名称！" limit="1,20" limitmsg="很抱歉，行政区名称最大长度为10个字！"/>
		        </span>
	       	</li>
	       	<li>
		        <label class="text">行政区代码：</label>
		        <span class="cont">
		        	<input type="text" name="areaCode" id="areaCode" value="${area.areaCode }" needcheck nullmsg="请输入行政区代码！" reg="^[0-9a-zA-Z]{1,10}$" errormsg="很抱歉，行政区代码最大长度为10个英文字符！"/>
		        </span>
	       	</li>
	       	<li>
		        <label class="text">HTTP服务器：</label>
		        <span class="cont">
			        <select needcheck nullmsg="请选择HTTP服务器！" name="baseFileServerId">
			        	<c:forEach items="${httpServers}" var="httpServer">
			        		<option value="${httpServer.id }" <c:if test="${httpServer.id eq area.baseFileServerId}">selected="selected"</c:if>>${httpServer.serverName }</option>
			        	</c:forEach>
			        </select>
		         </span>
	       	</li>
	       	<li>
		        <label class="text">PMS服务器：</label>
		        <span class="cont">
			        <select needcheck nullmsg="请选择PMS服务器！" name="basePmsServerId">
			        	<c:forEach items="${pmsServers}" var="pmsServer">
			        		<option value="${pmsServer.id }" <c:if test="${pmsServer.id eq area.basePmsServerId}">selected="selected"</c:if> >${pmsServer.serverName }</option>
			        	</c:forEach>
			        </select>
		         </span>
	       	</li>
	       	<li>
		        <label class="text">插件更新：</label>
		        <span class="cont">
			        <input type="radio" value="Y" name="softwareUpgrade" <c:if test="${area.softwareUpgrade eq 'Y'}">checked="checked"</c:if> > 开启
			        <input type="radio" value="N" name="softwareUpgrade" <c:if test="${area.softwareUpgrade eq 'N'}">checked="checked"</c:if> > 关闭
		         </span>
	       	</li>
	       	<li>
		        <label class="text">课表编辑：</label>
		        <span class="cont">
			        <input type="radio" value="Y" name="editSchedule" <c:if test="${area.editSchedule eq 'Y'}">checked="checked"</c:if> > 开启
			        <input type="radio" value="N" name="editSchedule" <c:if test="${area.editSchedule eq 'N'}">checked="checked"</c:if> > 关闭
		         </span>
	       	</li>
	       	<li>
		        <label class="text">创建学校：</label>
		        <span class="cont">
			        <input type="radio" value="Y" name="createSchool" <c:if test="${area.createSchool eq 'Y'}">checked="checked"</c:if> > 开启
			        <input type="radio" value="N" name="createSchool" <c:if test="${area.createSchool eq 'N'}">checked="checked"</c:if>> 关闭
		         </span>
	       	</li>
	       	
	       	<li>
				<label class="text">账号名称：</label>
				<span class="cont">
					${user.userName }
				</span>
			</li>
			<li>
				<label class="text">密码：</label>
				<span class="cont">
					<input type="text" name="password" id="password" needcheck allownull limit="6,18" limitmsg="很抱歉，密码长度需要是6到18个字符" reg="^[0-9a-zA-Z|,|.|;|~|!|@|@|#|$|%|\^|&|*|(|)|_|+|-|=|\\|/|<|>]{6,18}$" errormsg="对不起，密码请输入英文字母、数字、符号（除特殊字符），或组合。"/>&nbsp;&nbsp;
					<a href="javascript:;" class="btn btnGreen" onclick="setRandomPassword();">随机密码</a>
				</span>
			</li>
			<li>
				<label class="text">备注：</label>
				<span class="cont">
					<input type="text" value="${user.remark }" name="remark" id="remark" needcheck allownull limit="0,40" limitmsg="很抱歉，备注最大长度为20个字"/>
				</span>
			</li>
			<li>
				<label class="text">姓名：</label>
				<span class="cont">
					<input type="text" value="${user.realName }" name="realName" id="realName" needcheck nullmsg="请输入姓名!" limit="1,20" limitmsg="很抱歉，姓名最大长度为10个字"/>
				</span>
			</li>
			<li>
				<label class="text">职位：</label>
				<span class="cont">
					<input type="text" value="${user.position }" name="position" id="position" needcheck nullmsg="请输入职位!" limit="1,20" limitmsg="很抱歉，职位最大长度为10个字"/>
				</span>
			</li>
			<li>
				<label class="text">联系电话：</label>
				<span class="cont">
					<input type="text" value="${user.contactPhone }" name="contactPhone" id="phoneNum" needcheck nullmsg="请输入联系电话!" reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" errormsg="联系电话格式不正确！"/>
				</span>
			</li>
	       	
	       	<li class="center">
	       		<input type="submit" class="submit btn mr10"  value="确定" />
	       		<input type="button" class="btn btnGray" onclick="closeMe()" value="取消" />
	       	</li>
		</ul>
	</div>
	</form>
	<script type="text/javascript">
		var domid = frameElement.getAttribute("domid");
		
		function closeMe(){
			parent.Win.wins[domid].close();
		}
	
		new BasicCheck({
			form: $id("addArea"),
			addition : function(){
				return true;
			},
			ajaxReq : function(){
				var data = $("#addArea").serializeArray();
				$.post("${root}/admin/system/area/areaEdit.do",data,function(code){
					if(code && code.result){
						parent.Win.alert("修改成功！");
						var softwareUpgrade = $("input[name='softwareUpgrade']:checked").val();
						var editSchedule = $("input[name='editSchedule']:checked").val();
						var createSchool = $("input[name='createSchool']:checked").val();
						parent.updateCallBack({'baseAreaId':'${area.baseAreaId }','areaName':htmlencode($("#areaName").val()),'areaCode':$("#areaCode").val(),'softwareUpgrade':softwareUpgrade,'editSchedule':editSchedule,'createSchool':createSchool});
						closeMe();
					}else{
						Win.alert(code?code.message:"修改失败！");
					}
				});
			}
		});
		
		function setRandomPassword(){
			var password = getRandomPassword();
			$("#password").val(password);
		}
	</script>
	</script>
</body>
</html>