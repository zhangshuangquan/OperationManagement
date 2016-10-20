<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script>
	$(document).ready(
			function() {
				$.post("${root}/admin/scheduleStatistic/getAreaByParentId.do",
						{
							"parentId" : ""
						}, function(data) {
							var html = '<option value="-1">请选择</option>';
							for ( var i = 0, j = data.length; i < j; i++) {
								html += '<option value="'+data[i].id+'">'
										+ data[i].name + '</option>';
							}
							$("#provinceId").html(html);
						}, 'json');
				selectBind("areaSelectId",
						"${root}/admin/scheduleStatistic/getAreaByParentId.do",
						"parentId");
	});

	
	function doSearch() {
		var areas = $("#areaSelectId select");
		var areaLength = areas.length;
		var baseAreaId = "";
		var baseAreaId1 = "";
		if (areaLength == 1) {
			baseAreaId = $(areas[0]).val();
		} else {
			baseAreaId = $(areas[areaLength - 2]).val();
			baseAreaId1 = $(areas[areaLength - 1]).val();
			if ("-1" != baseAreaId1) {
				baseAreaId = baseAreaId1;
			}
		}

		var url = '${root}/admin/scheduleStatistic/searchPageList.do';
		var startTime = $("#startTime").val();
		var endTime = $("#endTime").val();
		var subject = $("#subject").val();
		
		var criteria = {
			"baseAreaId" : baseAreaId,
			"startTime" : startTime ,
			"endTime" : endTime,
			"subject" : subject
		};
		mySplit.search(url, criteria);
	}

	function createShowingTable(data, total) {
		$(".totalNum").html(total);
		//获取后台传过来的jsonData,并进行解析  
		//alert("-----   进入当前的数据展现:" + data.pageCount);
		var dataArray = data;

		//此处需要让其动态的生成一个table并填充数据  
		var tableStr = "";
		var len = dataArray.length;
		if (len > 0) {
			for ( var i = 0; i < len; i++) {
				tableStr = tableStr + "<tr><td>" +  dataArray[i].area
						+ "</td><td>" + dataArray[i].masterClassroomCount 
						+ "</td><td>" + dataArray[i].scheduleMasterClassroomCount
						+ "</td><td>" + dataArray[i].masterClassroomPercent*100 + '%'
						+ "</td><td>" + dataArray[i].planScheduleCount
						+ "</td><td>" + dataArray[i].requiredLessonCount
						+ "</td><td>" + dataArray[i].startedLessonCount
						+ "</td><td>" + dataArray[i].lessonPercent*100 + '%'
						+ "</td></tr>";
			}
		} else {
			tableStr += '<tr><td colspan="8">暂无资源信息</td></tr>';
		}

		$("#scheduleStatistic").html(tableStr);
		window.scrollTo(0, 0);
	}
</script>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">授课统计</a> &gt; <a href="javascript:;">开课数统计</a>
	</h3>
	<div id="control">
		<div id="controlContent">
			<ul class="searchWrap">
				<li><label>行政区：</label> 
				<span class="cont"
					id="areaSelectId"> <select class="mr20" id="provinceId"
						name="province">
							<option value="-1">请选择</option>
					</select>
				</span> 
				
				<span> 
				 	<select id="subject" name="subject">
						<option value="">学科</option>
						<c:forEach items="${subjects }" var="subject">
							<option value="${subject.baseSubjectId }">${subject.subjectName }</option>
						</c:forEach>
					</select>
				</span>
				
				<label class="labelText">&nbsp;</label> 
				<span> 
					<label class="mr10"><input type="radio" name="dateTyupe" value="day">日</label> 
					<label class="mr10"><input type="radio" name="dateTyupe" value="week">周</label> 
					<label class="mr10"><input type="radio" name="dateTyupe" value="month">月</label> 
				</span>
				<span> 
					<label class="labelText">开始时间：</label> 
						<input	type="text" class="Wdate" id="startTime" name="startTime"	onclick="WdatePicker();" value="" />
					<label class="labelText">结束时间：</label>
						<input type="text"	class="Wdate mr20" id="endTime" name="endTime"	onclick="WdatePicker();" value="" />
					
			 	</span>
			 	
			 	<span> 
					 <input
						type="button" class="submit btn" name="query"
						onclick="doSearch();" value="查询" />
				</span>
			 	
			 	</li>
				
			</ul>

			
			<div class="totalPageBox">
				总共<span class="totalNum">0</span>条数据
			</div>
			<table class="tableBox">
				<tr>
					<th width="5%">地区</th>
					<th width="10%">主讲教室数</th>
					<th width="10%">开课主讲教室数</th>
					<th width="8%">主讲课堂开课比例</th>
					<th width="8%">计划开课数</th>
					<th width="8%">应开课节数</th>
					<th width="8%">实开课节数</th>
					<th width="8%">开课节数比例</th>
				</tr>
				<tbody id="scheduleStatistic"></tbody>
			</table>
			<div id="pageNavi"></div>
			<script>
				var mySplit = new SplitPage({
					node : $id("pageNavi"),
					url : '${root}/admin/scheduleStatistic/searchPageList.do',
					count : 20,
					callback : createShowingTable
				});
			</script>
		</div>
	</div>
</body>
</html>