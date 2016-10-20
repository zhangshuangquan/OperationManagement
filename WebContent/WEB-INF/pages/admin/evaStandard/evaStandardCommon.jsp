    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <script src="${root }/public/js/basiccheck.js"></script>
    <script>
    function addNewItem(){
     	totalItem = parseInt(totalItem) + 1;
     	$("#totalItem").val(totalItem);
     	
     	var itemId = "itemId_" + totalItem;
     	var standardItemScoreStr = "standardItemScore_" + totalItem;
     	var itemHtml = 
     		'<div id="' + itemId + '">'+
     		' <ul class="commonUL borderBox lightBgWrap mg10">' + 
    		'	<li>' +
    		'		<label class="text"><span class="red">*</span>项目名：</label> ' +
    		'		<span class="cont"> ' + 
    		'			<input class="mr10" name="standardItemName_' + totalItem + '" type="text" limit="1,20" limitmsg="很抱歉，项目名超过最大长度10" needcheck nullmsg="请输入项目名!"/> '+
    		'			<label class="mr50">您最多可输入10个字符</label> ' +
    		' 		<label id="' + standardItemScoreStr + '_label">分数：</label> '+
    		'		<input id="' + standardItemScoreStr + '"name="' + standardItemScoreStr + '" type="text" limit="0,2" limitmsg="很抱歉，分数超过最大长度2" onblur="calculateScore(this.value);"/>'+
    		'		<a style="padding-left:50px;color:#cc3300;" href="javascript:doRemoveItem(' + itemId + ');">删除</a></p> ' +	
    		'		</span> ' +
    		'	</li> ' +
    		'	<div id="showNewSubItemId_' + totalItem + '"></div> ' +	
    		'	<li> ' +
    		'		<label class="text">&nbsp;</label> ' +
    		'		<span class="cont"> ' +
    		'	    <a href="#" onclick="javascript:addNewSubItem(' + totalItem + ');hiddenStandardItemScore('+ totalItem + ');">+添加子项内容</a> '+
    		'		</span> ' +
    		'	</li> ' +
    		'</ul> ' +
    		'</span> ' + 
    		'</div>';
    	    	
    	    $("#showNewItemId").append(itemHtml);
    	    addEvaluationCheck.addBindCheck();
    }


    function addNewSubItem(itemId){
    	totalSubItem = parseInt(totalSubItem) + 1;
    	$("#totalSubItem").val(totalSubItem);
    	var subItemId = "subItemId_" + itemId + "_" + totalSubItem;
    	var subItemHtml = 
    	'<div id="' + subItemId + '">' + 
    	'<li> ' + 
    	'<label class="text"><b>&nbsp;</b></label> ' +
    	'<span class="cont verticalTop"> ' +
    	'	<label>子项内容：</label> ' + 
    	'   <span class="counterBox w500 clearfix inlineBlock mr20"> ' +
		'   	<textarea id="content" class="w500" limit-len="200" name="content_' + itemId + '_' + totalSubItem + '"></textarea> ' + 
		' 			<p class="fr">您还能输入<b class="red limitCount">200</b>字</p> ' + 
		' 	</span> ' +
		'	<label>分数：</label>' +
    	'	<input name="score_' +itemId + '_' + totalSubItem + '" type="text" maxlength="3" onblur="calculateScore(this.value);"/>' +
    	'		<a href="javascript:doRemoveItemChild(' + subItemId + ');showStandardItemScore(' + itemId + ')" style="color:#cc3300;padding-left:50px;">删除</a> ' + 
    	'</span>' +
    	'</li>' +
      '</div>';
    	
    	$("#showNewSubItemId_" + itemId).append(subItemHtml);
    }
		
		function hiddenStandardItemScore(itemId){
			$("#standardItemScore_" + itemId).val("");
			$("#standardItemScore_" + itemId).hide();
			$("#standardItemScore_" + itemId + "_label").hide();
			calculateScore();
		}
		
		function showStandardItemScore(itemId){
			if($("input[name^='score_" + itemId + "']").length == 0){
				$("#standardItemScore_" + itemId).val("");
				$("#standardItemScore_" + itemId).show();
				$("#standardItemScore_" + itemId + "_label").show();
			}
	    	
		}
		
		function doCancel(){
			frameElement.src = '${root}/admin/evaStandard/list.html' ;
			/*$.ajax({
	    		 url: '${root}/admin/evaStandard/list.html',
	    		 type: 'PUT',
	    		 success: function(data) {
	    			 $("#controlContent").html(data);
	    		 },
	    		 error: function(data) {
	                  alert("error:"+data.responseText);
	             }
	    	});*/
		}
		
		function doRemoveItemChild(itemChildId){
			$(itemChildId).remove();
			addEvaluationCheck.addBindCheck();
			calculateScore();
		}
		
		function doRemoveItem(itemId){
			if($("[id^='itemId_']").length <= 1 ){
				Win.alert("评估项不能为空");
				return;
			}
			
			$(itemId).remove();
			addEvaluationCheck.addBindCheck();
			calculateScore();
		}
		
		function isNullOrEmpty(strVal) {
			if (strVal == '' || strVal == null || strVal == undefined) {
			return true;
			} else {
			return false;
			}
		}
		
		function calculateScore(){
			
			totalScore = 0;
	    	
	    	$("input[name^='standardItemScore_']").each(function(){
	    		
	    		if($.trim($(this).val()) != ''){
	    			totalScore = parseInt(totalScore) + parseInt($(this).val()); 
	    		}
	    		 
	    	});
	    	
	    	$("input[name^='score_']").each(function(){
	    		if($.trim($(this).val()) != ''){
	    			totalScore = parseInt(totalScore) + parseInt($(this).val()); 
	    		}
	    		 
	    	});
	    	
			$("#totalScoreId").html(totalScore);
		}
		
		function   isUnsignedInteger(a)
		{
		    var   reg =/(^[1-9]\d*$)/;
		    return reg.test(a);
		}
 
    </script>
   
