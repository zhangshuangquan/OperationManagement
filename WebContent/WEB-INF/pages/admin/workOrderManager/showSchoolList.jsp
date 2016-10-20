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
</script>
</head>
<body>
<input type="hidden" id="schoolArea" value="${requestScope.SchoolBaseAreaId}"/>
<input type="hidden" id="projId" value="${requestScope.projId}"/>
<div class="commonWrap" style="">
			<ul class="commonUL">
				<li>
		<!-- 查询必须使用input的button-->
				&nbsp;学校名称:<input type="text" id="schoolName"/>&nbsp;<input type="button" id = "queryBtn" class="submit btn" name="query" value="搜索" /><br/><hr/>
			   </li>
			</ul>
		<div class="totalPageBox">
				 <div class="totalPageBox">总共<span class="totalNum">0</span> 条项目</div> 
			</div>
		 <table class="tableBox">
			<tr>
				<th width="30%">学校名称</th>
				<th width="30%">学校区域</th>
				<th width="30%">项目</th>
				<th width="10%">操作</th>
			</tr>
			<tbody id="pageBody">
			</tbody>
		</table>
		<div id="pageNavi" class="pageNavi"></div>
	</div>
	  				
	
<script type="text/javascript">
    var schoolArea=$("#schoolArea").val();
    var projId=$("#projId").val();
	var mySplit = new SplitPage({
	    node : $id("pageNavi"),
	    url :"${root}/admin/workorder/searchschoolpagelist.do?schoolArea="+schoolArea+"&projId="+projId,
	    data:   {
		},
	    count : 10,
	    callback : showList,
	    type : 'post'
	});
	
	//回调
	function showList(data,totalCnt){
		var len = data.length;
		var html = '';
		//console.log(data);
	   if(len>0){
		   for(var i=0; i<len; i++){
			    html+='<tr>';
				html+='<td>'+(data[i].schoolName==null?'-':data[i].schoolName)+'</td>';
				html+='<td>'+(data[i].schoolPath==null?'-':data[i].schoolPath)+'</td>';
				html+='<td>'+(data[i].projectName==null?'-':data[i].projectName)+'</td>';
				html+='<td><input type="button" class="btn" onclick="selecArea(\''+data[i].schoolAreaPathId+'\',\''+data[i].schoolAreaPath+'\',\''+data[i].projAreaPath+'\',\''+data[i].projAreaPathId+'\',\''+data[i].schoolName+'\',\''+data[i].projectName+'\',\''+data[i].projectId+'\',\''+data[i].schoolId+'\')" value="选择"/></td>';
				html+='</tr>';
		   } 
		   
	   }else{
		        html += '<tr><td colspan="6">抱歉！没有搜索到您想要的信息！</td></tr>';
	   } 
	   $("#pageBody").html(html);//将拼接好的数据放置到表格体中		
	   $(".totalNum").html(totalCnt);
	 }
	
	//按条件进行查询函数
	function search(){
		//获得搜索的学校名
		var schoolName=$("#schoolName").val();
		var url="${root}/admin/workorder/searchschoolpagelist.do";
		var param  = {
				'schoolName':schoolName,
				'schoolArea':schoolArea,
				'projId':projId
		};
		mySplit.search(url,param);
	}
	
 
	//点击按钮按学校名称进行搜索
	 $("#queryBtn").click(function(){
			search();
		});
	
	//点中选择
	 function selecArea(schoolAreaPathId,schoolAreaPath,projAreaPath,projAreaPathId,schoolName,projectName,projectId,schoolId){
		 
	     //给父页面的函数传递参数
	     var AreaInfo=[schoolAreaPathId,schoolAreaPath,projAreaPath,projAreaPathId,schoolName,projectName,projectId,schoolId]
		 parent.showArea({
	     		area:AreaInfo
		     });
		 closeMe();
	}
	
	//关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
	

	</script>			
					
</body>
</html>