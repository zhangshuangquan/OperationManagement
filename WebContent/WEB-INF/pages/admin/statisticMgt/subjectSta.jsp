<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../common/meta.jsp" %>
<link href="${root}/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
</head>
<body>
<div id="control">
	<h3 class="cataMenu navMenu mb10">
		<span class="tabMenu">
			<a class="tabItem" href="toOpenProfile.html">开课概况</a> 
			<a class="tabItem selected" href="toSubject.html">学科统计</a>
		</span>
	</h3>
	<div id="controlContent">
        <div class="content-in">
	        <div class="borderBox deepBgWrap mb10">
	             <input id="areaId" type="hidden" value="${areaId}"/>
	             <input id="rootAreaLvl" type="hidden" value="${rootArea.areaLevel }" />
				 <ul class="sortWrap" id="areaDiv">
			    </ul>
			  </div>
		     <ul class="searchWrap deepBgWrap borderBox">
				 <li class="verticalTop">
				    <span class="tabTurner mr10">
						<a class="prevTuner" href="javascript:;">&lt;</a>
						<a class="nextTuner" href="javascript:;">&gt;</a>
					</span>
					<span class="tabRange mr20">
						<a class="firstRange  selected" dir="0" href="javascript:;">按周</a>
						<a class="secondRange" dir="1" href="javascript:;">按月</a>
						<input id="searchIndex" type="hidden" value="0"/>
					</span>
			        <label class="labelText">日期：</label>
			        <input type="text" class="Wdate" id="startDt" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'#F{$dp.$D(\'endDt\')}'});" value="" />
			        --
			        <input type="text" class="Wdate mr20" id="endDt" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'#F{$dp.$D(\'startDt\')}'});" value="" />
			        
			         <label class="labelText">学科：</label>
			         <select class="mr20" id="subject">
			            <option value="0">全部</option>
			            <c:forEach var="sbj" items="${subjects}">
			              <option value="${sbj.id}">${sbj.name }</option>
			            </c:forEach>
		       		</select>
			        <input type="button" class="submit btn query" id="query" value="查询" />
		       	</li>
		    </ul>
		    
		    <div class="totalPageBox">
		    	<span class="fr">
		    		<a id="exportBtn" class="btn btnOrange" href="javascript:;">导出</a> 
		    	</span>	
		    	总共<em class="totalNum">0</em>条数据
		    </div>
		    <table class="tableBox center">
				<tr>
				    <th id="areaHeader" width="30%">地区</th>
					<th width="30%">学科</th>
					<th width="10%">计划开课节数</th>
					<th width="10%">应开课节数</th>
					<th width="10%">实开课节数</th>
					<th width="10%">开课节数比例</th>
				</tr>
			</table>
			<div id="pageNavi" class="pageNavi"></div>
        </div>
    </div>
