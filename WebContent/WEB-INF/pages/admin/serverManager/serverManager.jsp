<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
    <link href="${root }/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${root }/public/calendar/WdatePicker.js"></script>
    <script type="text/javascript" src="${root }/public/js/basiccheck.js"></script>
</head>
<body>
<h3 id="cataMenu">
	<a href="javascript:;">系统设置</a> &gt; <a href="javascript:;">服务器管理</a>
</h3>
<div id="control">
	<div id="controlContent" style="padding-top: 10px;padding-left: 20px;">
		<h4>HTTP服务器配置</h4>
		  <div class="serverSet">
	    	<a id="addHTTPHost" class="btn btnGreen" href="javascript:;">新增服务器</a>
			 <c:if test="${!empty httpServer }">
		 		<c:forEach var="temp" items="${httpServer }">
		 			<form class="updateHTTPBoxForm">
		 				<ul class="hostList commonUL">
				 			<li>
				 			  <input type="hidden" name="id" value="${temp.id }"/>
			                  <label>服务器名称：</label><input name="serverName" type="text" value="${temp.serverName }" needcheck nullmsg="请输入服务器名称!" limit="1,20" limitmsg="很抱歉，名称超出最大长度20"/>
			                  <label>上传地址：</label><input name="uploadAddress" type="text" value="${temp.uploadAddress }" needcheck nullmsg="上传地址不能为空!" limit="1,100" limitmsg="很抱歉，地址超出最大长度100"/>
			                  <label>下载地址：</label><input name="downloadAddress" type="text" value="${temp.downloadAddress }" needcheck nullmsg="下载地址不能为空!" limit="1,100" limitmsg="很抱歉，地址超出最大长度100"/>
			                  <a href="javascript:;" class="btn btnGreen udateHTTPHost">修改</a>
			                  <a href="javascript:deletServer('${temp.id }','http');" class="btn">删除</a>
		              		</li>
            			</ul>
              		</form>
		 		</c:forEach>
      		</c:if>
      		<!-- ===========================添加HTTP=================================== -->
            <div class="addNewBox">
		    	<textarea class="newBoxBody" id="httpAdd">
					<form id="addHTTPBoxForm">
						<ul class="commonUL">
							<li><label class="labelText">服务器名称：</label> <input name="serverName" needcheck nullmsg="请输入服务器名称!" limit="1,20" limitmsg="很抱歉，名称超出最大长度20"/></li>
							<li><label class="labelText">上传地址：</label> <input name="uploadAddress" needcheck nullmsg="上传地址不能为空!" limit="1,100" limitmsg="很抱歉，地址超出最大长度100"/></li>
							<li><label class="labelText">下载地址：</label> <input name="downloadAddress" needcheck nullmsg="下载地址不能为空!" limit="1,100" limitmsg="很抱歉，地址超出最大长度100"/></li>
							<li class="center">
								<button type="submit" class="btn">确定</button>
								<a href="javascript:closeMe('httpWin');" class="btn btnGray udateHTTPHost">取消</a>
							</li>
						</ul>
					</form>
		    	</textarea>
		    </div>
	      </div>
	      <br />
       <h4>PMS服务器配置</h4>
		 <div class="serverSet">
	    	<a id="addPMSHost" class="btn btnGreen" href="javascript:;">新增服务器</a>
		 	<c:if test="${!empty pmsServer }">
			 	<c:forEach var="temp" items="${pmsServer }">
			 		<form class="updatePMSBoxForm">
						<ul class="hostList commonUL">
			               <li>
			                   <input name="id" type="hidden" value="${temp.id }" />
			                   <label>服务器名称：</label><input name="serverName" type="text" value="${temp.serverName }" needcheck nullmsg="请输入服务器名称!" limit="1,20" limitmsg="很抱歉，名称超出最大长度20"/>
			                   <label>PMS：</label><input name="serverAddress" type="text" value="${temp.serverAddress }" needcheck nullmsg="上传地址不能为空!" limit="1,100" limitmsg="很抱歉，地址超出最大长度100"/>
			                   <a href="javascript:;" class="btn btnGreen updatePMSHost">修改</a>
			                   <a href="javascript:deletServer('${temp.id }','pms');" class="btn">删除</a>
			               </li>
			            </ul>
		            </form>
	            </c:forEach>
            </c:if>
            <!-- ===========================添加PMS=================================== -->
            <div class="addNewBox">
		    	<textarea class="newBoxBody" id="pmsAdd">
					<form id="addPMSBoxForm">
						<ul class="commonUL">
							<li><label class="labelText" style="text-align: left;">服务器名称：</label> <input name="serverName" needcheck nullmsg="请输入服务器名称!" limit="1,20" limitmsg="很抱歉，名称超出最大长度20"/></li>
							<li><label class="labelText" style="text-align: left;">PMS：</label><input name="serverAddress" needcheck nullmsg="上传地址不能为空!" limit="1,100" limitmsg="很抱歉，地址超出最大长度100" /></li>
							<li class="center">
								<button type="submit" class="btn">确定</button>
								<a href="javascript:closeMe('pmsWin');" class="btn btnGray udateHTTPHost">取消</a>
							</li>
						</ul>
					</form>
		    	</textarea>
		    </div>
		    </div>	
	</div>
