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
<script type="text/javascript" src="${root }/public/upload/uploadfile.js"></script>
<script type="text/javascript" src="${root}/public/js/extend.js"></script>
<link href="${root}/public/css/reset.css" rel="stylesheet" type="text/css" media="all">

<script type="text/javascript">
var domid = frameElement.getAttribute("domid");//进行关闭当前窗口的操作
</script>
</head>

<body>

       <form id="editSupplier">
          <ul class="commonUL" style="margin-left:20px; width: 600px">
            <li class="clearfix" style="margin:5px 2px 15px;">
                <input type="hidden" name="supplierId" value="${requestScope.supplyer.supplierId}"/>
                <label>供应商名称:</label>
                <span>${requestScope.supplyer.name}</span>
            </li>
            <li class="clearfix" style="margin:5px -10px 15px;">
                <label class="text">区域：</label>&nbsp;&nbsp;<span>${requestScope.supplyer.baseArea.areaPath}</span>
		    </li>
            <li class="clearfix" style="margin:5px 40px 15px;">
		        <label>地址:</label>
		        <span>${requestScope.supplyer.address}</span>
		    </li> 
		    <li class="clearfix" style="margin:5px 30px 15px;">
		        <label>联系人:</label>
				   &nbsp;<input type="text" disabled="disabled" id='fName' style="color:gray; text-align:center;" value="${requestScope.supplyer.contactPersonNameOne==null?'第一联系人':requestScope.supplyer.contactPersonNameOne}" name="contactPersonNameOne"/>&nbsp;&nbsp;<input type="text" disabled="disabled" id='fJob' style="color:gray; text-align:center;" value="${requestScope.supplyer.contactPersonJobOne==null?'职位':requestScope.supplyer.contactPersonJobOne}" name="contactPersonJobOne"/>&nbsp;&nbsp;<input disabled="disabled" type="text" style="color:gray; text-align:center;" id='fPhone' value="${requestScope.supplyer.contactPersonPhoneOne==null?'联系方式':requestScope.supplyer.contactPersonPhoneOne}" name="contactPersonPhoneOne"/><br/><br/>
				   &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" disabled="disabled" style="color:gray; text-align:center;" id='sName' value="${requestScope.supplyer.contactPersonNameTwo==null?'第二联系人':requestScope.supplyer.contactPersonNameTwo}" name="contactPersonNameTwo"/>&nbsp;&nbsp;<input disabled="disabled" type="text" style="color:gray; text-align:center;" id='sJob' value="${requestScope.supplyer.contactPersonJobTwo==null?'职位':requestScope.supplyer.contactPersonJobTwo}" name="contactPersonJobTwo"/>&nbsp;&nbsp;<input disabled="disabled" type="text" style="color:gray; text-align:center;" id='sPhone' name="contactPersonPhoneTwo" value="${requestScope.supplyer.contactPersonPhoneTwo==null?'联系方式':requestScope.supplyer.contactPersonPhoneTwo}"/><br/><br/>
				   &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" disabled="disabled" id='tName' style="color:gray; text-align:center;" value="${requestScope.supplyer.contactPersonNameThree==null?'第三联系人':requestScope.supplyer.contactPersonNameThree}" name="contactPersonNameThree"/>&nbsp;&nbsp;<input type="text" disabled="disabled" id='tJob' style="color:gray; text-align:center;" value="${requestScope.supplyer.contactPersonJobThree==null?'职位':requestScope.supplyer.contactPersonJobThree}" name="contactPersonJobThree"/>&nbsp;&nbsp;<input type="text" disabled="disabled" style="color:gray; text-align:center;" id='tPhone' name="contactPersonPhoneThree" value="${requestScope.supplyer.contactPersonPhoneThree==null?'联系方式':requestScope.supplyer.contactPersonPhoneThree}"/>
		    </li>
		    <li class="clearfix" style="margin:5px 20px 15px;">
		        <label>注册资金:</label>
		        <span>${requestScope.supplyer.registeredCapital==null?0:requestScope.supplyer.registeredCapital}</span>
		    </li>

            <li class="clearfix" style="margin:5px 25px 15px;">            
                <label>已选项目:</label>
                <span id="showProjectName"></span><!-- 显示选中的项目 -->
            </li>
            <li class="clearfix" style="margin:5px 45px 15px;">           
		        <label>资质:</label>
		        <span>${requestScope.supplyer.qualification==null?'无':requestScope.supplyer.qualification}</span>
		          
           </li>
           <li class="clearfix" style="margin:5px 60px 15px;" id="upload">
                <table class="tableBox">
                   <thead>
                       <tr align="center"><th width="65%">附件名称</th><th width="35%">下载</th></tr>
                   </thead>
                   <tbody>
                      <ul id="uploadInfoBox" class="commonUL">
			         
		             </ul>
                   </tbody>
                </table>
		   </li>
           <li class="clearfix" style="margin:5px -2px 15px;">
          
               <label>主要服务内容:</label>
               <span>${requestScope.supplyer.serviceContent==null?'无':requestScope.supplyer.serviceContent}</span><br/>
               <span><input type="button" class="btn btnGreen" value="确定" onclick="closeMe()"/></span><br/>
          </ul>    
       </form>
       
       <script type="text/javascript">
       
       var showStatus='${requestScope.showStatus}';
       if(showStatus=='y'){
    	   $("#qua").html("上传的资质:");
       }else if(showStatus=='n'){
    	   $("#qua").html("上传的资质:无");
       }
//行政区的选择
      $(document).ready(function(){
    		$.post("${root}/admin/area/getBaseAreaByParentId.do",{"parentId":"-1"},function(data){
    			var html = '<option value="">-- 请选择 --</option>';
    			for(var i = 0,j = data.length; i<j; i++){
    			     html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';	
    			}
    			$("#province").html(html);
    		},'json');
    		selectBind("chooseArea","${root}/admin/area/getBaseAreaByParentId.do","parentId");		
    		$("#showUserList").click(function(){
    			parent.Win.open({id:"showUserListWin",url:"${root}/admin/projectmanager/toshowmanagerlist.html",title:"人员列表",width:500,height:400,mask:true}).css('left:1000px;top:300px');
    		});
    		
    	});
    	

  
  	$(
  	        function(){
  	        	//alert("ok");
  	        	//获得本资源的id
  	        	 var $supplyId =$("input[type='hidden']").val();
  	        	
  	             var url="${root}/admin/supplier/selcprojlistbysuid.do";
  	                var args={
  	                		
  	                		supplyId:$supplyId	
  	                };
  	                $.post(
  	                  url,
  	                  args,
  	                  function(data){
  	                	  var html='';
  	                	 if(data.length>0){
  	                		for(var i=0; i<data.length; i++){
  	  	                		
  	  						    //alert("projId="+data[i].projectId+"----proName="+data[i].projectName);
  	  	                		html+='<span id='+data[i].projectId+' class="e">'+data[i].projectName+'</span>&nbsp;&nbsp;&nbsp;';
  	  	                	}
  	                	 }else{
  	                		 html="<span>无</span>";
  	                	 }
  	                	
  	                	
  	                	$("#showProjectName").html(html);
  	                  }
  	                );
  	                
  	                return false; 
  	         
  	        }
  	     )
  	     
  	     
  	  //关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
  	
    $(document).ready(function(){
   
        var size = '${requestScope.quaList.size()}';
        var html = '';
        if(size > 0){
            <c:forEach items="${requestScope.quaList}" var="quali">
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
<%-- <script type="text/javascript" src="${root }/public/js/click.js"></script> --%>
</body>
</html>