</div>
<script type="text/javascript">
		function calcDtScopeByMonth(index){
			var today  = new Date();
			var month = today.getMonth();
			var year = today.getFullYear();
			var firstDay = new Date(year, month+index, 1);
			var millisecond = 1000 * 60 * 60 * 24;
			var lastDay = new Date(year,month+index+1,1);
			var lastDay = new Date(lastDay.getTime() - millisecond);
			$('#startDt').val(now('y-m-d',firstDay));
			$('#endDt').val(now('y-m-d',lastDay));	
		}
		
		function calcDtScopeByWeek(index){
			var today  = new Date();
			var day = today.getDay()==0?7:today.getDay();
			var millisecond = 1000* 60 *60 *24;
			var addDays = index*7-day+1;
			var mondayDt = new Date(today.getTime()+ addDays*millisecond);
			var sundayDt = new Date(today.getTime()+ (addDays+6)*millisecond);	
			$('#startDt').val(now('y-m-d',mondayDt));
			$('#endDt').val(now('y-m-d',sundayDt));	
		}
		
	    function toDate(strDate) {
	    	var sd=strDate.split("-");
	        return new Date(sd[0],sd[1],sd[2]);
	    }
		
		function showList(data,totalCnt,param){
		   var url = "${root}/admin/commons/checkIsLastAreaLevelById.do";
		   var areaColumn = "地区";
		   $.ajax({
			   type: "get",
			   url: url,
			   async:false,
			   data: "&areaId="+param.areaId,
			   dataType:'text',
			   success: function(data){
				   if(data =='1'){
					   areaColumn = "学校";
				   }
			   }
			});
			$("#areaHeader").html(areaColumn);
			
			
			var len = data.length;
			var html = '';
			if(len>0){
				for(var i = 0; i< len; i++){
					var obj = data[i];
					html += '<tr>';
					html += '<td>'+obj.areaName+'</td>';
					html += '<td>'+obj.subjectName+'</td>';
					html += '<td>'+obj.planCnt+'</td>';
					html += '<td>'+obj.requiredCnt+'</td>';
					html += '<td>'+obj.downCnt+'</td>';
					html += '<td>'+obj.downRate*1+'%</td>';
					html += '</tr>';
				}
			} else {
				html += '<tr><td colspan="6">抱歉！没有搜索到您想要的信息！</td></tr>';
			}
			$(".tableBox tr:first").nextAll().remove();	
			$(".tableBox tr:first").after(html);
			$(".totalNum").html(totalCnt);
		}

		function search(){
			var url  = "${root}/admin/statisticsAnaly/getClassSubjectSta.do";
			var startDt = $("#startDt").val();
			var endDt = $("#endDt").val();
			var subjectId = $("#subject").val();
			var areaPoint = $("#areaDiv a[class='selected'][dir='1']:last");
			
			
			//区域操作
			if(areaPoint.length > 0) {
				var areaId = areaPoint.attr("lang");
			} else {
				var areaId = $("#areaId").val();
			}
			
			if(toDate(startDt) > toDate(endDt)) {
				Win.alert({html:"<span class=\"dialog_Inner\">开始时间不能大于结束时间</span>",width:"200px"});
				return;
			}
			
			var param  = {
					startDt:startDt,
					endDt:endDt,
					areaId:areaId,
					subjectId:subjectId
			};
			mySplit.search(url,param);
		}
	
		function exportData(){
			var startDt = $("#startDt").val();
			var endDt = $("#endDt").val();
			var subjectId = $("#subject").val();
			var areaPoint = $("#areaDiv a[class='selected'][dir='1']:last");
			if(areaPoint.length > 0) {
				var areaId = areaPoint.attr("lang");
			} else {
				var areaId = $("#areaId").val();
			}
			window.location.href = "${root}/admin/statisticsAnaly/exportClassSubjectSta.do?startDt="+startDt+"&endDt="+endDt+"&areaId="+areaId+"&subjectId="+subjectId;
		}
		
		function getAreaLevelTitleByLvl(lvl){
			if(typeof(lvl) == 'undefined' || lvl == ''){
				return "";
			}
			<c:forEach var ="lvl" items="${areaLvlConfig}">
                if(lvl == '${lvl.key}'){
                	return "${lvl.value}";
                }
			</c:forEach>
		}
		
		function formAreaLi(data,p_id,p_level){
			var len = data.length;
			var html = "";
			if(len > 0){
				for(var i = 0; i < len;i++){
					var obj = data[i];
                    if(i == 0){
                    	var c_level = obj.areaLevel;
        				html += '<li p_level="'+p_level+'" p_id="'+p_id+'" c_level="'+c_level+'">';
                    	html += ' <label class="labelText"><b>'+getAreaLevelTitleByLvl(c_level)+'：</b></label>';
                    	html += ' <span class="sortBox">';
                    	html += ' 	<a href="javascript:;" dir="0" lang="'+obj.parentId+'" class="selected">全部</a>';
                    }
					html += ' 	<a href="javascript:;" dir="1"  lang="'+obj.baseAreaId+'" >'+obj.areaName+'</a>';
				}
				html += ' </span>';
				html += '</li>';		
			}
			return html;
		}
		
		function loalAreaInfoByParent(root,$elem){
			var p_id,p_level,$li,allFlg;
			if(root){
				p_level = $("#rootAreaLvl").val();
				p_id = $("#areaId").val();
				allFlg = '1';
			} else {
				$li = $elem.parent(0).parent(0);
				p_id  = $elem.attr("lang");
				p_level = $elem.attr("p_level");
				allFlg = $elem.attr("dir");
			}
			if(allFlg == '1'){
				var url = "${root}/admin/commons/getBaseAreaByParentId.do";
				$.ajax({
					   type: "get",
					   url: url,
					   async:false,
					   data: "parentId="+p_id,
					   dataType:'json',
					   success: function(data){
						   var html = formAreaLi(data,p_id,p_level);
							if(root){
								$("#areaDiv").html(html);
								if(html == ''){
									$("#areaDiv").parent(0).hide();
								}
							} else {
								$li.nextAll().remove();
								$li.after(html);				
							}
					   }
					});
			} else {
				$li.nextAll().remove();
			}
		}
		
		var mySplit = null;
		
		$(document).ready(function(){			 
			 $("#exportBtn").click(exportData);
			 $("#query").click(function(){
				 search();
				 $(".prevTuner").addClass("disable");
			     $(".nextTuner").addClass("disable");
			     $(".tabRange .selected").removeClass("selected");
			 });
			 
			 $("#areaDiv").on("click","li a",function(){
				 var $elem = $(this);
				 var $li = $elem.parent().parent();
				 $li.find("a").removeClass("selected");
				 $elem.addClass("selected");
				 loalAreaInfoByParent(false,$elem);
				 search();
			 });
			 
			 $(".prevTuner").click(function(){
			    	if($(this).hasClass("disable")){
			    		return;
			    	}
			    	var index = $("#searchIndex").val();
			    	index--;
			    	$("#searchIndex").val(index);
			    	var type = $(".tabRange .selected").attr("dir");
			     	if(type == '0'){
			       		calcDtScopeByWeek(index);
			       	} else {
			       		calcDtScopeByMonth(index);
			       	}
			     	search();
			    });
			   
			   $(".nextTuner").click(function(){
				   if($(this).hasClass("disable")){
			   		return;
			   	   }
				   var index = $("#searchIndex").val();
				   	index++;
				   	$("#searchIndex").val(index);
				   	var type = $(".tabRange .selected").attr("dir");
			    	if(type == '0'){//按周
			      		calcDtScopeByWeek(index);
			      	} else {
			      		calcDtScopeByMonth(index);
			      	}
			    	search();
			    });
			   
			   $(".tabRange a").click(function(){
				   var $elem = $(this);
			   		$(".tabRange .selected").removeClass("selected");
			       	$elem.addClass("selected");    	
			       	$("#searchIndex").val("0");
			       	var type = $elem.attr("dir");
			       	if(type == '0'){
			       		calcDtScopeByWeek(0);
			       	} else {       		
			       		calcDtScopeByMonth(0);
			       	}
			       	$(".prevTuner").removeClass("disable");
			    	$(".nextTuner").removeClass("disable");
			       	search();
			   });
			 
			  loalAreaInfoByParent(true); 
			  calcDtScopeByWeek(0);
			  
			  var startDt = $("#startDt").val();
		      var endDt = $("#endDt").val();
			  
			  mySplit = new SplitPage({
				    node : $id("pageNavi"),
				    url : "${root}/admin/statisticsAnaly/getClassSubjectSta.do",
				    data:{
						startDt:startDt,
						endDt:endDt,
						subjectId:'0',
						areaId:'${areaId}'
					},
				    count : 20,
				    callback : showList,
				    type : 'post'
				});
		 });
</script>
</body>
</html>