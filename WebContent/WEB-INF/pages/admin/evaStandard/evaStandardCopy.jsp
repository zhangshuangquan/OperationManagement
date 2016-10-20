<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
<%@ include file="evaStandardCommon.jsp" %>
    <script>
    var totalItem = '${totalItem }';
    var totalSubItem = '${totalSubItem }';
    var totalScore = ' ${evaStandard.totalScore }';
    
    $(document).ready(function(){
 	  
		var validateStandard = function (){
    	
    	if($("input[name^='standardItemName_']").length < 1 ){
			Win.alert("未添加评估项");
			return false;
		}
    	
    	var standardName = $("#standardNameId").val();
    	if(standardName != null && standardName != ''){
    		var hasSameName = false;
	    	$.ajax({
	    		 url: '${root}/admin/evaStandard/checkUnique.do',
	    		 type: 'GET',
	    		 async:false,
	    		 data: {standardName:standardName , standardId:''},
	    		 success: function(data) {
	    			 hasSameName = data.result;
	    		 },
	    		 error: function(data) {
	                  alert("error:"+data.responseText);
	             }
	    	});
	    	
	    	if(!hasSameName){
	    		Win.alert("很抱歉，名称已存在，请重新输入");
	    		return false;
	    	}
    	}
		
    	var checkScore = true;
    	$("input[name^='standardItemScore_']").each(function(){
    		var score = $(this).val();
    		if($(this).css("display") != 'none' && (!isUnsignedInteger(score) || score < 2 || score > 100)){
    			checkScore = false; 
    		}
    	});
    	
    	$("input[name^='score_']").each(function(){
    		var score = $(this).val();
    		if(!isUnsignedInteger(score) || score < 2 || score > 100){
    			checkScore = false; 
    		}
    	});
    	
    	if(!checkScore){
    		Win.alert("很抱歉，分数只能是2到100的整数 ");
    		return false;
    	}
    	
    	var contentLen = true;
    	$("[name^='content_']").each(function(){
    		if($(this).val().length > 200){
    			contentLen = false;
    		}
    	});
    	
    	if(!contentLen){
    		Win.alert("很抱歉，子项内容超出最大长度200 ");
    		return false;
    	}
    	
    	
    	return true;
    };
  
    window.addEvaluationCheck = new BasicCheck({
		form: $id("copyEvaluation"),
		addition :validateStandard ,
		ajaxReq : function(){
			$.post('${root}/admin/evaStandard/copy/confirm.do', $("#copyEvaluation").serializeArray(), function(data){
				if(data.result){
					//$("#controlContent").html(data);
					frameElement.src = '${root}/admin/evaStandard/list.html' ;
				}else{
					Win.alert(data.message);
				}
			});
		},
		warm: function warm(o, msg) {
			Win.alert(msg);
		}
	});
    });

    </script>
    
</head>
<body>
<h3 id="cataMenu">
	<a href="javascript:;">评课管理</a> &gt; <a href="javascript:;">系统默认评估标准</a> &gt; <a href="javascript:;">复制</a>
</h3>

