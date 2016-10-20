<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
    <link href="${root}/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
     <script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
     <script src="${root}/public/js/jsTree.js" type="text/javascript"></script>
      <script type="text/javascript" src="${root }/public/upload/uploadfile.js"></script>
     <script type="text/javascript" src="${root}/public/js/extend.js"></script>
     <script src="${root }/public/js/customer.js" type="text/javascript"></script>
     <script type="text/javascript" src="${root}/public/js/showImage/showImage.js"></script>
     <link href="${root}/public/css/reset.css" rel="stylesheet" type="text/css" media="all">
	<style>
	    .tableWrap{width:381px; margin-right:20px; float:left;margin-top:10px;}
	    .tableWrap:nth-of-type(2n){ margin-right:0px;}
		.tableTitle{height:20px;line-height:20px;padding-left:20px}
		.searchTop {border: 1px solid #333;}
	/* 	.tableWrap.specWrap {
			    float: none;
			    width: 100%;
			} */
	</style>
</head>
<body class="chase-ask">
	<form id="editForm">
	 <ul class="searchWrap">
	        <li class="clearfix" style="margin:5px 0 15px;">
	        	<label class="labelText">学校区域：</label>
	                 <span>  ${classroom.schoolArea }                 </span>
	           <label class="labelText"> 学校：</label>
	                <span>
	                    ${classroom.clsSchoolName}                </span>
	            <label class="labelText">教室：</label>
	                <span>
	                   ${classroom.roomName}                </span>
	            <label class="labelText">教室类别：</label>
	                <span>
	                    ${classroom.roomType}                </span>
	        </li>
	        <li class="clearfix" >
	            <label class="labelText">联系人：</label>
	                 <span>
	                    ${classroom.contactPersonName}                </span>
	           	<label class="labelText" style="margin-left:49px;">	手机：</label>
	                <span>
	                    ${classroom.contactPersonPhone}               </span>
	        </li>
	        <li>
	        	<div style="text-align:right;margin-bottom:5px;">
						<input type="submit" class="btn" value="保存调试记录" style="margin-right:20px;" />
				</div>	                    
	        </li>
	  </ul>
	<div class=" marginauto">
		<div class="searchTop clearfix" style="border;1px solid #ccc">
	 	<div class="fl w200" style=' width:320px;height:150px; border-right:1px solid ; '>
           <h4>本地调试情况</h4>
           <ul class="searchWrap">
           	<li class="clearfix">
           		<label class="labelText" style="margin-left:10px;">调试人：</label>
	                 <span>
	                 	<input name="clsClassroomId" value="${classroom.clsClassroomId}" type="hidden">
	                    <input name="testerName" value="${classroom.testerName}">                </span>
	        </li>
           	<li class="clearfix">
           		<label class="labelText" style="margin-left:6px;">调试完成时间：</label>
	                 <span>
	              <input type="text" class="Wdate" id="implementationTimeBegin" onclick="WdatePicker();"  name="testerTime" value="<fmt:formatDate value="${classroom.testerTime}" pattern="yyyy-MM-dd"/>"   >                </span>
           	</li>
           	<li class="clearfix">
           		<label class="labelText" style="margin-left:10px;">备注：</label>
	                 <span>
	                    <input name="testerRemark" value="${classroom.testerRemark}">               </span>
           	</li>
           </ul>
	 	</div>
	 	<div class="" style="overflow:hidden;height:150px;">
	 		<h4>联调情况</h4>
           <ul class="searchWrap">
           	<li class="clearfix">
           		<label class="labelText">联调人：</label>
	                 <span>
	                    <input name="helpTesterName" value="${classroom.helpTesterName}">                </span>
	        </li>
           	<li class="clearfix">
           		<label class="labelText">联调时间：</label>
	                 <span>
	                    <input type="text" class="Wdate" id="implementationTimeBegin" onclick="WdatePicker();"  name="helpTesterTime" value="<fmt:formatDate value="${classroom.helpTesterTime}" pattern="yyyy-MM-dd"/>"   >                </span>
	            <label class="labelText">联调结果：</label>
	                 <span>
		                <select  name="helpTesterResult">
								<option value="">--请选择--</option>
								<option value="正常"  <c:if test="${classroom.helpTesterResult == '正常' }">selected="selected"</c:if>>正常</option>
								<option value="不正常"  <c:if test="${classroom.helpTesterResult == '不正常' }">selected="selected"</c:if>>不正常</option>
						</select>
	                 </span>
           	</li>
           	<li class="clearfix">
           		<label class="labelText">备注：</label>
	                 <span>
	                    <input name="helpTesterRemark" value="${classroom.helpTesterRemark}">                </span>
           	</li>
           </ul>
	 	
	 	</div>
		</div>
	</div>
   <div class="content">
   		<c:set var="itype" value="-1"></c:set>
   		<c:set var="inum" value="0"></c:set>
   		<c:forEach items="${classroominspect }" var="ci" varStatus="status">
   			<c:if test="${ci.classroomInspect.type != itype }">
	   				<c:if test="${itype != '-1'}">
	   						</tbody>
      					 </table>
      					 </div>
	   				</c:if>
   					<c:set var="inum" value="0"></c:set>
					<div class="tableWrap specWrap">
					  <div class="tableTitle">
									 ${ci.classroomInspect.typeName}&nbsp;&nbsp; <fmt:formatDate value="${ci.updateTime}" pattern="yyyy-MM-dd"/>
								</div>
				   				<table class="tableBox center">
								<thead><tr>
									<th width="5%">序号</th>
									<th width="10%">检测项</th>
									<th width="10%">检测结果</th>
								</tr>
								</thead><tbody id="pageBody">
								<c:set var="itype" value="${ci.classroomInspect.type}"></c:set>			
			   			</c:if>
			   			
			   			<c:set var="inum" value="${inum+1 }" />
			   			<tr><td>${inum }</td>
			   			<td>
			   				<input name="classroomInspectDetailId" value="${ci.classroomInspectDetailId}" type="hidden">
			   				${ci.classroomInspect.name}
			   			</td>
			   			<td>
			   				<input name="result" value="${ci.result}" type="hidden">
			   				<c:if test="${ci.classroomInspect.istxt == 'Y'}">
			   					<textarea rows="1" cols="45" name="result${ci.classroomInspectDetailId}" >${ci.result}</textarea>
			   				</c:if>
			   				<c:if test="${ci.classroomInspect.istxt != 'Y'}">
			   					<c:if test="${ci.classroomInspect.optionList != null}">
			   						<c:forEach items="${ci.classroomInspect.optionList }" var="option">
			   							<input type="radio" name="result${ci.classroomInspectDetailId}" value="${option }" <c:if test="${ci.result == option }">checked</c:if>>${option }
			   						</c:forEach>		
			   					</c:if>
			   					<c:if test="${ci.classroomInspect.optionList == null}">
			   						<input type="radio" name="result${ci.classroomInspectDetailId}" value="是" <c:if test="${ci.result =='是' }">checked</c:if>>是
			   						<input type="radio" name="result${ci.classroomInspectDetailId}" value="否" <c:if test="${ci.result =='否' }">checked</c:if>>否
			   						<input type="radio" name="result${ci.classroomInspectDetailId}" value="无" <c:if test="${ci.result =='无' }">checked</c:if>>无
			   					</c:if>
			   				</c:if>
			   			</td>
			   			</tr>
   		</c:forEach>
   		</tbody>
      	</table>
      	<ul>
	  		<li class="clearfix" style="margin:10px 0 10px;">
	  		 <span class="mr20">共<span class="red" id="number">${attList.size()}</span>张照片</span>
	        <a href="javascript:;" class="uploadBox btn mr20" onclick="return false;">
	                             上传<span id="uploadCont" class="uploadCont"> </span>
	         </a>
	         <a href="javascript:;" class="uploadBox btn mr20" onclick="editPicture();">编辑</a>
             <a href="javascript:;" class="uploadBox btn mr20" onclick="viewPicture();">查看</a>
	        </li> 
	        <li class="clearfix" style="margin:10px 0 10px;">
	               <ul id="uploadInfoBox" class="commonUL"  style="width:500px;">
			        <c:if test="${requestScope.attList!=null}">
			            <c:forEach items="${requestScope.attList}" var="attachment">
			            <li id='${attachment.attachment_Url}'>
			            <span class='mr20'> 图片描述：<input type="text" name="picDesc" value="${attachment.remark}"></span>
			             <span class='mr20'><b class='fileName mr10' title='${attachment.name}'>${attachment.name}</b></span>
			              <span class="progressBox mr20">已上传！</span>
			             <span class='progressBox mr20'>
			             
			                <a href='javascript:;' file='${attachment.attachment_Url}' class='delUploadFile'>删除</a>
			                <input type='hidden' name='oraginalFileName' value='${attachment.name}'/>
			                <input type='hidden' name='newFileName' value='${attachment.attachment_Url}'/>
			                </span>
			            </li>
			            </c:forEach>
			        </c:if>
		        </ul>
	        </li>
	   	</ul> 
      	
      	</div>
   </div>
	 	 
   </form>
<script>
    if(window.frameElement)  var domid =frameElement.getAttribute("domid");
    $("#cancel").click(function(){
        parent.Win.wins[domid].close();
    });
    
	new BasicCheck({
	    form: $id("editForm"),
	    addition : function() {
	        return true;
	    },
	    ajaxReq : function(){
	        $.post('${root}/admin/classroominspect/finisheditclassroominspect.do',$("#editForm").serialize(),function(r){
	            try {
	                if(!r.result){
	                    Win.alert('操作失败！');
	                }else{
	                    parent.Win.alert('操作成功!');
	                    parent.location.reload()
	                    parent.Win.wins[domid].close();
	                }
	            } catch(e) {
	                Win.alert("错误提示:"+e.message);
	            }
	        });
	    }
	});
	
	
/*图片上传 */
    
    //获得上传的图片的原来的名字与新生成的名字
 var params = {
        debug : 1,
        fileType : "*.jpg;*.gif;*.png;*.jpeg;",
        typeDesc : "图片",
        autoStart : true,
        multiSelect : 1,
        server: encodeURIComponent("${root}/ImageUploadServlet")
	};
 	window.uploadSwf = new UploadFile($id("uploadCont"), "uploadSwf", "${root}/public/upload/uploadFile.swf",params);
 	
 	
 	uploadSwf.uploadEvent.add("onComplete",function(){
 		var elm = arguments[0].message[0],
 			data = arguments[0].message[1];
		var myProgressBox = $class("progressBox",$id(elm))[0],
			myUploadOperate = $class("uploadOperate",$id(elm))[0];
		myProgressBox.innerHTML = "上传完成!<input type ='hidden' name='newFileName' value="+JSON.parse(data).message+">";	
		myUploadOperate.innerHTML = "<a href='javascript:;' file='"+elm+"' class='delUploadFile'>删除</a>";
		
 	});
 	

 	events.delegate($id("uploadInfoBox"),".delUploadFile","click",function(){
 		//删除
 		var e = arguments[0] || window.event,
			target = e.srcElement || e.target,
			fileIndex = target.getAttribute("file"),
			liElm = $id(fileIndex);
 		liElm.parentNode.removeChild(liElm);
 		 $("#number").html($("#uploadInfoBox").children().length);
 	});
 	
                 //显示上传的文件信息
 	uploadSwf.uploadEvent.add("onOpen",function(){
 		
 		
 		var elm = arguments[0].message[0],
 			info = arguments[0].message[1];
 		//var jsonData = JSON.parse(arguments[0].message[1]);
 		if($id(elm)) return false;
 		//$id("uploadInfoBox").innerHTML += "<li id='"+elm+"'><span class='infoLabel'><b class='fileName mr10' title='"+info.name+"'>"+info.name+"</b><b class='fileSize mr10'></b></span><span class='progressBox mr20'><b class='progressBar mr10'><em class='progressRate'>&nbsp;</em></b>已上传<b class='uploaded'>0%</b></span><span class='uploadOperate'><a class='cancelUpload' href='javascript:;' file='"+elm+"'>取消上传</a></span><input type='hidden' name='oraginalFileName' value='"+info.name+"'/></li>";
 		html="<li id='"+elm+"'><span class='mr20'>图片描述：<input type='text' name='picDesc'></span><span class='mr20'><b class='fileName mr10' title='"+info.name+"'>"+info.name+"</b></span><span class='progressBox mr20'><b class='progressBar mr10'><em class='progressRate'>&nbsp;</em></b>已上传<b class='uploaded'>0%</b></span><span class='uploadOperate'><a class='cancelUpload' href='javascript:;' file='"+elm+"'>取消上传</a></span><input type='hidden' name='oraginalFileName' value='"+info.name+"'/></li>";
   	    $("#uploadInfoBox").append(html);
   	 $("#number").html($("#uploadInfoBox").children().length);
 	});
 	
</script>
</body>
</html>