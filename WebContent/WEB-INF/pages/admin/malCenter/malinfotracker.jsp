<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<%@ include file="malguidecommon.jsp"%>
<link href="${root}/public/calendar/skin/WdatePicker.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="${root}/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<style>
	#search {
	    height: 18px;
	    margin-right: 10px;
	    padding-left: 10px;
	    width: 250px;
	}
</style>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">报修管理</a> &gt; <a href="javascript:;">报修信息跟踪</a>
	</h3>
	<div id="control">
		<div id="controlContent">
		<ul class="searchWrap">
			<li style="padding-left:14px;">
				<label class="text">行政区：</label>
				<span class="cont" id="chooseArea">
					<select class="mr20" id="province" name = "province">
						<option value="-1">请选择</option>
					</select>
				</span>
				
				<label class="labelText">学校名称：</label>
				<input type="text" id="sname" value=""  name="clsSchoolName"/>
	
				
				<label class="text" style="margin-left:10px;">学校问题处理状况：</label>
				<select id="statusSelect" >
					<option value="ALL">全部记录</option>
					<option value="DONE">已处理记录</option>
					<option value="NEW">未处理记录</option>
				</select>
	
				<input type="button" class="submit btn" style="margin-left:20px;" name="query" onclick="listMalStatistic(1);" value="搜索" />
			</li>
		</ul>
		
		<!-- 故障排查指南列表  -->
		<table class="tableBox">
			<tr>
				<th>行政区</th>
				<th>学校</th>
				<th>问题总数</th>
				<th>已处理问题数</th>
				<th>最新问题报修日期</th>
				<th>最新问题处理状况</th>
				<th>操作</th>
			</tr>
			<tbody id="mals">
			</tbody>
		</table>
		
		<div id="pageNavi"></div>
		
		<script type="text/javascript">
		
			var currPage = 1;
	
			$(document).ready(function(){
				getTopArea();
				listMalStatistic(1);
			});
			
			function getTopArea() {
				$.post("${root}/admin/orgUser/getAreaByparentId.do",{"parentId":"-1"},function(data){
					var html = '<option value="-1">请选择</option>';
					for(var i = 0,j = data.length; i<j; i++){
						html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
					}
					$("#province").html(html);
				},'json');
				selectBind("chooseArea","${root}/admin/orgUser/getAreaByparentId.do","parentId");
			}
			
			var mySplit = null;
			
			function listMalStatistic( currentPage) {
				
				var baseAreaId = getBaseAreaId('chooseArea');
				
				var schoolName = $("#sname").val();
				
				var status = $("#statusSelect").val();
				
				currPage=currentPage;
				var criteria = {
						'currentPage' : currentPage, 
						'baseAreaId' : baseAreaId,
						'schoolName' : schoolName,
						'status' : status
					};
			    var url = '${root}/admin/malCenter/searchMalStatistic.do';
			    if(mySplit == null) {
				 	mySplit = new SplitPage({
				        node : $id("pageNavi"),
				        url : url,
				        data :  criteria,
				        count : 20,
				        callback : createMalStatisticList,
				        type : 'get' //支持post,get,及jsonp
				    });		
			    } else {
				   mySplit.search(url,criteria);
			    }
			
			}
			
			function createMalStatisticList(data) {
				var dataArray = data;
				//此处需要让其动态的生成一个table并填充数据  
				var tableStr = "";
				var len = dataArray.length;
	
				for ( var i = 0; i < len; i++) {
					tableStr = tableStr + "<tr><td>" + dataArray[i].areaName + "</td><td>"
								+ dataArray[i].clsSchoolName + "</td><td>"
								+ dataArray[i].totalCount + "</td><td>"
								+ dataArray[i].doneCount + "</td><td>"
								+ new Date(dataArray[i].latestReportDate).Format("yyyy-MM-dd hh:mm:ss") + "</td><td>"
								+ renderStatus(dataArray[i].latestRepairStatus) + "</td><td>"
								+ "<a style='margin-left:5px;' href='${root}/admin/malCenter/malinfotrackerdetail.html?baseSchoolId="+dataArray[i].baseSchoolId+"'>查看</a></td>"
								+"</tr>";
				}
	
				
				if(tableStr == "") {
					tableStr = "<tr><td colspan='7'>无报修信息!</td></tr>";
				}
				
				$("#mals").html(tableStr);
				
				
				window.scrollTo(0, 0);
			}
			
			//渲染状态
			function renderStatus(value) {
				if (value == null || value == "") {
					return "";
				}
				
				if (value == "NEW") {
					return "待处理";
				} else if (value == "PROCESSING") {
					return "处理中";
				} else if (value == "DONE") {
					return "已处理";
				} else if (value == "CHECKED") {
					return "已验收";
				}  else {
					return value;
				}
			}
			
		</script>
	</div>
	</div>
</body>
</html>

