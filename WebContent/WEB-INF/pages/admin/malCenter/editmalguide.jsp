<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<%@ include file="malguidecommon.jsp"%>
<link href="${root}/public/calendar/skin/WdatePicker.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="${root}/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
<script src="${root}/public/js/jsTree.js" type="text/javascript"></script>
<script type="text/javascript" src="${root}/public/js/ueditor/ueditor.information.config.js"></script>
<script type="text/javascript" src="${root}/public/js/ueditor/ueditor.all.min.js"></script>
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
	    background: url("${pageContext.request.contextPath}/public/img/green/add-new.png") no-repeat scroll 0 50% rgba(0, 0, 0, 0);
	    color: #52732e;
	    margin-left: 20px;
	    padding-left: 18px;
	    text-decoration: none;
	}
</style>
</head>
<body style="width:60%">
	<h3 id="cataMenu">
		<a href="javascript:;">报修管理</a> &gt; <a href="javascript:;">新增故障排查指南</a>
	</h3>
	<div id="control">
		<div id="controlContent">
			<form id="editmalGuideform">
				<ul class="searchWrap">
					<li>
						<label class="labelText">一级分类：</label>
						<select style="width:120px;margin-right:10px;" id='firstGuideCatalogSelect' name="uid" class="mr20" needcheck nullmsg="请选择一级分类!" onchange="fillSecondGuideCatalog();">
							<option value=''>请选择</option>
						</select>
						<a id="edit_guide_classification1" class="repair-icon edit" href="javascript:;" onclick="editFirstGuidCatalog();"></a>
						<a id="add_guide_classification1" class="repair-icon add" href="javascript:;" onclick="addFirstGuideCatalog();"></a>
						<a id="del_guide_classification1" class="repair-icon del" href="javascript:;" onclick="delFirstGuideCatalog();"></a>
						<span style="float:right;margin-right:20px;">
						<input class="btn btnGreen submit" type="submit" value="保存" />
						<input class="btn btnGray back" style="width:30px;height:24px;" onclick="returnBackWithConfirm();" value="返回" />
						</span>
					</li>
					<li>
						<label class="labelText">二级分类：</label>
						<select style="width:120px;margin-right:10px;" id='secondGuideCatalogSelect' needcheck nullmsg="请选择二级分类!">
							<option value=''>请选择</option>
						</select>
						<a id="edit_guide_classification2" class="repair-icon edit" href="javascript:;" onclick="editSecondGuidCatalog();"></a>
						<a id="add_guide_classification2" class="repair-icon add" href="javascript:;" onclick="addSecondGuideCatalog();"></a>
						<a id="del_guide_classification2" class="repair-icon del" href="javascript:;" onclick="delSecondGuideCatalog();"></a>
					</li>
					<li>
						<label class="labelText">故障标题 :&nbsp;</label>
						<input type="text"  value="" id="summaryText"   maxlength="50" size="100"/>
					</li>
					<li>
						<label class="labelText">解决办法：</label>
						<span class="cCont" style="overflow:unset;display: inline-block;vertical-align: top">
							<script id="contentUE" type="text/plain" style="width:700px;height:300px;"></script>
						</span>
						
					</li>
				</ul>
				</form>
		</div>
	</div>
	
	
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
	
		var content = UE.getEditor("contentUE");
		
		var malGuideId = '<%=request.getAttribute("malGuideId") %>';
		
		$(function() {
			
			if(malGuideId != 'null') {
				fillMalGuideById();
			} else {
				fillFirstGuideCatalog();
			}
		});
		
		function fillMalGuideById() {
			$.get('${root}/admin/malCenter/selectMalGuideById.do', {"malGuideId" : malGuideId}, function(result){
				
				var firstCatalogId = result.guideCatalogId1;
				var secondCatalogId = result.guideCatalogId2;
				var summary = result.summary;
				var description = result.description;
				
				fillFirstGuideCatalog(firstCatalogId);
				
				if(firstCatalogId != null &&  firstCatalogId != '') {
					fillSecondGuideCatalog(secondCatalogId);
				}
				
				$("#summaryText").val(summary);//TODO 显示html标签
				
				content.ready(function() {
					content.setContent(description);
				});
				
			}, "json");
		}
		
		function editOrAddMalGuide() {
			if(malGuideId != 'null') {
				editMalGuide();
			} else {
				addMalGuide();
			}
		}
		
		function addMalGuide() {
			var firstGuideCatalogId = $("#firstGuideCatalogSelect").val();
			var secondeGuideCatalogId = $("#secondGuideCatalogSelect").val();
			var summary = $("#summaryText").val();
			
			if($.trim(summary) == '') {
				Win.alert("请输入故障标题！") ;
				return;
			} else if (summary.length > 50) {
				Win.alert("故障标题不得超过50个字符") ;
				return false;
			}
			
			if(!content.hasContents()) {
				Win.alert("请输入解决办法！") ;
				return false ;
			} 
			var description   = content.getContent();
			
			if(description.length > 1200) {
				Win.alert("解决办法不得超过1200个字符") ;
				return false;
			}
			
			$.post('${root}/admin/malCenter/addMalGuide.do', {"guideCatalogId1" : firstGuideCatalogId, "guideCatalogId2":secondeGuideCatalogId, "summary":summary, "description":description}, function(result){
				if(result.result) {
					Win.alert("添加成功");
					returnBack();
				} else {
					Win.alert("添加失败,请重新添加");
				}
			}, "json");
		}
		
		function editMalGuide() {
			var firstGuideCatalogId = $("#firstGuideCatalogSelect").val();
			var secondeGuideCatalogId = $("#secondGuideCatalogSelect").val();
			var summary = $("#summaryText").val();
			
			if($.trim(summary) == '') {
				Win.alert("请输入故障标题！") ;
				return false;
			} else if (summary.length > 50) {
				Win.alert("故障标题不得超过50个字符") ;
				return false;
			}
			
			if(!content.hasContents()) {
				Win.alert("请输入解决办法！") ;
				return false ;
			} ;
			var description   = content.getContent();
			if(description.length > 1200) {
				Win.alert("解决办法不得超过1200个字符") ;
				return false;
			}
			
			$.post('${root}/admin/malCenter/editMalGuide.do', {"malGuideId":malGuideId,"guideCatalogId1" : firstGuideCatalogId, "guideCatalogId2":secondeGuideCatalogId, "summary":summary, "description":description}, function(result){
				if(result.result) {
					Win.alert("编辑成功");
					returnBack();
				} else {
					Win.alert("编辑失败,请重新编辑");
				}
			}, "json");
		}
		
		function returnBack() {
			window.location.href = "${root}/admin/malCenter/malguidelist.html";
		}
		
		function returnBackWithConfirm() {
			Win.confirm({html:"您确定要返回吗?",
				mask:true,
				title : "确认消息"},function() {
					returnBack();
			}, function() {
				//DO NOTHING
			});
		}
		
		new BasicCheck({
			form: $id("editmalGuideform"),
			ajaxReq : function(){
				editOrAddMalGuide();
			},
			warm: function warm(o, msg) {
				Win.alert(msg);
			}
		});
		
    </script>
		
</body>
</html>

