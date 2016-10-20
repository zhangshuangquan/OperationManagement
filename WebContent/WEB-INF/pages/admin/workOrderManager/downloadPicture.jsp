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
      <input id="userId" type="hidden" value="${id}"/>
        <div class="totalPageBox">总共<span class="totalNum" id="totalNum">0</span> 条项目</div> 
          <ul class="searchWrap">
         <li class="clearfix" style="margin:5px 20px 5px;">
          <table class="tableBox center">
			<tr>
				<th>图片名称</th>
				<th>图片描述</th>
				<th>图片下载</th>
			</tr>
			<tbody id="pageBody">
		    </tbody>
		 </table> 
		 </li>
		 </ul>
		 <div class="pageNavi" id="pager"></div>
		
	  
<script type="text/javascript">
   $(document).ready(function(){
	   var splitPage;
	   search();
   });
   function search(){
	   var uId=$("#userId").val();
		$("#pager").html("");
		var config = {
				node:$id("pager"),
				url:"${root}/admin/workorder/downloadpicture.do",
				count : 10,
				type :"post",
				callback:showList,
				data:{
					'maintenanceOrderId':uId
				}
			};
			splitPage = new SplitPage(config);
	    }
	  
     function showList(data, total) {
		if(total || total != 0){
			if(data){
				$("#totalNum").html(total);
				var start = splitPage.req.start;
				var html ='';
				var classroom;
				for(var i = 0,j = data.length;i<j;i++){
					resObj = data[i];
					start++;
					html += '<tr>';
					html += '<td>'+resObj.name+'</td>';
					html += '<td>'+(resObj.remark==null?'-':resObj.remark)+'</td>';
					html += '<td><a href="${root}/images/'+resObj.attachment_Url+'/'+encodeURIComponent(resObj.name)+'">下载</a></td>';
					html += '</tr>';
				}
				$("#pageBody").html(html);
			}else{
				$("#pageBody").html("<tr><td colspan='12'>抱歉，未查询到相关记录!</td></tr>");
				$("#totalNum").html("0");
			}
		}else{
			$("#pageBody").html("<tr><td colspan='12'>抱歉，未查询到相关记录!</td></tr>");
			$("#totalNum").html("0");
		}
      }
   </script>
</body>
</html>