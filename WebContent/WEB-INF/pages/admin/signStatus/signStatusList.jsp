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
		
		var splitPage;
		 var flag="DESC";
		 $("#sequence").attr("value",flag); //给默认的文本框填值
	});
</script>
</head>
<body>
<h3 id="cataMenu">
		<a href="javascript:;">人员管理</a> &gt; <a href="javascript:;">人员状态表</a>
</h3>
  <div id="control">
		<div id="controlContent">
		<ul class="searchWrap borderBox">
		<li class="clearfix">
           <label class="labelText">区域：</label>
					<span class="cont" id="chooseArea">
						<select class="mr20" id="province">
							<option value="-1">请选择</option>
						</select>
					</span>
					
	        <label class="labelText">项目：</label>
	        <span class="cont">
			  <input type="text" id="projectName"/>
			</span>
        </li>
        <li class="clearfix">
          <label class="labelText">姓名：</label>
          <input type="hidden" id="sequence" value="ASC"/><!--添加排序的类别-->
          <span>
            <input type="text" id="userName"/>
          </span>
          <label class="labelText">职位：</label>
          <span>
            <input type="text" id="position"/>
          </span>
          <label class="labelText">状态：</label>
          <span class="cont">
             <select id="status">
               <option value="">请选择</option>
                <option value="正常办公">正常办公</option>
               <option value="出差">出差</option>
               <option value="休假">休假</option>
               <option value="售后">售后</option>
            </select>
         </span>
         <span style="margin-left:20px;">
          <input type="button" id ="queryBtn" class="submit btn" name="query" value="查询" />
          </span>
        </li>  
   </ul> 
	  
    <div class="totalPageBox">
     <div class="fr">
	    <a class="btn btnGreen" style="margin-right:50px;" href="javascript:;" onclick="exportSignList();">导出</a>
	</div>  
         总共<span class="totalNum">0</span> 条数据</div>
		<table class="tableBox">
			<tr>
				<th width="10%">姓名</th>
				<th width="10%">职位</th>
				<th width="12%">最新签到时间<a sortType="status" sortdesc="ASC" class="sortBtn" href="javascript:;">↑↓</a></th>
				<th width="8%">最新状态</th>
				<th width="25%">最新位置</th>
				<th width="15%">项目</th>
				<th width="10%">工单</th>
				<th width="10%">历史签到记录</th>
			</tr>
			<tbody id="tbody"></tbody>
		</table>
		<div id="pageNavi" class="pageNavi"></div> 
		 </div>
  </div>
		<script type="text/javascript">
		//获得签到表列表
	   	var mySplit = new SplitPage({
	    node : $id("pageNavi"),
	    url :"${root}/admin/personsigncontroller/showsignmessage.do?sortDesc=DESC",
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
					html += '<td>'+(resObj.username==null?'-':resObj.username)+'</td>';
					html += '<td>'+(resObj.position==null?'-':resObj.position)+'</td>';
					html += '<td>'+(resObj.newSignTime==null?'-':resObj.newSignTime)+'</td>';
					html += '<td>'+(resObj.status==null?'-':resObj.status)+'</td>';
					html += '<td>'+(resObj.area_path==null?'-':resObj.area_path)+'</td>';
					html += '<td>'+(resObj.project_name==null?'-':resObj.project_name)+'</td>';
					html +='<td><a href="javascript:;" lang="'+(resObj.maintenanceOrderId==null?"no":resObj.maintenanceOrderId)+'" class="openOrderDetail">'+(resObj.orderNum==null?'-':resObj.orderNum)+'</a></td>';
					html += '<td>';
				    html += '<a href="javascript:;" class="viewLink"  lang="'+resObj.admin_user_id+'">查看</a>&nbsp;&nbsp;';
					html += '<a  href="javascript:;" onclick="exportSignDetailList(\''+resObj.admin_user_id+'\');">导出</a>';
					html += '</td>';
					html += '</tr>'; 
				}
			} else {
				html += '<tr><td colspan="8">抱歉！没有搜索到您想要的信息！</td></tr>';
			}
			$("#tbody").html(html);//将拼接好的数据放置到表格体中		
			$(".totalNum").html(totalCnt);
		}
		
		
		
	//条件查询操作
		  $("#queryBtn").click(function(){
			  //alert("ok");
				search();
			});
		  
			//按条件进行查询函数
		  function search(sortDesc){
			//获得选中的行政区
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
			var sortDesc=$("#sequence").val();
		  	var projectArea=baseAreaId;
		  	var projectName=$("#projectName").val();
		  	var userName=$("#userName").val();
		  	var position=$("#position").val();
		  	var status=$("#status").val();
		  	var url="${root}/admin/personsigncontroller/showsignmessage.do?sortDesc="+sortDesc;
		  	var param  = {
		  			projectArea:projectArea,
		  			projectName:projectName,
		  			userName:userName,
		  			position:position,
		  			status:status
		  	};
		  	mySplit.search(url,param);
		  }
			
		
		  //点击查看链接
		  
		  $(".tableBox").on("click",".viewLink",function(){
		  	var $resId = $(this).attr("lang");
		      
		  	//alert("ok");
		  	Win.open({id:"addOrgUserWin",url:"${root}/admin/personsigncontroller/jumptosigndetail.do?userId="+$resId,title:"签到历史记录",width:600,height:400,mask:true});
			});
		  
		  //查看工单详情 openOrderDetail
		    $(".tableBox").on("click",".openOrderDetail",function(){
		  	var $maintenanceOrderId = $(this).attr("lang");
		  	if("no"!=$maintenanceOrderId){
		  		Win.open({id:"addOrgUserWin",url:"${root}/admin/maintenanceorder/jumptorepmanagedetail.html?maintenanceOrderId="+$maintenanceOrderId,title:"售后保障记录",width:800,height:550,mask:true});
		  	}
		  	
			});
		  
	 /* 对表格头进行点击正反排序 */
			$(".sortBtn").click(function(){
				sortDesc = this.getAttribute("sortdesc");
				sortType = this.getAttribute("sortType");
				if(sortDesc == "ASC"){
					$(".sortBtn").html("↑↓");
					this.setAttribute("sortdesc","DESC");
					$(this).html("↓");
				}else{
					this.setAttribute("sortdesc","ASC");
					$(this).html("↑");
				}
				$("#sequence").attr("value",sortDesc); //给默认的文本框填值
				//alert("sortDesc=="+sortDesc);
				search(sortDesc) ;
			
			});
	 
	 
	 
	 //进行最新人员签到的导出操作
			function exportSignList(){
		 
				//获得选中的行政区
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
				var sortDesc=$("#sequence").val();
			  	var projectArea=baseAreaId;
			  	var projectName=$("#projectName").val();
			  	var userName=$("#userName").val();
			  	var position=$("#position").val();
			  	var status=$("#status").val();
				
				var url = "${root }/admin/personsigncontroller/exportnewsignlist.do?projectArea="+projectArea+"&projectName="+projectName+"&userName="+userName+"&position="+position+"&status="+status+"&sortDesc="+sortDesc;
				window.location.href = url;
			}
	 
	//进行指定工程师参与的所有项目
			function exportSignDetailList(userId){

				var url = "${root }/admin/personsigncontroller/exportsigndetaillist.do?userId="+userId;
				window.location.href = url; 
			}
		
		</script>   
</body>
</html>