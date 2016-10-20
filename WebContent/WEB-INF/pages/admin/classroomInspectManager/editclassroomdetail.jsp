<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../common/meta.jsp" %>
     <script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
     <script src="${root }/public/js/customer.js" type="text/javascript"></script>
     <script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
     <script type="text/javascript" src="${root }/public/upload/uploadfile.js"></script>
     <script type="text/javascript" src="${root}/public/js/extend.js"></script>
     <script type="text/javascript" src="${root}/public/js/showImage/showImage.js"></script>
     <script src="${root }/public/js/customer.js" type="text/javascript"></script>
     <link href="${root}/public/css/reset.css" rel="stylesheet" type="text/css" media="all">
    <style>
    	.labelTextEdit {
			width: 170px;
		    display: inline-block;
		    min-width: 80px;
		    text-align: right;
		}
	</style>
</head>
<body class="chase-ask">
<form id="editForm">
	<h4>基本信息</h4>
    <ul class="searchWrap" >
         <li class="clearfix" style="margin:5px 0 15px;">
			<input id="clsClassroomId" name="clsClassroomId" value="${classroom.clsClassroomId }" type="hidden">
			<label class="labelText">学校区域：</label>
				<span class="cont" >
					${classroom.schoolArea }
				</span>
			<label class="labelText">学校：</label>
				<span>
					${classroom.clsSchoolName }
				</span>
			<label class="labelText">教室：</label>
				<span>
					${classroom.roomName }
				</span>
			<label class="labelText">教室类别：</label>
				<span>
					${classroom.roomType }
				</span>
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">
        	<label class="labelText">联系人：</label>
				<span>
					${classroom.contactPersonName }
				</span>
			<label class="labelText" style="margin-left:49px;">手机：</label>
				<span>
					${classroom.contactPersonPhone }
				</span>
        	<input type="submit" class="btn" value="保存" style="margin-left:650px;" />
        </li>
     </ul>
     <ul class="commonUL borderBox">
     	<li class="clearfix" style="margin:5px 0 15px;">
     		<label class="labelTextEdit">工程师：</label><span>${classroom.installUserName}</span>
     		
     		<label class="labelTextEdit">
	     		<input type="checkbox" name="updateUser" value="true" checked><span>更新为当前登录人</span>
     		</label>
     	</li>
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="labelTextEdit">TeamviewID：</label>
				<span>
					<input name="teamviewid" value="${classroom.teamviewid }"> 
				</span>
			<label class="labelTextEdit">Teamview密码：</label>
				<span>
					<input name="teamviewpsd" value="${classroom.teamviewpsd }"> 
			</span>
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="labelTextEdit">在线课堂服务器地址：</label>
				<span>
					<input name="zxktService" value="${classroom.zxktService }"> 
				</span>
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="labelTextEdit">在线课堂服务器账号、密码：</label>
				<span>
					<input name="zxktUserNamePsd" value="${classroom.zxktUserNamePsd }"> 
				</span>
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="labelTextEdit">导播/插件版本：</label>
				<span>
					<input name="dbcjVersion" value="${classroom.dbcjVersion }"> 
				</span>
			<label class="labelTextEdit">产品版本号：</label>
				<span>
					<input name="projectVersion" value="${classroom.projectVersion }"> 
			</span>
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="labelTextEdit">实施进展：</label>
				<span>
					<select  name="implementationProgress">
							<option value="">--请选择--</option>
							<option value="已完成"  <c:if test="${classroom.implementationProgress == '已完成' }">selected="selected"</c:if>>已完成</option>
							<option value="未完成"  <c:if test="${classroom.implementationProgress == '未完成' }">selected="selected"</c:if>>未完成</option>
					</select>
				</span>
			<label class="labelTextEdit">实施时间：</label>
				<span>
					<input type="text" class="Wdate" id="implementationTimeBegin" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'implementationTimeEnd\')}'});"  name="implementationTimeBegin" value="<fmt:formatDate value="${classroom.implementationTimeBegin }" pattern="yyyy-MM-dd"/>"   >
					至
					<input type="text" class="Wdate" id="implementationTimeEnd" onclick="WdatePicker({minDate:'#F{$dp.$D(\'implementationTimeBegin\')}'});"  name="implementationTimeEnd" value="<fmt:formatDate value="${classroom.implementationTimeEnd }" pattern="yyyy-MM-dd"/>"   >
			</span>
        </li>
		<li class="clearfix" style="margin:5px 0 15px;">
			<label class="labelTextEdit">主材设备序列号：</label>
				<span>
					<input name="zcsbNum" value="${classroom.zcsbNum }"> 
				</span>
			<label class="labelTextEdit">产品质保期：</label>
				<span>
					<input name="productWarrantyPeriod" value="${classroom.productWarrantyPeriod }"> 
			</span>
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="labelTextEdit">监管平台地址（内外网）：</label>
				<span>
					<input name="jgptAddress" value="${classroom.jgptAddress }"> 
				</span>
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="labelTextEdit">监管平台服务器地址：</label>
				<span>
					<input name="jgptService" value="${classroom.jgptService }" size="90"> 
				</span>
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="labelTextEdit">监管平台服务器账号、密码：</label>
				<span>
					<input name="jgptNamePsd" value="${classroom.jgptNamePsd }"> 
				</span>
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="labelTextEdit">服务器配置：</label>
				<span>
					<input name="serviceInfo" value="${classroom.serviceInfo }"> 
				</span>
			<label class="labelTextEdit" style="margin-left:-45px;">网络配置：</label>
				<span>
					<input name="netInfo" value="${classroom.netInfo }"> 
				</span>
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="labelTextEdit">黑板样式：</label>
				<span>
					<select  name="blackboard">
							<option value="">--请选择--</option>
							<option value="两板式"  <c:if test="${classroom.blackboard == '两板式' }">selected="selected"</c:if>>两板式</option>
							<option value="三板式"  <c:if test="${classroom.blackboard == '三板式' }">selected="selected"</c:if>>三板式</option>
							<option value="普通黑板"  <c:if test="${classroom.blackboard == '普通黑板' }">selected="selected"</c:if>>普通黑板</option>
							<option value="触摸一体机"  <c:if test="${classroom.blackboard == '触摸一体机' }">selected="selected"</c:if>>触摸一体机</option>
							<option value="无"  <c:if test="${classroom.blackboard == '无' }">selected="selected"</c:if>>无</option>
					</select> 
				</span>
			<label class="labelTextEdit">讲台配置：</label>
				<span>
					<select  name="platform">
							<option value="">--请选择--</option>
							<option value="钢式"  <c:if test="${classroom.platform == '钢式' }">selected="selected"</c:if>>钢式</option>
							<option value="木式"  <c:if test="${classroom.platform == '木式' }">selected="selected"</c:if>>木式</option>
							<option value="无"  <c:if test="${classroom.platform == '无' }">selected="selected"</c:if>>无</option>
					</select> 
				</span>
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="labelTextEdit">班班通情况：</label>
				<span>
					<select  name="bbtInfo">
							<option value="">--请选择--</option>
							<option value="投影白板"  <c:if test="${classroom.bbtInfo == '投影白板' }">selected="selected"</c:if>>投影白板</option>
							<option value="触摸一体机"  <c:if test="${classroom.bbtInfo == '触摸一体机' }">selected="selected"</c:if>>触摸一体机</option>
							<option value="投影幕布"  <c:if test="${classroom.bbtInfo == '投影幕布' }">selected="selected"</c:if>>投影幕布</option>
							<option value="电视机"  <c:if test="${classroom.bbtInfo == '电视机' }">selected="selected"</c:if>>电视机</option>
							<option value="无"  <c:if test="${classroom.bbtInfo == '无' }">selected="selected"</c:if>>无</option>
					</select> 
				</span>
			<label class="labelTextEdit">是否打标签：</label>
				<span>
					<select  name="isSign">
							<option value="">--请选择--</option>
							<option value="已标"  <c:if test="${classroom.isSign == '已标' }">selected="selected"</c:if>>已标</option>
							<option value="未标"  <c:if test="${classroom.isSign == '未标' }">selected="selected"</c:if>>未标</option>
					</select> 
				</span>
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="labelTextEdit">调试状态：</label>
				<span>
					<select  name="status">
							<option value="">--请选择--</option>
							<option value="已调"  <c:if test="${classroom.status == '已调' }">selected="selected"</c:if>>已调</option>
							<option value="未调"  <c:if test="${classroom.status == '未调' }">selected="selected"</c:if>>未调</option>
					</select> 
				</span>
			<label class="labelTextEdit">是否已培训：</label>
				<span>
					<select  name="isTrain">
							<option value="">--请选择--</option>
							<option value="已培训"  <c:if test="${classroom.isTrain == '已培训' }">selected="selected"</c:if>>已培训</option>
							<option value="未培训"  <c:if test="${classroom.isTrain == '未培训' }">selected="selected"</c:if>>未培训</option>
					</select> 
				</span>
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="labelTextEdit">培训讲师：</label>
				<span>
					<input name="trainTeacher" value="${classroom.trainTeacher }">
				</span>
			<label class="labelTextEdit" style="margin-left:-43px;">是否验收：</label>
				<span>
					<select  name="isCheck">
							<option value="">--请选择--</option>
							<option value="已验收"  <c:if test="${classroom.isCheck == '已验收' }">selected="selected"</c:if>>已验收</option>
							<option value="未验收"  <c:if test="${classroom.isCheck == '未验收' }">selected="selected"</c:if>>未验收</option>
					</select> 
				</span>
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="labelTextEdit">培训时间：</label>
				<span>
				  <input type="text" class="Wdate" id="trainTime" onclick="WdatePicker();"  name="trainTime" value="<fmt:formatDate value="${classroom.trainTime }" pattern="yyyy-MM-dd"/>"   >
				</span>
			<label class="labelTextEdit" style="margin-left:-43px;">开课情况：</label>
				<span>
					<select  name="isStart">
							<option value="">--请选择--</option>
							<option value="已开课"  <c:if test="${classroom.isStart == '已开课' }">selected="selected"</c:if>>已开课</option>
							<option value="未开课"  <c:if test="${classroom.isStart == '未开课' }">selected="selected"</c:if>>未开课</option>
					</select> 
				</span>
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="labelTextEdit" style="float:left;">备注：</label>
				<span>
					<textarea cols="63" rows="5" name="remark">${classroom.remark }</textarea>
				</span>
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">
         <span class="mr20">共<span class="red" id="number">${attList.size()}</span>张照片</span>
         <a href="javascript:;" class="uploadBox btn" onclick="return false;">
	                               上传<span id="uploadCont" class="uploadCont"> </span>
          </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <a href="javascript:;" class="uploadBox btn mr20" onclick="editPicture();">编辑</a>
         <a href="javascript:;" class="uploadBox btn mr20" onclick="viewPicture();">查看</a>
         <br/><br/>
         </li> 
         <li class="clearfix" style="margin:5px 0 15px;">
                <ul id="uploadInfoBox" class="commonUL">
			        <c:if test="${requestScope.attList!=null}">
			            <c:forEach items="${requestScope.attList}" var="attachment">
			              <li id='${attachment.attachment_Url}'>
			                 <span class='mr20'>
			                                                       图片描述:<input type="text" name="picDesc" value="${attachment.remark}"/>
			                  </span>
			                 <span class='infoLabel'>
			                   <b class='fileName mr10' title='${attachment.name}'>${attachment.name}</b>
			                   <b class='fileSize mr10'>"+(info.size/1024/1024).toFixed(2)+"MB</b>
			                 </span>
			                 <span class='progressBox mr20'>
			                   <b class='progressBar mr10'><em class='progressRate'>&nbsp;</em></b>&nbsp;&nbsp;
			                   <b class='uploaded'></b>
			                 </span>
			                 <span class='uploadOperate'></span>
			                 <span class="progressBox mr20">&nbsp;&nbsp;已上传！</span>
			                 <span>
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
    
    
    
    </form>



