<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../../common/meta.jsp"%> 
<link rel="stylesheet" href="${root}/public/css/responsiveslides.css">
<link rel="stylesheet" href="${root }/public/css/style.css">
<script type="text/javascript" src="${root }/public/js/responsiveslides.min.js"></script>
<script type="text/javascript">
$(function () {
	
  $("#slider4").responsiveSlides({
	auto: false,
	pager: false,
	nav: true,
	speed: 500,
	namespace: "callbacks",
	before: function () {
	  $('.events').append("<li>before event fired.</li>");
	},
	after: function () {
	  $('.events').append("<li>after event fired.</li>");
	}
  });
});
</script>
</head>
<body>

<div id="wrapper">
	<div class="callbacks_container">
		<ul class="rslides" id="slider4">
		<c:choose>
		  <c:when test="${picture!=null&&fn:length(picture)>0}">
		      <c:forEach var="attach" items="${picture}" varStatus="status">
		        <li style="padding-bottom:10px">
				  <img style="float:left;" src="${root}/images/${attach.attachment_Url}/${attach.name}" alt="">
				  <span style="font-weight:bold;font-size: 20px;">${status.index+1}/${fn:length(picture)}</span>
			       <input type="text" id="mark${status.index}" value="${attach.remark}" style="border:1px solid silver; margin-left:-380px; margin-top:5px; position:absolute; width:300px;"/>
			       <input type="button" value="确定" style="margin-left:100px; position:absolute;"  onclick="editPicture('${attach.relationShipId}','${attach.attachment_Url}','${status.index}')"/> 
			       <input style="margin-left:200px; position:absolute;margin-top:1px;"  type="button" value="删除图片"  onclick="delPicture('${attach.relationShipId}','${attach.attachment_Url}')"/> 
			   </li>   
		    </c:forEach>
		  </c:when>
		  <c:otherwise>
		     	<li style="font-weight:bold;font-size: 20px;">暂无照片！</li>
		  </c:otherwise>
		</c:choose>

		</ul>
	</div>
</div>

<script type="text/javascript">

//删除对应的单号指定的图片

function delPicture(orderId, newFileName){
	  /*  console.log("okokok");
	   console.log("orderId="+orderId+"  ,newFileName="+newFileName); */
	   
	   Win.confirm({mask:true,html:"确定要删除吗?"},function(){
	    var url = "${root }/admin/maintenanceorder/deleteattachmentbypicname.do?relationShipId="+orderId+"&attachment_Url="+newFileName;
		$.ajax({
			   type: "get",
			   url: url,
			   success: function(r){
	               try {
	                   if(!r.result){
	                       Win.alert('操作失败！');
	                   }else{
	                       Win.alert('删除成功!');
	                       window.location.reload();//重新刷新本页面
	                   }
	               } catch(e) {
	                   Win.alert("错误提示:"+e.message);
	               }
	           }
		 }); 
	},function(){});
}

//编辑图片信息
function editPicture(orderId, newFileName,idObj){
	var flag="mark"+idObj;
	var $remark='';
	$remark=$("#"+flag+"").val();//获得用户的动态id
	var url="${root }/admin/maintenanceorder/editpicmark.do?time="+new Date().getMilliseconds();
	 $.ajax({
		   type: "POST",
		   url: url,
		   data:{
			   'attachment_Url': newFileName,
			   'relationship_Id':orderId,
			   'remark':$remark
		   },
		   success: function(r){
               try {
                   if(!r.result){
                       Win.alert('操作失败！');
                   }else{
                       Win.alert('编辑成功!');
                       window.location.reload();//重新刷新本页面
                   }
               } catch(e) {
                   Win.alert("错误提示:"+e.message);
               }
           }
	 }); 
}


</script>

</body>
</html>