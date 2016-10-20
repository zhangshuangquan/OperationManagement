<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<link href="${root }/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root }/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root }/public/js/jsTree.js"></script>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">前台参数配置</a> &gt; <a href="javascript:;">知识点管理</a>
	</h3>
	<div id="control">
		<div id="controlContent">
			<div style="margin-bottom: 30px;">
				<button type="submit" class="unExpand btn" style="float: right;">全部收起</button>
			</div>
			<div class="thead clearfix">
				<div class="theadTd theadTd-title">名称</div>
				<div class="theadTd">操作</div>
			</div>
			<div id="baseKnowledgeWarp" class="jsTree-warper2c"></div>
		</div>
			<div class="addNewBox">
				<textarea class="newBoxBody">
					<form id="addNewKnowledgeBoxForm">
						<ul class="commonUL">
							<li>输入知识点名称：</li>
							<li><input id="knowledgeName" type="text" needcheck nullmsg="请输入知识点名称" maxlength="20" /></li>
							<li class="center"><button type="submit" class="btn" >确定</button></li>
						</ul>
					</form>
				</textarea>
			</div>
			<div class="editNewBox">
				<textarea class="newBoxBody">
					<form id="editNewKnowledgeBoxForm">
						<ul class="commonUL">
							<li>输入知识点名称：<input id="editKnowledgeName" type="text" needcheck nullmsg="请输入知识点名称" maxlength="20" /></li>
							<li class="center"><button type="submit" class="btn" >确定</button></li>
						</ul>
					</form>
				</textarea>
			</div>
	</div>
