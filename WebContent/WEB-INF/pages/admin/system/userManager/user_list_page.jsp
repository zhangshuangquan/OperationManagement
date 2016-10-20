<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../common/meta.jsp"%>
<link href="${root }/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root }/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">系统设置</a> &gt; <a href="javascript:;">账号管理(后台)</a>
	</h3>
	<div id="control">
		<div id="controlContent">
			<ul class="searchWrap">
				<li>
					<label>角色：</label>
					<select id="role" class="mr20">
						<option value="">-- 请选择 --</option>
						<c:forEach items="${roles }" var="role">
							<option value="${role.adminRoleId }">${role.roleName }</option>
						</c:forEach>
					</select>
					<label class="labelText">账号名称：</label>
					<input type="text" id="userName" placeholder="请输入账号名称"  />
					<input type="button" class="submit btn mr10" id="query" value="搜索" />
				</li>
			</ul>
			 
			<div class="totalPageBox"><a href="javascript:;" class="btn btnGreen fr" id="addAdminUser">新增账号</a> 总共<span class="totalNum">0</span> 条数据</div>
			<table class="tableBox">
				<tr>
					<th width="5%">序号</th>
					<th width="25%">账号名称</th>
					<th width="25%">角色</th>
					<th width="20%">创建人</th>
					<th width="25%">操作</th>
				</tr>
				<tbody id="mals">
				</tbody>
			</table>
			<div id="pageNavi"></div>
		</div>
	</div>
</body>
<script type="text/javascript">
	<!-- ====================================  js调用区域  ===================================================== -->
	// 1、新增帐号
	$("#addAdminUser").unbind("click") ;
	$("#addAdminUser").bind("click", function() {
		Win.open({
			id	   : "adminUserId" ,
			title : "新增帐号" ,
			width : 500,
			height : 300,
			url : "addAdminUserPage.html", 
			afterClose:function() {
				mySplit.reload() ;
			}
		});
	}) ;
	
	// ===  分页数据列表
	//动态的创建一个table，同时将后台获取的数据动态的填充到相应的单元格  
	function createShowingTable(data,total, req) {
		$(".totalNum").html(total);
		//获取后台传过来的jsonData,并进行解析  
		//alert("-----   进入当前的数据展现:" + data.pageCount);
		var dataArray = data;
		//此处需要让其动态的生成一个table并填充数据  
		var tableStr = "";
		var len = dataArray.length;
		if (len > 0) {
			 for ( var i = 0; i < len; i++) {
				tableStr = tableStr + "<tr><td>" + (req.start + 1 + i) 
						+ "</td><td>" + dataArray[i].userName
						+ "</td><td>" + dataArray[i].roleName
						+ "</td><td>" + dataArray[i].createAdminUser
						+ "</td><td>" 
						+ showOperator(dataArray[i].adminUserId) ; 
						+ "</td></tr>";
			} 
		} else {
			tableStr += '<tr><td colspan="6">抱歉！没有搜索到您想要的信息！</td></tr>'; 
		}

		//将动态生成的table添加的事先隐藏的div中.
		$("#mals").html(tableStr||'<tr/>');
		window.scrollTo(0,0);
		
		$("#mals").find('.editLink').click(function() {
			var adminUserId = $(this).attr("value") ;
			Win.open({
				id	   : "editAdminUserId" ,
				title : "编辑帐号" ,
				width : 500,
				height : 300,
				url : "editAdminUserPage.html?adminUserId="+adminUserId , 
				afterClose:function() {
					mySplit.reload() ;
				}
			});
		}) ;

		$("#mals").find('.delLink').click(function(){
			var adminUserId = $(this).attr("value") ;
			Win.confirm({"id":"deleteConfirm","html":"确定要删除吗?"},function(){
					$.post("deleteAdminUser.html",{
						"adminUserId"	:	adminUserId
					}, function(data){
						if(data.flag) {
							spliPageReloadAfterDelete(mySplit) ;
							Win.alert("删除用户成功！") ;
						} else {
							Win.alert("删除用户失败！") ;
						}
					},"json") ;  
				}, function() {
					return false ;
				});
		}); 
	} ;
	
	var url = 'listAdminUser.do';
	var role = $("#role").val() ;
	var userName = $("#userName").val() ;
	var criteria = {
		"adminRoleId"	:	role, 
		"userName"		:	userName
	};
  var mySplit = new SplitPage({
        node : $id("pageNavi"),
        url : url,
        data : criteria,
        count : 20,
        callback : createShowingTable,
        type : 'post' //支持post,get,及jsonp
    });			 
	
	$("#query").click(function(){
		var role = $("#role").val() ;
		var userName = $("#userName").val() ;
		var criteria = {
			"adminRoleId"	:	role, 
			"userName"		:	userName
		};
		mySplit.search(url,criteria) ;
	}) ;
	
	function showOperator(id) {
		if(id != "admin") {
			return "<a href='javascript:;' value = '"+ id +"' class='editLink'>编辑</a>&nbsp;&nbsp;<a href='javascript:;' value = '"+ id +"' class='delLink'>删除</a>" ;
		} else {
			return "-" ;
		}
	}
</script>
</html>