</div>
</body>

	<script>
		/* 绑定新增按钮 */
	 	$("#addHTTPHost").click(function(){
			//var html = $(this).parents(".addNewBox").find(".newBoxBody").val();
			var html = $("#httpAdd").val();
			Win.open({
				id:"httpWin",
				title : "添加服务器",
				width: 300,
				html : html
			});
			new BasicCheck({
					form : $id("addHTTPBoxForm"),
					ajaxReq : function(){
						var data = $("#addHTTPBoxForm").serializeArray();
						var url = "${root}/admin/server/addHttpServer.do";
						$.post(url ,data , function(code){
							if(code && code.result){
								Win.alert(code.message);
								window.location.href="${root}/admin/server/index.html";
							}else if(code && !code.result){
								Win.alert(code.message);
							}
						});
					},
					warm : function(o,msg){ 
		                Win.alert(msg);
		            }
			})
		});
	 	
		/* 绑定修改按钮 */
	 	$(".udateHTTPHost").click(function(){
	 		var thatForm = $(this).parents(".updateHTTPBoxForm");
			new BasicCheck({
				form : thatForm[0],
				ajaxReq : function(){
					var data = thatForm.serializeArray();
					var url = "${root}/admin/server/updateHttpServer.do";
					$.post(url ,data , function(code){
						if(code && code.result){
							Win.alert(code.message,2000,function(){
								window.location.href="${root}/admin/server/index.html";
							});
						}else if(code && !code.result){
							Win.alert(code.message,2000);
						}
					});
				}
			})
			$(this).parents(".updateHTTPBoxForm").submit();
		});
	
		/* 绑定PMS新增 */
	   $("#addPMSHost").click(function(){
			//var html = $(this).parents(".addNewBox").find(".newBoxBody").val();
			var html = $("#pmsAdd").val();
			Win.open({
				id:"pmsWin",
				title : "添加服务器",
				width: 300,
				html : html
			});
			new BasicCheck({
					form : $id("addPMSBoxForm"),
					ajaxReq : function(){
						var data = $("#addPMSBoxForm").serializeArray();
						var url = "${root}/admin/server/addPmsServer.do";
						$.post(url ,data , function(code){
							if(code && code.result){
								Win.alert(code.message);
								window.location.href="${root}/admin/server/index.html";
							}else if(code && !code.result){
								Win.alert(code.message);
							}
						});
					},
					warm : function(o,msg){
		                Win.alert(msg);
		            }
			})
		});
	   
		/* 绑定PMS修改 */
	   $(".updatePMSHost").click(function(){
	 		var thatForm = $(this).parents(".updatePMSBoxForm");
			new BasicCheck({
				form : thatForm[0],
				ajaxReq : function(){
					var data = thatForm.serializeArray();
					var url = "${root}/admin/server/updatePmsServer.do";
					$.post(url ,data , function(code){
						if(code && code.result){
							Win.alert(code.message, 2000, function(){
								window.location.href="${root}/admin/server/index.html";
							});
						}else if(code && !code.result){
							Win.alert(code.message, 2000);
						}
					});
				},
				warm : function(o,msg){ 
	                Win.alert(msg);
	            }
			})
			$(this).parents(".updatePMSBoxForm").submit();
		});
		
		function deletServer(id,type){
			Win.confirm({
				id:"deletServer",
				html:"确定删除服务器吗？"
			},function(){
				var data = new Array();
				var url = "${root}/admin/server/deletServer.do";
				data.push({"name":"id","value":id});
				data.push({"name":"type","value":type});
				$.post(url,data,function(code){
					if(code && code.result){
						Win.alert(code.message);
						window.location.href="${root}/admin/server/index.html";
					}else if(code && !code.result){
						Win.alert(code.message);
					}
				});
			});
			
		}
		
		function closeMe(winId){
			Win.wins[winId].close();
		}
	  </script>
</html>