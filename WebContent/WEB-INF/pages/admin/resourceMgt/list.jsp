<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
</head>
<body>
<h3 id="cataMenu">
	<a href="javascript:;">前台内容管理</a> &gt; <a href="javascript:;">资源管理</a>&gt; 
	<a href="javascript:;"><c:if test="${column eq 'video' }">视频</c:if><c:if test="${column ne 'video' }">文档</c:if>类资源</a>
</h3>
<div id="control">
	<div id="controlContent">
	   <div class="borderBox">
		    <ul class="sortWrap">
		    	<li>
		    		 <label class="labelText"><b>分类：</b></label>
		    		 <span class="sortBox category">
		    		 	<a class="selected" href="javascript:;" lang="0">全部</a>
		    		 	<c:forEach var="category" items="${resCategoryLi}">
		    		 	    <a href="javascript:;" lang="${category.resourceCategoryId}">${category.resourceCategoryName }</a>
		    		 	</c:forEach>
		    		 </span>
		    	</li>
		    	<li>
		    		 <label class="labelText"><b>学段：</b></label>
		    		 <span class="sortBox semester">
		    		 	<a class="selected" href="javascript:;" lang="0">全部</a>
		    		 </span>
		    	</li>
		    	<li>
		    		 <label class="labelText"><b>年级：</b></label>
		    		 <span class="sortBox classlevel">
		    		 	<a class="selected" href="javascript:;" lang="0">全部</a>
		    		 </span>
		    	</li>
		    	<li>
		    		 <label class="labelText"><b>学科：</b></label>
		    		 <span class="sortBox subject">
		    		 	<a class="selected" href="javascript:;" lang="0">全部</a>
		    		 </span>
		    	</li>
		    </ul>
			<ul class="sortWrap">
				<li>
			        <label class="labelText"><b>时间：</b></label>
			        <input type="text" class="Wdate" id = "startDt" name="startDt" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'#F{$dp.$D(\'endDt\')}'});" value="" />
			        --
			        <input type="text" class="Wdate mr20" id = "endDt" name="endDt" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'#F{$dp.$D(\'startDt\')}'});" value="" />
			        <label class="labelText"><b>资源名称：</b></label>
			        <input type="text" id= "resourceName" name="resourceName" value="" />
			        <input type="button" id = "queryBtn" class="submit btn" name="query" value="查询" />
		       	</li>
		    </ul>
	    </div>
	  	<div class="totalPageBox">总共<span class="totalNum">0</span> 条资源</div>
		<table class="tableBox">
			<tr>
				<th width="5%"><label><input class="selectAll" type="checkbox" />全选</label></th>
				<th width="25%">资源名称</th>
				<th width="20%">创建时间</th>
				<th width="15%">创建人</th>
				<th width="15%">公开状态</th>
				<th width="15%">转换状态</th>
				<th width="20%">操作</th>
			</tr>
		</table>
		<a id="delBatchBtn" class="btn btnGreen" href="javascript:;">批量删除</a>
		<div id="pageNavi" class="pageNavi"></div>
	</div>
