<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${root}/public/js/customer.js" type="text/javascript"></script>

<script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
 var domid = frameElement.getAttribute("domid");//进行关闭当前窗口的操作
//关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
</script>
</head>
<body>
<form id="editRepairForm">
<ul class="commonUL" style="margin-left:20px;">
 <li class="clearfix" style="margin:5px 0 15px;">
     <input type="hidden" name="orderId" value="${requestScope.orderDetailView.orderId}"/><!-- 本工单的id-->
     <label>单号：</label>${requestScope.orderDetailView.order_Num}
     <span style="margin-left:200px;"><label>工单提交人：</label>${requestScope.realName}</span>
  </li>
  <li class="clearfix" style="margin:5px 0 15px;">
     <label style="font-weight:bold">项目信息</label>
  </li>
  <li class="clearfix" style="margin:5px 0 15px;">
     <label>项目区域：</label>${requestScope.orderDetailView.projectArea}
     <span></span>&nbsp;&nbsp;&nbsp;
     <label>项目：</label>${requestScope.orderDetailView.projectName}
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span></span>
  </li>
  <li class="clearfix" style="margin:5px 0 15px;">
     <label>项目经理：</label>${requestScope.orderDetailView.projectManager}
     <span></span>&nbsp;&nbsp;
     <label>联系电话：</label>${requestScope.orderDetailView.projectConcat}
     &nbsp;&nbsp;<span></span>
  </li>
</ul> 
<hr/>
 
<ul class="commonUL" style="margin-left:20px;">
    <li class="clearfix" style="margin:5px 0 15px;">
	   <label style="font-weight:bold">客户信息</label>
	</li> 
	<li class="clearfix" style="margin:5px 0 15px;"> 
	   <label>学校区域：</label>${requestScope.orderDetailView.schoolArea}
	   <span></span>&nbsp;&nbsp;&nbsp;
	   <label>学校：</label>${requestScope.orderDetailView.schoolName}
	   <span></span>
	 </li>
	 <li class="clearfix" style="margin:5px 0 15px;">
	   <label>详细地址：</label>${requestScope.orderDetailView.orderAddr}
	   <span></span>
	   </li>
	 <li class="clearfix" style="margin:5px 0 15px;">
	   <label>联系人：</label>${requestScope.orderDetailView.schoolConcat}
	   <span></span>&nbsp;&nbsp;&nbsp;
	   <label>联系电话：</label>${requestScope.orderDetailView.schoolPhone}
	   <span></span><br/><br/>
	   <label>问题类型：</label>
	   <c:if test="${requestScope.checkedQuTyList!=null}">
	     <c:forEach items="${requestScope.checkedQuTyList}" var="problemType">
	        <span>${problemType.problemName}</span>&nbsp;&nbsp;
	     </c:forEach><br/>
	   </c:if><br/>
	   <label>问题描述：</label><span>${requestScope.orderDetailView.problem}</span>
	 </li>
