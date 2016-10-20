<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../common/meta.jsp"%>
<link href="${root }/public/calendar/skin/WdatePicker.css"	rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root }/public/upload/uploadfile.js"></script>
<style>
	.app-menu .btn {
		background-color: #73a53f;
	}
	.app-menu .btn.sel {
		background-color: #e57617;
	}
</style>
</head>
<body>
<h3 id="cataMenu">
	<a href="javascript:;">系统设置</a> &gt; <a href="javascript:;">移动端版本管理</a>
</h3>
<div id="control">
	<div id="controlContent">
		<div class="app-menu">
			<a class="btn" href="javascript:;" data-val="ANDROID_PHONE">ANDROID_PHONE</a>
			<a class="btn" href="javascript:;" data-val="ANDROID_PAD">ANDROID_PAD</a>
			<a class="btn" href="javascript:;" data-val="IOS_PHONE">IOS_PHONE</a>
			<a class="btn" href="javascript:;" data-val="IOS_PAD">IOS_PAD</a>
		</div>
		<div class="totalPageBox">
			总共<span class="totalNum" >0</span>条数据<span style="margin-left: 50px;color: red">注：最新版本不允许删除，如需删除它请先把其它版本设为最新版本，或上传新版本。</span>
			<a id="addAppVersion" class="btn btnGreen fr" href="javascript:;">新增版本</a>
		</div>
		<table class="tableBox">
			<tr>
				<th width="10%">版本号</th>
				<th width="40%">描述</th>
				<th width="20%">是否当前最新版本</th>
				<th width="20%">链接地址</th>
				<th width="10%">操作</th>
			</tr>
			<tbody id="appVersionList"></tbody>
			
		</table>
		<div id="pageNavi"></div>
	</div>
</div>
<script id="addNewBoxBody" type="text/tmpl">
	
</script>
<script type="text/javascript">
var appType = null;
$(function(){
	$('.app-menu').on('click', 'a', function () {
		var $elm = $(this);
		$elm.addClass('sel').siblings().removeClass('sel');
		if(appType !=$elm.attr('data-val')){
			search($elm.attr('data-val'));
		}
		appType = $elm.attr('data-val');
	}).find('a:eq(0)').click();
});
var getAddNewBoxHtml = function (appType) {
	return '<form id="addAppVersionBoxForm">\
				<ul class="commonUL">\
					<li>版本号：</li>\
					<li><input id="appVersion" type="text" reg="^[a-zA-Z0-9.]+$" errormsg="由数字、英文、英文符号\'.\'组成" style="width:300px" needcheck nullmsg="请输入版本号" maxlength="20" /></li>\
					<li>描述：</li>\
					<li><textarea id="appDesc" style="width:300px" maxlength="200" ></textarea></li>' 
					+ (appType == 'IOS_PHONE' || appType == 'IOS_PAD'?
					'<li>IOS应用商店链接地址：</li><li><input id="IOSURL" type="text" style="width:300px" maxlength="500" /></li>':'<li>Android应用存储地址：</li><li id="uploadProgress" style="display: none"></li><li><input id="uploadLoadFileName" type="hidden"  /><a href="javascript:;" id="uploadBtn btn" class="uploadBox btn" onclick="return false;">上传<span id="uploadCont" class="uploadCont"></span></a></li>')
					+'<li class="center"><button type="submit" class="btn"  style="margin-bottom: 50px">确定</button></li>\
				</ul>\
			</form>'
};
var params = {
		debug : 1,
		fileType : "*.apk;",
		typeDesc : "apk文档",
		sizeLimit : 200*1024*1024,//200M大小限制
		server: encodeURIComponent("${root}/AndroidUploadServlet")
	};
