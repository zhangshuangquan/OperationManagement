<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script src="${root }/public/js/basiccheck.js"></script>
<script type="text/javascript" src="${root}/public/js/ajaxfileupload.js"></script>
<script>

var domid = frameElement.getAttribute("domid");

</script>
<style>
 
.commonUL li label.text{width:90px;}
</style>
<head>
<body>
	<div class="commonWrap" style="padding:10px;">
		<div id="downloadModel" class="addNewBox" >
			<a id="addOrgUserBatch" class="btn btnGreen" href="${root }/admin/commons/downloadUserModel.do?userType=${userType}">模板下载</a>
		</div>
		<div id="uploadExcel">
			<ul class="commonUL">
				<li>1、请先下载模板，录入数据后导入。</li>
				<li>2、请选择需要导入的Excel文件,文件格式必须为xls后缀。</li>
				<li><label class="text">Excel导入：</label>
					<span class="cont">
						<input type="file" name="malGuideFile" class="malGuideFile" id="malGuideFile" />
					</span>
				</li>
				<li class="center">
				<input type="submit" class="submit btn mr10" value="确定" id="btnSubmit" onclick="submitForm();" />
		  		<input type="button" class="btn btnGray" value="取消"  id="btnCancel" onclick="closeMe();" />
			</li>
			</ul>
		</div>
	</div>
	<script>
		function ajaxFileUpload() {
	        $.ajaxFileUpload({
	            url: '${root}/admin/malCenter/batchAddMalGuide.do', 
	            type: 'post',
	            secureuri: false, //一般设置为false
	            fileElementId: 'malGuideFile', // 上传文件的id、name属性名
	            dataType: 'json', //返回值类型，一般设置为json、application/json
	            success: function(data, status){  
	               if(data.result) {
	            	   parent.listMalGuide(1);
	            	   setTimeout("closeMe()",1000);
	               } else {
	            	   if(1 == data.code){
		     				Win.confirm("导入失败，是否下载问题明细？",
			     					function(){
			     						window.location.href="${root}/admin/commons/downLoadErrorDetail.do?fileName="+data.message;
			     				},
			     					function(){
			     						$.post("${root}/admin/commons/deleteErrorDetail.do",{"fileName":data.message},function (data){});
			     				});
		     			}else{
		     				Win.alert(data.message);
		     			}
	               }
	            },
	            error: function(data, status, e){ 
	                alert(e);
	            }
	        });
	        //return false;
		}
		
		function submitForm() {
			
			var fileName = $("#malGuideFile").val();
			
			if(fileName == '') {
				Win.alert("请选择文件");
				return;
			} else if(!fileName.endWith(".xlsx") && !fileName.endWith(".xls")) {
	    		Win.alert("批量新增的文件类型必须是Excel");
	    		return;
	    	}
	    	ajaxFileUpload();
	    }
		
	    String.prototype.endWith=function(endStr){
	    	  var d=this.length-endStr.length;
	    	  return (d>=0&&this.lastIndexOf(endStr)==d);
	    };

		function closeMe() {
			parent.Win.wins[domid].close();
		}

		
	</script>
</body>

</html>