</ul>
 <hr/>

 <ul class="commonUL" style="margin-left:20px;">
  <li class="clearfix" style="margin:5px 0 15px;">
     <label style="font-weight:bold">售后跟踪进程</label>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span></span>
  </li>
  <li class="clearfix" style="margin:5px 0 15px;">
     <label>客户来电：</label>
     <span><fmt:formatDate value="${requestScope.orderDetailView.orderCall}" pattern="yyyy-MM-dd"/></span>
  </li>
  <li class="clearfix" style="margin:5px 0 15px;">
     <label>派工流程：</label>
    <span><fmt:formatDate value="${requestScope.orderDetailView.orderProcess}" pattern="yyyy-MM-dd"/></span>
  </li>
  <li class="clearfix" style="margin:5px 0 15px;">
     <label>任务分配：</label>
     <span class="mr20">
		<input type="text" class="Wdate" id="task" onclick="WdatePicker();"  name="taskAssginment" value="<fmt:formatDate value="${requestScope.orderDetailView.orderTask}" pattern="yyyy-MM-dd"/>"/>  
	 </span>
  </li>
  <li class="clearfix" style="margin:5px 0 15px;">
     <label>上门维修：</label>
     <span class="mr20">
		<input type="text" class="Wdate" id="task" onclick="WdatePicker();"  name="outdoors" value="<fmt:formatDate value="${requestScope.orderDetailView.orderDoor}" pattern="yyyy-MM-dd"/>"/>  
	 </span>
  </li>
  <li class="clearfix" style="margin:5px 0 15px;">
     <label>问题解决：</label>
     <span class="mr20">
		<input type="text" class="Wdate" id="task" onclick="WdatePicker();"  name="quesResolve" value="<fmt:formatDate value="${requestScope.orderDetailView.orderSolve}" pattern="yyyy-MM-dd"/>"/>  
	 </span>
  </li>
  <li class="clearfix" style="margin:5px 0 15px;">
     <label>售后回访：</label>
     <span><fmt:formatDate value="${requestScope.orderDetailView.orderVisit}" pattern="yyyy-MM-dd"/></span>
  </li>
 </ul>
 <hr/>
 
 <ul class="commonUL" style="margin-left:20px;">
  <li class="clearfix" style="margin:5px 0 15px;">
     <label style="font-weight:bold">售后维护信息</label>
  </li>
  <li class="clearfix" style="margin:5px 0 15px;">
    <c:if test="${requestScope.engineers!=null}">
        <c:forEach items="${requestScope.engineers}" var="eng">
         <li class="clearfix" id="${eng.adminUserId }">
			<label class="labelText">工程师：</label><span class="e" style="display:inline-block;width:100px;" id="${eng.adminUserId }">${eng.realName}</span>
			<label class="mr20" style="margin-left:20px;"> 联系电话:</label><span class="ph">${eng.contact}</span>			   
	     </li>
        </c:forEach>
    </c:if>
  </li>
 </ul>
 <hr/>
 
 <ul class="commonUL" style="margin-left:20px;">
  <li class="clearfix" style="margin:5px 0 15px;">
     <label style="font-weight:bold">设备寄送信息</label>
  </li>
  <li class="clearfix" style="margin:5px 0 15px;">
     <c:if test="${requestScope.equipList!=null}">
         <c:forEach items="${requestScope.equipList}" var="equip">
            <span><fmt:formatDate value="${equip.delivery_time}" pattern="yyyy-MM-dd"/></span>&nbsp;&nbsp;
          <label>设备：</label>${equip.name}<br/>
           <label>快递公司：</label>${equip.expressCompany}&nbsp;&nbsp;
           <label>单号：</label>${equip.expressNum}&nbsp;&nbsp;<br/><br/>
           
         </c:forEach>
     </c:if>
     
  </li>
 </ul>
 <hr/>
 <label>问题解决描述：</label>
 <textarea name="problemResolve" cols="50" rows="3">${requestScope.orderDetailView.problemSolving}</textarea><br/><br/>
 <span style="width:100px; height:100px;">
  备 注：
   
   ${requestScope.orderDetailView.orderRemark}
   
 </span><br/><br/>
 <span><input type="submit" class="btn btnGreen" value="确定"/></span>&nbsp;&nbsp;
 <span><input type="button" class="btn btnGreen" onclick="closeMe()" value="取消"/></span>
 </form>
 <script>
   
 //进行提交操作  
  	new BasicCheck({
				form: $id("editRepairForm"),
				ajaxReq : function(){
					  $.post('${root}/admin/maintenanceorder/updaterepair.do',$("#editRepairForm").serialize(),function(r){
						  try {
			                    if(!r.result){
			                        Win.alert('操作失败！');
			                    }else{
			                    		parent.Win.alert('操作成功!');
				                        parent.location.reload();
			                    	
			                    }
			                } catch(e) {
			                    Win.alert("错误提示:"+e.message);
			                }
			            });
				},
				warm: function warm(o, msg) {
					Win.alert(msg);
				} 
			});
 </script>
</body>
</html>