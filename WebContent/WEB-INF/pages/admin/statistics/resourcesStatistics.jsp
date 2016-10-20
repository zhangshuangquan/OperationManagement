<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="../../common/meta.jsp"%>
	<script type="text/javascript" src="${root }/public/calendar/WdatePicker.js"></script>
	<script type="text/javascript" src="${root }/public/js/customer.js"></script>
	<script type="text/javascript" src="${root }/public/highcharts/highcharts.js"></script>
	<script type="text/javascript" src="${root }/public/highcharts/modules/no-data-to-display.js"></script>
	<%-- <script type="text/javascript" src="${root }/public/js/evaluation.js"></script> --%>
	<script type="text/javascript" src="${root }/public/js/resourcesStatistics.js"></script>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">统计管理</a> &gt; <a href="javascript:;">资源统计</a>
	</h3>
	<div id="control">
		<div id="controlContent">
			<ul class="searchWrap borderBox">
				<li>
					<label class="labelText">时间：</label>
					<input id="startTime" type="text" class="Wdate" name="stime" onclick="startFocus(this) ;" value="" />
					--
					<input id="endTime" type="text" class="Wdate mr20" name="etime" onclick="endFocus(this) ;" value="" />
				</li>
				<li>
					<label class="labelText">行政区：</label>
					<span id="areaSelect">
						<select class="mr20" id="level1">
							<option value="-1">请选择</option>
						</select>
					</span>
					<input type="button" id="search" class="submit btn" value="查询" />
				</li>
				<li>
					<label class="labelText">资源分类：</label>
					<span class="sortBox" id="resourceCategory">
					 	<a class="selected" href="javascript:;" lang="-1">全部</a>
					</span>
				</li>
				<li>
					<label class="labelText">学段：</label>
					<span class="sortBox" id="semester">
					 	<a class="selected" href="javascript:;" lang="-1">全部</a>
					</span>
				</li>
			</ul>
			<div id="content">
				<h4 class="totalPageBox pd10" id="top">&nbsp;</h4>
				<div class="statistics fl" id="statistics1"></div>
				<div class="statistics fl" id="statistics2"></div>
				<div class="statistics fl" id="statistics3"></div>
				<div class="statistics fl" id="statistics4"></div>
				<div class="statistics fl" id="statistics5"></div>
				<div class="statistics fl" id="statistics6"></div>
				<div class="statistics fl statisticsList" id="statistics7">
					<h5>学校Top10</h5>
					<table class="tableBox center" id="tableBox1">
						<thead>
							<tr>
								<th width="10%">排名</th>
								<th width="70%">学校</th>
								<th width="20%">资源数</th>
							</tr>
						</thead>
						<tbody id="schoolT">
							
						</tbody>
					</table>
				</div>
				<div class="statistics fl statisticsList" id="statistics8">
					<h5>教师Top10</h5>
					<table class="tableBox center" id="tableBox2">
						<thead>
							<tr>
								<th width="10%">排名</th>
								<th width="20%">教师</th>
								<th width="50%">学校</th>
								<th width="20%">资源数</th>
							</tr>
						</thead>
						<tbody id="teacherT">
							
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		// ============================================  函数调用  =================================
		$(document).ready(function(){
			// === 初始化行政区
			$.post("${root}/admin/statistics/getAreaByparentId.do",{"parentId":"-1"},function(data){
				var html = '<option value="-1">请选择</option>';
				for(var i = 0,j = data.length; i<j; i++){
					html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
				}
				$("#level1").html(html);
			},'json');
			selectBind("areaSelect","${root}/admin/statistics/getAreaByparentId.do","parentId");
			
			// === 初始化资源分类
			$.post("${root}/admin/commons/getResourcesCategory.do",function(data){
				for(var i =0, j= data.length; i<j; i++){
					var html = '<a lang="'+data[i].resourceCategoryId+'" href="javascript:;">'+data[i].resourceCategoryName+'</a>';
					$("#resourceCategory").append(html);
				}
			}, "json");
			
			// === 初始化学段
			$.post("${root}/admin/statistics/getSemester.do",function(data){
				for(var i =0, j= data.length; i<j; i++){
					var html = '<a lang="'+data[i].baseSemesterId+'" href="javascript:;">'+data[i].semesterName+'</a>';
					$("#semester").append(html);
				}
			});
			
			// === 初始化条件选择
			var startTime 		= $("#startTime").val() ;
			var endTime 		= $("#endTime").val() ;
			var categoryId 		= $("#resourceCategory .selected").attr("lang") ;
			var baseSemesterId 	= $("#semester .selected").attr("lang") ;
			var areas = $("#areaSelect select");
			var areaLength = areas.length;
			var baseAreaId = "";
			var baseAreaId1 = "";
			if(areaLength == 1){
				baseAreaId = $(areas[0]).val();
			}else{
				baseAreaId = $(areas[areaLength-2]).val();
				baseAreaId1 =$(areas[areaLength-1]).val();
				if("-1" != baseAreaId1){
					baseAreaId = baseAreaId1;
				}
			}
			
			var data = {
					startTime		:	startTime ,
					endTime			:	endTime ,
					categoryId		:	categoryId ,
					baseSemesterId	:	baseSemesterId ,
					baseAreaId		:	baseAreaId
			} ;
			
			// === 初始化资源总数
			totalTop(data) ;
			// === 上传资源统计
			uploadResources(data) ;
			// === 资源总量
			allResources(data) ;
			// === 资源一级分类
			firstCatelogry(data) ;
			// === 资源二级分类
			secondCatelogry(data) ;
			// === 年级资源分布
			classlevelCatelogry(data) ;
			// === 学科统计资源
			subjectCatelory(data) ;
			// === 学校top10
			schoolTopTen(data) ;
			// === 老师top10
			teacherTopTen(data) ;
		}) ;
		
		// === 日期跨年校验
		function startFocus(element) {
			WdatePicker({
					onpicking		:	changeStartData, 
					onpicked		:	chearStartValue ,
					skin			:	'whyGreen',
					dateFmt		:	'yyyy-MM', 
					isShowToday 	:	false ,
					maxDate		:	'#F{$dp.$D(\'endTime\')}' 
					});
		} ;
		
		function endFocus() {
			WdatePicker({
					onpicking		:	changeEndData, 
					onpicked		:	clearEndValue ,
					skin			:	'whyGreen',
					dateFmt		:	'yyyy-MM',
					isShowToday 	:	false ,
					minDate		:	'#F{$dp.$D(\'startTime\')}' 
					});
		} ;
		
		var startFlag = false ;
		var endFlag = false ;
		function changeStartData(){
			var start = $("#startTime").val() ;
			var end = $("#endTime").val() ;
			var newS = $dp.cal.getNewDateStr() ;
			if(newS != "" && end != "") {
				if(newS.substring(0,newS.indexOf("-")) != end.substring(0,end.indexOf("-"))) {
					startFlag = true ;
					Win.alert("很抱歉，日期不能跨年!") ;
					return  ;
				} else {
					startFlag = false ;
				}
			} else {
				startFlag = false ;
			}
		}
		
		function changeEndData(){
			var start = $("#startTime").val() ;
			var end = $("#endTime").val() ;
			var newS = $dp.cal.getNewDateStr() ;
			if(start != "" && newS != "") {
				if(start.substring(0,start.indexOf("-")) != newS.substring(0,newS.indexOf("-"))) {
					endFlag = true ;
					Win.alert("很抱歉，日期不能跨年!") ;
					return  ;
				} else {
					endFlag = false ;
				}
			} else {
				endFlag = false ;
			}
		}
		
		function chearStartValue() {
			if(startFlag) {
				$dp.$('startTime').value = "" ;
			}
		}
		
		function clearEndValue() {
			if(endFlag) {
				$dp.$('endTime').value = "" ;
			}
		}
		
		$(".sortBox").on("click"," a",function(){
			var $elem = $(this);
			$elem.addClass("selected");
			var $parent = $elem.parent();
			$parent.find("a").not(this).removeClass("selected");
			
			search();
		});
		
		$("#search").unbind("click") ;
		$("#search").bind("click", function() {
			search() ;
		}) ;
		
		function search() {
			var startTime 		= $("#startTime").val() ;
			var endTime 		= $("#endTime").val() ;
			var categoryId 		= $("#resourceCategory .selected").attr("lang") ;
			var baseSemesterId 	= $("#semester .selected").attr("lang") ;
			var areas = $("#areaSelect select");
			var areaLength = areas.length;
			var baseAreaId = "";
			var baseAreaId1 = "";
			if(areaLength == 1){
				baseAreaId = $(areas[0]).val();
			}else{
				baseAreaId = $(areas[areaLength-2]).val();
				baseAreaId1 =$(areas[areaLength-1]).val();
				if("-1" != baseAreaId1){
					baseAreaId = baseAreaId1;
				}
			}
			
			var data = {
					startTime		:	startTime ,
					endTime			:	endTime ,
					categoryId		:	categoryId ,
					baseSemesterId	:	baseSemesterId ,
					baseAreaId		:	baseAreaId
			} ;
			
			// === 资源总数统计
			totalTop(data) ;
			// === 上传资源统计
			uploadResources(data) ;
			// === 资源总量
			allResources(data) ;
			// === 资源一级分类
			firstCatelogry(data) ;
			// === 资源二级分类
			secondCatelogry(data) ;
			// === 年级资源分布
			classlevelCatelogry(data) ;
			// === 学科资源统计
			subjectCatelory(data) ;
			// === 学校top10
			schoolTopTen(data) ;
			// === 老师top10
			teacherTopTen(data) ;
		}
		
	</script>
</body>
</html>