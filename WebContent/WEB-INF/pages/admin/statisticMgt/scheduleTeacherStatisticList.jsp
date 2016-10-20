<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script>
	$(document).ready(
			function() {
				$.post("${root}/admin/scheduleTeacherStatistic/getAreaByParentId.do",
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
						"${root}/admin/scheduleTeacherStatistic/getAreaByParentId.do",
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

		var url = '${root}/admin/scheduleTeacherStatistic/searchPageList.do';
		var startTime = $("#startTime").val();
		var endTime = $("#endTime").val();
		
		if(toDate(startTime) > toDate(endTime)) {
			Win.alert({html:"<span class=\"dialog_Inner\">开始时间不能大于结束时间</span>",width:"200px"});
			return;
		}
		
		var stateType = $("#stateTypeId").val();
		
		var criteria = {
			"baseAreaId" : baseAreaId,
			"startTime" : startTime ,
			"endTime" : endTime,
			"stateType": stateType
		};
		mySplit.search(url, criteria);
	}
	
    function toDate(strDate) {
    	var sd=strDate.split("-");
        return new Date(sd[0],sd[1],sd[2]);
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
						+ "</td><td>" + dataArray[i].teacherCount 
						+ "</td><td>" + dataArray[i].chineseCount
						+ "</td><td>" + dataArray[i].mathCount
						+ "</td><td>" + dataArray[i].englishCount
						+ "</td><td>" + dataArray[i].chemistryCount
						+ "</td><td>" + dataArray[i].physicsCount
						+ "</td><td>" + dataArray[i].peCount
						+ "</td><td>" + dataArray[i].geogCount
						+ "</td></tr>";
			}
		} else {
			tableStr += '<tr><td colspan="10">暂无资源信息</td></tr>';
		}

		$("#scheduleTeacherStatistic").html(tableStr);
		window.scrollTo(0, 0);
	}
</script>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">授课统计</a> &gt; <a href="javascript:;">开课教师统计</a>
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
				
				<!--<label class="labelText">&nbsp;</label> 
				<span> 
					<label class="mr10"><input type="radio" name="dateTyupe" value="day">日</label> 
					<label class="mr10"><input type="radio" name="dateTyupe" value="week">周</label> 
					<label class="mr10"><input type="radio" name="dateTyupe" value="month">月</label> 
				</span> -->
				
				<span> 
					<label class="labelText">开始时间：</label> 
						<input	type="text" class="Wdate" id="startTime" name="startTime"	onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'#F{$dp.$D(\'endTime\')}'});" value="" />
					<label class="labelText">结束时间：</label>
						<input type="text"	class="Wdate mr20" id="endTime" name="endTime"	onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'#F{$dp.$D(\'startTime\')}'});" value="" />
					
			 	</span>
			 	
			 	<span>
			 		<label class="labelText">统计方式：</label> 
			 		<select id="stateTypeId" name="stateType" class="mr20">
								<option value="area">按区域统计</option>
								<option value="school">按学校统计</option>
					</select>
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
					<th width="15%">地区</th>
					<th width="10%">教师总数</th>
					<th width="10%">语文</th>
					<th width="8%">数学</th>
					<th width="8%">英语</th>
					<th width="8%">化学</th>
					<th width="8%">物理</th>
					<th width="8%">体育</th>
					<th width="8%">地理</th>
				</tr>
				<tbody id="scheduleTeacherStatistic"></tbody>
			</table>
			<div id="pageNavi"></div>
			<script>
				var mySplit = new SplitPage({
					node : $id("pageNavi"),
					url : '${root}/admin/scheduleTeacherStatistic/searchPageList.do',
					count : 20,
					callback : createShowingTable
				});
			</script>
		</div>
	</div>
</body>
</html>