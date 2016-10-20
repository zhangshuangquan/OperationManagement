<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<%@ include file="malguidecommon.jsp"%>
<link href="${root}/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
<script src="${root}/public/js/jsTree.js" type="text/javascript"></script>
<script src="${root}/public/js/ajaxfileupload.js" type="text/javascript"></script>
<style>
	#search {
	    height: 18px;
	    margin-right: 10px;
	    padding-left: 10px;
	    width: 250px;
	}
	
	.repair-icon.edit {
    	background-position: 0 0;
	}
	.repair-icon.add {
    	background-position: 0 -40px;
	}
	.repair-icon.del {
    	background-position: 0 -80px;
	}
	.repair-icon {
	    background: url("${root}/public/img/green/repairIcon.png") no-repeat  0 0;
	    padding:0 15px 10px;
	}
	
	.add-new {
	    background: url("${root}/public/img/green/add-new.png") no-repeat scroll 0 50% rgba(0, 0, 0, 0);
	    color: #52732e;
	    margin-left: 20px;
	    padding-left: 18px;
	    text-decoration: none;
	}
</style>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">报修管理</a> &gt; <a href="javascript:;">浏览故障排查指南</a>
	</h3>
<div id="control">
	<div id="controlContent">
	<ul class="searchWrap">
		<li>
			<label class="labelText">一级分类：</label>
			<select style="width:120px;" id='firstGuideCatalogSelect' onchange="fillSecondGuideCatalog();">
				<option value=''>请选择</option>
			</select>
			<a id="edit_guide_classification1" class="repair-icon edit" href="javascript:;" onclick="editFirstGuidCatalog();"></a>
			<a id="add_guide_classification1" class="repair-icon add" href="javascript:;" onclick="addFirstGuideCatalog();"></a>
			<a id="del_guide_classification1" class="repair-icon del" href="javascript:;" onclick="delFirstGuideCatalog();"></a>
			<span style="margin-left:20px;">系统会根据关键字对所有问题标题、解决办法进行全文搜索</span>
		</li>
		<li>
			<label class="labelText">二级分类：</label>
			<select style="width:120px;" id='secondGuideCatalogSelect'>
				<option value=''>请选择</option>
			</select>
			<a id="edit_guide_classification2" class="repair-icon edit" href="javascript:;" onclick="editSecondGuidCatalog();"></a>
			<a id="add_guide_classification2" class="repair-icon add" href="javascript:;" onclick="addSecondGuideCatalog();"></a>
			<a id="del_guide_classification2" class="repair-icon del" href="javascript:;" onclick="delSecondGuideCatalog();"></a>
			<input style="margin-left:20px;" type="text" value="" placeholder="请输入问题关键字" id="keyContent" maxlength="20" >
			<input type="button" class="submit btn" name="query" onclick="listMalGuide(1);" value="查询" />
			<a href="${root}/admin/malCenter/editmalguide.do" class="add-new">新增问题</a>
			<a href="javascript:void(0);" class="add-new" onclick="batchAddMalGuide();">批量新增问题</a>
		</li>
	</ul>
	
	<!-- 故障排查指南列表  -->
	<table class="tableBox">
		<tr>
			<th width="10%">创建时间</th>
			<th width="15%">一级分类</th>
			<th width="15%">二级分类</th>
			<th width="40%">问题标题</th>
			<th width="20%">操作</th>
		</tr>
		<tbody id="mals">
		</tbody>
	</table>
	
	<div id="pageNavi"></div>
	
	<!-- 更新指南分类弹出层  -->
     <textarea id="operation-pop" style="display: none;">
		<div class="already-detail">
			<div class="name-tag">
				<label>分类名称: </label>
				<input type="text" value="" id="catalogNameField" maxlength="20" >
			</div>
			
		</div>
	</textarea>

	<script type="text/javascript">
		var currPage = 1;

		//动态的创建一个table，同时将后台获取的数据动态的填充到相应的单元格  
		function createMalGuideTable(data, total) {
			var dataArray = data;
			//此处需要让其动态的生成一个table并填充数据  
			var tableStr = "";
			var len = dataArray.length;
			if (len == 0) {
				$("#page_navi").hide();
				$("#no_result").show();
			} else {
				$("#page_navi").show();
				$("#no_result").hide();
			}

			for ( var i = 0; i < len; i++) {
				tableStr = tableStr + "<tr><td>" + new Date(dataArray[i].createTime).Format("yyyy-MM-dd hh:mm:ss") + "</td><td>"
						+ renderCatalog(dataArray[i].guideCatalogName1) + "</td><td>"
						+ renderCatalog(dataArray[i].guideCatalogName2) + "</td><td>"
						+ dataArray[i].summary + "</td><td>"
						+ "<a href='${root}/admin/malCenter/editmalguide.do?malGuideId="+dataArray[i].malGuideId+"'  >修改</a>"
						+ "<a style='margin-left:5px;color:gray' href='javascript:void(0);' onclick='deleteMalGuideById(\""+dataArray[i].malGuideId+"\")'>删除</a></td>"
						+"</tr>";
			}
			//将动态生成的table添加的事先隐藏的div中.

			//alert(tableStr);
			
			if(tableStr == "") {
				tableStr = "<tr><td colspan='5'>无满足条件的故障排查指南信息!</td></tr>";
			}
			
			$("#mals").html(tableStr);
			
			
			window.scrollTo(0, 0);

		}

		$(function() {
			listMalGuide(1);
			fillFirstGuideCatalog();
		});
		
		var mySplit = null;

		function listMalGuide(currentPage) {
			currPage = currentPage;
			
			var firstGuideCatalogId = $("#firstGuideCatalogSelect").val();
			
			var secondeGuideCatalogId = $("#secondGuideCatalogSelect").val();
			
			var keyContent = $.trim($("#keyContent").val());
			
			var criteria = {
				'currentPage' : currentPage,
				'guideCatalogId1':firstGuideCatalogId,
				'guideCatalogId2':secondeGuideCatalogId,
				'summary':keyContent
			};
			var url = '${root}/admin/malCenter/searchguidelist.do';
			
			if(mySplit == null) {
				mySplit = new SplitPage({
					node : $id("pageNavi"),
					url : url,
					data : criteria,
					count : 20,
					callback : createMalGuideTable,
					type : 'get' //支持post,get,及jsonp
				});
			} else {
				mySplit.search(url, criteria);
			}

		}
		
		function deleteMalGuideById(malGuideId) {
			
			Win.confirm({html : '<span class="dialog_Inner">确认要删除该故障排查指南吗?</span>',mask:true}, function () {
					$("#firstGuideCatalogSelect").val("");
					$("#secondGuideCatalogSelect").val("");
					$("#keyContent").val("");
					$.post('${root}/admin/malCenter/deleteMalGuideById.do', {"malGuideId" : malGuideId}, function(result){
						if(result.result) {
							Win.alert("删除成功");
							listMalGuide(1);
						} else {
							Win.alert("删除失败,请重新删除");
						}
					}, "json");
				}
			);
			
		}
	    
	    function batchAddMalGuide() {
	    	Win.open({id:'uploadExcel',width:500,height:260,title:"批量新增故障排查指南",url:"${root}/admin/malCenter/importMalGuidePage.do?userType=malguide",mask:true});
	    	//$("#malGuideFile").click();
	    }
	    
	    function renderCatalog(catalogName) {
	    	if(catalogName == null || catalogName == '' || catalogName == 'null') {
	    		return '未分类';
	    	}
	    	return catalogName;
	    }
		
	</script>
	</div>
	</div>
</body>
</html>

