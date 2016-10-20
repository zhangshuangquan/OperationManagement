<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="commonWrap">
		<div class="totalPageBox">
				<div>总共<span class="totalNum" id="totalNum"></span> 条数据</div>
				<input type="hidden" id="sequence"/><!--添加排序的类别-->
	    </div>
		<table class="tableBox">
			<tr>
			    <th width="5%">序号</th>
				<th width="10%">教室名称</th>
				<th width="10%">类型</th>
				<th width="10%">学校</th>
				<th width="10%">区域</th>
				<th width="10%">调试进度<a sortType="status" sortdesc="ASC" class="sortBtn" href="javascript:;">↑↓</a></th>
			</tr>
			<tbody id="pageBody">
			</tbody>
		</table>
		<div class="pageNavi" id="pager"></div>
		
</div>

   <script type="text/javascript">
	var domid = frameElement.getAttribute("domid");
	 $(document).ready(function(){
		 var splitPage;
		 search();
	 });
	
	//关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
	
	 /* 对表格头进行点击正反排序 */
	$(".sortBtn").click(function(){
		sortDesc = this.getAttribute("sortdesc");
		sortType = this.getAttribute("sortType");
		if(sortDesc == "ASC"){
			$(".sortBtn").html("↑↓");
			this.setAttribute("sortdesc","DESC");
			$(this).html("↓");
		}else{
			this.setAttribute("sortdesc","ASC");
			$(this).html("↑");
		}
		$("#sequence").attr("value",sortDesc); //给默认的文本框填值
		search() ;
	
	});
	
	function getClassList(data,total){
		if(total || total != 0){
			if(data){
				$("#totalNum").html(total);
				var start = splitPage.req.start;
				var html ='';
				var baseUser;
				for(var i = 0,j = data.length;i<j;i++){
					baseUser = data[i];
					start++;
					html+='<tr>';
					html+='<td>'+start+'</td>';
					html+='<td>'+baseUser.roomName+'</td>';
					html+='<td>'+baseUser.roomType+'</td>';
					html+='<td>'+baseUser.clsSchoolName+'</td>';
					html+='<td>'+baseUser.schoolArea+'</td>';
					html+='<td>'+baseUser.inspectProcess+'</td>';
					html+='</tr>';
				}
				$("#pageBody").html(html);
			}else{
				$("#pageBody").html("<tr><td colspan='8'>抱歉，未查询到相关记录!</td></tr>");
				$("#totalNum").html("0");
			}
		}else{
			$("#pageBody").html("<tr><td colspan='8'>抱歉，未查询到相关记录!</td></tr>");
			$("#totalNum").html("0");
		}
	}
	function search(sortDesc){
		var projectId='${projectId}';
		var sortDesc=$("#sequence").val();
		$("#pager").html("");
		var config = {
				node:$id("pager"),
				url:"${root}/admin/schoolmanager/showclass.do",
				count:10,
				type:"post",
				callback:getClassList,
				data:{
					projectId:projectId,
					sortDesc:sortDesc
					
				}
			};
		 splitPage = new SplitPage(config);
	 }
  </script>
</body>
</html>