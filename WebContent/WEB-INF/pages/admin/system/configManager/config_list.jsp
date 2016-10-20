<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../common/meta.jsp" %>
    <script type="text/javascript" src="${root }/public/js/basiccheck.js"></script>
</head>
<body>
<h3 id="cataMenu">
	<a href="javascript:;">系统设置</a> &gt; <a href="javascript:;">参数设置</a>
</h3>
<div id="control">
	<div id="controlContent" style="padding-top: 10px;padding-left: 20px;">
		<h4>系统参数</h4>
		  <div class="serverSet">
			 <c:if test="${!empty sysConfigs }">
		 		<c:forEach var="temp" items="${sysConfigs }">
		 			<form class="updateForm">
		 				<ul class="hostList commonUL">
				 			<li data-id="${temp.baseConfigId }">
				 			  <input name="oldId" type="hidden" value="${temp.baseConfigId }" />
			                  <label>参数ID：</label><input name="baseConfigId" style="border: 0;" readonly="readonly" value="${temp.baseConfigId }"/>
			                  <label>参数内容：</label><input name="configValue" type="text" value="${temp.configValue }" needcheck nullmsg="参数内容不能为空!" limit="1,100" limitmsg="很抱歉，参数内容超出最大长度100"/>
			                  <label>备注：</label><input name="remark" type="text" value="${temp.remark }" needcheck allownull limit="1,200" limitmsg="很抱歉，备注超出最大长度200"/>
			                  <a href="javascript:;" class="btn btnGreen udateConfig">修改</a>
		              		</li>
            			</ul>
              		</form>
		 		</c:forEach>
      		</c:if>
	      </div>
	      <br />
       <h4>课堂参数</h4>
		 <div class="serverSet">
		 	<c:if test="${!empty meetConfigs }">
			 	<c:forEach var="temp" items="${meetConfigs }">
			 		<form class="updateForm">
						<ul class="hostList commonUL">
			               <li data-id="${temp.baseConfigId }">
			                   <input name="oldId" type="hidden" value="${temp.baseConfigId }" />
			                   <label>参数ID：</label><input name="baseConfigId" type="text" value="${temp.baseConfigId }" needcheck reg="^meet\.[0-9a-zA-Z_]+$" errormsg="很抱歉，参数ID只能是'meet.'开头的50位以内的数字英文组合！" nullmsg="参数ID不能为空!" limit="1,50" limitmsg="很抱歉，参数ID超出最大长度50"/>
			                   <label>参数内容：</label><input name="configValue" type="text" value="${temp.configValue }" needcheck allownull limit="1,100" limitmsg="很抱歉，参数内容超出最大长度100"/>
			                   <label>备注：</label><input name="remark" type="text" value="${temp.remark }" needcheck allownull limit="1,200" limitmsg="很抱歉，备注超出最大长度200"/>
			                   <a href="javascript:;" class="btn btnGreen udateConfig">修改</a>
			                   <a href="javascript:;" class="btn deleteConfig">删除</a>
			               </li>
			            </ul>
		            </form>
	            </c:forEach>
            </c:if>
            <div class="addNewBox">
		    	<textarea class="newBoxBody" >
					<form id="addForm">
						<ul class="commonUL">
							<li><label class="labelText">参数ID：</label> <input name="baseConfigId" type="text" needcheck reg="^meet\.[0-9a-zA-Z_]+$" errormsg="很抱歉，参数ID只能是'meet.'开头的50位以内的数字英文组合！" nullmsg="参数ID不能为空!" limit="1,50" limitmsg="很抱歉，参数ID超出最大长度50"/></li>
							<li><label class="labelText">参数内容：</label> <input name="configValue" type="text" needcheck allownull limit="1,100" limitmsg="很抱歉，参数内容超出最大长度100"/></li>
							<li><label class="labelText">备注：</label> <input name="remark" type="text" value="${temp.remark }" needcheck allownull limit="1,200" limitmsg="很抱歉，备注超出最大长度200"/></li>
							<li class="center"><button type="submit" class="btn">确定</button></li>
						</ul>
					</form>
		    	</textarea>
		    	<a id="addConfig" class="btn btnGreen" href="javascript:;">新增</a>
		    </div>
		    </div>	
	</div>
</div>
</body>
	<script>
		$(".udateConfig").click(function(){
			var thatForm = $(this).parents(".updateForm");
			new BasicCheck({
				form : thatForm[0],
				ajaxReq : function(){
					var data = thatForm.serializeArray();
					var url = "${root}/admin/system/config/editConfig.do";
					$.post(url ,data , function(code){
						if(code && code.result){
							Win.alert("修改成功！");
							window.location.href="${root}/admin/system/config/index.html";
						}else if(code && !code.result){
							Win.alert(code.message);
						}
					});
				},
				warm : function(o,msg){ 
	                Win.alert(msg);
	            }
			});
			thatForm.submit();
		});
	   $("#addConfig").click(function(){
			var html = $(this).parents(".addNewBox").find(".newBoxBody").val();
			Win.open({
				title : "添加参数",
				width: 300,
				html : html
			});
			new BasicCheck({
					form : $id("addForm"),
					ajaxReq : function(){
						var data = $("#addForm").serializeArray();
						var url = "${root}/admin/system/config/addConfig.do";
						$.post(url ,data , function(code){
							if(code && code.result){
								Win.alert("添加成功！");
								window.location.href="${root}/admin/system/config/index.html";
							}else if(code && !code.result){
								Win.alert(code.message);
							}
						});
					},
					warm : function(o,msg){ 
		                Win.alert(msg);
		            }
			});
		});
	   
	   $(".deleteConfig").click(function(){
		   var id = $(this).parents("li").attr("data-id");
		   Win.confirm({
				id:"deletConfig",
				html:"确定删除吗？"
			},function(){
				var url = "${root}/admin/system/config/deleteConfig.do";
				$.post(url,{id:id},function(code){
					if(code && code.result){
						Win.alert("删除成功！");
						window.location.href="${root}/admin/system/config/index.html";
					}else if(code && !code.result){
						Win.alert(code.message);
					}
				});
			},true);
	   });
	  </script>
</html>