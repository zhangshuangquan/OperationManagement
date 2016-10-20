<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
    <link href="${root}/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
     <script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
     <script src="${root}/public/js/jsTree.js" type="text/javascript"></script>
     <script src="${root }/public/js/customer.js" type="text/javascript"></script>
</head>
<body>
<h3 id="cataMenu">
	<a href="javascript:;">评课管理</a> &gt; <a href="javascript:;">评课活动回收站</a>
</h3>
	<form id="form">
<div id="control">
	<div id="controlContent">
		<ul class="searchWrap">
			<li>
	            <label class="labelText">发起时间：</label>
	            <input type="text" class="Wdate" id="createTimeStart" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeEnd\')}'});" value="" name="createTimeStart">
	            --
	            <input type="text" class="Wdate" id="createTimeEnd" onclick="WdatePicker({minDate:'#F{$dp.$D(\'createTimeStart\')}'})" value="" name="createTimeEnd">
	            <label class="labelText">活动开始时间：</label>
	            <input type="text" class="Wdate" id="startTimeStart" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'startTimeEnd\')}'});" value="" name="startTimeStart">
	            --
	            <input type="text" class="Wdate" id="startTimeEnd" onclick="WdatePicker({minDate:'#F{$dp.$D(\'startTimeStart\')}'});" value="" name="startTimeEnd">
	        </li>
	       	<li>
	        	<label class="labelText">
            	活动主题：</label><input type="text" value="" id="evaDescription" maxlength="20"  name="evaDescription">
            	<label class="labelText">
            	发起方：</label><input type="text" value="" id="showName" maxlength="20"  name="showName">
	       		<in>
         	</li>
	       	<li>
            <label class="labelText">删除日期：</label>
	            <input type="text" class="Wdate" id="deleteTimeStart" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'deleteTimeEnd\')}'});" value="" name="deleteTimeStart">
	            --
	            <input type="text" class="Wdate" id="deleteTimeEnd" onclick="WdatePicker({minDate:'#F{$dp.$D(\'deleteTimeStart\')}'});" value="" name="deleteTimeEnd">
	       		<input type="button" class="submit btn" name="query" value="查询"  onclick = "listAsync(1);"/>
	       	</li>
	    </ul>
		</form>
	  	<div class="totalPageBox">总共<span class="totalNum">0</span> 条数据</div>
		<table class="tableBox">
			<tr>
				<th width="16%">发起时间</th>
                <th width="16%">活动开始时间</th>
                <th width="20%">活动主题</th>
                <th width="16%">发起方</th>
                <th width="16%">删除时间</th>
                <th width="14%">操作</th>
			</tr>
			<tbody id="mals">
			</tbody>
	</table>
	<div id="pageNavi"></div>
</div>
</div>	 	
<script>
var currPage=1;
//动态的创建一个table，同时将后台获取的数据动态的填充到相应的单元格  
function createShowingTable(data,total,req) {
	$(".totalNum").html(total);
	 //获取后台传过来的jsonData,并进行解析  
	//alert("-----   进入当前的数据展现:" + data.pageCount);
	var dataArray = data;
	//此处需要让其动态的生成一个table并填充数据  
	var tableStr = "";
	var len = dataArray.length;
	if (len > 0) {
		 for ( var i = 0; i < len; i++) {
			tableStr += "<tr><td>"+dataArray[i].createTime
				+ "</td><td>" + (dataArray[i].startTime == null ?'':dataArray[i].startTime)
				+ "</td><td>" + (dataArray[i].evaTitle == null ?'':dataArray[i].evaTitle)
				+ "</td><td>" + (dataArray[i].showName == null ?'':dataArray[i].showName)
				+ "</td><td>" + (dataArray[i].deleteTime== null ?'':dataArray[i].deleteTime)
				+ "</td><td><a href='${root}/admin/evaCenter/toviewevadel.html?id="+dataArray[i].evaEvaluationId+"'>查看</a>" ;
		} 	
	} else {
		tableStr += '<tr><td colspan="14">抱歉，未查询到相关记录</td></tr>';
	}
 
	//alert(tableStr);
	$("#mals").html(tableStr||'<tr/>');
	window.scrollTo(0,0);
	
	$("a.assignExam").click(function(){
		popAssignExam($(this).attr("value"));
		return false;
	}); 
	$("a.delExam").click(function(){
		delExamAsync($(this).attr("value"));
	}); 
	
}
 

$(function() {
	listAsync(1);
});

function listAsync( currentPage) {
		var formdata = $("#form").serialize();
		currPage=currentPage;
		var criteria = {
				'currentPage' : currentPage
			};
	    var url = '${root}/admin/evaCenter/searchdellist.do?'+formdata;
		 var mySplit = new SplitPage({
		        node : $id("pageNavi"),
		        url : url,
		        data :  criteria,
		        count : 20,
		        callback : createShowingTable,
		        type : 'get' //支持post,get,及jsonp
		    });			 
	
		 mySplit.search(url,criteria);
}



</script>
</body>
</html>