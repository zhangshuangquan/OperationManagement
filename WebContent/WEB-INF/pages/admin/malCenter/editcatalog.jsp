<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<link href="${root }/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root }/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root }/public/js/jsTree.js"></script>
</head>
<body>
	<div id="control">
		<div id="controlContent">
		<div class="addNewBox">
				<textarea class="newBoxBody">
					<form id="addNewKnowledgeBoxForm">
						<ul class="commonUL">
							<li>输入报修类别名称：</li>
							<li><input id="catalogName" type="text" needcheck nullmsg="请输入报修类别名称" maxlength="20" /></li>
							<li class="center"><button type="submit" class="btn"  style="margin-bottom: 50px">确定</button></li>
						</ul>
					</form>
				</textarea>
			</div>
			<div class="editNewBox">
				<textarea class="newBoxBody">
					<form id="editNewKnowledgeBoxForm">
						<ul class="commonUL">
							<li>输入报修类别名称：</li>
							<li><input id="editcatalogName" type="text" needcheck nullmsg="请输入报修类别名称" maxlength="20" /></li>
							<li class="center"><button type="submit" class="btn"  style="margin-bottom: 50px">确定</button></li>
						</ul>
					</form>
				</textarea>
			</div>
			<div class="addNewBox">
				<a href="javascript:;" class="btn" id="addNewBtn_Catalog" >添加一级故障类别</a>
			</div>
			<div class="thead clearfix">
				<div class="theadTd theadTd-title">名称</div>
				<div class="theadTd">操作</div>
			</div>
			<div id="malcatalogWarp" class="jsTree-warper2c"></div>
		</div>
	</div>
