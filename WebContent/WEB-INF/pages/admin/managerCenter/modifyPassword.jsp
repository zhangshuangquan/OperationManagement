<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
<script src="${root }/public/js/basiccheck.js"></script>
<style>
	.formContainer{overflow: hidden;padding-top: 5px;font-size: medium;}
	.editpsw ul.formbody li span {color: #52732e;}
	.formbody{ background: none repeat scroll 0 0 #ffffff;clear: both;margin: 20px auto;overflow: hidden;width: 650px;z-index: 50;}
	ul.formbody li {line-height: 40px;}
	ul.formbody li span {display: block;float: left;font-weight: 600;margin-right: 15px;overflow: hidden;text-align: right;width: 180px;}
	.input {border: 1px solid #ccc;padding: 3px;width: 200px;}
</style>
</head>
<body>
<h3 id="cataMenu">
	<a href="javascript:;">管理中心</a> &gt; <a href="javascript:;">修改密码</a>
</h3>
<div id="control">
	<div id="controlContent">
		<div class="formContainer editpsw">
			<form id="editForm">
				<ul class="formbody">
					<li>
						<span>原密码:</span>
						<input class="input" type="password" autocomplete="off" name="oldPassword" nullmsg="请输入原密码！" limitmsg="原密码长度限制6-18个字节!" limit="6,18" needcheck/>
					</li>
					<li>
						<span>新密码:</span>
						<input class="input" type="password" autocomplete="off" name="newPassword" nullmsg="请输入新密码！" limitmsg="密码长度限制6-18个字节!" limit="6,18" needcheck/>
					</li>
					<li>
						<span>确认新密码:</span>
						<input class="input" type="password" autocomplete="off" name="newPassword2" watchmsg="两次输入的密码不一致！" watchnode="newPassword" nullmsg="请再次输入密码！" limitmsg="密码长度限制6-18个字节!" limit="6,18" needcheck/>
					</li>
					<li class="submitBox">
						<span>&nbsp;</span>
						<input type="submit" class="btn" id="subut" value="修改密码" />
					</li>
				</ul>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
new BasicCheck({
	form: $id("editForm"),
	ajaxReq : function(){
		//ajax提交
		$.ajax({
			type: 'POST',
			url: '${root}/admin/managercenter/modifypassword.do',
			data: $("#editForm").serialize(),
			success : function(data){
				if(data){
					if(data.result){
						Win.alert("修改成功！");
						setTimeout("window.location.reload()",3000);
					}else{
						Win.alert(data.message);
					}
				}else{
					Win.alert("修改失败！");
				}
			},
			error:function(){
				Win.alert("修改失败！");
			}
		});
	},
	warm: function warm(o, msg) {
		Win.alert(msg);
	}
});
</script>
</body>
</html>