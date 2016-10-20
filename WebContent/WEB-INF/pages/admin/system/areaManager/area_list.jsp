<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="../../../common/meta.jsp"%>
<link href="${root }/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root }/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root }/public/js/jsTree.js"></script>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">系统设置</a> &gt; <a href="javascript:;">行政区管理</a>
	</h3>
	<div id="control">
		<div id="controlContent">
			<div class="addNewBox">
				<a href="javascript:;" id="addAreaBtn"  class="btn addArea disable">添加行政区</a>
			</div>
			<div class="thead clearfix">
				<div class="theadTd theadTd-title" style="width: 40%;">行政区名称</div>
				<div class="theadTd" style="width: 10%;">行政区代码</div>
				<div class="theadTd" style="width: 10%;">插件更新</div>
				<div class="theadTd" style="width: 10%;">课表编辑</div>
				<div class="theadTd" style="width: 10%;">创建学校</div>
				<div class="theadTd" style="width: 20%;">操作</div>
			</div>
			<div id="baseDataWarp" class="jsTree-warper2c"></div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$.post(ROOT + '/admin/system/area/areaTree.do', function (data) {
		if(!data || data.length==0){
			$("#addAreaBtn").removeClass('disable')
		}
		$('#baseDataWarp').jsTree({
			treeData: data,
			hasCheckBox: false,
			treeType: 2,
			extraHtml: function (data){
				var html = '<div class="jsTree-operate1">'+data.areaCode+'</div>';
				html += '<div class="jsTree-operate1">'+getState(data.softwareUpgrade)+'</div>';
				html += '<div class="jsTree-operate1">'+getState(data.editSchedule)+'</div>';
				html += '<div class="jsTree-operate1">'+getState(data.createSchool)+'</div>';
				html += '<div class="jsTree-operate2">';
				html += '<a href="javascript:;" areas="true" class="add-link mr20 addArea">添加子行政区</a>';
				html += '<a href="javascript:;" class="edit-link mr20 editArea">编辑行政区</a>';
				html += '<a href="javascript:;" class="del-link mr20 deleteArea">删除</a>';
				html += '<a href="${root}/admin/system/area/areaMapPre.html?areaId=' + data.baseAreaId + '" target="_blank" class="edit-link">编辑地图</a></div>';
				return html;
			},
			dragSelector: '.jsTree-node,.jsTree-leaf',
			idKey: 'baseAreaId',
			nameKey: 'areaName',
			onDragEnd: function ($dragElm, startIndex, endIndex) {
				var orders = [];
				$dragElm.parent().children().each(function (index) {
					orders.push({baseAreaId: this.getAttribute('data-id'), sort: index+1});
				});
				$.post("${root}/admin/system/area/areaSort.do",{'json':JSON.stringify(orders)},function(resultData){
					if(!resultData || !resultData.result){
						Win.alert("排序失败！");
					}
				});
			},
			onExpand: function (data, $li, callback) {
				var __key = data.__key;
				$.post(ROOT + '/admin/system/area/areaTree.do', {parentId: __key}, function (data) {
					$('#baseDataWarp').jsTree("loadNode", data, $li);
					callback();
				}, 'json');
			}
		});
	}, 'json');
	
	$("#controlContent").on("click",".addArea",function(){
		if($(this).hasClass("disable")){
			return null;
		}
		var $li = $(this).parents("li");
		var parentId = $li[0]?$li.attr("data-id"):'';
		Win.open({
			id:"addArea",
			title : "添加行政区",
			width : 500,
			height : 525,
			url : "${root}/admin/system/area/areaCreatePre.html?parentId="+parentId
		});
	 });
	
	$("#controlContent").on("click",".editArea",function(){
		var $li = $(this).parents("li");
		var id = $li.attr("data-id");
		Win.open({
			id:"editArea",
			title : "修改行政区",
			width : 500,
			height : 525,
			url : "${root}/admin/system/area/areaEditPre.html?id="+id
		});
	 });
	
	$("#controlContent").on("click",".deleteArea",function(){
		var $li = $(this).parents("li");
		var id = $li.attr("data-id");
		Win.confirm({id:"deleteAreaCheck",html:"确定删除吗？"},function(){
			$.post("${root}/admin/system/area/areaDelete.do",{id:id},function(code){
				if(code && code.result){
					$('#baseDataWarp').jsTree('delData', id);
					if ($('.jsTree-node').length <= 1) {
						 $("#addAreaBtn").removeClass('disable');
					}
					Win.alert("删除成功！");
				}else{
					Win.alert(code?code.message:"删除失败！");
				}
			});
		},true);
	 });
	 
	 function getState(state){
		 return {'Y':'开启','N':'关闭'}[state] || '未知';
	 }
	 function addCallBack(parentId,data) {
		 $("#addAreaBtn").addClass('disable');
		 $('#baseDataWarp').jsTree('addData', parentId, data);
	 }
	 
	 function updateCallBack(data) {
		 $('#baseDataWarp').jsTree('updateData', data.baseAreaId, data);
	 }
</script>
</html>