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
	    </div>
		<table class="tableBox">
			<tr>
			    <th width="5%">序号</th>
				<th width="10%">姓名</th>
				<th width="15%">联系电话</th>
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
	
	function getEngineer(data,total){
		if(total || total != 0){
			if(data){
				$("#totalNum").html(total);
				var start = splitPage.req.start;
				var html ='';
				var baseUser;
				for(var i = 0,j = data.length;i<j;i++){
					engineer = data[i];
					start++;
					html+='<tr>';
					html+='<td>'+start+'</td>';
					html+='<td>'+engineer.realName+'</td>';
					html+='<td>'+engineer.contact+'</td>';
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
	function search(){
		var clsSchoolId='${schoolId}';
		$("#pager").html("");
		var config = {
				node:$id("pager"),
				url:"${root}/admin/schoolmanager/showengineer.do",
				count:10,
				type:"post",
				callback:getEngineer,
				data:{
					clsSchoolId:clsSchoolId
				}
			};
		 splitPage = new SplitPage(config);
	 }
  </script>
</body>
</html>