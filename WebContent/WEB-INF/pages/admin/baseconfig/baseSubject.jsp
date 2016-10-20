<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<link href="${root }/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root }/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root }/public/js/jsTree.js"></script>
<script type="text/javascript" src="${root }/public/upload/uploadfile.js"></script>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">前台参数配置</a> &gt; <a href="javascript:;">学科管理</a>
	</h3>
	<div id="control">
		<div id="controlContent">
			<div class="addNewBox">
				<textarea class="newBoxBody">
					<form id="addNewSubjectBoxForm">
						<ul class="commonUL">
							<li>输入学科名称：<input id="subjectName" type="text" needcheck nullmsg="请输入学科名称" maxlength="10" /></li>
							<li>学科图标：
								<img style="display: none" src="" id="subjectPic" width=80 height=80 />
								<span style="display: none" id="uploadProgress"></span>
								<input id="subjectPicVal" type="hidden"/>
								<a href="javascript:;" id="uploadBtn" class="uploadBox btn" onclick="return false;">
								上传<span id="uploadCont" class="uploadCont"></span>
								</a>
							</li>
							<li class="center"><button type="submit" class="btn">确定</button></li>
						</ul>
					</form>
				</textarea>
				<a href="javascript:;" class="btn" id="addNewSubjectBtn">添加学科</a>
			</div>
			<div class="editNewBox">
				<textarea class="newBoxBody">
					<form id="editNewSubjectBoxForm">
						<ul class="commonUL">
							<li>输入学科名称：<input id="editSubjectName" type="text" needcheck nullmsg="请输入学科名称" maxlength="10" /></li>
							<li>学科图标：
								<img  src="" id="subjectPicEdit" width=80 height=80 />
								<span id=''></span>
								<input id="subjectPicValEdit" type="hidden"  />
								<a href="javascript:;" id="uploadBtn" class="uploadBox btn" onclick="return false;">
								上传<span id="uploadCont" class="uploadCont"></span>
								</a>
							</li>
							<li class="center"><button type="submit" class="btn" >确定</button></li>
						</ul>
					</form>
				</textarea>
			</div>
			<div class="thead clearfix">
				<div class="theadTd theadTd-title">名称</div>
				<div class="theadTd">操作</div>
			</div>
			<div id="subjectWarp" class="jsTree-warper2c"></div>
		</div>
	</div>
	<script type="text/javascript">
	var saveSubject = function() {
		if(uploadSwf.uploading){//上传中
			Win.alert("等待上传完成！");
			return;
		}
		var subjectName = $.trim($("#subjectName").val());
		var subjectPicVal = $.trim($("#subjectPicVal").val());
		$.ajax({
			cache : false,
			url : '${root}/admin/subject/addSubject.do',
			data : {
				"subjectName" : subjectName,
				"subjectPicVal":subjectPicVal
			},
			dataType : 'json',
			success : function(data) {
				if (data.result) {
					$('#subjectWarp').jsTree('addData', "jsTree", {id:data.message, name:htmlencode(subjectName),sbjPic:subjectPicVal});
					Win.wins.addSubjectWin.close();
				} else {
					Win.alert(data.message);
				}
			},
			error : function() {
				Win.alert("添加失败！");
			}
		});
	};
	$("#addNewSubjectBtn").click(function(){
			var html = $(this).parents(".addNewBox").find(".newBoxBody").val();
			Win.open({
				mask:true,
				id:"addSubjectWin",
				title : "添加学科",
				width:400,
				html : html
			});
			window.uploadSwf = new UploadFile($id("uploadCont"), "uploadSwf", "${root}/public/upload/uploadFile.swf",{
				debug : 1,
				autoStart : false,
				server: encodeURIComponent("${root}/ImageUploadServlet")
			});
			uploadSwf.uploadEvent.add("onSelect",function(){
				var info = arguments[0].message;
				$("#subjectPic").hide();
				uploadSwf.startUpload();  //如未设置autoStart，此处正式调用上传,可传入server地址
			});
			uploadSwf.uploadEvent.add("noticeTypeError",function(){
				Win.confirm({html:"上传失败！<br>当前上传只支持*.jpg;*.gif;*.png;*.jpeg;*.bmp格式图片",width:350},function(){});
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
				$id("subjectPic").src ="${root}/images/"+ jsonData.message;
				$("#uploadProgress").hide();//隐藏进度
				$("#subjectPic").show();//显示图片
				$id("subjectPicVal").value = jsonData.message;
			});
			
			new BasicCheck({
				form : $id("addNewSubjectBoxForm"),
				ajaxReq :saveSubject
			})
		});
	$.post(ROOT + '/admin/subject/list.do', function (data) {
		$('#subjectWarp').jsTree({
			treeData: data,
			hasCheckBox: false,
			treeType: 2,
			extraHtml: '<a href="javascript:;" class="edit-link">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" class="del-link">删除</a>',
			dragSelector: '.jsTree-node,.jsTree-leaf',
			onDragEnd: function ($dragElm, startIndex, endIndex) {
				var orders = [];
				$dragElm.parent().children().each(function (index) {
					orders.push({id: this.getAttribute('data-id'), sort: index+1});
				});
				$.ajax({//排序
					cache:false,
					url:'${root}/admin/subject/sort.do',
					data:{"data":JSON.stringify(orders)},
					dataType:'json',
					success:function(data){
						if(data.result){
							Win.alert("排序成功！");
						}else{
							Win.alert("排序失败！");
						}
					},
					error:function(){
						Win.alert("失败");
					}
				});
			}
		});
	}, 'json');

	var editSubjectSave = function($li,id) {
		if(uploadSwf.uploading){//上传中
			Win.alert("等待上传完成！");
			return;
		}
		var subjectName = $.trim($("#editSubjectName").val());
		var data = $('#subjectWarp').jsTree('getData', $li);
		
		var subjectPicVal = $.trim($("#subjectPicValEdit").val());;
		$.ajax({
			cache : false,
			url : '${root}/admin/subject/updateSubject.do',
			data : {
				"subjectName" : subjectName,
				"baseSubjectId":id,
				"subjectPicVal" :subjectPicVal
			},
			dataType : 'json',
			success : function(data) {
				if (data.result) {
					Win.alert(data.message);
					Win.wins.editSubjectWin.close();
					subjectName = htmlencode(subjectName);
					$('#subjectWarp').jsTree('updateData', $li.attr('data-id'), {name: subjectName,sbjPic:subjectPicVal});
				} else {
					Win.alert(data.message);
				}
			},
			error : function() {
				Win.alert("保存失败！");
			}
		});
	};
	$('#subjectWarp').on('click', '.edit-link', function () {
		var $li = $(this).parents(".jsTree-node:eq(0)");
		var data = $('#subjectWarp').jsTree('getData', $li);
		var id = $li.attr('data-id');
		var name = data.name;
		var html = $(".editNewBox").find(".newBoxBody").val();
		Win.open({
			mask:true,
			id:"editSubjectWin",
			title : "编辑学科",
			width:400,
			html : html
		});
		window.uploadSwf = new UploadFile($id("uploadCont"), "uploadSwf", "${root}/public/upload/uploadFile.swf",{
			debug : 1,
			server: encodeURIComponent("${root}/ImageUploadServlet")
		});
		
		uploadSwf.uploadEvent.add("noticeTypeError",function(){
			Win.confirm({html:"上传失败！<br>当前上传只支持*.jpg;*.gif;*.png;*.jpeg;*.bmp格式图片",width:350},function(){});
	 	});
		uploadSwf.uploadEvent.add("onComplete",function(){
			var jsonData = JSON.parse(arguments[0].message);
			$id("subjectPicEdit").src ="${root}/images/"+ jsonData.message;
			$id("subjectPicValEdit").value = jsonData.message;
		});
		if(data.sbjPic!=null&&data.sbjPic!=""){
			$id("subjectPicEdit").src ="${root}/images/"+ data.sbjPic;
			$id("subjectPicValEdit").value = data.sbjPic;
		}else{
			$id("subjectPicEdit").src ="${root}/public/img/defaultPic/subjectDefault.png";
		}
		$("#editSubjectName").val(htmldecode(name));
		new BasicCheck({
			form : $id("editNewSubjectBoxForm"),
			ajaxReq : function(){
				editSubjectSave($li,id);
			}
		})
	});
	$('#subjectWarp').on('click', '.del-link', function () {
		var $li = $(this).parents(".jsTree-node:eq(0)");
		var id = $li.attr('data-id');
		
		Win.confirm({mask:true,html:"您确定要删除该条记录吗？"},function(){
			$.ajax({
				cache:false,
				url:'${root}/admin/subject/deleteSubject.do',
				data:{"baseSubjectId":id},
				dataType:'json',
				success:function(data){
					if(data.result){
						$('#subjectWarp').jsTree('delData',id);
					}else{
						Win.alert("学科被引用，无法删除！");
					}
				},
				error:function(){
					Win.alert("删除失败！");
				}
			});
		},function(){});
	});

</script>
</body>
</html>