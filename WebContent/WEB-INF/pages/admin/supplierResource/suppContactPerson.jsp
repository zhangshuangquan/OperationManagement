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

</head>
<body>
   <input type="hidden" value="${requestScope.supplier_Id}" name="adminUserId"/>
   
    <table class="tableBox">
			<tr>
			    <th>&nbsp;&nbsp;</th>
				<th>姓名</th>
				<th>职位</th>
				<th>联系方式</th>
			</tr>
			<tbody id="tbody"></tbody>
   </table> 
   
   <script type="text/javascript">
$(
        function(){
        	//alert("ok");
        	var $supplierId =$("input[type='hidden']").val();
            var url="${root}/admin/supplier/contactpersonlist.do?supplier_Id="+$supplierId;
                var args={};
                $.post(
                  url,
                  args,
                  function(data){
                	  
                	 // alert("data.length="+data.length);
                    console.log("data="+data);
                    var html='';
                    if(data.length>0){
                    	
                    	for(var i=0; i<data.length; i++){
                    		
                    		//alert("data[i].contactPersonName="+data[i].contactPersonName+" ,"+data[i].contactPersonJob+" ,"+data[i].contactPersonPhone);
        					html += '<tr>';
        					html += '<td>'+(data[i].concatPersonFlag==null?'-':data[i].concatPersonFlag)+'</td>';
        					html += '<td>'+(data[i].contactPersonName==null?'-':data[i].contactPersonName)+'</td>';
        					html += '<td>'+(data[i].contactPersonJob==null?'-':data[i].contactPersonJob)+'</td>';
        					html += '<td>'+(data[i].contactPersonPhone==null?'-':data[i].contactPersonPhone)+'</td>';
        					html += '</tr>';
                    	}
                    	
                    	
                    }else{
                    	
                    	html += '<tr><td colspan="4">抱歉！没有您想要的联系人!</td></tr>';
                    }
                	
                    $("#tbody").html(html);
                  }
                );   
             
         }		
    ) 
</script>
</body>

</html>