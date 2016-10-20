<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script>
	$(document).ready(
			function() {
				$.post("${root}/admin/teacherLessonStatistic/getAreaByParentId.do",
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
						"${root}/admin/teacherLessonStatistic/getAreaByParentId.do",
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

		var url = '${root}/admin/teacherLessonStatistic/searchPageList.do';
		var startTime = $("#startTime").val();
		var endTime = $("#endTime").val();
		
		if(toDate(startTime) > toDate(endTime)) {
			Win.alert({html:"<span class=\"dialog_Inner\">开始时间不能大于结束时间</span>",width:"200px"});
			return;
		}
		
		var schoolName = $("#schoolName").val();
		var semester = $("#semester").val();
		
		var criteria = {
			"baseAreaId" : baseAreaId,
			"startTime" : startTime ,
			"endTime" : endTime,
			"schoolName": schoolName,
			"semester": semester,
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
				tableStr = tableStr + "<tr><td>" +  dataArray[i].teacher
						+ "</td><td>" + dataArray[i].school 
						+ "</td><td>" + dataArray[i].semester
						+ "</td><td>" + dataArray[i].subject
						+ "</td><td>" + dataArray[i].area
						+ "</td><td>" + dataArray[i].planScheduleCount
						+ "</td><td>" + dataArray[i].requiredScheduleCount
						+ "</td><td>" + dataArray[i].startedScheduleCount
						+ "</td><td>" + multiply(dataArray[i].schedulePercent, 100) + '%'
						+ "</td></tr>";
			}
		} else {
			tableStr += '<tr><td colspan="9">暂无资源信息</td></tr>';
		}

		$("#teacherLessonStatistic").html(tableStr);
		window.scrollTo(0, 0);
	}
	
	function multiply(arg1, arg2) {
	    var m = 0; //扩大后的两数相乘比初始值相乘扩大的倍数
	    var s1 = arg1.toString();
	    var s2 = arg2.toString();

	    try {
	        //获取第一个参数的小数部分长度，去掉小数点后，小数部分的长度就是初始值的小数点右移的位数
	        m += s1.split(".")[1].length;
	    } catch (e) {
	    }

	    try {
	        ////获取第二个参数的小数部分长度，去掉小数点后，小数部分的长度就是初始值的小数点右移的位数
	        m += s2.split(".")[1].length;
	    } catch (e) {
	    }

	    //返回值：将参数的小数点去掉然后相乘，最后除以Mah.pow(10,m)
	    return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
	}
</script>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">授课统计</a> &gt; <a href="javascript:;">教师授课统计</a>
	</h3>
	<div id="control">
		<div id="controlContent">
			<ul class="searchWrap">
				
				<li>
				<span> 
					<input id="schoolName" name="schoolName" type="text" placeholder="学校" />
			 	</span>
			 	
			 	<span> 
				 	<select id="semester" name="semester">
						<option value="">学段</option>
						<c:forEach items="${semesterList }" var="semester">
							<option value="${semester.baseSemesterId }">${semester.semesterName }</option>
						</c:forEach>
					</select>
				</span>
				
				<!--  <label class="labelText">&nbsp;</label> 
				<span> 
					<label class="mr10"><input type="radio" name="dateTyupe" value="day">日</label> 
					<label class="mr10"><input type="radio" name="dateTyupe" value="week">周</label> 
					<label class="mr10"><input type="radio" name="dateTyupe" value="month">月</label> 
				</span>-->
				
				<span> 
					<label class="labelText">开始时间：</label> 
						<input	type="text" class="Wdate" id="startTime" name="startTime"	onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'#F{$dp.$D(\'endTime\')}'});" value="" />
					<label class="labelText">结束时间：</label>
						<input type="text"	class="Wdate mr20" id="endTime" name="endTime"	onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'#F{$dp.$D(\'startTime\')}'});" value="" />
					
			 	</span>
			 	
			 		
				<label class="labelText">行政区：</label> 
				<span class="cont"
					id="areaSelectId"> <select class="mr20" id="provinceId"
						name="province">
							<option value="-1">请选择</option>
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
					<th width="5%">教师</th>
					<th width="10%">学校</th>
					<th width="10%">学段</th>
					<th width="8%">开课学科</th>
					<th width="8%">地区</th>
					<th width="8%">计划开课数</th>
					<th width="8%">应开课节数</th>
					<th width="8%">实开课节数</th>
					<th width="8%">开课节数比例</th>
				</tr>
				<tbody id="teacherLessonStatistic"></tbody>
			</table>
			<div id="pageNavi"></div>
			<script>
				var mySplit = new SplitPage({
					node : $id("pageNavi"),
					url : '${root}/admin/teacherLessonStatistic/searchPageList.do',
					count : 20,
					callback : createShowingTable
				});
			</script>
		</div>
	</div>
</body>
</html>