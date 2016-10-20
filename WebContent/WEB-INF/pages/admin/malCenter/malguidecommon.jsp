<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	function fillFirstGuideCatalog(guideCatalogId) {
		$("#firstGuideCatalogSelect").empty();
		var url = '${root}/admin/malCenter/getTopGuideCatalog.do';
		
		$.ajax({
			   type: "get",
			   url:url,
			   async:false,
			   dataType:"json",
			   success: function(result){
				   result.unshift({"malGuideCatalogId":"", "catalogName":"请选择"});
					$.each(result, function(index, json){
						$("#firstGuideCatalogSelect").append("<option value='" + json.malGuideCatalogId + "'>" + json.catalogName + "</option>");
					});
					if(typeof guideCatalogId != 'undefined' && guideCatalogId != '') {
						$("#firstGuideCatalogSelect").val(guideCatalogId);
					}
			   }});
	}
	
	function fillSecondGuideCatalog(guideCatalogId) {
		$("#secondGuideCatalogSelect").empty();
		var firstGuideCatalogId = $("#firstGuideCatalogSelect").val();
		var url = '${root}/admin/malCenter/getGuideCatalogByPid.do';
		$.get(url, {"pid" : firstGuideCatalogId}, function(result){
			result.unshift({"malGuideCatalogId":"", "catalogName":"请选择"});
			$.each(result, function(index, json){
				$("#secondGuideCatalogSelect").append("<option value='" + json.malGuideCatalogId + "'>" + json.catalogName + "</option>");
			});
			if(typeof guideCatalogId != 'undefined' && guideCatalogId != '') {
				$("#secondGuideCatalogSelect").val(guideCatalogId);
			}
		}, "json");
	}
	
	function editFirstGuidCatalog() {
		var firstGuideCatalogId = $("#firstGuideCatalogSelect").val();
		if(firstGuideCatalogId == '') {
			Win.alert("请选择一级分类");
			return false ;
		}
		editGuideCatalog(firstGuideCatalogId,true);
	}
	
	function editSecondGuidCatalog() {
		var secondeGuideCatalogId = $("#secondGuideCatalogSelect").val();
		if(secondeGuideCatalogId == '') {
			Win.alert("请选择二级分类");
			return false ;
		}
		editGuideCatalog(secondeGuideCatalogId, false);
	}
	
	
	// 显示编辑分类弹出框
	function editGuideCatalog(guideCatalogId, firstGuideCatalogIdFlag) {
		
		var originalCatalogName = ''; 
		var catalogLevel = '1';
		
		if(firstGuideCatalogIdFlag) {
			originalCatalogName = $("#firstGuideCatalogSelect option:selected").text();
		} else {
			originalCatalogName = $("#secondGuideCatalogSelect option:selected").text();
			catalogLevel = '2';
		}
		
		
		Win.confirm({
			title: "编辑分类",
			html: $id("operation-pop").value,
			mask:true,
			width: "300",
			height: "200"
		},function(){//确定
			var catalogNameField = $("#catalogNameField").val();
			if($.trim(catalogNameField) == '') {
				Win.alert("分类名称不能为空");
				return false ;
			} else if (catalogNameField.length > 20) {
				Win.alert("分类名称不能超过20个字符");
				return false ;
			}
			
			$.post('${root}/admin/malCenter/updateGuideCatalog.do', {"malGuideCatalogId" : guideCatalogId, "catalogName":catalogNameField, "catalogLevel":catalogLevel}, function(result){
				if(result.result) {
					Win.alert("编辑成功");
					if(firstGuideCatalogIdFlag) {
						fillFirstGuideCatalog(guideCatalogId);
					} else {
						fillSecondGuideCatalog(guideCatalogId);
					}
				} else {
					Win.alert(result.message);
				}
			}, "json");
		},function(){//取消
			//DO NOTHING
		});
		
		$("#catalogNameField").val(originalCatalogName);
	}
	
	function addFirstGuideCatalog() {
		addGuideCatalog('');
	}
	
	function addSecondGuideCatalog() {
		var firstGuideCatalogId = $("#firstGuideCatalogSelect").val();
		if(firstGuideCatalogId == '') {
			Win.alert("请选择一级分类");
			return false ;
		}
		addGuideCatalog(firstGuideCatalogId);
	}
	
	// 显示分类增加弹出框
	function addGuideCatalog(firstGuideCatalogId) {
		
		var title = "添加二级分类";
		var parentId = firstGuideCatalogId;
		
		if($.trim(firstGuideCatalogId) == '') {
			parentId = '-1';
			title = "添加一级分类";
		}
		
		Win.confirm({
			title: title,
			html: $id("operation-pop").value,
			mask:true,
			width: "300",
			height: "200"
		},function(){//确定
			var catalogNameField = $("#catalogNameField").val();
			if($.trim(catalogNameField) == '') {
				Win.alert("请输入分类名称");
				return false ;
			} else if (catalogNameField.length > 20) {
				Win.alert("分类名称不能超过20个字符");
				return false ;
			}
			
			$.post('${root}/admin/malCenter/addGuideCatalog.do', {"parentId" : parentId, "catalogName":catalogNameField}, function(result){
				if(result.result) {
					Win.alert("添加成功");
					if($.trim(firstGuideCatalogId) == '') {
						fillFirstGuideCatalog();
					} 
						fillSecondGuideCatalog();
				} else {
					Win.alert(result.message);
				}
			}, "json");
		},function(){//取消
			//DO NOTHING
		});
		
	}
	
	function delFirstGuideCatalog() {
		var firstGuideCatalogId = $("#firstGuideCatalogSelect").val();
		if(firstGuideCatalogId == '') {
			Win.alert("请选择一级分类");
			return false ;
		}
		delGuideCatalog(firstGuideCatalogId, true);
	}
	
	function delSecondGuideCatalog() {
		var secondGuideCatalogId = $("#secondGuideCatalogSelect").val();
		if(secondGuideCatalogId == '') {
			Win.alert("请选择二级分类");
			return false ;
		}
		delGuideCatalog(secondGuideCatalogId, false);
	}
	
	function delGuideCatalog(guideCatalogId, firstGuideCatalogIdFlag) {
		
		Win.confirm({html:"您确定删除该分类吗?",
			mask:true,
			title : "确认消息"},function() {
				$.post('${root}/admin/malCenter/delGuideCatalog.do', {"id" : guideCatalogId}, function(result){
					if(result.result) {
						Win.alert("删除成功");
						if(firstGuideCatalogIdFlag) {
							fillFirstGuideCatalog();
						} 
							fillSecondGuideCatalog();
					} else {
						Win.alert(result.message);
					}
				}, "json");
		
		}, function() {
			//DO NOTHING
		});
	}
	
	
	//对Date的扩展，将 Date 转化为指定格式的String 
	//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
	//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
	//例子： 
	//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
	//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
	Date.prototype.Format = function(fmt) 
	{ //author: meizz 
		var o = { 
		 "M+" : this.getMonth()+1,                 //月份 
		 "d+" : this.getDate(),                    //日 
		 "h+" : this.getHours(),                   //小时 
		 "m+" : this.getMinutes(),                 //分 
		 "s+" : this.getSeconds(),                 //秒 
		 "q+" : Math.floor((this.getMonth()+3)/3), //季度 
		 "S"  : this.getMilliseconds()             //毫秒 
		}; 
		if(/(y+)/.test(fmt)) 
		 fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
		for(var k in o) 
		 if(new RegExp("("+ k +")").test(fmt)) 
		fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length))); 
		return fmt; 
	};
	
</script>