</body>
<script type="text/javascript">
$(".unExpand").click(function(){
	$('#baseKnowledgeWarp').jsTree('unExpand');
});
$(function(){
	$.post(ROOT + '/admin/knowledge/getAllSemester.do', function (data) {
		$('#baseKnowledgeWarp').jsTree({
			treeData: data,
			hasCheckBox: false,
			treeType: 2,
			delCheckLeaf: true,
			extraHtml: function (data) {
				if (data.__deep == 1) {
					return "";
				} else if(data.__deep == 2){
					return '<a href="javascript:;" class="add-link">添加子节点</a>';
				}else if(data.__deep >= 8){
					return '<a href="javascript:;" class="edit-link">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" class="del-link">删除</a>';
				}else{
					return '<a href="javascript:;" class="add-link">添加子节点</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" class="edit-link">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" class="del-link">删除</a>';
				}
			},
			dragCheck: function (data) {
				if (data.__deep <= 2)
					return false;
			},
			dragSelector: '.jsTree-node',
			idKey: 'baseSemesterId',
			nameKey: 'semesterName',
			onDragEnd: function ($dragElm, startIndex, endIndex) {
				var data = $('#baseKnowledgeWarp').jsTree('getData', $dragElm);
				var orders = [];
				$dragElm.parent().children().each(function (index) {
					orders.push({id: this.getAttribute('data-id'), sort: index+1});
				});
				if(data.__deep >= 3){
					$.ajax({//排序
						cache:false,
						url:'${root}/admin/knowledge/sort.do',
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
				if (__deep == 1) {
					$.post(ROOT + '/admin/knowledge/getDistinctSubjectBySemesterId.do', {baseSemesterId: __key}, function (data) {
						$('#baseKnowledgeWarp').jsTree("loadNode", data, $li, {idKey: 'baseSubjectId', nameKey: 'subjectName'});
						callback();
					}, 'json');
				} else if (__deep == 2) {
					$.post(ROOT + '/admin/knowledge/getFirstKnowledgeBySemeIdAndSubId.do', {baseSemesterId: data.baseSemesterId,baseSubjectId:__key}, function (data) {
						$('#baseKnowledgeWarp').jsTree("loadNode", data, $li, {idKey: 'baseKnowledgeId', nameKey: 'knowledgeName'});
						callback();
					}, 'json');
				} else if (__deep >= 3) {
					$.post(ROOT + '/admin/knowledge/getKnowledgeListByParentId.do', {parentId: __key}, function (data) {
						$('#baseKnowledgeWarp').jsTree("loadNode", data, $li, {idKey: 'baseKnowledgeId', nameKey: 'knowledgeName'});
						callback();
					}, 'json');
				} else {
					callback();
				}
			}
		});
	}, 'json');
	
	//保存知识点跟节点
	var saveRootKnowledge = function($li,baseSemesterId,baseSubjectId){
		var knowledgeName = $.trim($("#knowledgeName").val());
		$.ajax({
			cache : false,
			url : '${root}/admin/knowledge/addRootKnowledge.do',
			data : {
				"baseSemesterId":baseSemesterId,
				"baseSubjectId":baseSubjectId,
				"knowledgeName" : knowledgeName
			},
			dataType : 'json',
			success : function(data) {
				if (data.result) {
					$('#baseKnowledgeWarp').jsTree('addData', $li.attr('data-id'), {baseKnowledgeId:data.message, knowledgeName: htmlencode(knowledgeName)}, {idKey: 'baseKnowledgeId', nameKey: 'knowledgeName'});
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
	//保存知识点子节点
	var saveKnowledge = function($li,parentId){
		var knowledgeName = $.trim($("#knowledgeName").val());
		$.ajax({
			cache : false,
			url : '${root}/admin/knowledge/addKnowledge.do',
			data : {
				"parentId":parentId,
				"knowledgeName" : knowledgeName
			},
			dataType : 'json',
			success : function(data) {
				if (data.result) {
					$('#baseKnowledgeWarp').jsTree('addData', $li.attr('data-id'), {baseKnowledgeId:data.message, knowledgeName: htmlencode(knowledgeName)}, {idKey: 'baseKnowledgeId', nameKey: 'knowledgeName'});
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
	//添加事件绑定
	$('#baseKnowledgeWarp').on('click', '.add-link', function () {
		var $li = $(this).parents('.jsTree-node:eq(0)');
		var data = $('#baseKnowledgeWarp').jsTree('getData', $li);
		var html = $(".addNewBox").find(".newBoxBody").val();
		var baseSemesterId = data.baseSemesterId;
		var baseSubjectId = data.baseSubjectId;
		var deep = data.__deep;
		var parentId = data.__key;
		console.log(data);
		Win.open({
			mask:true,
			id:"addKnowledgeWin",
			title : "添加知识点",
			width:300,
			html : html
		});
		new BasicCheck({
			form : $id("addNewKnowledgeBoxForm"),
			ajaxReq :function(){
				if(deep == 2){
					saveRootKnowledge($li,baseSemesterId,baseSubjectId);
				}else{
					saveKnowledge($li,parentId);
				}
			}
		})
	});
	//编辑保存
	var editKnowledgeSave = function($li,baseKnowledgeId){
		var knowledgeName = $.trim($("#editKnowledgeName").val());
		
		$.ajax({
			cache : false,
			url : '${root}/admin/knowledge/editKnowledge.do',
			data : {
				"baseKnowledgeId":baseKnowledgeId,
				"knowledgeName" : knowledgeName
			},
			dataType : 'json',
			success : function(data) {
				if (data.result) {
					//Win.alert("成功！");
					knowledgeName=htmlencode(knowledgeName);
					$('#baseKnowledgeWarp').jsTree('updateData', $li.attr('data-id'), {knowledgeName: knowledgeName}, {idKey: 'baseKnowledgeId', nameKey: 'knowledgeName'});
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
	$('#baseKnowledgeWarp').on('click', '.edit-link', function () {
		var $li = $(this).parents('.jsTree-node:eq(0)');
		var data = $('#baseKnowledgeWarp').jsTree('getData', $li);
		console.log(data);
		var html = $(".editNewBox").find(".newBoxBody").val();
		Win.open({
			mask:true,
			id:"editKnowledgeWin",
			title : "编辑知识点",
			width:350,
			height:200,
			html : html
		});
		console.log(data);
		$('#editKnowledgeName').val(htmldecode(data.knowledgeName));
		new BasicCheck({
			form : $id("editNewKnowledgeBoxForm"),
			ajaxReq :function(){
				editKnowledgeSave($li,data.baseKnowledgeId);
			}
		})
	});
	//删除
	$('#baseKnowledgeWarp').on('click', '.del-link', function () {
		var $li = $(this).parents('.jsTree-node:eq(0)');
		var data = $('#baseKnowledgeWarp').jsTree('getData', $li);
		var baseKnowledgeId = data.baseKnowledgeId;
		Win.confirm({mask:true,html:"您确定要删除该条记录吗？"},function(){
			$.ajax({
				cache:false,
				url:'${root}/admin/knowledge/deleteKnowledge.do',
				data:{"baseKnowledgeId":baseKnowledgeId},
				dataType:'json',
				success:function(data){
					if(data.result){
						$('#baseKnowledgeWarp').jsTree('delData',baseKnowledgeId);
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