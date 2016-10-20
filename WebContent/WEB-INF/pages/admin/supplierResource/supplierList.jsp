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
    	
</script>

<!-- 设置删除链接的颜色-->
<style>
.delLink, .del-link{color:#4c7002 !important}
</style>

</head>

<body>
<h3 id="cataMenu">
		<a href="javascript:;">资源超市</a> &gt; <a href="javascript:;">系统集成商资源</a>
</h3>

<div id="control">
		<div id="controlContent">
		<ul class="searchWrap borderBox">
		 <li class="clearfix" style="margin:5px 0 15px;">
		   <label class="text">供应商名称：</label>
			<span class="cont">
              <input type="text" id="name"/>
             </span>
          <label class="labelText">区域：</label>
					<span class="cont" id="chooseArea">
						<select class="mr20" id="province">
							<option value="-1">请选择</option>
						</select>
					</span>
	     <label class="labelText">资质：</label>
	     <span class="cont">
           <select id="select">
                <option value="">--请选择--</option>
				<option value="特一级资质">特一级资质</option>
				<option value="一级资质">一级资质</option>
				<option value="二级资质">二级资质</option>
				<option value="三级资质">三级资质</option>
				<option value="四级资质">四级资质</option>
			    <option value="普通提供商">普通提供商</option>
		    </select>
         </span>
      <label class="labelText">注册资本：</label>
        <span class="cont">
            <input type="text" id="leftData"/>----<input type="text" id="rightData"/>
        </span>
     </li>
     <li class="clearfix" style="margin:5px 0 15px;">
       <label class="text" style="margin-left:25px;">联系人：</label>  
       <span class="mr20">
          <input type="text" id="contactName"/>
       </span>
       <label class="labelText">联系电话：</label>
       <span class="cont">
          <input type="text" id="contactPhone"/>
       </span>
        <span style="margin-left:20px;">
           <input type="button" id ="queryBtn" class="submit btn" name="query" value="查询"/>
        </span>
	 </li>
	</ul>  
    <div class="totalPageBox">
    <div class="fr">
		<a id="addOrgUser" class="btn btnGreen" href="javascript:;">新增</a>
	    <a class="btn btnGreen" href="javascript:;" onclick="exportSupplierList();">导出</a>
	</div>  
        总共<span class="totalNum">0</span> 条数据</div>
		<table class="tableBox">
			<tr>
				<th width="15%">供应商名称</th>
				<th width="10%">所属区域</th>
				<th width="15%">地址</th>
				<th width="5%">联系人</th>
				<th width="10%">注册资本(万元)</th>
				<th width="10%">历史合作项目</th>
				<th width="5%">资质</th>
				<th width="23%">主要服务内容</th>
				<th width="7%">操作</th>
			</tr>
			<tbody id="tbody"></tbody>
		</table>
		<div id="pageNavi" class="pageNavi"></div>
	</div>
</div>	
		
	<script type="text/javascript">
	   //获得集成商的信息列表
	   	var mySplit = new SplitPage({
	    node : $id("pageNavi"),
	    url :"${root}/admin/supplier/selcsupplierlist.do",
	    data:   {
		},
	    count : 20,
	    callback : showList,
	    type : 'post'
	});
	   
		function showList(data,totalCnt){
			var len = data.length;
			//alert("len="+len);
			//alert("data[1].projectId="+data[1].projectId+" ,data[1].projectName="+data[1].projectName);
			var html = '';
			if(len>0){
				for(var i = 0; i< len; i++){
					var resObj = data[i];
					html += '<tr>';
					html += '<td>'+(resObj.name==null?'-':resObj.name)+'</td>';
					html += '<td>'+(resObj.baseArea.areaPath==null?'-':resObj.baseArea.areaPath)+'</td>';
					html += '<td>'+(resObj.address==null?'-':resObj.address)+'</td>';
					html += '<td><a href="javascript:;"   onclick="selectContact(\''+resObj.supplierId+'\',\''+resObj.name+'\');">'+resObj.countContactNum+'</a></td>';
					html += '<td>'+(resObj.registeredCapital==null?'-':resObj.registeredCapital)+'</td>';
					html += '<td><a href="javascript:;"   onclick="selectProject(\''+resObj.supplierId+'\',\''+resObj.name+'\');">'+resObj.countNum+'</a></td>';
					html += '<td><a href="javascript:;"   onclick="selectQualification(\''+resObj.supplierId+'\',\''+resObj.name+'\');">'+resObj.qualification+'</a></td>';
					html += '<td>'+(resObj.serviceContent==null?'-':resObj.serviceContent)+'</td>';
					html += '<td>';
				    html += '<a href="javascript:;" class="viewLink"  lang="'+resObj.supplierId+'">编辑</a>&nbsp;&nbsp;';
				    html += '<a href="javascript:;" class="queryLink"  lang="'+resObj.supplierId+'">查看</a>&nbsp;&nbsp;';
					html += '<a href="javascript:;"  class="delLink"  lang="'+resObj.supplierId+'">删除</a>';
					html += '</td>';
					html += '</tr>';
				}
			} else {
				html += '<tr><td colspan="10">抱歉！没有搜索到您想要的信息！</td></tr>';
			}
			$("#tbody").html(html);//将拼接好的数据放置到表格体中		
			
			
			$(".totalNum").html(totalCnt);//显示记录总数
		}
		
		
		//集成商导出功能
		function exportSupplierList(){
			
			  var areas = $("#chooseArea select");
				var baseAreaId = "";
				var baseAreaId1 = "";
				if(areas.length == 1){
					baseAreaId = $(areas[0]).val();
				}else{
					baseAreaId = $(areas[areas.length-2]).val();
					baseAreaId1 =$(areas[areas.length-1]).val();
					if("-1" != baseAreaId1){
						baseAreaId = baseAreaId1;
					}
					
				}
				
				var baseAreaId = baseAreaId;
				var name=$("#name").val();
			  	var qualification=$("#select").val();
			  	var leftData=$("#leftData").val();
			  	var rightData=$("#rightData").val();
			  	var contactName=$("#contactName").val();
			  	var contactPhone=$("#contactPhone").val();
			  	
			var url = "${root}/admin/supplier/exportSupplierList.do?baseAreaId="+baseAreaId
					+"&name="+encodeURIComponent(name)
					+"&qualification="+encodeURIComponent(qualification)
					+"&leftData="+encodeURIComponent(leftData)
					+"&rightData="+encodeURIComponent(rightData)
					+"&contactName="+encodeURIComponent(contactName)
					+"&contactPhone="+encodeURIComponent(contactPhone)
					;
			window.location.href = url;
			
		}
		
		
	  //点击编辑链接
	  $(".tableBox").on("click",".viewLink",function(){
	  	var $resId = $(this).attr("lang");
	     
	  	Win.open({id:"addOrgUserWin",url:"${root}/admin/supplier/jumptoeditsupplier.html?supplyId="+$resId,title:"编辑系统集成商",width:650,height:500,mask:true});
		});
	  
	  //点击查看供应商详情
	   $(".tableBox").on("click",".queryLink",function(){
	  	var $resId = $(this).attr("lang");
	     
	  	Win.open({id:"addOrgUserWin",url:"${root}/admin/supplier/jumptosupplierdetail.html?supplyId="+$resId,title:"系统集成商详情",width:650,height:500,mask:true});
		});
	  
		//点击删除按钮执行删除操作
		  $(".tableBox").on("click",".delLink",function(){
		  	var $resId = $(this).attr("lang");
		  	//alert($resId);
		  	delResource($resId);				
			});
		  
		  function delResource(supplierId){
				Win.confirm({mask:true,html:"确定要删除吗?"},function(){
					    var url = "${root}/admin/supplier/delsupplierbyid.do?supplierId="+supplierId;
						$.ajax({
							   type: "get",
							   url: url,
							   success: function(msg){
							     Win.alert("删除成功！");
							     window.location.reload();
							   }
						 }); 
					},function(){});			
			}
		  
	   
		  //点击新增按钮进行弹窗
		$("#addOrgUser").click(function(){
			//alert("ok!");
			Win.open({id:"addOrgUserWin",url:"${root}/admin/supplier/jumptoaddsupplier.html",title:"新增系统集成商",width:650,height:500,mask:true});
		});
		  
		//点击合作项目数来弹出合作项目列表
		function selectProject(id,supplyName){
		
			Win.open({id:"addOrgUserWin",url:"${root}/admin/supplier/jumptoprojlist.do?supplier_Id="+id,title:"供应商"+supplyName+"历史合作项目",width:600,height:400,mask:true});
		}
		
		//点击指定供应商的资质
		function selectQualification(id,supplyName){
			
			Win.open({id:"addOrgUserWin",url:"${root}/admin/supplier/jumpToShowQualification.do?supplier_Id="+id,title:"供应商"+supplyName+"资质",width:600,height:400,mask:true});
		}
		
		
		
		//点击联系人的个数来获得联系人列表
		function selectContact(id,supplyName){
			
			Win.open({id:"addOrgUserWin",url:"${root}/admin/supplier/jumptocontactpersonlist.do?supplier_Id="+id,title:"供应商"+supplyName+"联系人清单",width:600,height:400,mask:true});
		}
		  
	 	
	      //条件查询操作
		  $("#queryBtn").click(function(){
			
				search();
			});
		 
		//按条件进行查询函数
		  function search(){
			
			//获取用户选择的区域
			  var areas = $("#chooseArea select");
				var baseAreaId = "";
				var baseAreaId1 = "";
				if(areas.length == 1){
					baseAreaId = $(areas[0]).val();
				}else{
					baseAreaId = $(areas[areas.length-2]).val();
					baseAreaId1 =$(areas[areas.length-1]).val();
					if("-1" != baseAreaId1){
						baseAreaId = baseAreaId1;
					}
					
				}
		  	var name=$("#name").val();
		  	var qualification=$("#select").val();
		  	var leftData=$("#leftData").val();
		  	var rightData=$("#rightData").val();
		  	var contactName=$("#contactName").val();
		  	var contactPhone=$("#contactPhone").val();
		  	
		  	var url="${root}/admin/supplier/selcsupplierlist.do";
		  	var param  = {
		  			baseAreaId:baseAreaId,
		  			name:name,
		  			qualification:qualification,
		  			leftData:leftData,
		  			rightData:rightData,
		  			contactName:contactName,
		  			contactPhone:contactPhone
		  	};
		  	mySplit.search(url,param);
		  }
		  
	</script>
</body>
</html>