<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
    <link href="${root}/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
     <script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
     <script src="${root}/public/js/jsTree.js" type="text/javascript"></script>
     <script src="${root }/public/js/customer.js" type="text/javascript"></script>
     <style>
	.embedRecord-box-right {
		float: right;
		height: 100%;
		text-align: left;
		width: 210px;
	}
	.embedRecord-box-right a{
		display: block;
		float: left;
		width: 100px;
		height: 25px;
		line-height: 25px;
	}
	a.selected {
		color: #16adfc;
	}
	#classList .gray {
		color:#999;
	}
</style>
</head>
<body>
<h3 id="cataMenu">
	<a href="javascript:;">授课统计</a> &gt; <a href="javascript:;">课堂列表</a>
</h3>
<div id="control">
	<div id="controlContent">
		<form id="form">
			<ul class="searchWrap">
				<li>
					<label class="text">行政区：</label>
					<span class="cont" id="chooseArea">
						<select class="mr20" id="province" name = "province">
							<option value="-1">请选择</option>
						</select>
					</span>
					<label class="labelText">主讲学校：</label><input type="text" id="schoolName" value=""  name="schoolName"/>
					<label class="labelText">主讲教师：</label><input type="text" id="teacherName" value=""  name="teacherName"/>
					<label class="labelText">接收学校：</label><input type="text" id="receiveSchoolName" value=""  name="receiveSchoolName"/>
				</li>
				<li>
					<label class="text">排课时间：</label>
					<input type="text" class="Wdate" id="startScheduleDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'#F{$dp.$D(\'endScheduleDate\')}'});" value="" name="startScheduleDate">
	                --
	                <input type="text" class="Wdate" id="endScheduleDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'#F{$dp.$D(\'startScheduleDate\')}'});" value="" name="endScheduleDate">
	                <label class="labelText">实际上课时间：</label>
					<input type="text" class="Wdate" id="startRealBeginTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endRealBeginTime\')}'});" value="" name="startRealBeginTime">
	                --
	                <input type="text" class="Wdate" id="endRealBeginTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startRealBeginTime\')}'});" value="" name="endRealBeginTime">
				    <input type="button" class="submit btn" name="query" value="查询"  onclick = "listAsync(1);"/>
				</li>
			</ul>	
		</form>
		<div class="totalPageBox">总共<span class="totalNum">0</span> 条数据</div>
		<table class="tableBox">
			<tr>
				<th width="10%">所在地区</th>
				<th width="6%">排课时间</th>
                <th width="6%">实际上课时间</th>
                <th width="6%">学校（主讲）</th>
				<th width="6%">年级</th>
                <th width="6%">学科</th>
                <th width="6%">主讲教师</th>
                <th width="6%">星期</th>
                <th width="6%">节次</th>
                <th width="15%">学校（接收）</th>
                <th width="5%">操作</th>
			</tr>
			<tbody id="classList">
			</tbody>
	</table>
	<div id="pageNavi"></div>
	</div>
</div>
<script>
var currPage=1;
$(document).ready(function(){
	$.post("${root}/admin/orgUser/getAreaByparentId.do",{"parentId":"-1"},function(data){
		var html = '<option value="-1">请选择</option>';
		for(var i = 0,j = data.length; i<j; i++){
			html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
		}
		$("#province").html(html);
	},'json');
	selectBind("chooseArea","${root}/admin/orgUser/getAreaByparentId.do","parentId");
});
$(function() {
	listAsync(1);
});

