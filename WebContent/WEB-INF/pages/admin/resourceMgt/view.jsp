<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
</head>
<body>
<h3 id="cataMenu">
	<a href="javascript:;">前台内容管理</a> &gt; <a href="javascript:;">资源管理</a>&gt; 
	<a href="javascript:;"><c:if test="${column eq 'video' }">视频</c:if><c:if test="${column ne 'video' }">文档</c:if>类资源详情</a>
</h3>
<div id="control">
	<div id="controlContent">
		<div class="showWrap">
				<div class="infoBox fr">
					<ul class="commonUL">
					    <li>
							<label style="font-weight: bold;font-size: larger;">${resource.resourceName}</label>
						</li>
						<li>
							<label><b>简介：</b></label>
							${resource.resourceBrief }
						</li>
						<li>
							<div class="wHalf fl">
								<label><b>学段：</b></label>
								${resource.semesterName }							
							</div>
							<div class="wHalf fl">
								<label><b>发布时间：</b></label>
								<fmt:formatDate value="${resource.createTime}" pattern="yyyy年MM月dd日 HH:mm"/>
							</div>
						</li>
						<li>
						     <div class="wHalf fl">
								    <label><b>年级：</b></label>					   
									${resource.classlevelName }
							 </div>
						     <c:if test="${column eq 'doc'}">
								<div class="wHalf fl">
								    <label><b>作者：</b></label>					   
									${resource.author}
								</div>
							 </c:if>
							 <c:if test="${column eq 'video'}">
								<div class="wHalf fl">
								    <label><b>主讲人：</b></label>					   
									${resource.author}
								</div>
							 </c:if>
						</li>
						<li>
						    <div class="wHalf fl">
								<label><b>学科：</b></label>
								${resource.subjectName }
							</div>
							<div class="wHalf fl">
								<label><b>发布人：</b></label>
								${resource.createUserName}								
							</div>							
						</li>
						<li>
							<div class="wHalf fl">
								    <label><b>分册：</b></label>					   
									${resource.volumeName}
							</div>
						   <c:if test="${column eq 'doc'}">
								<div class="wHalf fl">
									<label><b>文件大小：</b></label>
									<fmt:formatNumber value="${resource.resourceSize/1024/1024 }" pattern="#0.0#"/>M
								</div>
							 </c:if>
							 <c:if test="${column eq 'video'}">
								<div class="wHalf fl">
									<label><b>时长：</b></label>
									<fmt:formatNumber type="number" value="${(resource.duration - resource.duration%(1000*60*60))/1000/60/60 }"  maxFractionDigits="0" pattern="00"/>:
								 	<fmt:formatNumber type="number" value="${(resource.duration%(1000*60*60) - (resource.duration%(1000*60)))/1000/60}"  maxFractionDigits="0" pattern="00"/>:
								 	<fmt:formatNumber type="number" value="${resource.duration%(1000*60)/1000  }"  maxFractionDigits="0"/>
								</div>
							</c:if>
						</li>
						<li>
						    <div class="wHalf fl">
								    <label><b>章：</b></label>					   
									<c:if test = "${resource.baseChapterId ne null }">
									  ${resource.chapterName}
									</c:if>
							</div>
							<div class="wHalf fl">
								<label><b>观看次数：</b></label>
								<b class="orange">${resource.viewCnt}</b> 次
							</div>
						</li>
						<li>
						     <div class="wHalf fl">
								    <label><b>节：</b></label>					   
									<c:if test = "${resource.baseSectionId ne null }">
							       ${resource.sectionName}
							        </c:if>
							</div>
						   <div class="wHalf fl">
								<label><b>下载次数：</b></label>
								<b class="orange">${resource.downloadCnt}</b> 次
							</div>
						</li>
						<li>
							<label><b>知识点：</b></label>
							<c:forEach var="klg" items="${rKnowleges }" varStatus="flag">
							   <c:if test="${flag.index eq 0 }">
							       ${klg. endKnowledgeIdName}
							   </c:if>
							   <c:if test="${flag.index ne 0 }">
							        , ${klg. endKnowledgeIdName}
							   </c:if>
							</c:forEach>
						</li>
						<li class="verticalTop">
							<label><b>评分：</b></label>
							<span class="starRate disabled" ><a class="star<fmt:formatNumber type="number" value="${resource.ratingAvg}" maxFractionDigits="0"/>" href="javascript:;"></a></span><b class="orange"><fmt:formatNumber type="number" value="${resource.ratingAvg}" maxFractionDigits="1"/> </b>分						
						</li>
						<li>
							<c:if test="${resource.highDefinePath !=null &&  resource.highDefinePath ne ''}">
								<a href="javascript:;" dir="high" class="btn mr10 btnGray playTip">高清</a>
								<a href="javascript:;" dir="normal" class="btn playTip">普清</a>
							</c:if>
						</li>
					</ul>
				</div>
				<div class="showBox" id="videoShow" style="display: none;">&nbsp;</div>
				 <div class="showBox" id="docShow" style="display: none;">&nbsp;</div>
				 <script>
				 var myPlayer = null;
			     var column  = '${column}';
			     var Pad;
				 $(document).ready(function(){
					 $(".playTip").click(function(){
						 var $elem = $(this);
						 if(!$elem.hasClass("btnGray")){
							 $(".playTip").removeClass("btnGray");
							 $elem.addClass("btnGray");
							 var type = $elem.attr("dir");
							 var id = '${resource.resourceId}';
							 if(myPlayer != null){
								 myPlayer.playFile("${root}/ResVideoServlet/"+id+"."+type+".mp4");
							 }; 
						 }
					 });
					 
					 if(column == 'doc'){
						   $("#docShow").show();
						 //白板翻页操作
							var FlashKeyEvent = {
								catchHtmlKey : function(){
									events.addEvent(document,'keyup',function(){
										var e = arguments[0] || window.event;
										var target = e.srcElement ||  e.target;
										if(target.type == 'textarea' ||  target.type == 'application/x-shockwave-flash') return false; 
										FlashKeyEvent.applyPage(e.keyCode);
									});
								},
								catchSwfKey : function(code){
									// CR_writepad.swf中调用 （当鼠标聚焦在swf上时，ie下无法catch到swf内的鼠标事件，所以各浏览器统一在swf内捕获再抛出）
									 FlashKeyEvent.applyPage(code);
								},
								applyPage : function(code){
									if(!Pad || !Pad.pageUp) return false;
									switch(code){
										case 33:
										case 37:
										case 38:
											Pad.pageUp();
											break;	
										case 34:
										case 39:
										case 40:
											Pad.pageDown();
											break;	
										case 36:
											Pad.pageFirst();
											break;	
										case 35:
											Pad.pageLast();
											break;	
									}
								}
							};
							FlashKeyEvent.catchHtmlKey();
							
							function createWritepad(){
								var myParams = {
									auth : 1,
									phphost : "${root}",
									meetId : "${resource.resourceId}",
									myID : 222
								}
								var paramVars = "";
								for(var i in myParams){
									paramVars += i+"="+myParams[i]+"&";
								};
								Pad = FlashPlayer($id("docShow"),"${root}/public/flash/CR_writepad/Pad4Java.swf?"+paramVars);
							}
							setTimeout(createWritepad,300);
					   } else if (column == 'video'){
						        $("#videoShow").show();	
						        
								var myParams = {
								    skin : "${root}/public/flvPlayback/MinimaFlatCustomColorAll.swf",
								    url : "${root}/ResVideoServlet/${resource.resourceId}.mp4",
								  //thumb : "play.png",
								    autoplay : true
								};
								var paramVars = "";
								for(var i in myParams){
								    paramVars += i+"="+myParams[i]+"&";
								};
								myPlayer = new FlashPlayer($id("videoShow"),"${root}/public/flvPlayback/myflvPlayBack.swf?"+paramVars);
					   }
				 });
				 </script>
			</div>
   </div>
</div>
</body>
</html>