</body>
<script type="text/javascript">
$(function(){
	$.post(ROOT + '/admin/malCenter/getTopCatalog.do', function (data) {
		$('#malcatalogWarp').jsTree({
			treeData: data,
			hasCheckBox: false,
			treeType: 2,
			delCheckLeaf: true,
			extraHtml: function (data) {
				 if(data.__deep >= 3){
					return '<a href="javascript:;" class="edit-link">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" class="del-link">删除</a>';
				}else{
					return '<a href="javascript:;" class="add-link">添加子节点</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" class="edit-link">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" class="del-link">删除</a>';
				}
			},
			dragSelector: '.jsTree-node',
			idKey: 'malCatalogId',
			nameKey: 'catalogName',
			onDragEnd: function ($dragElm, startIndex, endIndex) {
				var data = $('#malcatalogWarp').jsTree('getData', $dragElm);
				var orders = [];
				$dragElm.parent().children().each(function (index) {
					orders.push({id: this.getAttribute('data-id'), sort: index+1});
				});
				if(data.__deep >= 0){
					$.ajax({//排序
						cache:false,
						url:'${root}/admin/malCenter/sort.do',
						data:{"data":JSON.stringify(orders),"baseSemesterId":data.baseSemesterId,"baseSubjectId":data.baseSubjectId,"parentId":data.parentId},
						dataType:'json',
						success:function(data){
							if(data.result){
								Win.alert("排序成功！");
							}else{
								Win.alert("排序失败！");
							}
						},
						error:function(){
							Win.alert("失败");
						}
					});
				}
			},
			onExpand: function (data, $li, callback) {
				var __key = data.__key;
				var __deep = data.__deep;
				console.log(__key);
				console.log(__deep);
				if(__key == null || __key ==''){
					__key=-1;
				}
					$.post(ROOT + '/admin/malCenter/getCatalogByPid.do', {pid: __key}, function (data) {
						$('#malcatalogWarp').jsTree("loadNode", data, $li, {idKey: 'malCatalogId', nameKey: 'catalogName'});
						callback();
					}, 'json');
				
			}
		});
	}, 'json');
	

	//保存报修类别子节点
	var saveKnowledge = function($li,parentId){
		var catalogName = $.trim($("#catalogName").val());
		$.ajax({
			cache : false,
			url : '${root}/admin/malCenter/addCatalog.do',
			data : {
				"parentId":parentId,
				"catalogName" : catalogName
			},
			dataType : 'json',
			success : function(data) {
				if (data.result) {
					$('#malcatalogWarp').jsTree('addData', $li.attr('data-id'), {malCatalogId:data.message, catalogName: catalogName}, {idKey: 'malCatalogId', nameKey: 'catalogName'});
					Win.wins.addKnowledgeWin.close();
				} else {
					Win.alert(data.message);
				}
			},
			error : function() {
				Win.alert("添加失败！");
			}
		});
	}
	
	//添加一级类别
	$('#addNewBtn_Catalog').on('click',  function () {
		console.log('添加一级类别');
		var $li = $(this).parents('.jsTree-node:eq(0)');
		var data = $('#malcatalogWarp').jsTree('getData', $li);
		var html = $(".addNewBox").find(".newBoxBody").val();
		var baseSemesterId = data.baseSemesterId;
		var baseSubjectId = data.baseSubjectId;
		var deep = data.__deep;
		var parentId = -1;
		Win.open({
			id:"addKnowledgeWin",
			title : "添加报修类别",
			width:350,
			height:200,
			html : html
		});
		new BasicCheck({
			form : $id("addNewKnowledgeBoxForm"),
			ajaxReq :function(){
					saveKnowledge($li,parentId);
			}
		})
	});
	
	//添加事件绑定
	$('#malcatalogWarp').on('click', '.add-link', function () {
		console.log('添加子类别');
		var $li = $(this).parents('.jsTree-node:eq(0)');
		var data = $('#malcatalogWarp').jsTree('getData', $li);
		var html = $(".addNewBox").find(".newBoxBody").val();
		var baseSemesterId = data.baseSemesterId;
		var baseSubjectId = data.baseSubjectId;
		var deep = data.__deep;
		var parentId = data.__key;
		Win.open({
			id:"addKnowledgeWin",
			title : "添加报修类别",
			width:350,
			height:200,
			html : html
		});
		new BasicCheck({
			form : $id("addNewKnowledgeBoxForm"),
			ajaxReq :function(){
					saveKnowledge($li,parentId);
			}
		})
	});
	//编辑保存
	var editKnowledgeSave = function($li,malCatalogId){
		var catalogName = $.trim($("#editcatalogName").val());
		$.ajax({
			cache : false,
			url : '${root}/admin/malCenter/updateCatalog.do',
			data : {
				"malCatalogId":malCatalogId,
				"catalogName" : catalogName
			},
			dataType : 'json',
			success : function(data) {
				if (data.result) {
					Win.alert("保存成功！");
					$('#malcatalogWarp').jsTree('updateData', $li.attr('data-id'), {catalogName: catalogName}, {idKey: 'malCatalogId', nameKey: 'catalogName'});
					Win.wins.editKnowledgeWin.close();
				} else {
					Win.alert(data.message);
				}
			},
			error : function() {
				Win.alert("保存失败！");
			}
		});
	}
	//编辑事件绑定
	$('#malcatalogWarp').on('click', '.edit-link', function () {
		var $li = $(this).parents('.jsTree-node:eq(0)');
		var data = $('#malcatalogWarp').jsTree('getData', $li);
		var html = $(".editNewBox").find(".newBoxBody").val();
		Win.open({
			id:"editKnowledgeWin",
			title : "编辑报修类别",
			width:350,
			height:200,
			html : html
		});
		console.log(data);
		$('#editcatalogName').val(htmldecode(data.catalogName));
		new BasicCheck({
			form : $id("editNewKnowledgeBoxForm"),
			ajaxReq :function(){
				editKnowledgeSave($li,data.malCatalogId);
			}
		})
	});
	//删除
	$('#malcatalogWarp').on('click', '.del-link', function () {
		var $li = $(this).parents('.jsTree-node:eq(0)');
		var data = $('#malcatalogWarp').jsTree('getData', $li);
		var malCatalogId = data.malCatalogId;
		Win.confirm("您确定要删除该条记录吗？",function(){
			$.ajax({
				cache:false,
				url:'${root}/admin/malCenter/delCatalog.do',
				data:{"malCatalogId":malCatalogId},
				dataType:'json',
				success:function(data){
					if(data.result){
						$('#malcatalogWarp').jsTree('delData',malCatalogId);
					}else{
						Win.alert(data.message);
					}
				},
				error:function(){
					Win.alert("删除失败！");
				}
			});
		},function(){});
	});
});

	
</script>
</html>