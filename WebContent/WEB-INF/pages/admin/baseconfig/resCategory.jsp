<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/jsTree.js"></script>
</head>
<body>
<h3 id="cataMenu">
	<a href="javascript:;">前台参数配置</a> &gt; <a href="javascript:;">资源分类</a>
</h3>
<div class="categoryBox">
	<textarea class="newBoxBody">
		<form id="categoryEditor">
			<ul class="commonUL">
				<li>分类名称：<input id="categoryName" type="text" needcheck nullmsg="请输入分类名称" maxlength="20" /></li>
				<li class="center"><button type="submit" class="btn" >确定</button></li>
			</ul>
		</form>
	</textarea>
</div>
<div id="control">
		<div id="controlContent">
			<div class="clearfix">
				<button type="submit" class="unExpand btn"  style="margin-bottom: 5px; float: right;">全部收起</button>
			</div>
			<div class="thead clearfix">
				<div class="theadTd theadTd-title">名称</div>
				<div class="theadTd">操作</div>
			</div>
			<div id="baseDataWarp" class="jsTree-warper2c"></div>
		</div>
	</div>
</body>
<script type="text/javascript">
  $(".unExpand").click(function(){
	  $('#baseDataWarp').jsTree('unExpand');
  });


	$.post('${root}/admin/baseConfig/resCategory/getResCategoryTreeData.do', function (data) {
		$('#baseDataWarp').jsTree({
			treeData: data,
			hasCheckBox: false,
			treeType: 2,
			isExpand: true,
			idKey: 'resourceCategoryId',
			nameKey: 'resourceCategoryName',
			extraHtml: function (data) {
				var optHtml = '';
				if(data.__deep == '1'){
				     optHtml += '<a href="javascript:;" class="addLink">添加子分类</a>';
				}else if(data.__deep == '2') {
				     optHtml += '<a href="javascript:;" class="editLink">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;';
				     optHtml += '<a href="javascript:;" class="delLink">删除</a>';
				}
				return optHtml;				
			},
			dragSelector: '.jsTree-node,.jsTree-leaf',
			onDragEnd: function($elem,startIndex,endIndex){
				var orders = [];
				$elem.parent().children().each(function (index) {
					orders.push({id: this.getAttribute('data-id'), sort: index+1});
				});
				$.ajax({//排序
					cache:false,
					url:'${root}/admin/baseConfig/resCategory/sort.do',
					data:{"data":JSON.stringify(orders)},
					dataType:'json',
					success:function(data){						
						if(data.result){
							Win.alert("排序成功！");
						} else {
							Win.alert("排序失败！");
						}
					},
					error:function(){
						Win.alert("排序失败！");
					}
				});
			}
		});
	 }, 'json');
	
	$("#baseDataWarp").on("click",".addLink",function(){
		var $li = $(this).parents('.jsTree-node:eq(0)');
		var html = $(".categoryBox").find(".newBoxBody").val();
		var obj = $('#baseDataWarp').jsTree('getData',$(this).parent().parent().parent());
		var id = '0';
		Win.open({
			id:"categoryWin",
			title : "添加分类",
			width:300,
			html : html
		});
		new BasicCheck({
			form : $id("categoryEditor"),
			ajaxReq : function(){
				saveCategory(id,obj.resourceCategoryId,$li);
			}
		});
	});
	
   $("#baseDataWarp").on("click",".editLink",function(){
	   var $li = $(this).parents('.jsTree-node:eq(0)');
		var id = $(this).parents(".jsTree-leaf").attr('data-id');
		var obj = $('#baseDataWarp').jsTree('getData',$(this).parents(".jsTree-leaf"));
		var html = $(".categoryBox").find(".newBoxBody").val();
		Win.open({
			id:"categoryWin",
			title : "编辑分类",
			width:350,
			height:200,
			html : html
		});
		$("#categoryName").val(htmldecode(obj.resourceCategoryName),$li);
		new BasicCheck({
			form : $id("categoryEditor"),
			ajaxReq : function(){
				saveCategory(id,obj.resourceColumn,$li);
			}
		});		
	});
   
	 function saveCategory(id,column,$li) {
		var categoryName = $.trim($("#categoryName").val());
		$.post('${root}/admin/baseConfig/resCategory/saveOrUpdateCategory.do',{
				"categoryName" : categoryName,
				"categoryId":id,
				"column":column}, 
				function (res) {
					var key = res.key;
					var data = res.data;
					if(id == '0'){
						if (key.result) {
							$('#baseDataWarp').jsTree('addData', $li.attr('data-id'), {resourceCategoryId:data.resourceCategoryId, resourceCategoryName: data.resourceCategoryName,resourceColumn:data.resourceColumn}, {idKey: 'resourceCategoryId', nameKey: 'resourceCategoryName'});
							Win.alert(key.message);
							Win.wins.categoryWin.close();
						} else {
							Win.alert(key.message);
						}
					} else {
						if (key.result) {
							$('#baseDataWarp').jsTree('updateData', $li.attr('data-id'), {resourceCategoryId:data.resourceCategoryId, resourceCategoryName: data.resourceCategoryName,resourceColumn:data.resourceColumn}, {idKey: 'resourceCategoryId', nameKey: 'resourceCategoryName'});
							Win.alert(key.message);
							Win.wins.categoryWin.close();
						} else {
							Win.alert(key.message);
						}
					}
					
				},'json');
	};
   
   
   
   $("#baseDataWarp").on("click",".delLink",function(){
	   var $li = $(this).parents(".jsTree-node:eq(0)");
		var id = $li.attr('data-id');
		Win.confirm({mask:true,html:"您确定要删除该条记录吗？"},function(){
			$.ajax({
				cache:false,
				url:'${root}/admin/baseConfig/resCategory/deleteResCategory.do',
				data:{"categoryId":id},
				success:function(res){
					if(res == '1'){
						$('#baseDataWarp').jsTree('delData',id);
						Win.alert("资源分类删除成功！");
					} else {
						Win.alert("资源分类被引用,无法删除！");
					}
				},
				error:function(){
					Win.alert("删除失败！");
				}
			});
		},function(){});
	});
	
</script>
</html>