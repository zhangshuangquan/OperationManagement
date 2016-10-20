<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script src="${root }/public/js/basiccheck.js"></script>
<script src="${root }/public/js/map.js"></script>
</head>
<body>
      <input type="hidden" value="${requestScope.uId}" id="userId"/>
      <div class="totalPageBox">总共<span class="totalNum">0</span> 条数据</div>
		<table class="tableBox">
			<tr>
				<th width="25%">时间</th>
				<th width="25%">地点</th>
				<th width="10%">项目</th>
				<th width="10%">状态</th>
				<th width="10%">工单</th>
				<th width="20%">备注</th>
			</tr>
			<tbody id="tbody"></tbody>
		</table>
		<div id="pageNavi" class="pageNavi"></div> 
		
	<script type="text/javascript">
	
	//获得传来选中的用户的id
	var $resId = $("#userId").val();
	//获得签到表列表
   	var mySplit = new SplitPage({
    node : $id("pageNavi"),
    url :"${root}/admin/personsigncontroller/selcsigndetail.do?userId="+$resId,
    data:   {
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
				html += '<td>'+(resObj.sigTimeStr==null?'-':resObj.sigTimeStr)+'</td>';
				html += '<td>'+(resObj.area_path==null?'-':resObj.area_path)+'</td>';
				html += '<td>'+(resObj.project_name==null?'-':resObj.project_name)+'</td>';
				html += '<td>'+(resObj.status==null?'-':resObj.status)+'</td>';
				html += '<td><a href="javascript:;" lang="'+(resObj.maintenanceOrderId==null?"no":resObj.maintenanceOrderId)+'" class="openOrderDetail">'+(resObj.orderNum==null?'-':resObj.orderNum)+'</a></td>';
				html += '<td>'+(resObj.remarks==null?'-':resObj.remarks)+'</td>';
				html += '</tr>'; 
			}
		} else {
			html += '<tr><td colspan="6">抱歉！没有搜索到您想要的信息！</td></tr>';
		}
		$("#tbody").html(html);//将拼接好的数据放置到表格体中		
		$(".totalNum").html(totalCnt);
	}
	
	
	 //查看工单详情 openOrderDetail
    $(".tableBox").on("click",".openOrderDetail",function(){
  	var $maintenanceOrderId = $(this).attr("lang");
  	if("no"!=$maintenanceOrderId){
  		parent.Win.open({id:"addOrgUserWinaa",url:"${root}/admin/maintenanceorder/jumptorepmanagedetail.html?maintenanceOrderId="+$maintenanceOrderId,title:"售后保障记录",width:500,height:550,mask:true}).css('left:950px;top:200px;');
  	}
  	
	});
	</script>
</body>
</html>