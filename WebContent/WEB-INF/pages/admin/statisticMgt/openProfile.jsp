<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
    <link href="${root}/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
     <script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
</head>
<body>
<div id="control">
	<h3 class="cataMenu navMenu mb10">
		<span class="tabMenu">
			<a class="tabItem selected" href="toOpenProfile.html">开课概况</a> 
			<a class="tabItem" href="toSubject.html">学科统计</a>
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
			  <div class="borderBox deepBgWrap mb10">
				 <ul class="sortWrap">
			    	<li class="classroomType">
			    		 <label class="labelText"><b>教室类型：</b></label>
			    		 <span class="sortBox">
				    		  <c:forEach var="type" items="${classroomType}" varStatus="status">
				    		  <c:if test="${status.index  eq 0}">
				    		       <a href="javascript:;" class="selected" dir="${type.key}">${type.value}</a>
				    		  </c:if>
				    		  <c:if test="${status.index  ne 0}">
				    		       <a href="javascript:;" dir="${type.key}">${type.value}</a>
				    		  </c:if>
			       		      </c:forEach>
			    		 </span>
			    	</li>
			    	<li class="classType">
			    		 <label class="labelText"><b>课程类型：</b></label>
			    		 <span class="sortBox">
			    		 	<a href="javascript:;" dir="" class="selected">全部</a>
			    		 	<a href="javascript:;" dir="N">计划开课</a>
			    		 	<a href="javascript:;" dir="Y">自主开课</a>
			    		 </span>
			    	</li>
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
		
	    function formHeaderTr(classroomType,classType,areaId){
			   var url = "${root}/admin/commons/checkIsLastAreaLevelById.do";
			   var areaColumn = "地区";
			   $.ajax({
				   type: "get",
				   url: url,
				   async:false,
				   data: "&areaId="+areaId,
				   dataType:'text',
				   success: function(data){
					   if(data =='1'){
						   areaColumn = "学校";
					   }
				   }
				});
			   
		    	var html = "";
				if(classroomType == 'MASTER' && classType == ''){
					html += '<tr>';
					html += '<th width="20%">'+areaColumn+'</th>';
					html += '<th width="10%">主讲教室总数</th>';
					html += '<th width="10%">开课主讲教室数</th>';
					html += '<th width="10%">主讲教室开课比例</th>';
					html += '<th width="10%">总开课节数</th>';
					html += '<th width="10%">应开课节数</th>';
					html += '<th width="10%">实开课节数</th>';
					html += '<th width="10%">开课节数比例</th>';
					html += '<th width="10%">操作</th>';
					html += '</tr>';			
				} else if (classroomType == 'MASTER' && classType == 'Y'){
					html += '<tr>';
					html += '<th width="20%">'+areaColumn+'</th>';
					html += '<th width="10%">主讲教室总数</th>';
					html += '<th width="10%">开课主讲教室数</th>';
					html += '<th width="10%">主讲教室开课比例</th>';
					html += '<th width="10%">自主开课节数</th>';
					html += '<th width="10%">应开课节数</th>';
					html += '<th width="10%">实开课节数</th>';
					html += '<th width="10%">开课节数比例</th>';
					html += '<th width="10%">操作</th>';
					html += '</tr>';				
				} else if (classroomType == 'MASTER' && classType == 'N'){
					html += '<tr>';
					html += '<th width="20%">'+areaColumn+'</th>';
					html += '<th width="10%">主讲教室总数</th>';
					html += '<th width="10%">开课主讲教室数</th>';
					html += '<th width="10%">主讲教室开课比例</th>';
					html += '<th width="10%">计划开课节数</th>';
					html += '<th width="10%">应开课节数</th>';
					html += '<th width="10%">实开课节数</th>';
					html += '<th width="10%">开课节数比例</th>';
					html += '<th width="10%">操作</th>';
					html += '</tr>';			
				} else if (classroomType == 'RECEIVE' && classType == ''){
					html += '<tr>';
					html += '<th width="20%">'+areaColumn+'</th>';
					html += '<th width="10%">接收教室总数</th>';
					html += '<th width="10%">听课接收教室数</th>';
					html += '<th width="10%">接收教室听课比例</th>';
					html += '<th width="10%">总听课节数</th>';
					html += '<th width="10%">应听课节数</th>';
					html += '<th width="10%">实听课节数</th>';
					html += '<th width="10%">听课节数比例</th>';
					html += '<th width="10%">操作</th>';
					html += '</tr>';	
				} else if (classroomType == 'RECEIVE' && classType == 'Y'){
					html += '<tr>';
					html += '<th width="20%">'+areaColumn+'</th>';
					html += '<th width="10%">接收教室总数</th>';
					html += '<th width="10%">听课接收教室数</th>';
					html += '<th width="10%">接收教室听课比例</th>';
					html += '<th width="10%">自主听课节数</th>';
					html += '<th width="10%">应听课节数</th>';
					html += '<th width="10%">实听课节数</th>';
					html += '<th width="10%">听课节数比例</th>';
					html += '<th width="10%">操作</th>';
					html += '</tr>';	
				} else if (classroomType == 'RECEIVE' && classType == 'N'){
					html += '<tr>';
					html += '<th width="20%">'+areaColumn+'</th>';
					html += '<th width="10%">接收教室总数</th>';
					html += '<th width="10%">听课接收教室数</th>';
					html += '<th width="10%">接收教室听课比例</th>';
					html += '<th width="10%">计划听课节数</th>';
					html += '<th width="10%">应听课节数</th>';
					html += '<th width="10%">实听课节数</th>';
					html += '<th width="10%">听课节数比例</th>';
					html += '<th width="10%">操作</th>';
					html += '</tr>';
				}
			  return html;
		    }
		
		function showList(data,totalCnt,param){
			var header_html = formHeaderTr(param.classroomType,param.classType,param.areaId);
			var len = data.length;
			var html = '';
			if(len>0){
				for(var i = 0; i< len; i++){
					var obj = data[i];
					html += '<tr>';
					html += '<td>'+obj.areaName+'</td>';
					html += '<td>'+obj.classroomCnt+'</td>';
					html += '<td>'+obj.doClsroomCnt+'</td>';
					html += '<td>'+obj.doClsroomRate*1+'%</td>';
					html += '<td>'+obj.planCnt+'</td>';
					html += '<td>'+obj.requiredCnt+'</td>';
					html += '<td>'+obj.downCnt+'</td>';
					html += '<td>'+obj.downRate*1+'%</td>';
					//html += '<td><a href="toAreaOpenProfileDetail.html?areaId='+obj.areaId+'&startDt='+param.startDt+'&endDt='+param.endDt+'&classroomType='+param.classroomType+'&classType='+param.classType+'&type='+obj.type+'">查看详情</a></td>';
					html += "<td><a href=\"javascript:gotoDetail('"+obj.areaId+"','"+param.startDt+"','"+param.endDt+"','"+param.classroomType+"','"+param.classType+"','"+obj.type+"')\">查看详情</a></td>";
					html += '</tr>';
				}
			} else {
				html += '<tr><td colspan="9">抱歉！没有搜索到您想要的信息！</td></tr>';
			}
			$(".tableBox").html(header_html+html);		
			$(".totalNum").html(totalCnt);
		}
		
		function gotoDetail(areaId,startDt,endDt,classroomType,classType,type){
			$("#p_startDt").val(startDt);
			$("#p_endDt").val(endDt);
			$("#p_areaId").val(areaId);
			$("#p_classroomType").val(classroomType);
			$("#p_classType").val(classType);
			$("#p_type").val(type);
			$("#dispatchDetail").submit();
		}

		function search(){
			var url  = "${root}/admin/statisticsAnaly/getClassOpenProfile.do";
			var classroomType = $(".classroomType .selected").attr("dir");
			var classType = $(".classType .selected").attr("dir");
			var startDt = $("#startDt").val();
			var endDt = $("#endDt").val();
			var areaPoint = $("#areaDiv a[class='selected'][dir='1']:last");
			var areaId;
			if(areaPoint.length > 0) {
				areaId = areaPoint.attr("lang");
			} else {
				areaId = $("#areaId").val();
			}
			
			if(toDate(startDt) > toDate(endDt)) {
				Win.alert({html:"<span class=\"dialog_Inner\">开始时间不能大于结束时间</span>",width:"200px"});
				return;
			}
			
			var param  = {
					classroomType:classroomType,
					classType:classType,
					startDt:startDt,
					endDt:endDt,
					areaId:areaId
			};
			mySplit.search(url,param);
		}
	
		function exportData(){
			var classroomType = $(".classroomType .selected").attr("dir");
			var classType = $(".classType .selected").attr("dir");
			var startDt = $("#startDt").val();
			var endDt = $("#endDt").val();
			var areaPoint = $("#areaDiv a[class='selected'][dir='1']:last");
			var areaId;
			if(areaPoint.length > 0) {
				areaId = areaPoint.attr("lang");
			} else {
				areaId = $("#areaId").val();
			}
			window.location.href = "${root}/admin/statisticsAnaly/exportClassOpenProfile.do?startDt="+startDt+"&endDt="+endDt+"&areaId="+areaId+"&classroomType="+classroomType+"&classType="+classType;
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
			 
			 $(".classroomType").on("click","a", function(){
				 var $elem = $(this);
				 $elem.parent().find("a").removeClass("selected");
				 $elem.addClass("selected");
				 search();
			 });
			 
			 $(".classType").on("click","a", function(){
				 var $elem = $(this);
				 $elem.parent().find("a").removeClass("selected");
				 $elem.addClass("selected");
				 search();
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
				    url : "${root}/admin/statisticsAnaly/getClassOpenProfile.do",
				    data:{
				    	classroomType:'MASTER',
				    	classType:'',
						startDt:startDt,
						endDt:endDt,
						areaId:'${areaId}'
					},
				    count : 20,
				    callback : showList,
				    type : 'post'
				}); 
		 });
</script>
<form id="dispatchDetail" action="toAreaOpenProfileDetail.html" method="post">
	<input id="p_startDt" name="startDt" type="hidden" value=""/>
	<input id="p_endDt" name="endDt"  type="hidden" value=""/>
	<input id="p_classroomType" name="classroomType"  type="hidden" value=""/>
	<input id="p_classType" name="classType"  type="hidden" value=""/>
	<input id="p_areaId" name="areaId" type="hidden" value=""/>
	<input id="p_type" name="type" type="hidden" value=""/>
</form>
</body>
</html>