$("#addAppVersion").click(function(){
	var html = getAddNewBoxHtml(appType);
	Win.open({
		id:"addAppVersionWin",
		title : "添加版本",
		width:450,
		html : html
	});
	if(appType=="ANDROID_PHONE"||appType=="ANDROID_PAD"){
		window.uploadSwf = new UploadFile($id("uploadCont"), "uploadSwf", "${root}/public/upload/uploadFile.swf",params);
		
		uploadSwf.uploadEvent.add("noticeTypeError",function(){
			var data = arguments[0].message;
			console.log("文件类型错误：只支持以下文件类型：" + data[0]);
		});
		uploadSwf.uploadEvent.add("noticeSizeError",function(){
			var data = arguments[0].message;
			Win.alert("上传文件过大：限制大小：" + (data[0]/1024/1024)+"MB");
		});
		uploadSwf.uploadEvent.add("noticeSizeError",function(){
			 
		});
		uploadSwf.uploadEvent.add("onProgress",function(){
			var d = arguments[0].message;
			$("#uploadProgress").show();
			$("#uploadProgress").html("上传进度：" + (d[0]/d[1]*100 >>0)+"%");
		});
		uploadSwf.uploadEvent.add("onFail",function(){
	 		var data = arguments[0].message;
	 		$("#uploadProgress").html("<span class='red'>上传失败！</span>");
	 	});
		uploadSwf.uploadEvent.add("onComplete",function(){
			var jsonData = JSON.parse(arguments[0].message);
			$id("uploadLoadFileName").value = jsonData.message;
		});
	}
	
	new BasicCheck({
		form : $id("addAppVersionBoxForm"),
		ajaxReq :function(){
			saveAppVersion();
		}
	})
});
var saveAppVersion= function() {
		if(appType =="ANDROID_PHONE"||appType == "ANDROID_PAD"){
			if(uploadSwf.uploading){//上传中
				Win.alert("等待上传完成！");
				return;
			}
		}
		var appVersion = $.trim($("#appVersion").val());
		var appDesc =  $.trim($("#appDesc").val());
		var url = "";
		var androidFile = "";
		if(appType =="IOS_PHONE"||appType == "IOS_PAD"){
			url = $.trim($("#IOSURL").val());
			if($.trim(url).length==0){
				Win.alert("IOS应用商店链接地址不允许为空！");
				return;
			}
		}else {
			//获取androidFile
			androidFile = $('#uploadLoadFileName').val();
			if($.trim(androidFile).length==0){
				Win.alert("请上传应用包！");
				return;
			}
		}
		$.ajax({
			cache : false,
			type:'post',
			url : '${root}/admin/app/addAppVersion.do',
			data : {
				"appType":appType,
				"appVersion" : appVersion,
				"appDesc":appDesc,
				"currentVersion":'N',
				"url":url,
				"androidFile":androidFile
			},
			dataType : 'json',
			success : function(data) {
				if (data.result) {
					Win.alert("添加成功！");
					 search(appType);
					Win.wins.addAppVersionWin.close();
				} else {
					Win.alert(data.message);
				}
			},
			error : function() {
				Win.alert("添加失败！");
			}
		});
	};

function createShowingTable(data) {
	var dataArray = data;
	var tableStr = "";
	var len = dataArray.length;
	$(".totalNum").html(len);
	if (len > 0) {
		for (var i = 0; i < len; i++) {
			tableStr = tableStr + "<tr><td>" + dataArray[i].appVersion;
			
			if(dataArray[i].appDesc==null){
				tableStr += "</td><td>";
			}else{
				tableStr += "</td><td>" + dataArray[i].appDesc;
			}
			
			if( dataArray[i].currentVersion=='Y'){
				tableStr +="</td><td><span style='color: red'>是</span>";
			}else{
				tableStr +="</td><td><span>否</span>";
			} 
			if(appType =="ANDROID_PHONE" || appType=="ANDROID_PAD"){
				if(dataArray[i].androidFile==null){
					tableStr += "</td><td>";
				}else{
					tableStr += "</td><td><a href='${root}/android/"+dataArray[i].androidFile+"'>下载</a>" ;
				}
				
			}else{
				if( dataArray[i].url ==null){
					tableStr += "</td><td>";
				}else{
					tableStr += "</td><td>" + dataArray[i].url;
				}
				
			}
			
			tableStr += "</td><td> " ;
				if( dataArray[i].currentVersion!='Y'){
					tableStr +="<a href=\"javascript:setCurrentVersion('" + dataArray[i].adminAppId  + "');\">设为当前最新版本</a>&nbsp;&nbsp;"
								+"<a href=\"javascript:deleteVersion('" + dataArray[i].adminAppId  + "');\">删除</a>";
				}
				
				tableStr += "</td></tr>";
		}
	} else {
		tableStr += '<tr><td colspan="20">抱歉！没有搜索到您想要的信息！</td></tr>';
	}

	$("#appVersionList").html(tableStr);
	window.scrollTo(0, 0);
}


function search(appType){
	$.ajax({
		cache : false,
		url : '${root}/admin/app/list.do',
		data : {
			"appType" : appType
		},
		dataType : 'json',
		success : function(data) {
			createShowingTable(data);
		},
		error : function() {
			Win.alert("查询失败！");
		}
	});
}
function setCurrentVersion(appId){
	$.ajax({
		cache : false,
		url : '${root}/admin/app/setCurrentVersion.do',
		data : {
			"appType" : appType,
			"appId":appId
		},
		dataType : 'json',
		success : function(data) {
			Win.alert("设置当前版本成功！");
			search(appType);
		},
		error : function() {
			Win.alert("设置当前版本失败！");
		}
	});
}
var deleteVersion = function(appId){
	Win.confirm({mask:true,html:"您确定要删除该版本吗？"},function(){
		$.ajax({
			cache : false,
			url : '${root}/admin/app/deleteVersion.do',
			data : {
				"appType" : appType,
				"appId":appId
			},
			dataType : 'json',
			success : function(data) {
				if(data.result){
					Win.alert("删除成功！");
					search(appType);
				}else{
					Win.alert(data.message);
				}
			},
			error : function() {
				Win.alert("删除失败！");
			}
		});
	},function(){});
}
</script>
</body>
</html>