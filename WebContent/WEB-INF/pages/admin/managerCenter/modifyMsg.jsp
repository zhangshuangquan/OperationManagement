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
	<a href="javascript:;">管理中心</a> &gt; <a href="javascript:;">修改个人资料</a>
</h3>
<div id="control">
	<div id="controlContent">
		<div class="formContainer editpsw">
			<form id="editForm">
				<ul class="formbody">
					<li>
						<span>用户名:</span>
						<span style="text-align:left;">${adminUser.userName}</span>
						<br/>
					</li>
					<li>
						<span>姓名:</span>
						<input class="input" type="text" name="realName" value="${adminUser.realName}" nullmsg="请输入姓名！" needcheck limit="1,20" limitmsg="很抱歉，姓名长度为1到10个字"/>
					</li>
					<li>
						<span>联系电话:</span>
						<input class="input" type="text" name="contact" value="${adminUser.contact}" errormsg="请输入正确的电话号码！" reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" needcheck/>
					</li>
					
					<li>
						<span>职位:</span>
						<span style="text-align:left;">${adminUser.position}</span>
						<br/>
					</li>
					<li class="submitBox">
						<span>&nbsp;</span>
						<input type="submit" class="btn" id="subut" value="保存修改"/>
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
			url: '${root}/admin/managercenter/modifymsg.do',
			data: $("#editForm").serialize(),
			success : function(data){
				if(data){
					if(data.result){
						Win.alert("修改成功！");
						setTimeout("window.location.reload()",2000);
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