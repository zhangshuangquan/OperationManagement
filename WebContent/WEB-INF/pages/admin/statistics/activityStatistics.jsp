<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ include file="../../common/meta.jsp"%>
	<script type="text/javascript" src="${root }/public/calendar/WdatePicker.js"></script>
	<script type="text/javascript" src="${root }/public/js/customer.js"></script>
	<script type="text/javascript" src="${root }/public/highcharts/highcharts.js"></script>
	<script type="text/javascript" src="${root }/public/highcharts/modules/no-data-to-display.js"></script>
	<script type="text/javascript" src="${root }/public/js/statisticsPublic.js"></script>
	<%-- <script type="text/javascript" src="${root }/public/js/evaluation.js"></script> --%>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">统计管理</a> &gt; <a href="javascript:;">活动统计</a>
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
					<input type="button" class="submit btn" onclick="search()" value="查询" />
				</li>
				<li>
					<label class="labelText">学段：</label>
					<span class="sortBox semester">
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
				<div class="statistics fl statisticsList" id="statistics5">
					<h5>学校Top10</h5>
					<table class="tableBox center" id="tableBox1">
						<thead>
						<tr>
							<th width="10%">排名</th>
							<th width="70%">学校</th>
							<th width="20%">组织活动数</th>
						</tr>
						</thead>
						<tbody id="schoolTop">
							
						</tbody>
					</table>
				</div>
				<div class="statistics fl statisticsList" id="statistics6">
					<h5>教师Top10</h5>
					<table class="tableBox center" id="tableBox2">
						<thead>
						<tr>
							<th width="10%">排名</th>
							<th width="20%">教师</th>
							<th width="50%">学校</th>
							<th width="20%">参与活动数</th>
						</tr>
						</thead>
						<tbody id="teacherTop">
							
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	
	// === 日期跨年校验
	function startFocus(element) {
		WdatePicker({
				onpicking	:	changeStartData, 
				onpicked	:	chearStartValue ,
				skin		:	'whyGreen',
				dateFmt		:	'yyyy-MM', 
				isShowToday 	:	false ,
				maxDate		:	'#F{$dp.$D(\'endTime\')}' 
				});
	} ;
	
	function endFocus() {
		WdatePicker({
				onpicking	:	changeEndData, 
				onpicked	:	clearEndValue ,
				skin		:	'whyGreen',
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
	
		function search(){
			var startTime = $("#startTime").val();
			var endTime = $("#endTime").val();
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
			
			var semesterId = $(".semester .selected").attr("lang");
			var param ={
					'startTime':startTime,
					'endTime':endTime,
					'baseAreaId':baseAreaId,
					'baseSemesterId':semesterId
			};
			
			$.post("${root}/admin/statistics/getAnalysis.do",param,function(data){
				if(data.totalEva == 0){
					$("#top").html("没有相关统计信息！");
					
				}else{
					$("#top").html("共有学校<b class='orange'>"+data.totalSchool+"</b>所，教师<b class='orange'>"+data.totalTeacher+"</b>人次，发起、参与评课议课活动<b class='orange'>"+data.totalEva+"</b>个。");
					
				}
				
			});
			
			$.ajax({
	            url: '${root}/admin/statistics/activityStatistics1.do',
	            type: 'post',
	            data: param,
	            error: function()
	            {
	            	$('#statistics1').html("");
	            	$('#statistics2').html("");
	            },
	            success: function(data)
	            {
	            	showActive1(data);
					showActive2(data);
	            }
	        });
			
			$.ajax({
	            url: '${root}/admin/statistics/activityStatistics2.do',
	            type: 'post',
	            data: param,
	            error: function()
	            {
	            	$('#statistics3').html("");
	            },
	            success: function(data)
	            {
	            	showActive3(data);
	            }
	        });
			$.ajax({
	            url: '${root}/admin/statistics/activityStatistics3.do',
	            type: 'post',
	            data: param,
	            error: function()
	            {
	            	$('#statistics4').html("");
	            },
	            success: function(data)
	            {
	            	showActive4(data);
	            }
	        });
			$.ajax({
	            url: '${root}/admin/statistics/activityStatistics4.do',
	            type: 'post',
	            data: param,
	            error: function()
	            {
	            	$("#schoolTop").html("");
	            },
	            success: function(data)
	            {
	            	showActive5(data);
	            }
	        });
			$.ajax({
	            url: '${root}/admin/statistics/activityStatistics5.do',
	            type: 'post',
	            data: param,
	            error: function()
	            {
	            	$("#teacherTop").html("");
	            },
	            success: function(data)
	            {
	            	showActive6(data);
	            }
	        });
		
		}
		
		function bindEvent(){
			$(".sortBox").on("click"," a",function(){
				var $elem = $(this);
				$elem.addClass("selected");
				var $parent = $elem.parent();
				$parent.find("a").not(this).removeClass("selected");
				
				search();
			});
		}
	
		$(document).ready(function(){
			
			$.post("${root}/admin/statistics/getAreaByparentId.do",{"parentId":"-1"},function(data){
				var html = '<option value="-1">请选择</option>';
				for(var i = 0,j = data.length; i<j; i++){
					html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
				}
				$("#level1").html(html);
			},'json');
			
			selectBind("areaSelect","${root}/admin/statistics/getAreaByparentId.do","parentId");
			
			$.post("${root}/admin/statistics/getSemester.do",function(data){
				for(var i =0, j= data.length; i<j; i++){
					var html = '<a lang="'+data[i].baseSemesterId+'" href="javascript:;">'+data[i].semesterName+'</a>';
					$(".semester").append(html);
				}
			});
			
			bindEvent();
			search();
		});
		window.onerror = function () {return true;}
	</script>
</body>
</html>