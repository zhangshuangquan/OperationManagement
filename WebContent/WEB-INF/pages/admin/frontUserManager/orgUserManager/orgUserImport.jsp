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
		<form id="addOrgUserForm">
			<ul class="commonUL">
				<li>
					<label class="text"><a id="addOrgUserBatch" class="btn btnGreen" href="${root }/admin/orgUser/downoadOrgUserModel.do">模板下载</a></label>
				</li>
			</ul>
		</form>
	</div>
</body>
<script>
function closeMe() {
	parent.Win.wins[domid].close();
}
</script>
</html>