<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
</head>
<body>
<h3 id="cataMenu">
	<a href="javascript:;">评课管理</a> &gt; <a href="javascript:;">评估标准回收站</a>
</h3>
	<div id="control">
		<div id="controlContent">
			<div class="borderBox">
				<ul class="sortWrap">
					<li>
						<label class="labelText"><b>新增日期：</b></label> 
						<input	type="text" class="Wdate" id="createTimeStart" name="createTimeStart"	onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'#F{$dp.$D(\'createTimeEnd\')}'});" value="" />
						 至
						<input type="text"	class="Wdate mr20" id="createTimeEnd" name="createTimeEnd"	onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'#F{$dp.$D(\'createTimeStart\')}'});" value="" />
					</li>
				
					<li>
						<label class="labelText"><b>名称：</b></label>
						<input type="text" id="evaStandardName" name="evaStandardName" value="" />
						
						<label class="labelText">学科：</label>
						<select id="baseSubjectId" name="baseSubjectId">
							<option value="">请选择</option>
							<c:forEach items="${subjectList}" var="item" varStatus="vs">
								<option value="${item.baseSubjectId}">${item.subjectName}</option>
							</c:forEach>
						</select>
					</li>
				
					<li>
						<label class="labelText"><b>删除日期：</b></label> 
						<input	type="text" class="Wdate" id="deleteTimeStart" name="deleteTimeStart"	onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'#F{$dp.$D(\'deleteTimeEnd\')}'});" value="" />
						 至
						<input type="text"	class="Wdate mr20" id="deleteTimeEnd" name="deleteTimeEnd"	onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'#F{$dp.$D(\'deleteTimeStart\')}'});" value="" />
						<input type="button" id="queryBtn" class="submit btn" name="query"	value="查询" />
					</li>
				</ul>
			</div>
			<div class="totalPageBox">
				总共<span class="totalNum">0</span>条数据
			</div>
			<table class="tableBox">
				<tr>
					<th width="10%">新增时间</th>
					<th width="15%">名称</th>
					<th width="10%">撰写方</th>
					<th width="5%">学科</th>
					<th width="5%">总分</th>
					<th width="5%">公开权限</th>
					<th width="10%">删除时间</th>
					<th width="10%">操作</th>
				</tr>
				<tbody id="evaStandards"></tbody>
			</table>
			<div id="pageNavi"></div>
		</div>
	</div>
</body>
<script>

var mySplit = new SplitPage({
	node : $id("pageNavi"),
	url : '${root}/admin/evaStandardRecycle/list.do',
	count : 20,
	callback : createShowingTable
});
function createShowingTable(data, total) {
	$(".totalNum").html(total);
	var dataArray = data;
	var tableStr = "";
	var len = dataArray.length;
	if (len > 0) {
		for (var i = 0; i < len; i++) {
			tableStr = tableStr + "<tr><td>" + now('y-m-d h:i:s',dataArray[i].createTime)
			+ "</td><td>" + dataArray[i].standardName
			+ "</td><td>" + dataArray[i].baseUserName
			+ "</td><td>" + dataArray[i].subjectName
			+ "</td><td>" + dataArray[i].totalScore;
			if(dataArray[i].availableScope == 'PUBLIC'){
				tableStr += "</td><td>公开" ;
			}else{
				tableStr += "</td><td>私有" ;
			}
			tableStr += "</td><td>" + now('y-m-d h:i:s',dataArray[i].deleteTime)
						+ "</td><td> " +
							"<a href=\"javascript:doView('" + dataArray[i].standardId  + "','"+dataArray[i].standardName+"');\">查看</a>"
						+ "</td></tr>";
		}
	} else {
		tableStr += '<tr><td colspan="20">抱歉！没有搜索到您想要的信息！</td></tr>';
	}

	$("#evaStandards").html(tableStr);
	window.scrollTo(0, 0);
}


function search(){
	var url  = '${root}/admin/evaStandardRecycle/list.do';
	var createTimeStart = $("#createTimeStart").val();
	var createTimeEnd = $("#createTimeEnd").val();
	var name = $("#evaStandardName").val();
	var baseSubjectId = $("#baseSubjectId").val();
	var deleteTimeStart = $("#deleteTimeStart").val();
	var deleteTimeEnd = $("#deleteTimeEnd").val();
	var param  = {
			createTimeStart:createTimeStart,
			createTimeEnd:createTimeEnd,
			name:name,
			baseSubjectId:baseSubjectId,
			deleteTimeStart:deleteTimeStart,
			deleteTimeEnd:deleteTimeEnd
	};
	mySplit.search(url,param);
}
function doView(standardId,standardName) {
	Win.open({
		title : standardName,
		url : '${root}/admin/evaStandardRecycle/view.html?standardId=' + standardId,
		mask : true,
		width : "800",
		height : "800"
	});
}

function bindEvent(){
	$("#queryBtn").click(function(){
		search();
	});
}
$(function(){
	bindEvent();
});
</script>
</html>