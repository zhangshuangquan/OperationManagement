<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<link href="${root}/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
<script src="${root}/public/js/jsTree.js" type="text/javascript"></script>
</head>
<body>
			 <h3 id="cataMenu">
				<a href="javascript:;">评课管理</a> &gt; <a href="javascript:;">评课活动回收站</a>&gt; <a href="javascript:;">查看</a>
			</h3>
			<a id="returnBack" class="btn btnOrange fr mr20" href="${root }/admin/evaCenter/evadellist.html">返回</a>
	<div id="control">
		<div id="controlContent">
			<!--  
			有边框block，请使用class名:borderBox
		 -->
				<!-- ============================================== -->
				<!-- 
			module name:搜索框结构
			1.使用class名：searchWrap；
			2.label使用class名：text；
			3.需要在右侧增加间距，使用class名：mr20; 20标识20px
			 -->
				<h4 class="center">${eva.evaTitle }</h4>
				<div class="center">
					<label >发起方：</label><span class="mr20" >${eva.showName } </span>
					<label>发起时间：</label><span  class="mr20" >  <fmt:formatDate  value="${eva.createTime }" pattern="yyyy-MM-dd HH:mm"/> </span>          
					<label >删除时间：</label> <span > <fmt:formatDate value="${eva.deleteTime }" pattern="yyyy-MM-dd HH:mm"/></span>             
				</div>
				<ul class="commonUL">
					<li><label class="text"><b>评估标准：</b></label>
					<span class="cont">
						<label> 
						<c:if test="${eva.evaStandardName == null }">
							<input type="checkbox" value="" disabled="disabled">
						</c:if>
						<c:if test="${eva.evaStandardName != null }">
							<input type="checkbox" value=""  checked="checked" disabled="disabled">
						</c:if>
						使用评估标准</label>  &nbsp;&nbsp;<a href="javascript:viewbzdetail('${eva.evaStandardId}')">${eva.evaStandardName}</a>&nbsp; </li>
											
					</span>
					<li><label class="text"><b>活动要求：</b></label> 
						<span class="cont">
							${eva.evaDescription }
						 </span>
					</li>
					<li><label class="text"><b>选择课程：</b></label> 
						<span class="cont">
							<label>学校:</label><span class = "mr20" >${eva.schoolName }</span>
							<label>主讲教师:</label><span class = "mr20" >${eva.scheduleDetail.teacherName}</span>
							<label>年级:</label><span class = "mr20" >${eva.scheduleDetail.baseClasslevelName}</span>
							<label>学科:</label><span class = "mr20" >${eva.scheduleDetail.baseSubjectName}</span>
							<br/>
							<label>排课日期:</label><span class = "mr20" ><fmt:formatDate  value="${eva.startTime }" pattern="yyyy-MM-dd "/>  ${eva.scheduleDetail.daySeqStr } ${eva.scheduleDetail.classSeqStr }</span>
							<label>实际上课时间:</label><span class = "mr20" ><fmt:formatDate  value="${eva.scheduleDetail.realBeginTime }" pattern="yyyy-MM-dd "/> </span>
							<label>观摩方式:</label><span class = "mr20" >${eva.evaTypeStr}</span>
							 
						 </span>
					</li>
					<li><label class="text"><b>活动时间：</b></label> 
						<span class="cont">
						<fmt:formatDate  value="${eva.startTime }" pattern="yyyy-MM-dd HH:mm"/> 至 <fmt:formatDate  value="${eva.endTime }" pattern="yyyy-MM-dd HH:mm"/>
						 </span>
					</li>
					<li><label class="text"><b>参与范围：</b></label> 
						<span class="cont lightBgWrap">
						<c:forEach var="school" items="${eva.evaReceiveSchools}" varStatus="s">
							<ul class="commonUL deepBgWrap borderBox mg10">
								<li>
									<label class="text">参与学校：</label> 
									<span class="cont">${school.schoolName }</span>
								</li>
								<li>
									<label class="text">参与教师：</label> 
									<span class="cont">
									<c:forEach var="teacher" items="${school.teachers}" varStatus="t">
											${teacher.realName }
									</c:forEach>
									</span>
								</li>
							</ul>
						</c:forEach>
						 </span>
					</li>
					<li><label class="text"><b>算分方式：</b></label> 
						<span class="cont">
							<c:if  test="${eva.scoreType =='REMOVE_SIDE' }">
								<input type="radio"  disabled="disabled"/>		
							</c:if>
							<c:if  test="${eva.scoreType =='ADD_ALL' }">
								<input type="radio"  checked="checked" disabled="disabled"/>		
							</c:if>
							全部相加法：全部相加求平均数
							<br />
							<c:if  test="${eva.scoreType =='REMOVE_SIDE' }">
								<input type="radio"  checked="checked" disabled="disabled"/>		
							</c:if>
							<c:if  test="${eva.scoreType =='ADD_ALL' }">
								<input type="radio"  disabled="disabled"/>		
							</c:if>
							去除首尾法：参与教师大于等于5的时候，去掉最大值和最小值后，相加求平均数；小于5则全部相加求平均数
						 </span>
					</li>
					
					<li><label class="text"><b>评分明细&nbsp;&nbsp;&nbsp;<br />公开范围：</b></label> 
						<span class="cont">如果公开，公开对象可以看到所有参与教师的评分情况；如果未公开，只能看到总评分<br />公开对象是指能看到活动的省市县校和教师<br />
						<c:if test="${eva.publicToSponsorFlag == 'Y' }">
								<input type="checkbox"  checked="checked" disabled="disabled"> 发起方<br>
							</c:if>
							<c:if test="${eva.publicToSponsorFlag == 'N' }">
								<input type="checkbox"  disabled="disabled"> 发起方<br>
							</c:if>
							<c:if test="${eva.publicToManagerFlag == 'Y' }">
								<input type="checkbox"  checked="checked" disabled="disabled"> 各级机构管理员<br>
							</c:if>
							<c:if test="${eva.publicToManagerFlag == 'N' }">
								<input type="checkbox"  disabled="disabled"> 各级机构管理员<br>
							</c:if>
							<c:if test="${eva.publicToMainTeacherFlag == 'Y' }">
								<input type="checkbox"  checked="checked" disabled="disabled"> 主讲教师<br>
							</c:if>
							<c:if test="${eva.publicToMainTeacherFlag == 'N' }">
								<input type="checkbox"  disabled="disabled"> 主讲教师<br>
							</c:if>
							<c:if test="${eva.publicToJoinTeacherFlag == 'Y' }">
								<input type="checkbox"  checked="checked" disabled="disabled"> 参与教师<br>
							</c:if>
							<c:if test="${eva.publicToJoinTeacherFlag == 'N' }">
								<input type="checkbox"  disabled="disabled"> 参与教师<br>
							</c:if>
						 </span>
					</li>
				</ul>
				
	</div>
	<script>
	function viewbzdetail(standardId){
		$.ajax({
			 url: '${root}/admin/evaStandard/view.do?standardId=' + standardId,
			 type: 'GET',
			 success: function(data) {
				 parent.Win.open({
					 	id:'bzview',
						title: "查看评课标准",
						html: data,
						mask:true,
						width: "800",
						height: "800"
					});
			 }
		});
	}
	
	</script>
</body>
</html>