</div>
<script type="text/javascript">
		var mySplit = new SplitPage({
		    node : $id("pageNavi"),
		    url : "${root}/admin/resourceMgt/${column}/listResResource.do",
		    data:{
					categoryId:'0',
					semesterId:'0',
					classlevelId:'0',
					subjectId:'0',
					startDt:'',
					endDt:'',
					resourceName:''
			},
		    count : 20,
		    callback : showList,
		    type : 'post'
		});
		
		function formTransStatus(key){
	    	var x = '等待转换';
	    	switch(key){
	    	case 'TRANS_PENDDING':
	    		x = '等待转换';
	    		break;
	    	case 'TRANS_CAPTURING':
	    		x = '等待转换';
	    		break;
	    	case 'TRANS_CAPTURED':
	    		x = '等待转换';
	    		break;
	    	case 'TRANS_TRANSING':
	    		x = '转换中';
	    		break;
	    	case 'TRANS_FAILED':
	    		x = '转换失败';
	    		break;
	    	case 'TRANS_SUCCESS':
	    		x = '转换成功';
	    		break;
	    	}
	    	return x;
	    }
		
		function showList(data,totalCnt){
			var len = data.length;
			var html = '';
			if(len>0){
				for(var i = 0; i< len; i++){
					var resObj = data[i];
					html += '<tr>';
					html += '<td><input type="checkbox" class="childChk" lang="'+resObj.resourceId+'"/></td>';
					html += '<td>'+resObj.resourceName+'</td>';
					html += '<td>'+now('y-m-d h:i:s',resObj.createTime)+'</td>';
					html += '<td>'+resObj.createUserName+'</td>';
					html += '<td>'+formPermission(resObj.permission)+'</td>';
					html += '<td>'+formTransStatus(resObj.transFlag)+'</td>';
					html += '<td>';
					if(resObj.transFlag == 'TRANS_SUCCESS'){
						html += '<a href="${root}/admin/resourceMgt/${column}/toView.html?resourceId='+resObj.resourceId+'" class="viewLink">查看</a>&nbsp;&nbsp;';
					}
					html += '<a href="javascript:;" class="delLink" lang="'+resObj.resourceId+'">删除</a>';
					html += '</td>';
					html += '</tr>';
				}
			} else {
				html += '<tr><td colspan="6">抱歉！没有搜索到您想要的信息！</td></tr>';
			}
			$(".tableBox tr").not(":first").remove();
			$(".tableBox").append(html);		
			$(".totalNum").html(totalCnt);
		}
		
		
		function search(){
			var url  = "${root}/admin/resourceMgt/${column}/listResResource.do";
			var categoryId = $(".category .selected").attr("lang");
			var semesterId = $(".semester .selected").attr("lang");
			var classlevelId = $(".classlevel .selected").attr("lang");
			var subjectId = $(".subject .selected").attr("lang");
			var startDt = $("#startDt").val();
			var endDt = $("#endDt").val();
			var resourceName = $("#resourceName").val();
			var param  = {
					categoryId:categoryId,
					semesterId:semesterId,
					classlevelId:classlevelId,
					subjectId:subjectId,
					startDt:startDt,
					endDt:endDt,
					resourceName:resourceName
			};
			mySplit.search(url,param);
		}
		
		function bindEvent(){
			$(".sortBox").on("click"," a",function(){
				var $elem = $(this);
				$elem.addClass("selected");
				var $parent = $elem.parent();
				$parent.find("a").not(this).removeClass("selected");
				
				
				if($parent.hasClass("semester")){
					bindClasslevelBySemesterId($elem.attr("lang"));
					bindSubjectByClasslevelId(0);
				} else if ($parent.hasClass("classlevel")){
					bindSubjectByClasslevelId($elem.attr("lang"));
				}
				
				search();
			});
			
			$("#queryBtn").click(function(){
				search();
			});
			
	
            $(".tableBox").on("click",".delLink",function(){
            	var $resId = $(this).attr("lang");
            	delResource($resId);				
			});
            
            $("#delBatchBtn").click(function(){
            	delResourceBatch();
            });
		}
		
		function delResource(resourceId){
			Win.confirm({mask:true,html:"确定要删除吗?"},function(){
				    var url = "${root}/admin/resourceMgt/${column}/deleteResource.do?resourceIds="+resourceId;
					$.ajax({
						   type: "get",
						   url: url,
						   success: function(msg){
						     Win.alert("删除成功！");
						     search();
						   }
					 }); 
				},function(){});			
		}
		
		function delResourceBatch(){
			var len = $(".childChk:checked").length;
			if(len == 0) {
				Win.alert( "请选择要删除的记录！") ;
				return false ;
			} else {
				Win.confirm({mask:true,html:"确定要删除吗?"},function(){
					var str = "" ;
					$(".childChk:checked").each(function(i,obj){
						if(i == len -1){
							str += $(obj).attr("lang");
						} else {
							str += $(obj).attr("lang") + "," ;
						}	
					});
					$.ajax({                                                                                                                                            
						url		:	'${root}/admin/resourceMgt/${column}/deleteResource.do',                                                                    
						cache	:	false,                                                                                                                                     
						data	:	{'resourceIds':str},
						success	:	function(data){
							Win.alert('资源删除成功！');  
							search();
						},                                                                                                                                                
						error: function(data) {                                                                                                                           
							Win.alert('资源删除失败！');                                                                                                                 
						}                                                                                                                                                 
					});
				},function(){}) ;
			}
		}
		
		function bindSemester(){
			var url = "${root}/admin/commons/getAllSemester.do";
			$.get(url , function(result){
				var html = '<a href="javascript:;" class="selected" lang="0">全部</a>';
				$.each(result, function(index, json){
					html += '<a href="javascript:;" lang="'+json.baseSemesterId+'">'+json.semesterName+'</a>';
				});
				$(".semester").html(html);
			}, "json");
		}
		
		function bindClasslevelBySemesterId(semesterId){
			var url = "${root}/admin/commons/getClasslevelBySemesterId.do?semesterId="+semesterId;
			$.get(url , function(result){
				var html = '<a href="javascript:;" class="selected" lang="0">全部</a>';
				$.each(result, function(index, json){
					html += '<a href="javascript:;" lang="'+json.baseClasslevelId+'">'+json.classlevelName+'</a>';
				});
				$(".classlevel").html(html);
			}, "json");
		}
		
		function bindSubjectByClasslevelId(classlevelId){
			var url = "${root}/admin/commons/getSubjectByClasslevelId.do?classlevelId="+classlevelId;
			$.get(url , function(result){
				var html = '<a href="javascript:;" class="selected" lang="0">全部</a>';
				$.each(result, function(index, json){
					html += '<a href="javascript:;" lang="'+json.baseSubjectId+'">'+json.subjectName+'</a>';
				});
				$(".subject").html(html);
			}, "json");
		}
		
		function formPermission(key){
			return key == 'PUBLIC'? '公开':'私有';
		}
		
		$(document).ready(function(){
			bindEvent();
			bindSemester();
		});
		
		
		
		
</script>
</body>
</html>