<div id="control">
	<div id="controlContent">
		<form id="copyEvaluation" action="">
			<input type="hidden" name="totalItem" id="totalItem" value="${totalItem }"/>
			<input type="hidden" name="totalSubItem" id="totalSubItem" value="${totalSubItem }"/>
			<input type="hidden" name="standardId" id="standardId" value="${evaStandard.standardId }"/>
			<ul class="commonUL">
				<li>
					<label class="text mr20"><b><span class="red">*</span>名称：</b></label>
					<span class="cont">
						<label class="mr10">
							<input id="standardNameId"  name="standardName" type="text" limit="1,40" limitmsg="很抱歉，名称超过最大长度20" needcheck nullmsg="请输入名称!" value="${evaStandard.standardName }"/> 
						</label>  
						<label class="mr100">您最多可输入20个字符</label>
						<label class="mr10">标准总分： </label> <label  id="totalScoreId"> ${evaStandard.totalScore }</label>  <label> 分</label>
					</span>
				</li>
				
				<li>
					<label class="text mr20"><b><span class="red">*</span>学科：</b></label>
					<span class="cont">
						<label class="mr10">
							<select id="subjectId" name="subjectId" needcheck nullmsg="请选择学科!">
								<option value="">请选择</option>
								<c:forEach items="${subjects }" var="subject">
									<c:if test="${subject.baseSubjectId == evaStandard.subjectId }">
										<option value="${subject.baseSubjectId }" selected>${subject.subjectName }</option>
									</c:if>
									<c:if test="${subject.baseSubjectId != evaStandard.subjectId }">
										<option value="${subject.baseSubjectId }">${subject.subjectName }</option>
									</c:if>
									
								</c:forEach>
							</select>
						</label>  
						
					</span>
				</li>
				
				<li>
					<label class="text mr20"><b><span class="red">*</span>评估项：</b></label>
					<span class="cont deepBgWrap">
							
							<c:forEach items="${evaStandard.evaStandardItems }" var="item">
							<div id="itemId_${item.standardItemId }">
							<ul class="commonUL borderBox lightBgWrap mg10">
								<li>
									<label class="text"><span class="red">*</span>项目名：</label> 
									<span class="cont">
										<input class="mr10" name="standardItemName_${item.standardItemId }" type="text" limit="1,20" limitmsg="很抱歉，项目名超过最大长度10" needcheck nullmsg="请输入项目名!" value="${item.standardItemName }"/>
										<label class="mr50">您最多可输入10个字符</label> 
					 	    			<label id="standardItemScore_${item.standardItemId }_label"
					 	    				<c:if test="${fn:length(item.standardItemChildren) > 0}">
					 	    					style="display:none;"
					 	    				</c:if>
					 	    			>分数：</label>
										<input id="standardItemScore_${item.standardItemId }" name="standardItemScore_${item.standardItemId }" type="text" maxlength="3" onblur="calculateScore();" value="${item.score }"
										 	<c:if test="${fn:length(item.standardItemChildren) > 0}">
												style="display:none;"
											</c:if>
										/>
					 	    			<a style="padding-left:50px;color:#cc3300" href="javascript:doRemoveItem(itemId_${item.standardItemId });">删除</a> 
									</span>
								</li>
								
								<c:forEach items="${item.standardItemChildren }" var="child" varStatus="status">
					 	    		<div id="subItemId_${child.standardItemChildId}">
					 	    			<li> 
					 	    				<label class="text">&nbsp;</label> 
											<span class="cont verticalTop"> 
											<label>子项内容：</label> 
											<span class="counterBox w500 clearfix inlineBlock mr20">
											<textarea class="w500" limit-len="200" id="content" name="content_${child.standardItemChildId}">${child.content }</textarea>
											<p class="fr">您还能输入<b class="red limitCount">${200 - fn:length(child.content)}</b>字</p>
											</span>
											<label>分数：</label>
											<input name="score_${child.standardItemChildId}" type="text" maxlength="3"  value="${child.score }"  onblur="calculateScore(this.value);"/>
												<a href="javascript:doRemoveItemChild(subItemId_${child.standardItemChildId});showStandardItemScore(${item.standardItemId });" style="color:#cc3300;padding-left:50px;">删除</a> 
											</span>
										</li>
					 	    		</div>
					 	    	</c:forEach>
								<div id="showNewSubItemId_${item.standardItemId }"></div> 
								
								<li>
									<label class="text">&nbsp;</label> 
									<span class="cont">
										<a href="#" onclick="javascript:addNewSubItem('${item.standardItemId }'); hiddenStandardItemScore('${item.standardItemId }');">+添加子项内容</a>
									</span>
								</li>
								</ul>
								</div>
							</c:forEach>
							
						<div id="showNewItemId"></div>
				 	</span>
				</li>
				<li>
					<label class="text mr20">&nbsp;</label>
					<a href="javascript:addNewItem();">+添加项目</a>
				</li>
				
				<li>
			
				<li>
					<center>
						<input class="btn mr20" type="submit" name="publish" id="publish"  value="发布" />
						<input class="btn btnGray"  type="button" name="cancel" id="cancel"  value="取消" onClick="javascript:doCancel();"/>
					</center>
				</li>
				
			</ul>
	</form>
</div>
</div>
</body>
</html>