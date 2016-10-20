<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script src="${root }/public/js/basiccheck.js"></script>
<script type="text/javascript" src="${root}/public/js/ajaxfileupload.js"></script>
<script>
	var domid = frameElement.getAttribute("domid");
</script>
</head>

<script>
	$(function(){
		// $("#uploadExcel").hide() ;
		$("#failure").hide() ;
	}) ;
	
	var len = 360 ;
	var add = 0 ;
	
	function openContenFrame(){
	    var td1 = $("#tdOne") ;
	    var td2 = $("#tdTwo") ;
	    add = add+10 ;
	    td1.width(add) ;
	    if(len - add <= 0){
	       td2.width(1) ;
	    }else{
	       td2.width((len - add)) ;
	    }
	    if(add<=len) {
		   ;
	    }else{
	       td1.width(1) ;
	       td2.width(360) ;
	       add = 0 ;
	    }
	    
	  	window.setTimeout('openContenFrame()', 100) ;
	}
	
	function importLoading(){
		$("#uploadExcel").hide() ;
		$("#downloadModel").hide() ;
	    $("#load").css("display","block"); 
	    openContenFrame();
	}
	
	function unimportLoading(){
		$("#load").css("display","none"); 
	}
	
	String.prototype.endWith = function(str){     
		
		 var reg = new RegExp(str+"$"); 
		 return reg.test(this);        
	} ;
		
	function submitForm() {
		var fpath = $("#uploadFile").val();
		if (fpath == "") {
			Win.alert("未选择需要导入的文档！");
			return false;
		}
		
		if(!fpath.endWith(".xls")){
			Win.alert("您上传的文件格式不正确,请重新上传!") ;
			return false ;
		}
		
		// ===== 加进度条控制
		importLoading() ;
		
		$.ajaxFileUpload({
	    	url					:	'${root}/admin/commons/importUser.do?userType=${userType}' , 	// === 需要链接到服务器地址
	    	secureuri			:	false ,
	     	fileElementId		:	'uploadFile' ,                  			 			// === 文件选择框的id属性
	    	dataType			:	'json',                                    	 		// === 服务器返回的格式，可以是json
	     	success				:	function (json, status){            			 		// === 相当于java中try语句块的用法      
	     		unimportLoading();
	     		// === 导入成功
	     		if(json.result){
	     			Win.alert("导入成功");
	     			parent.splitPage.reload();
					setTimeout("closeMe()",1000);
	     		}else{
	     			if(1 == json.code){
	     				Win.confirm("导入失败，是否下载问题明细？",
		     					function(){
		     						window.location.href="${root}/admin/commons/downLoadErrorDetail.do?fileName="+json.message;
		     				},
		     					function(){
		     						$.post("${root}/admin/commons/deleteErrorDetail.do",{"fileName":json.message},function (data){});
		     				});
	     			}else{
	     				Win.alert(json.message);
	     			}
	     			
	     			$("#downloadModel").show() ;
	     			$("#uploadExcel").show();
	     			//Win.alert(json.message);
	     			
	     			// === 导入失败
	     			/*Win.confirm(json.message, function() {
	     				//$("#downloadFailure").attr("class","btn mr20") ;
	     				parent.splitPage.reload();
		     			 $("#failure").show() ;
		     			url = "${ctx}/front/manageruser/downloadErrorModal.do?fileName="+json.fileName ;
		     			$("#downloadFailure").attr("href",url) ; 
	     			},function() {
	     				parent.splitPage.reload();
						closeMe() ;
	     			}) ;*/
	     		}  
	     	},
	     	error			:	function (data, status, e){            					 // === 相当于java中catch语句块的用法
	     		unimportLoading() ;
	     		closeMe() ;
	     		Win.alert("请使用下载的模板录入数据上传！");
	     	}
	 	}) ; 
		
	}

	function closeMe() {
		parent.Win.wins[domid].close();
	}
</script>

<table id="load" width="495" height="180" border="0" align="center" bgcolor="#FAFAFA" cellpadding="0" cellspacing="0" bordercolor="#000000" style="border-collapse:collapse;display:none ">
  <tr>
    <td><br><br>
    <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#287BCE" style="border-collapse:collapse ">
        <tr bgcolor="#F7F7F6">
          <td width="20%" height="100" valign="middle">
		    <table align='center' width='480'>
		      <tr>
		       <td colspan='2' align='center' ><font size="2">
		      		 正在进行保存，用时较长，请稍后...
		        </font>
		       </td>
		      </tr>
		      <tr>
		        <td id='tdOne' height='25' width=1 bgcolor="blue">&nbsp;</td>
		        <td id='tdTwo' height='25' width=360 bgColor='#999999'>&nbsp;</td>
		      </tr>
		    </table>
          </td>
        </tr>
    </table>
    </td>
  </tr>
</table>
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
					<input type="file" id="uploadFile" name="uploadFile" />
				</span>
			</li>
			<li class="center">
				<input type="submit" class="submit btn mr10" value="确定" id="btnSubmit" onclick="submitForm();" />
		  		<input type="button" class="btn btnGray" value="取消"  id="btnCancel" onclick="closeMe();" />
			</li>
		</ul>
	</div>
	
	<div id="failure">
		<div style="margin: 0 auto;width:250px;font-size:14px;">
			<label class="ml20 mt10">数据导入失败，请下载信息表格，</label><br/>
			<label class="ml20 mt10">以检查错误项，修改后重新导入。</label><br /><br />
		</div>
		<div>
			<input type="submit" class="submit btn mr10" value="下载信息表" id="downloadFailure" />
		   <input type="button" class="btn btnGray" value="取消"  id="btnCancel" onclick="closeMe();" />
		</div>
	</div>
</div>