<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<link href="${root }/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root }/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root }/public/js/jsTree.js"></script>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">前台参数配置</a> &gt; <a href="javascript:;">教材版本管理</a>
	</h3>
	<div id="control">
		<div id="controlContent">
			<div class="addNewBox">
				<textarea class="newBoxBody">
					<form id="addNewVersionBoxForm">
						<ul class="commonUL">
							<li>输入版本名称：<input id="versionName" type="text" needcheck nullmsg="请输入版本名称" maxlength="20" /></li>
							<li class="center"><button type="submit" class="btn" >确定</button></li>
						</ul>
					</form>
				</textarea>
				<a href="javascript:;" class="btn" id="addNewVersionBtn">添加版本</a>
			</div>
			<div class="editNewBox">
				<textarea class="newBoxBody">
					<form id="editNewVersionBoxForm">
						<ul class="commonUL">
							<li>输入版本名称：</li>
							<li><input id="editVersionName" type="text" needcheck nullmsg="请输入版本名称" maxlength="20" /></li>
							<li class="center"><button type="submit" class="btn"  style="margin-bottom: 50px">确定</button></li>
						</ul>
					</form>
				</textarea>
			</div>
			<div class="thead clearfix">
				<div class="theadTd theadTd-title">名称</div>
				<div class="theadTd">操作</div>
			</div>
			<div id="versionWarp" class="jsTree-warper2c"></div>
		</div>
	</div>
	<script type="text/javascript">
	var saveVersion = function() {
		var versionName = $.trim($("#versionName").val());
		$.ajax({
			cache : false,
			url : '${root}/admin/version/addVersion.do',
			data : {
				"versionName" : versionName
			},
			dataType : 'json',
			success : function(data) {
				if (data.result) {
					Win.wins.addVersionWin.close();
					$('#versionWarp').jsTree('addData', 'jsTree', {id:data.message, name: htmlencode(versionName)});
				} else {
					Win.alert(data.message);
				}
			},
			error : function() {
				Win.alert("添加失败！");
			}
		});
	};
	 $("#addNewVersionBtn").click(function(){
			var html = $(this).parents(".addNewBox").find(".newBoxBody").val();
			Win.open({
				mask:true,
				id:"addVersionWin",
				title : "添加版本",
				width:300,
				html : html
			});
			new BasicCheck({
				form : $id("addNewVersionBoxForm"),
				ajaxReq :function(){
					saveVersion();
				}
				/* warm : function(o,msg){ 
					Win.alert(msg);
				} */
			})
		});
	$.post(ROOT + '/admin/version/list.do', function (data) {
		$('#versionWarp').jsTree({
			treeData: data,
			hasCheckBox: false,
			treeType: 2,
			extraHtml: '<a href="javascript:;" class="edit-link">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" class="del-link">删除</a>',
			dragSelector: '.jsTree-node,.jsTree-leaf',
			onDragEnd: function ($dragElm, startIndex, endIndex) {
				//console.log($dragElm, startIndex, endIndex);
				var orders = [];
				$dragElm.parent().children().each(function (index) {
					orders.push({id: this.getAttribute('data-id'), sort: index+1});
				});
				//console.log(orders);
				//console.log(JSON.stringify(orders));
				$.ajax({//排序
					cache:false,
					url:'${root}/admin/version/sort.do',
					data:{"data":JSON.stringify(orders)},
					dataType:'json',
					success:function(data){
						if(data.result){
							Win.alert("排序成功！");
						}else{
							Win.alert("排序失败！");
						}
					},
					error:function(){
						alert("失败");
					}
				});
			}
		});
	}, 'json');

	var editVersionSave = function(data,$li,id) {
		var versionName = $.trim($("#editVersionName").val());
		var oldName = data.name;
		if(htmldecode(oldName)==versionName){//没有变更
			Win.wins.editVersionWin.close();
			return;
		}
		$.ajax({
			cache : false,
			url : '${root}/admin/version/updateName.do',
			data : {
				"versionName" : versionName,
				"baseVersionId":id
			},
			dataType : 'json',
			success : function(data) {
				if (data.result) {
					Win.alert(data.message);
					Win.wins.editVersionWin.close();
					versionName = htmlencode(versionName);
					$('#versionWarp').jsTree('updateData', $li.attr('data-id'), {name: versionName});
				} else {
					Win.alert(data.message);
				}
			},
			error : function() {
				Win.alert("保存失败！");
			}
		});
	};
	$('#versionWarp').on('click', '.edit-link', function () {
		var $li = $(this).parents(".jsTree-node:eq(0)");
		var data = $('#versionWarp').jsTree('getData', $li);
		var id = $li.attr('data-id');
		//var name = $li.find(".jsTree-content-text:eq(0)").text();
		var name = data.name;
		var html = $(".editNewBox").find(".newBoxBody").val();
		Win.open({
			mask:true,
			id:"editVersionWin",
			title : "编辑版本",
			width:350,
			height:200,
			html : html
		});
		$("#editVersionName").val(htmldecode(name));
		new BasicCheck({
			form : $id("editNewVersionBoxForm"),
			ajaxReq : function(){
				editVersionSave(data,$li,id);
			}
			
		})
	});
	$('#versionWarp').on('click', '.del-link', function () {
		var that = $(this).parents(".jsTree-node:eq(0)");
		var id = that.attr('data-id');
		
		Win.confirm({mask:true,html:"您确定要删除该条记录吗？"},function(){
			$.ajax({
				cache:false,
				url:'${root}/admin/version/deleteVersion.do',
				data:{"baseVersionId":id},
				dataType:'json',
				success:function(data){
					if(data.result){
						that.remove();
					}else{
						Win.alert("版本被引用，无法删除！");
					}
				},
				error:function(){
					Win.alert("删除失败！");
				}
			});
		},function(){});
	});

</script>
</body>
</html>