function listAsync( currentPage) {
	var startScheduleDate = $("#startScheduleDate").val();
	var endScheduleDate = $("#endScheduleDate").val();
	var startRealBeginTime = $("#startRealBeginTime").val();
	var endRealBeginTime = $("#endRealBeginTime").val();
	if(startScheduleDate && endScheduleDate) {
		if(startScheduleDate > endScheduleDate) {
			Win.alert({html:"<span class=\"dialog_Inner\">开始时间不能大于结束时间</span>",width:"200px"});
			return;
		}
	}
	if(startRealBeginTime && endRealBeginTime) {
		if(startRealBeginTime > endRealBeginTime) {
			Win.alert({html:"<span class=\"dialog_Inner\">开始时间不能大于结束时间</span>",width:"200px"});
			return;
		}
	}
	var formdata = $("#form").serialize();
	var baseAreaId = getBaseAreaId('chooseArea');
	formdata +="&baseAreaId="+baseAreaId;
	currPage=currentPage;
	var criteria = {
			'currentPage' : currentPage
		};
    var url = '${root}/admin/statisticMgt/searchlist.do?'+formdata;
	 var mySplit = new SplitPage({
	        node : $id("pageNavi"),
	        url : url,
	        data :  criteria,
	        count : 20,
	        callback : createShowingTable,
	        type : 'post' //支持post,get,及jsonp
	});			 
	mySplit.search(url,criteria);
}

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
			var opration = "";
			switch(dataArray[i].status) {
				case 'INIT':
					opration = '-';
					break;
				case 'PROGRESS':
					//opration = '<a href="javascript:;" onclick="watchV(\''+dataArray[i].clsScheduleDetailId+'\');">观摩</a>';
					opration = '-';
					break;
				case 'END':
					if(dataArray[i].hasPlayBack) {
						opration = '<a href="javascript:;" scheduleDetailId="'+dataArray[i].clsScheduleDetailId+'"  class="room-record">课程回放</a>';						
					} else {
						opration = '<a href="javascript:;" class="gray">课程回放</a>';
					}
					break;
				default:
					opration = '-';
			}
			tableStr += "<tr><td>"+ dataArray[i].areaName
			    + "</td><td>" + dataArray[i].scheduleDate
				+ "</td><td>" + (dataArray[i].realBeginTime?dataArray[i].realBeginTime:'-')
				+ "</td><td>" + "<span title='"+dataArray[i].roomName+"'>"+dataArray[i].schoolName+"</span>"
				+ "</td><td>" + dataArray[i].baseClasslevelName
				+ "</td><td>" + dataArray[i].baseSubjectName
				+ "</td><td>" + dataArray[i].teacherName
				+ "</td><td>" + dataArray[i].daySeqStr
				+ "</td><td>" + dataArray[i].classSeqStr
				+ "</td><td>" + dataArray[i].receiveSchoolName
				+ "</td><td>" + opration
				+ "</td></tr>" ;
		} 	
	} else {
		tableStr += '<tr><td colspan="11">暂无课堂信息</td></tr>';
	}
 
	//alert(tableStr);
	$("#classList").html(tableStr||'<tr/>');
	window.scrollTo(0,0);
	
}
function watchV(mid) {
	window.open('${OnlineClassUrl}/class/schoolTeaching/watch/'+mid+'.html',"mid"+mid);
}
var myPlayer;
$(document).on('click', '.room-record', function (){
	var scheduleDetailId = $(this).attr('scheduleDetailId');
	$.post(ROOT + '/monitor/schedule/videoList.do', {
		scheduleDetailId: scheduleDetailId
	}, function (data) {
		if (data.length > 0) {
			var html = '<div class="embedRecord-box-right">';
			for (var i =0, len = data.length; i < len; i++) {
				html += '<a href="javascript:;" class="embedRecord-box-right-play ' + (i==0?"selected":'') + '" data-path="'+data[i].path+'">' + data[i].name + '</a>'	
			}
			var opt = {mask: true, width: 950, height: 510};
			opt.html = html + '</div><div style="margin-right: 100px;width: 700px;height:430px;" id="embedRecord"><div>';
			opt.title = "课程回放";
			Win.open(opt);
			var myParams = {
				skin : ROOT + "/public/flvPlayback/MinimaFlatCustomColorAll.swf",
				url : ROOT + data[0].path,
				//thumb : "play.png",
				autoplay : true
			};
			var paramVars = "";
			for(var i in myParams){
				paramVars += i+"="+myParams[i]+"&";
			};
			myPlayer = new FlashPlayer($id("embedRecord"), ROOT + "/public/flvPlayback/myflvPlayBack.swf?" + paramVars);
		} else {
			Win.alert('无视频回放');
		}
		//console.log(data);
		//console.log(ROOT + data[0].path);
		//myPlayer.playFile(ROOT + data[0].path);
	}, 'json');
}).on('click', '.embedRecord-box-right-play', function (){
	$(this).siblings('.embedRecord-box-right-play').removeClass('selected').addClass('selected');
	myPlayer.playFile(ROOT + $(this).attr('data-path'));
})
</script>	
</body>
</html>