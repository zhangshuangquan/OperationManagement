<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../common/meta.jsp"%>
<link href="${root }/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root }/public/calendar/WdatePicker.js"></script>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">系统设置</a> &gt; <a href="javascript:;">角色管理(后台)</a>
	</h3>
	<div id="control">
		<div id="controlContent">
			<div class="totalPageBox"><a href="javascript:;" class="btn btnGreen fr" id="addAdminUser">新增角色</a> 总共<span class="totalNum">0</span> 条数据</div>
			<table class="tableBox">
				<tr>
					<th width="5%">序号</th>
					<th width="10%">角色</th>
					<!-- <th width="8%">账号名称</th> -->
					<th width="12%">操作</th>
					<th width="8%">账号数</th>
				</tr>
				<tbody id="mals">
				</tbody>
			</table>
			<div id="pageNavi" 	></div>
		</div>
	</div>
</body>
<script type="text/javascript">
	<!-- ====================================  js调用区域  ===================================================== -->
	var mySplit ;
	// 1、新增角色
	$("#addAdminUser").unbind("click") ;
	$("#addAdminUser").bind("click", function() {
			Win.open({
				id	   : "adminRoleId" ,
				title : "新增帐号" ,
				width : 500,
				height : 300,
				url : "addAdminRolePage.html", 
				afterClose:function() {
					mySplit.reload() ;
				}
			});
	});
 
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
					tableStr = tableStr + "<tr><td>" + (req.start + (i+1)) 
						+ "</td><td>" + dataArray[i].adminRoleName
						/* + "</td><td>" + dataArray[i].adminUserName */
						+ "</td><td>" 
						+ showOperator(dataArray[i].adminRoleId)
						+ "</td><td><a href='javascript:;' value = '"+ dataArray[i].adminRoleId +"' class='adminUserLink'>"+dataArray[i].adminUserNum+"</a>" 
						+ "</td></tr>";
				} 
		} else {
			tableStr += '<tr><td colspan="6">抱歉！没有搜索到您想要的信息！</td></tr>';
		}

		//将动态生成的table添加的事先隐藏的div中.
		$("#mals").html(tableStr||'<tr/>');
		window.scrollTo(0,0);
		
		$("#mals").find('.editLink').click(function() {
			var adminRoleId = $(this).attr("value") ;
			Win.open({
				id	   : "editAdminRoleId" ,
				title : "编辑角色" ,
				width : 500,
				height : 300,
				url : "editAdminRolePage.html?adminRoleId="+adminRoleId , 
				afterClose:function() {
					mySplit.reload() ;
				}
			});
		}) ;
		

		$("#mals").find('.delLink').click(function(){
			var adminRoleId = $(this).attr("value") ;
			Win.confirm({"id":"deleteConfirm","html":"确定要删除吗?"},function(){
					$.post("deleteAdminRole.html",{
						"adminRoleId"	:	adminRoleId
					}, function(data){
							mySplit.reload() ;
							Win.alert(data.flag) ;
					},"json") ;  
				}, function() {
					return false ;
				});
		});  
		
		// === 弹出帐号列表框
		$("#mals").find('.adminUserLink').click(function(){
			var adminRoleId = $(this).attr("value") ;
			Win.open({
				id	   : "adminUserRoleId" ,
				title : "帐号列表" ,
				width : 800,
				height : 500,
				url : "showAdminUserRolePage.html?adminRoleId="+adminRoleId , 
				afterClose:function() {
					mySplit.reload() ;
				}
			});
		});  
	
	} ;
   var url = 'listAdminRole.do';
   mySplit = new SplitPage({
        node : $id("pageNavi"),
        url : url,
        count : 20,
        callback : createShowingTable,
        type : 'post' //支持post,get,及jsonp
    });		
   
   function showOperator(id) {
		if(id != "adminRole") {
			return "<a href='javascript:;' value = '"+ id +"' class='editLink'>编辑</a>&nbsp;&nbsp;<a href='javascript:;' value = '"+ id +"' class='delLink'>删除</a>" ;
		} else {
			return "-" ;
		}
	}
</script>
</html>