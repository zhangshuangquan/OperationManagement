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
	
	.dialog_Cont{padding:5px 0px 20px 0px;}
	.append-window{overflow-y:auto;height:420px;padding:20px 0px;}
	.append-window li {margin-bottom:10px;}
</style>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">报修信息跟踪</a> &gt; <a href="javascript:;">${schoolName}</a>
		<span><button class="btn btnGray back" style="float:right;margin-right:20px;" onclick="returnBack();">返回</button></span>
	</h3>
	<div id="control">
		<div id="controlContent">
		<!-- 故障排查指南列表  -->
		<table class="tableBox">
			<tr>
				<th style="width: 9%;">报修时间</th>
				<th style="width: 8%;">故障类型</th>
				<th style="width: 15%;">故障描述</th>
				<th style="width: 8%;">报修人</th>
				<th style="width: 8%;">报修人电话</th>
				<th style="width: 8%;">处理人</th>
				<th style="width: 8%;">处理人电话</th>
				<th style="width: 15%;">处理过程</th>
				<th style="width: 9%;">预计处理日期</th>
				<th style="width: 6%;">状态</th>
				<th>操作</th>
			</tr>
			<tbody id="DetailTableContent">
			</tbody>
		</table>
		
		<div id="pageNavi"></div>
		
		<!-- 追问弹出层 -->
	     <textarea id="already-pop" style="display: none;">
	     		<div class="append-window">
			     	<div class="append-issue" style="margin-bottom:5px;">
			     	</div>
					<div class="original-issue">
					</div>
				</div>
		</textarea>
		<script src="${pageContext.request.contextPath}/public/js/feed.js" type="text/javascript"></script>
		
		<script type="text/javascript">
		
		var baseSchoolId = '<%=request.getAttribute("baseSchoolId") %>';
		
		var currPage = 1;
	
		$(document).ready(function(){
			listMalDetail(1);
			
			$(document).on('click', '.prettyPhoto', function () {//显示大图
				var tab = [];
				$(this).parent().find('.prettyPhoto').each(function (i) {
					tab.push($(this).attr('img-href'));
				});
				top.feed.picDetail.show(tab, $(this).index());
			});
			
		});
		
		var mySplit = null;
		
		function listMalDetail(currentPage) {
			
			currPage=currentPage;
			
			var criteria = {
					'currentPage' : currentPage, 
					'baseSchoolId' : baseSchoolId
				};
		    var url = '${root}/admin/malCenter/searchMalInfoDetail.do';
			if(mySplit == null) {
			    mySplit = new SplitPage({
			        node : $id("pageNavi"),
			        url : url,
			        data :  criteria,
			        count : 10,
			        callback : createMalDetailList,
			        type : 'get' //支持post,get,及jsonp
				});	
			} else {
				mySplit.search(url,criteria);
			}
		
		}
		
		function createMalDetailList(data) {
			var dataArray = data;
			//此处需要让其动态的生成一个table并填充数据  
			var tableStr = "";
			var len = dataArray.length;
	
			for ( var i = 0; i < len; i++) {
				tableStr = tableStr + "<tr><td>" + dealNull(dataArray[i].createTime)+ "</td><td>"
							+ dealNull(dataArray[i].malCatalogName1) + "</td><td style='padding:0px;'><div style='overflow: hidden;height:75px;text-align:left;vertical-align:top;word-break:break-all;' title='"+dataArray[i].malDescription+"'>"
							+ dealNull(dataArray[i].malDescription) + "</div></td><td>"
							+ dealNull(dataArray[i].reporter) + "</td><td>"
							+ dealNull(dataArray[i].reporterContact) + "</td><td>"
							+ dealNull(dataArray[i].repairman) + "</td><td>"
							+ dealNull(dataArray[i].repairmanContact) + "</td><td style='padding:0px;'><div style='overflow: hidden;height:75px;text-align:left;vertical-align:top;word-break:break-all;' title='"+dataArray[i].responseContent+"'>"
							+ dealNull(dataArray[i].responseContent) + "</div></td><td>"
							+ new Date(dataArray[i].planRepairTime).Format("yyyy-MM-dd") + "</td><td>"
							+ renderStatus(dataArray[i].status) + "</td><td>"
							+ "<a style='margin-left:5px;' href='javascript:void(0);' onclick='onSearchAppend(\""+dataArray[i].malDetailId+"\")'>查看</a></td>"
							+"</tr>";
			}
	
			
			if(tableStr == "") {
				tableStr = "<tr><td colspan='11'>无报修信息!</td></tr>";
			}
			
			$("#DetailTableContent").html(tableStr);
			
			
			window.scrollTo(0, 0);
		}
		
	
		//点击查看按钮
		function onSearchAppend(id) {
			showAppendWindow();
			fillMainData(id);
			fillAppendData(id);
			
		}
		
		//显示追问窗
		function showAppendWindow() {
			Win.open({
				title: "查看",
				html: $id("already-pop").value,
				mask:true,
				width: "500",
				height: "530"
			});
		}
		
		//填充追问窗信息
		function fillMainData(id) {
			$.get("${root}/admin/malCenter/searchMalDetailById.do", {"malDetailId":id}, function(result){
				
				var issueType = result.malCatalogName;
				var reportTime = result.createTime;
				var reporter = result.reporter;
				var reporterPhoneNum = result.reporterContact;
				var description = result.malDescription;
				var originalImgList = result.imgs;
				//var appendList = result.append;
				var originalHtml = '';		
				originalHtml += '<div style="padding-left:10px;border-top:1px solid #000;border-bottom:1px solid #000;margin-bottom:5px;font-size:15px;">'+
							'<b>原问题'+reportTime+
						'</b></div>'+
						'<div style="font-size:15px;padding-left:10px;">'+
							'<table>'+
								'<tr height="25"><td align="right" width="88">故障类别:&nbsp;&nbsp;</td><td colspan="3">'+issueType+'</td></tr>'+
								'<tr height="25"><td align="right" width="88">报修人名字:&nbsp;&nbsp;</td><td>'+reporter+'</td><td width="115">&nbsp;&nbsp;&nbsp;报修人手机号:</td><td>'+reporterPhoneNum+'</td></tr>'+
								'<tr height="25"><td align="right" valign="top" width="88">故障描述:&nbsp;&nbsp;</td><td valign="top" colspan="3" style="word-break:break-all;">'+description+'</tr></tr>'+
								'<tr><td align="right" valign="top" width="88">附加图片:&nbsp;&nbsp;</td>';						
				originalHtml += '<td colspan="3">';
				if(originalImgList && originalImgList.length > 0) {
					for(var index = 0; index < originalImgList.length; index ++) {
						originalHtml += '<a style="margin-right:5px;" href="javascript:;" img-href="${root}/images/' + originalImgList[index].imageName + '" class="prettyPhoto"><img height="30" width="50" src="${root}/images/'+originalImgList[index].imageName+'"/></a>';
					}
					
				} else {
					originalHtml += '无';
				}
				originalHtml += '</td>';
				originalHtml += '</tr></table></div>';		
				$(".original-issue").html(originalHtml);			
			}, "json");
		}
		
		
		//填充追问信息(不包括原问题信息)
		function fillAppendData(id) {
			$.get("${root}/admin/malCenter/searchMalAppend.do", {"malDetailId":id}, function(appendList){
				var html = '';
				if(appendList && appendList.length > 0) {				
					for(var index = 0; index < appendList.length; index ++) {
						var append = appendList[index];
						var description = append.appendDescription;
						var appendDate = new Date(append.createTime).Format("yyyy-MM-dd hh:mm:ss");
						var imgList = append.imgs;					
						html += '<div style="padding-left:10px;border-top:1px solid #000;border-bottom:1px solid #000;margin-bottom:5px;font-size:15px;">'+
											'<b>追问'+appendDate+
										'</b></div>'+
										'<div style="margin-bottom:10px;font-size:15px;padding-left:10px;">'+
											'<table>'+
											'<tr height="25"><td align="right" valign="top" width="88">故障描述:&nbsp;&nbsp;</td><td valign="top">'+description+'</tr></tr>'+
											'<tr><td align="right" valign="top" width="88">附加图片:&nbsp;&nbsp;</td>';						
						html += '<td>';
						if(imgList && imgList.length > 0) {
							
							for(var i = 0; i < imgList.length; i ++) {
								html += '<a style="margin-right:5px;" href="javascript:;" img-href="${root}/images/' + imgList[i].imageName + '" class="prettyPhoto"><img style="margin-right:5px;" height="30" width="50" src="${root}/images/'+imgList[i].imageName+'"/></a>';
							}
							
						} else {
							html += '无';
						}	
						html += '</td>';
						html += '</tr></table></div>';					
					}
				}	
				$(".append-issue").html(html);					
			}, "json");
				
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
			
			//处理null字符串
			function dealNull(content) {
				if(content == null || content == 'null') {
					return '';
				}
				return content;
			}
			
			function returnBack() {
				window.location.href = "${root}/admin/malCenter/malinfotracker.html";
			}
			
		</script>
	</div>
	</div>
</body>
</html>

