<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
      <input id="userId" type="hidden" value="${requestScope.uId}"/>
      <div class="totalPageBox">总共<span class="totalNum">0</span> 条项目</div> 
      <table class="tableBox">
			<tr>
				<th>项目编号</th>
				<th>项目名称</th>
			</tr>
		</table> 
	  <div id="pageNavi" class="pageNavi"></div>
	  
<script type="text/javascript">
	  
	  var uId=$("#userId").val();
	    	 
	    	 var mySplit = new SplitPage({
	 		    node : $id("pageNavi"),
	 		    url :"${root}/admin/supplier/selcsupplierprilist.do",
	 		    data:{
	 		    	'supplier_Id':uId
	 			},
	 		    count : 20,
	 		    callback : showList,
	 		    type : 'post'
	 		});
	 	  
	 		function showList(data,totalCnt){
	 			var len = data.length;
	 			var html = '';
	 			//$("#suppName").html(data[0].supplyName);
	 			if(len>0){
	 				for(var i = 0; i< len; i++){
	 					var resObj = data[i];
	 					if(resObj.projectCode==null && resObj.projectName==null){
	 						html += '<tr><td colspan="6">抱歉！没有搜索到您想要的信息！</td></tr>';
	 					}else{
	 						html += '<tr>';
		 					html += '<td>'+(data[i].projectCode==null?'-':data[i].projectCode)+'</td>';
		 					html += '<td>'+(data[i].projectName==null?'-':data[i].projectName)+'</td>';
		 					html += '</tr>';
	 					}
	 					
	 				}
	 			} else {
	 				html += '<tr><td colspan="6">抱歉！没有搜索到您想要的信息！</td></tr>';
	 			}
	 			$(".tableBox tr").not(":first").remove();
	 			$(".tableBox").append(html);		
	 			$(".totalNum").html(totalCnt);
	 		}
	 		
	  </script>
</body>
</html>