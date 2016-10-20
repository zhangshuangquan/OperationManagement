<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
    <script>
		function createShowingTable(data,total) {
			$(".totalNum").html(total);
			 //获取后台传过来的jsonData,并进行解析  
			//alert("-----   进入当前的数据展现:" + data.pageCount);
			var dataArray = data;
			
			//此处需要让其动态的生成一个table并填充数据  
			var tableStr = "";
			var len = dataArray.length;
			if (len > 0) {
				for ( var i = 0; i < len; i++) {
					tableStr = tableStr + "<tr><td>" + now('y-m-d h:i:s',dataArray[i].createTime)
					+ "</td><td id='standardName_"+dataArray[i].standardId + "'>" + dataArray[i].standardName
					+ "</td><td>" + dataArray[i].subjectName
					+ "</td><td>" + dataArray[i].totalScore
					+ "</td><td>" + dataArray[i].usedCount
					+ "</td><td> " +
						"<a href=\"javascript:doView('" + dataArray[i].standardId  + "');\">查看</a>&nbsp;" +
			        	"<a href=\"javascript:doEdit('" + dataArray[i].standardId  + "');\">编辑</a> &nbsp;"  +
			        	"<a href=\"javascript:doCopy('" + dataArray[i].standardId  + "');\">复制</a> &nbsp;"  +
			        	"<a class=\"delLink\" href=\"javascript:doRemove('"  +dataArray[i].standardId + "');\">删除</a>" 
					+ "</td></tr>";
				} 
			} else {
				tableStr += '<tr><td colspan="6">暂无评估标准信息</td></tr>';
			}
				
			$("#evaStandards").html(tableStr);
			window.scrollTo(0,0);
		}
	    
	    function doAdd(){
	    /*	$.ajax({
	    		 url: '${root}/admin/evaStandard/add.html',
	    		 type: 'PUT',
	    		 success: function(data) {
	    			 $("#controlContent").html(data);
	    		 }
	    	});*/
	    	frameElement.src = '${root}/admin/evaStandard/add.html' ;
	    }
	    
	    function doRemove(standardId){
	    	
	    	Win.confirm({"id":"deleteConfirm","html":"<span class=\"dialog_Inner\">确定要删除吗?</span>"},function(){
	    		$.ajax({
		    		 url: '${root}/admin/evaStandard/remove.do?standardId=' + standardId ,
		    		 type: 'PUT',
		    		 success: function(data) {
		    			 if(data.result){
		    				 mySplit.reload();
		    			 }else{
		    				 Win.alert(data.message);
		    			 }
		    		 }
		    	});
			}
	    	,true);	
	    }
	    
	    function doEdit(standardId){
	    	frameElement.src =  '${root}/admin/evaStandard/edit.html?standardId=' + standardId;
	    	/*$.ajax({
	    		 url: '${root}/admin/evaStandard/edit.html?standardId=' + standardId,
	    		 type: 'PUT',
	    		 success: function(data) {
	    			 $("#controlContent").html(data);
	    		 }
	    	});*/
	    }
	    
	    function doCopy(standardId){
	    	
	    	frameElement.src =  '${root}/admin/evaStandard/copy.html?standardId=' + standardId;
	    	/*$.ajax({
	    		 url: '${root}/admin/evaStandard/copy.html?standardId=' + standardId,
	    		 type: 'PUT',
	    		 success: function(data) {
	    			 $("#controlContent").html(data);
	    		 }
	    	});*/
	    }
	    
		function doView(standardId) {
			
			var standardName = html2Escape($("#standardName_" + standardId).text());
			 Win.open({
					title: standardName,
					url: '${root}/admin/evaStandard/view.html?standardId=' + standardId,
					mask:true,
					width: "800",
					height: "800"
				});
			 
		/*	$.ajax({
	    		 url: '${root}/admin/evaStandard/view.do?standardId=' + standardId,
	    		 type: 'GET',
	    		 success: function(data) {
	    			 Win.open({
	    					title: "查看评课标准",
	    					html: data,
	    					mask:true,
	    					width: "800",
	    					height: "800"
	    				});
	    		 }
	    	});*/
		}
		
		var html2Escape = function(str) {
		    return str.replace(/[<>&"]/g, function(c) {
		        return {
		            '<': '&lt;',
		            '>': '&gt;',
		            '&': '&amp;',
		            '"': '&quot;'
		        }[c];
		    });
		};
    </script>
</head>
<body>
<h3 id="cataMenu">
	<a href="javascript:;">评课管理</a> &gt; <a href="javascript:;">系统默认评估标准</a>
</h3>
<div id="control">
	<div id="controlContent">
	    <div class="totalPageBox">
	    	<input class="btn fr" type="button" name="add" id="add" value="新增评估标准" onclick="doAdd();"/>
	    	总共<span class="totalNum">0</span> 条数据
	     </div>
		<table class="tableBox">
			<tr>
					<th width="5%">新增日期</th>
					<th width="10%">名称</th>
					<th width="10%">学科</th>
					<th width="8%">总分</th>
					<th width="8%">评课使用次数</th>
					<th width="8%">操作</th>
			</tr>
	    	<tbody id="evaStandards"></tbody>
		</table>
		<div id="pageNavi"></div>
		<script>
		var mySplit = new SplitPage({
	        node : $id("pageNavi"),
	        url :  '${root}/admin/evaStandard/pagelist.do',
	        count : 20,
	        callback : createShowingTable
	    });		
		</script>
	</div>
</div>
</body>
</html>