<script>
$(document).ready(function(){
	$.post("${root}/admin/area/getBaseAreaByParentId.do",{"parentId":"-1"},function(data){
		var html = '<option value="">-- 请选择 --</option>';
		for(var i = 0,j = data.length; i<j; i++){
		     html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
		}
		$("#province").html(html);
		$("#schoolprovince").html(html);
	},'json');
	selectBind("chooseArea","${root}/admin/area/getBaseAreaByParentId.do","parentId");		
	selectBind("schoolchooseArea","${root}/admin/area/getBaseAreaByParentId.do","parentId");		
	$("#showUserList").click(function(){
		parent.Win.open({id:"showUserListWin",url:"${root}/admin/projectmanager/toshowmanagerlist.html",title:"人员列表",width:500,height:400,mask:true}).css('left:1000px;top:300px');
	});
	
	
	$('#chooseArea').on("change","select",function(){
		var areas = $("#chooseArea select");
		var baseAreaId = "";
		var baseAreaId1 = "";
		if(areas.length == 1){
			baseAreaId = $(areas[0]).val();
		}else{
			baseAreaId = $(areas[areas.length-2]).val();
			baseAreaId1 =$(areas[areas.length-1]).val();
			if("-1" != baseAreaId1){
				baseAreaId = baseAreaId1;
			}
		}
		$.post("${root}/admin/projectmanager/getprojectbyarea.do",{"areaId":baseAreaId},function(data){
			var html = '<option value="">-- 请选择 --</option>';
			for(var i = 0,j = data.length; i<j; i++){
				html += '<option value="'+data[i].projectId+'">'+data[i].projectName+'</option>';
			}
			$("#project").html(html);
		},'json');
	});
	
	$('#schoolchooseArea').on("change","select",function(){
		var project = $("#project").val();
		var areas = $("#schoolchooseArea select");
		var baseAreaId = "";
		var baseAreaId1 = "";
		if(areas.length == 1){
			baseAreaId = $(areas[0]).val();
		}else{
			baseAreaId = $(areas[areas.length-2]).val();
			baseAreaId1 =$(areas[areas.length-1]).val();
			if("-1" != baseAreaId1){
				baseAreaId = baseAreaId1;
			}
		}
		if(project != '-1'){
			$.post("${root}/admin/schoolmanager/getschoollist.do",{"areaId":baseAreaId,"projectId":project},function(data){
				var html = '<option value="">-- 请选择 --</option>';
				for(var i = 0,j = data.length; i<j; i++){
					html += '<option value="'+data[i].clsSchoolId+'">'+data[i].schoolName+'</option>';
				}
				$("#school").html(html);
			},'json'); 
		}
	});
	
	$('#chooseProject').on("change","select",function(){
		var project = $("#project").val();
		var areas = $("#schoolchooseArea select");
		var baseAreaId = "";
		var baseAreaId1 = "";
		if(areas.length == 1){
			baseAreaId = $(areas[0]).val();
		}else{
			baseAreaId = $(areas[areas.length-2]).val();
			baseAreaId1 =$(areas[areas.length-1]).val();
			if("-1" != baseAreaId1){
				baseAreaId = baseAreaId1;
			}
		}
		
		$.post("${root}/admin/schoolmanager/getschoollist.do",{"areaId":baseAreaId,"projectId":project},function(data){
			var html = '<option value="">-- 请选择 --</option>';
			for(var i = 0,j = data.length; i<j; i++){
				html += '<option value="'+data[i].clsSchoolId+'">'+data[i].schoolName+'</option>';
			}
			$("#school").html(html);
		},'json'); 
	});
});
if(window.frameElement)  var domid =frameElement.getAttribute("domid");
var mySplit = parent.mySplit;
	
	new BasicCheck({
	    form: $id("editForm"),
	    addition : function() {
	        return true;
	    },
	    ajaxReq : function(){
	        $.post('${root}/admin/classroominspect/finisheditdetail.do',$("#editForm").serialize(),function(r){
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
	$("#cancel").click(function(){
	    parent.Win.wins[domid].close();
	});
    if(window.frameElement)  var domid =frameElement.getAttribute("domid");
    $("#cancel").click(function(){
        parent.Win.wins[domid].close();
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
 		//$id("uploadInfoBox").innerHTML += "<li id='"+elm+"'>附件描述：<input type='text'  name='Desc' value=''/><span class='infoLabel'><b class='fileName mr10' title='"+info.name+"'>"+info.name+"</b><b class='fileSize mr10'></b></span><span class='progressBox mr20'><b class='progressBar mr10'><em class='progressRate'>&nbsp;</em></b>已上传<b class='uploaded'>0%</b></span><span class='uploadOperate'><a class='cancelUpload' href='javascript:;' file='"+elm+"'>取消上传</a></span><input type='hidden' name='oraginalFileName' value='"+info.name+"'/></li>";
 	     html="<li id='"+elm+"'><span class='mr20'>图片描述：<input type='text'  name='picDesc' value=''/></span><span class='infoLabel'><b class='fileName mr10' title='"+info.name+"'>"+info.name+"</b><b class='fileSize mr10'></b></span><span class='progressBox mr20'><b class='progressBar mr10'><em class='progressRate'>&nbsp;</em></b>已上传<b class='uploaded'>0%</b></span><span class='uploadOperate'><a class='cancelUpload' href='javascript:;' file='"+elm+"'>取消上传</a></span><input type='hidden' name='oraginalFileName' value='"+info.name+"'/></li>";
 	     $("#uploadInfoBox").append(html);
 	    $("#number").html($("#uploadInfoBox").children().length);
 	});
 	
</script>
</body>
</html>