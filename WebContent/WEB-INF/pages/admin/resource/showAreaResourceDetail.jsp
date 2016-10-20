<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script src="${root }/public/js/basiccheck.js"></script>
<script src="${root }/public/js/map.js"></script>

<script type="text/javascript">
var domid = frameElement.getAttribute("domid");//进行关闭当前窗口的操作


//关闭窗口
function closeMe() {
	parent.Win.wins[domid].close();
}
	

//将指定资源对应的所有项目在指定位置进行显示
$(
        function(){
        	//alert("ok");
        	//获得本资源的id
        	 var $reginalResourceId =$("input[type='hidden']").val();
        	//alert("reginalResourceId="+$reginalResourceId);
             var url="${root}/admin/arearesource/selcprobyId.do";
                var args={
                		
                		RegionalResourceId:$reginalResourceId	
                };
                $.post(
                  url,
                  args,
                  function(data){
                	  console.log("data="+data);
                	  var html='';
                	 if(data.length>0){
                		 for(var i=0; i<data.length; i++){
                     		
     					    //alert("projId="+data[i].projectId+"----proName="+data[i].projectName);
                     		html+='<span id='+data[i].projectId+' class="e">'+data[i].projectName+'</span>&nbsp;&nbsp;&nbsp;';
                     	} 
                	 }else{
                		 
                		   html='<span>无</span>';
                	 }

                	$("#showProjectName").html(html);
                  }
                );
                
                return false; 
         
        }
     )
</script>
</head>

<body>

   <form id="editAreaResource">
     <ul class="commonUL" style="margin-left:20px; width: 600px">
        <li class="clearfix" style="margin:5px 2px 15px;">
             <input type="hidden" name="regionalResourceId"  value="${requestScope.regresObj.regionalResourceId}"/>
             <label>供应商名称:</label>
             <span>${requestScope.regresObj.name}</span>
        </li> 
        <li class="clearfix" style="margin:5px 40px 15px;">     
           <label>类别:</label>
           <span id="select">${requestScope.regresObj.type}</span>
         </li>
         <li class="clearfix" style="margin:5px 50px 15px;">
             <label>已选项目显示:</label>
	         &nbsp;&nbsp;<span id="showProjectName"></span>
          </li>
          <li class="clearfix" style="margin:5px 38px 15px;">
            <label>区域:</label>
            <span>${requestScope.regresObj.baseArea.areaPath}</span>
          </li> 
         <li class="clearfix" style="margin:5px 40px 15px;">   
            <label>地址:</label>
            <span>${requestScope.regresObj.address}</span>
         </li>
         <li class="clearfix" style="margin:5px 30px 15px;">       
            <label>联系人:</label>
            <span>${requestScope.regresObj.contactPersonName}</span>
        </li>
        <li class="clearfix" style="margin:5px 20px 15px;">
            <label>联系电话:</label>
            <span>${requestScope.regresObj.contactPersonPhone}</span>
        </li> 
        <li class="clearfix" style="margin:5px 20px 15px;"> 
            <label>服务内容:</label>
            <span>${requestScope.regresObj.serviceContent==null?'无':requestScope.regresObj.serviceContent}</span>
        </li> 
        <li class="clearfix" style="margin:5px 45px 15px;"> 
            <label>备注:</label>
            <span>${requestScope.regresObj.remark==null?'无':requestScope.regresObj.remark}</span>
        </li>
        <li class="clearfix" style="margin:5px 45px 15px;"> 
         <table class="tableBox">
                   <thead>
                       <tr align="center"><th width="65%">附件名称</th><th width="35%">下载</th></tr>
                   </thead>
                   <tbody>
                   <ul id="uploadInfoBox" class="commonUL"> 
			         <%-- <c:if test="${requestScope.attachList!=null}">
			          <span style="margin-left:-45px;" id="qua"></span>
			              <c:forEach items="${requestScope.attachList}" var="quali">
			                 <tr><td>${quali.name}</td><td><a href="${root}/images/${quali.attachment_Url}/${quali.name}">下载</a></td></tr>
			              </c:forEach>
			          </c:if> --%>
		             </ul>
                   </tbody>
                </table>
        </li>          
        <li class="clearfix" style="margin:5px 30px 15px;">
           <input class="btn btnGreen" type="button"  value="确定" onclick="closeMe()"/>
        </li>
    </ul>  
  </form>
  <script type="text/javascript">
  
  $(document).ready(function(){
	   
      var size = '${requestScope.attachList.size()}';
      var html = '';
      if(size > 0){
          <c:forEach items="${requestScope.attachList}" var="quali">
            html += '<tr><td>${quali.name}</td>';
            html += '<td><a href=${root}/images/${quali.attachment_Url}/'+encodeURIComponent('${quali.name}')+'>下载</a></td></tr>';
            
          </c:forEach>
        
         $("tbody").append(html);
      }else{
        html +='<tr align="center"><td colspan="2">暂无附件</td></tr>';
        $("tbody").append(html);
      }
  });
  
  </script>
</body>
</html>