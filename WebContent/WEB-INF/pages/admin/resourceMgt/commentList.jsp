<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
</head>
<body>
<h3 id="cataMenu">
	<a href="javascript:;">前台内容管理</a> &gt; <a href="javascript:;">资源评论管理</a>&gt; 
	<a href="javascript:;"><c:if test="${column eq 'video' }">视频</c:if><c:if test="${column ne 'video' }">文档</c:if>类资源评论</a>
</h3>
<div id="control">
	<div id="controlContent">
		<ul class="sortWrap">
			<li>
		        <label><b>评论人：</b></label>
		        <input type="text" id= "userName" name="userName" value="" />
		        <label class="labelText"><b>关键字：</b></label>
		        <input type="text" id= "keyWord" name="keyWord" value="" />
		        <input type="button" id = "queryBtn" class="submit btn" name="query" value="查询" />
	       	</li>
	    </ul>
	  	<div class="totalPageBox">总共<span class="totalNum">0</span> 条资源</div>
		<table class="tableBox">
			<tr>
				<th width="5%"><label><input class="selectAll" type="checkbox" />全选</label></th>
				<th width="20%">评论时间</th>
				<th width="10%">评论人</th>
				<th width="15%">来源</th>
				<th width="40%">评论内容</th>
				<th width="10%">操作</th>
			</tr>
		</table>
		<a id="delBatchBtn" class="btn btnGreen" href="javascript:;">批量删除</a>
		<div id="pageNavi" class="pageNavi"></div>
	</div>
</div>
<script type="text/javascript">
		var mySplit = new SplitPage({
		    node : $id("pageNavi"),
		    url : "${root}/admin/resCommentMgt/${column}/listResComments.do",
		    data:{
					userName:'',
					keyWord:''
			},
		    count : 20,
		    callback : showList,
		    type : 'post'
		});
		
		function showList(data,totalCnt){
			var len = data.length;
			var html = '';
			if(len>0){
				for(var i = 0; i< len; i++){
					var resObj = data[i];
					html += '<tr>';
					html += '<td><input type="checkbox" class="childChk" lang="'+resObj.resourceCommentId+'"/></td>';
					html += '<td>'+now('y-m-d h:i:s',resObj.createTime)+'</td>';
					html += '<td>'+resObj.userName+'</td>';
					html += '<td>';
					html += toDetail(resObj);
					html += '</td>';
					html += '<td>'+resObj.comment+'</td>';
					html += '<td>';
					html += '<a href="javascript:;" class="delLink" lang="'+resObj.resourceCommentId+'">删除</a>';
					html += '</td>';
					html += '</tr>';
				}
			} else {
				html += '<tr><td colspan="6">暂无评论信息</td></tr>';
			}
			$(".tableBox tr").not(":first").remove();
			$(".tableBox").append(html);		
			$(".totalNum").html(totalCnt);
		}
		
		function toDetail(resObj){
			var html ='';
			var type = '${column}';
			var transFlag = resObj.transFlag;
			if(transFlag == 'TRANS_SUCCESS'){
				if(type == 'video'){
					html += '<a href="${root}/admin/resourceMgt/video/toView.html?resourceId='+resObj.resourceId+'">'+resObj.resName+'</a>';
				}else{
					html += '<a href="${root}/admin/resourceMgt/doc/toView.html?resourceId='+resObj.resourceId+'">'+resObj.resName+'</a>';
				}
			}else{
				html += '<a href="javascript:;">'+resObj.resName+'</a>';
			}
			return html;
			
		}
		
		
		function search(){
			var url  = "${root}/admin/resCommentMgt/${column}/listResComments.do";
			var userName = $("#userName").val();
			var keyWord = $("#keyWord").val();
			var param  = {
					userName:userName,
					keyWord:keyWord
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
            	delCommentBatch();
            });
		}
		
		function delResource(resourceCommentId){
			Win.confirm({mask:true,html:"确定要删除吗?"},function(){
				var url = "${root}/admin/resCommentMgt/deleteResComment.do?resourceCommentId="+resourceCommentId;
				$.ajax({
					   type: "get",
					   url: url,
					   success: function(msg){
					     Win.alert("删除成功！");
					     mySplit.reload();
					   }
				 }); 
			},function(){});	
		}
		
		function delCommentBatch(){
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
						url		:	'${root}/admin/resCommentMgt/deleteResCommentBatch.do?',                                                                    
						cache	:	false,                                                                                                                                     
						data	:	{'resourceCommentIds':str},
						success	:	function(data){
							Win.alert('资源评论删除成功！');  
							search();
						},                                                                                                                                                
						error: function(data) {                                                                                                                           
							Win.alert('资源评论删除失败！');                                                                                                                 
						}
					});
				},function(){}) ;
			}
		}
		
		$(document).ready(function(){
			bindEvent();
		});
</script>
</body>
</html>