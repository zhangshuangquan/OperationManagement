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
	
	
	$('#chooseArea').on("change","select",function(){
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
		
	   //alert("baseAreaId="+baseAreaId);
	   getAreaValue(baseAreaId);
		
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
		<a href="javascript:;">资源超市</a> &gt; <a href="javascript:;">区域资源</a>
</h3>
<div id="control">
		<div id="controlContent">
		<ul class="searchWrap borderBox">
			<li class="clearfix" style="margin:5px 0 15px;">
               <label class="text">供应商名称：</label>
                <span class="cont">
                <input type="text" id="name" name="supplierName"/>
                </span>
         <label class="labelText" style="margin-left:30px;">供应商区域：</label>
			  <span class="cont" id="chooseArea">
						<select class="mr20" id="province" name="baseAreaId">
							<option value="-1">-- 请选择 --</option>
						</select>
			  </span>
  
         <label class="labelText">类别：</label>
         <span class="cont">
         <select id="type" name="type">
           <option value="-1">请选择</option>
           <option value="材料">材料</option>
           <option value="餐饮">餐饮</option>
           <option value="住宿">住宿</option>
           <option value="交通">交通</option>
           <option value="其他">其他</option>
        </select>
      </span>
     </li>
   <li class="clearfix" style="margin:5px 0 15px;"> 
   <label class="text" style="margin-left:25px;">联系人：</label>
     <span class="cont">
       <input type="text" id="contactPersonName" name="linkPer"/>
     </span>
 <lable class="text" style="margin-left:48px;">联系电话：</lable>
    <span class="cont">
    <input type="text" id="contactPersonPhone" name="linkPhone"/>
    </span>
  
<label class="labelText">项目：</label>
   <span class="cont">
   <input type="text" id="projectName"/>
   </span>
   <span style="margin-left:20px;">
     <input type="button" id = "queryBtn" class="submit btn" name="query" value="查询" />
   </span>
  </li>
  </ul>
 <div class="totalPageBox">
  <div class="fr">
		<a id="addOrgUser" class="btn btnGreen" href="javascript:;">新增</a>
	    <a class="btn btnGreen" href="javascript:;" onclick="exportResourceList();">导出</a>
	</div> 
     总共<span class="totalNum">0</span> 条数据</div>
		<table class="tableBox">
			<tr>
				<th width="13%">供应商名称</th>
				<th width="5%">类别</th>
				<!-- <th width="5%">合作项目</th> -->
				<th width="15%">区域</th>
				<th width="15%">地址</th>
				<th width="5%">联系人</th>
				<th width="10%">联系电话</th>
				<th width="15%">服务内容</th>
				<th width="15%">备注</th>
				<th width="%7">操作</th>
			</tr>
		</table>
		<div id="pageNavi" class="pageNavi"></div>
	</div>
</div>
<script type="text/javascript">

//获得传来的变量
var baseAreaId='';
function getAreaValue(areaId){
	
	baseAreaId=areaId;
}

var mySplit = new SplitPage({
    node : $id("pageNavi"),
    url : "${root}/admin/arearesource/arearesourcepageList.do",
    data:{//向本url传递参数
    	
	},
    count : 20,
    callback : showList,
    type : 'post'
});

//total记录的总条数
function showList(data,totalCnt){
	
	var len = data.length;
	//alert("len="+len);
	var html = '';
	if(len>0){
		for(var i = 0; i< len; i++){
			var resObj = data[i];
			html += '<tr>';
			html += '<td>'+(resObj.name==null?'-':resObj.name)+'</td>';
			html += '<td>'+(resObj.type==null?'-':resObj.type)+'</td>';
			/* html += '<td><a href="javascript:;"   onclick="selectProject(\''+resObj.regionalResourceId+'\',\''+resObj.name+'\');">'+resObj.num+'</a></td>'; */
			html += '<td>'+(resObj.baseArea.areaPath==null?'-':resObj.baseArea.areaPath)+'</td>';
			html += '<td>'+(resObj.address==null?'-':resObj.address)+'</td>';
			html += '<td>'+(resObj.contactPersonName==null?'-':resObj.contactPersonName)+'</td>';
			html += '<td>'+(resObj.contactPersonPhone==null?'-':resObj.contactPersonPhone)+'</td>';
			html += '<td>'+(resObj.serviceContent==null?'-':resObj.serviceContent)+'</td>';
			html += '<td>'+(resObj.remark==null?'-':resObj.remark)+'</td>';
			html += '<td>';
		    html += '<a href="javascript:;" class="viewLink"  lang="'+resObj.regionalResourceId+'">编辑</a>&nbsp;&nbsp;';
		    html += '<a href="javascript:;" class="queryLink"   lang="'+resObj.regionalResourceId+'">查看</a>&nbsp;&nbsp;';
			html += '<a href="javascript:;" class="delLink"   lang="'+resObj.regionalResourceId+'">删除</a>';
			html += '</td>';
			html += '</tr>';
		}
	} else {
		html += '<tr><td colspan="10">抱歉！没有搜索到您想要的信息！</td></tr>';
	}
	$(".tableBox tr").not(":first").remove();
	$(".tableBox").append(html);		
	$(".totalNum").html(totalCnt);
}

//根据条件导出表
function exportResourceList(){
	
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
	var projectName=$("#projectName").val();	
	var baseAreaId = baseAreaId;
	var name=$("#name").val();
	var type=$("#type").val();
	var contactPersonName=$("#contactPersonName").val();
	var contactPersonPhone=$("#contactPersonPhone").val();
	var url = "${root }/admin/arearesource/exportRegionalResource.do?baseAreaId="+baseAreaId
			+"&name="+encodeURIComponent(name)
			+"&type="+encodeURIComponent(type)
			+"&contactPersonName="+encodeURIComponent(contactPersonName)
			+"&contactPersonPhone="+encodeURIComponent(contactPersonPhone)
			+"&projectName="+encodeURIComponent(projectName);
	window.location.href = url;
}

//按条件进行查询函数
function search(){
	var name=$("#name").val();
	var type=$("#type").val();
	var contactPersonName=$("#contactPersonName").val();
	var contactPersonPhone=$("#contactPersonPhone").val();
	var projectName=$("#projectName").val();
	var url="${root}/admin/arearesource/arearesourcepageList.do";
	var param  = {
			baseAreaId:baseAreaId,
			name:name,
			type:type,
			contactPersonName:contactPersonName,
			contactPersonPhone:contactPersonPhone,
			projectName:projectName
	};
	mySplit.search(url,param);
}

//根据提供商的id查看本用户的所有项目信息
function selectProject(id,supplyName){
	if($(".e")!=null){
		
		parent.editEngs={};
		  $(".e").each(function (){
			  parent.editEngs[this.id]=this.innerHTML;
		    });  
	}
	
	Win.open({id:"addOrgUserWin",url:"${root}/admin/arearesource/jumptoproject.do?supplier_Id="+id,title:"供应商"+supplyName+"历史合作项目",width:600,height:400,mask:true});
}


//点击删除按钮执行删除操作
  $(".tableBox").on("click",".delLink",function(){
  	var $resId = $(this).attr("lang");
  	//alert($resId);
  	delResource($resId);				
	});
  
  function delResource(resourceId){
		Win.confirm({mask:true,html:"确定要删除吗?"},function(){
			    var url = "${root}/admin/arearesource/deletearearesource.do?regionalResourceId="+resourceId;
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
  
  
  //点击编辑链接
  $(".tableBox").on("click",".viewLink",function(){
  	var $resId = $(this).attr("lang");
     
  	Win.open({id:"addOrgUserWin",url:"${root}/admin/area/jumptoeditpage.html?regionalResourceId="+$resId,title:"编辑资源",width:650,height:600,mask:true});
	});
  
  //点击查看对指定的资源详情
  $(".tableBox").on("click",".queryLink",function(){
  	var $resId = $(this).attr("lang");
     
  	Win.open({id:"addOrgUserWin",url:"${root}/admin/area/jumptodetailpage.html?regionalResourceId="+$resId,title:"资源详情",width:650,height:600,mask:true});
	});
  
  
  
  //条件查询操作
  $("#queryBtn").click(function(){
		search();
	});
  
  //点击新增按钮进行弹窗
	$("#addOrgUser").click(function(){
		//alert("ok!");
		Win.open({id:"addOrgUserWin",url:"${root}/admin/area/jumptoaddlist.html",title:"新增资源",width:550,height:600,mask:true});
	});
  
	 

</script> 						
</body>
</html>