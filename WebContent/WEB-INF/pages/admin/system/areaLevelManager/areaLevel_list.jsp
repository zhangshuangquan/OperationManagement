<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../common/meta.jsp"%>
<style>	
.commonUL li label.text {
    float: left;
    text-align: right;
    width: 100px;
}
</style>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">系统设置</a> &gt; <a href="javascript:;">行政区级别管理</a>
	</h3>
	<div id="control">
		<div id="controlContent">
			<div class="totalPageBox">
				<div class="fr">
					<a id="addLevel" class="btn btnGreen" href="javascript:;">新增级别</a>
				</div>
				<div>总共<span class="totalNum" id="totalNum">${fn:length(areaLevels) }</span> 条数据</div>
			</div>
			<table class="tableBox">
				<tr>
					<th width="5%">序号</th>
					<th width="20%">电脑-级别名称</th>
					<th width="20%">手机-级别名称</th>
					<th width="10%">级别等级</th>
					<th width="45%">操作</th>
				</tr>
				<c:forEach items="${areaLevels }" var="areaLevel" varStatus="status">
					<tr id="${areaLevel.baseConfigAreaLevelId }">
						<td>${status.count }</td>
						<td>${areaLevel.levelTitle }</td>
						<td>${areaLevel.mobileTitle }</td>
						<td>${areaLevel.areaLevel }</td>
						<td><a class="editAreaLevel" href="javascript:;">编辑</a>&nbsp;&nbsp;
						<a class="delLink deleteAreaLevel" href="javascript:;">删除</a></td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div id="addLevelBox" class="addNewBox">
	    	<textarea class="newBoxBody" >
				<form id="addNewBoxForm">
				<input type="hidden" name="baseConfigAreaLevelId" id="baseConfigAreaLevelId"/>
 				<ul class="commonUL">
					<li>
				        <label class="text">电脑-级别名称：</label>
				        <span class="cont">
				        	 <input type="text" id="levelTitle" name="levelTitle" needcheck nullmsg="请输入级别名称！" limit="1,20" limitmsg="很抱歉，级别名称最大长度为10个字！"/>
				        </span>
			       	</li>
			       	<li>
				        <label class="text">手机-级别名称：</label>
				        <span class="cont">
				        	<input type="text" id="mobileTitle" needcheck nullmsg="请输入级别名称！" limit="1,20" limitmsg="很抱歉，级别名称最大长度为10个字！" name="mobileTitle"  />
				        </span>
			       	</li>
			       	<li>
				        <label class="text">级别等级：</label>
				        <span class="cont">
				        	<select id="areaLevel" name="areaLevel" needcheck nullmsg="请输入级别等级！">
				        		<option value="1">1</option>
				        		<option value="2">2</option>
				        		<option value="3">3</option>
				        		<option value="4">4</option>
				        		<option value="5">5</option>
				        		<option value="6">6</option>
				        		<option value="7">7</option>
				        		<option value="8">8</option>
				        		<option value="9">9</option>
				        		<option value="10">10</option>
				        	</select>
				        </span>
			       	</li>
			       	<li class="center">
			       		<input type="submit" class="submit btn mr10"  value="确定" />
			       		<input type="button" class="btn btnGray" onclick="Win.wins.addLevelWin.close();" value="取消" />
			       	</li>
			    </ul>	
				</form>
	    	</textarea>
	    </div>
	    <script>
		    $("#addLevel").click(function(){
				var html = $("#addLevelBox").find(".newBoxBody").val();
				Win.open({
					id:"addLevelWin",
					title : "添加行政区级别",
					width : 400,
					html : html
				});
				new BasicCheck({
 					form : $id("addNewBoxForm"),
 					ajaxReq : function(){
 						var data = $("#addNewBoxForm").serializeArray();
						$.post("${root}/admin/system/areaLevel/addAreaLevel.do",data,function(code){
							if(code && code.result){
								Win.alert("添加成功！");
								Win.wins.addLevelWin.close();
								window.location.reload();
							}else{
								Win.alert(code?code.message:"添加失败！");
							}
						});
 					}
				});
			});
		    
		    $(".editAreaLevel").click(function(){
		    	var id = $(this).parents("tr").attr("id");
		    	var html = $("#addLevelBox").find(".newBoxBody").val();
				Win.open({
					id:"addLevelWin",
					title : "编辑行政区级别",
					width : 400,
					html : html
				});
				
				$.post("${root}/admin/system/areaLevel/getAreaLevel.do",{id:id},function(data){
					if(data){
						$("#baseConfigAreaLevelId").val(data.baseConfigAreaLevelId);
						$("#levelTitle").val(data.levelTitle);
						$("#mobileTitle").val(data.mobileTitle);
						$("#areaLevel").val(data.areaLevel);
					}
					
				});
				new BasicCheck({
 					form : $id("addNewBoxForm"),
 					ajaxReq : function(){
 						var data = $("#addNewBoxForm").serializeArray();
						$.post("${root}/admin/system/areaLevel/editAreaLevel.do",data,function(code){
							if(code && code.result){
								Win.alert("修改成功！");
								Win.wins.addLevelWin.close();
								window.location.reload();
							}else{
								Win.alert(code?code.message:"修改失败！");
							}
						});
 					}
				});
		    });
		    
		    $(".deleteAreaLevel").click(function(){
		    	var id = $(this).parents("tr").attr("id");
		    	Win.confirm({id:"deleteWin",html:"确定删除吗？"},function(){
		    		$.post("${root}/admin/system/areaLevel/deleteAreaLevel.do",{id:id},function(code){
						if(code && code.result){
							Win.alert("删除成功！");
							window.location.reload();
						}else{
							Win.alert(code?code.message:"删除失败！");
						}
					});
		    	},true);
		    });
	    </script>
	</div>
</body>
</html>