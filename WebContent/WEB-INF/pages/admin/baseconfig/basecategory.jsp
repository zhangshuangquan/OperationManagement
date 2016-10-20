<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<link href="${root }/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${root }/public/calendar/WdatePicker.js"></script>
<script type="text/javascript" src="${root }/public/js/jsTree.js"></script>
<style>
#baseDataWarp.jsTree-warper2c label {
	width: 66%;
}
#baseDataWarp.jsTree-warper2c .jsTree-operate {
	width: 33%;
}
.jsTree-warper2c .jsTree-operate a,.jsTree-warper2c .jsTree-operate .nbsp{
	display: inline-block;
	width: 60px;
	text-align: left;
}
</style>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">基础设置</a> &gt; <a href="javascript:;">基本分类</a>
	</h3>
	<div id="control">
		<div id="controlContent">
			<div class="addNewBox">
				<a href="javascript:;" class="btn" id="addNewBtn_Semester">添加学段</a>
				<button type="submit" class="unExpand btn" style="margin-bottom: 5px; float: right;">全部收起</button>
			</div>
			<div class="thead clearfix">
				<div class="theadTd theadTd-title">名称</div>
				<div class="theadTd">操作</div>
			</div>
			<div id="baseDataWarp" class="jsTree-warper2c"></div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(".unExpand").click(function(){
		$('#baseDataWarp').jsTree('unExpand');
	});
	var DEEP_OPT_MAP = {
			'0': {idKey: 'baseSemesterId', nameKey: 'semesterName'},
			'1': {idKey: 'baseClasslevelId', nameKey: 'classlevelName'},
			'2': {idKey: 'baseClasslevelSubjectId', nameKey: 'subjectName'},
			'3': {idKey: 'baseClasslevelSubjectVerId', nameKey: 'versionName'},
			'4': {idKey: 'baseVolumeId', nameKey: 'volumeName'},
			'5': {idKey: 'baseChapterId', nameKey: 'chapterName'},
			'6': {idKey: 'baseSectionId', nameKey: 'sectionName'}
		
	};
	$.post(ROOT + '/admin/commons/getAllSemesterView.do', function (data) {
		$('#baseDataWarp').jsTree({
			treeData: data,
			hasCheckBox: false,
			delCheckLeaf: true,
			treeType: 2,
			extraHtml: function (data) {
				switch(data.__deep) {<%-- 添加HTML --%>
					case 1:
						return '<a href="javascript:;" class="add-link">添加年级</a><a href="javascript:;" class="edit-link" id="semester_editor">编辑</a><a href="javascript:;" class="del-link" id="semester_delete">删除</a>';
						break;
					case 2:
						return '<a href="javascript:;" class="add-link">添加学科</a><a href="javascript:;" class="edit-link" id="version_editor">编辑</a><a href="javascript:;" class="del-link" id="classlevel_editor">删除</a>';
						break;
					case 3:
						return '<a href="javascript:;" class="add-link">添加版本</a><span class="nbsp"></span><a href="javascript:;" class="del-link" id="subject_delete">删除</a>';
						break;
					case 4:
						return '<a href="javascript:;" class="add-link">添加分册</a><span class="nbsp"></span><a href="javascript:;" class="del-link" id="version_delete">删除</a>';
						break;
					case 5:
						return '<a href="javascript:;" class="add-link">添加章</a><a href="javascript:;" class="edit-link" id="volume_editor">编辑</a><a href="javascript:;" class="del-link" id="volume_delete">删除</a>';
						break;
					case 6:
						return '<a href="javascript:;" class="add-link">添加节</a><a href="javascript:;" class="edit-link" id="chapter_editor">编辑</a><a href="javascript:;" class="del-link" id="chapter_delete">删除</a>';
						break;
					case 7:
						return '<span class="nbsp"></span><a href="javascript:;" class="edit-link" id="section_editor">编辑</a><a href="javascript:;" class="del-link" id="section_delete">删除</a>';
						break;
				}
			},
			dragSelector: '.jsTree-node',
			hasChild: function (data) {<%-- 判断是否有子节点，页面上是否要显示图标 --%>
				switch(data.__deep) {
				case 1:
						return data.hasClasslevelChildrenNum;
					break;
				case 2:
						return data.hasSubjectChildrenNum;
					break;
				case 3:
						return data.hasVersionChildrenNum;
					break;
				case 4:
						return data.hasVolumeChildrenNum;
					break;
				case 5:
						return data.hasChapterChilderNum;
					break;
				case 6:
						return data.hasSectionChildrenNum;
					break;
				case 7:
						return data.hasChildrenNum;
					break;
				}
			},
			idKey: 'baseSemesterId',
			nameKey: 'semesterName',
			onDragEnd: function ($dragElm, startIndex, endIndex) {
				var orders = [];
				$dragElm.parent().children().each(function (index) {
					var data = $('#baseDataWarp').jsTree('getData', $(this));
					orders.push({id: this.getAttribute('data-id'), sort: index+1});
				});
				var data = this.getData($dragElm);
				switch(data.__deep) {<%-- 排序 --%>
				case 1:
					onDragEnd('semester/sort.do',orders);
					break;
				case 2:
					onDragEnd('classlevel/sort.do',orders);
					break;
				case 3:
					var datas = [];
					$dragElm.parent().children().each(function (index) {
						var data = $('#baseDataWarp').jsTree('getData', $(this));
						datas.push({id:data.baseClasslevelSubjectId,sort:index+1});
					});
					onDragEnd('baseconfig/classlevelSubject/sort.do',datas);
					break;
				case 4:
					var datas = [];
					$dragElm.parent().children().each(function (index) {
						var data = $('#baseDataWarp').jsTree('getData', $(this));
						datas.push({id:data.baseClasslevelSubjectVerId,sort:index+1});
					});
					onDragEnd('baseconfig/classlevelSubjectVersion/sort.do',datas);
					break;
				case 5:
					onDragEnd('volume/sort.do',orders);
					break;
				case 6:
					onDragEnd('chapter/sort.do',orders);
					break;
				case 7:
					onDragEnd('section/sort.do',orders);
					break;
				}
			},
			onExpand: function (data, $li, callback) {<%-- 点击展开事件，一层一层加载数据 --%>
				var __key = data.__key;
				var __deep = data.__deep;
				if (__deep == 0) {
					$.post(ROOT + '/admin/commons/getAllSemesterView.do', function (data) {
						$('#baseDataWarp').jsTree("loadNode", data, $li);
						callback();
					}, 'json');
				} else if (__deep == 1) {
					$.post(ROOT + '/admin/commons/getClasslevelBySemesterIdView.do', {semesterId: __key}, function (data) {
						$('#baseDataWarp').jsTree("loadNode", data, $li, DEEP_OPT_MAP[1]);
						callback();
					}, 'json');
				} else if (__deep == 2) {
					$.post(ROOT + '/admin/commons/getSubjectByClasslevelIdView.do', {classlevelId: __key}, function (data) {
						$.each(data, function () {
							this.classlevelId = __key;
						})
						$('#baseDataWarp').jsTree("loadNode", data, $li, DEEP_OPT_MAP[2]);
						callback();
					}, 'json');
				} else if (__deep == 3) {
					$.post(ROOT + '/admin/commons/getVersionByClasslevelIdAndSubjectIdView.do', {classlevelId: data.classlevelId, subjectId: data.baseSubjectId}, function (data) {
						$('#baseDataWarp').jsTree("loadNode", data, $li, DEEP_OPT_MAP[3]);
						callback();
					}, 'json');
				} else if (__deep == 4) {
					$.post(ROOT + '/admin/commons/getVolumeByVersionIdView.do', {versionId: data.baseClasslevelSubjectVerId}, function (data) {
						$('#baseDataWarp').jsTree("loadNode", data, $li, DEEP_OPT_MAP[4])
						callback();
					}, 'json');
				} else if (__deep == 5) {
					$.post(ROOT + '/admin/commons/getChapterByVolumeIdView.do', {volumeId: __key}, function (data) {
						$('#baseDataWarp').jsTree("loadNode", data, $li, DEEP_OPT_MAP[5])
						callback();
					}, 'json');
				} else if (__deep == 6) {
					$.post(ROOT + '/admin/commons/getSectionByChapterIdView.do', {chapterId: __key}, function (data) {
						$('#baseDataWarp').jsTree("loadNode", data, $li, DEEP_OPT_MAP[6])
						callback();
					}, 'json');
				} else {
					callback();
				}
			}
		});
	}, 'json');
	
	function onDragEnd(url,orders){<%-- 拖拽排序 --%>
		$.ajax({//排序
			cache:false,
			url:'${root }/admin/'+url,
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
				alert("失败");
			}
		});
	}
	
	var saveSemester = function() {<%-- 保存学段 --%>
		var addName_Semester = $.trim($("#addName_Semester").val());
		$.ajax({
			cache : false,
			url : '${root }/admin/semester/addSemester.do',
			data : {
				"semesterName" : addName_Semester
			},
			dataType : 'json',
			success : function(data) {
				if (data.result) {
					Win.alert(data.message);
					$('#baseDataWarp').jsTree('rushNode');
					<%-- $('#baseDataWarp').jsTree('addData', '', "需要后台返回插入的数据及id号");//window.location.reload();--%>
					Win.wins.addSemesterWin.close();
				} else {
					Win.alert(data.message);
				}
			},
			error : function() {
				Win.alert("添加失败！");
			}
		});
	};
	
	var getHtml = function (data, title) {<%-- 添加各级名称窗口 --%>
		return '<form id="addNewBoxForm"><ul class="commonUL">\
				<li>输入' + title + '名称：<input id="addNewBoxIpt" type="text" needcheck nullmsg="请输入' + title + '名称" maxlength="10" /></li>\
				<li class="center"><button type="submit" class="btn" >确定</button></li>\
				</ul></form>'
	};
	var getHtml2 = function (tab, data, title) {<%-- 添加学科窗口 --%>
		var html = ['<form id="addNewBoxForm"><div class="add-list clearfix">'];
		$.each(tab, function () {
			html.push('<label><input type="checkbox" value="' + this.baseSubjectId + '"/>' + this.subjectName + '</label>')
		})
		html.push('</div><div class="pt10">注：如果没有对应的学科，请到<a href="javascrip:;" onclick="parent.$(\'#menuBaseSubject\')[0].click();return false;">学科管理</a>里进行配置。</div><div class="center"><button type="submit" class="btn">确定</button></div></form>')
		return html.join('');
	};
	var getHtml3 = function (tab, data, title) {<%-- 添加版本窗口 --%>
		var html = ['<form id="addNewBoxForm"><div class="add-list clearfix">'];
		$.each(tab, function () {
			html.push('<label><input type="checkbox" value="' + this.baseVersionId + '"/>' + this.versionName + '</label>')
		})
		html.push('</div><div class="pt10">注：如果没有对应的版本，请到<a href="javascrip:;" onclick="parent.$(\'#menuBaseVersion\')[0].click();return false;">版本管理</a>里进行配置。</div><div class="center"><button type="submit" class="btn">确定</button></div></form>')
		return html.join('');
	};
	
	var ADD_OPEN_WIN;
	var openAddWin = function (data, ajaxReq, title, action) {<%-- 打开添加窗口 --%>
		action = action || '添加';
		ADD_OPEN_WIN = Win.open({
			id: "addClasslevelWin",
			title: action + title,
			width: 300,
			html : getHtml(data, title)
		});
		new BasicCheck({
			form : $id("addNewBoxForm"),
			ajaxReq : ajaxReq,
			warm  : function(o,msg){
				Win.alert(msg);
			}
		});
	};
	
	var addWinAjax = function(data, opt) {<%-- 在打开的添加窗口中，通过ajax方式提交数据，并更改页面中的树信息 --%>
		 $.ajax({
			cache : false,
			url : opt.url,
			data : opt.opt,
			dataType : 'json',
			success : function(json) {
				if (json.result) {
					Win.alert(json.message);
					$('#baseDataWarp').jsTree('rushNode', data.__key, DEEP_OPT_MAP[data.__deep]);
					if (ADD_OPEN_WIN) {
						ADD_OPEN_WIN.close();
						ADD_OPEN_WIN = null;
					}
				} else {
					Win.alert(json.message);
				}
			},
			error : function() {
				Win.alert("添加失败！");
			}
		});
	};
	
	var editWinAjax = function(data, opt, notPost) {<%-- 在打开的编辑窗口中，通过ajax方式提交数据，并更改页面中的树信息 --%>
		notPost = notPost || false;
		if (notPost) {<%-- 编辑的内容等于原内容，点击确定，关闭窗口 --%>
			if (ADD_OPEN_WIN) {
				ADD_OPEN_WIN.close();
				ADD_OPEN_WIN = null;
			}
			return;
		}
		$.ajax({
			cache : false,
			url : opt.url,
			data : opt.opt,
			dataType : 'json',
			success : function(json) {
				if (json.result) {
					Win.alert(json.message);
					var config = DEEP_OPT_MAP[data.__deep-1];
					var obj = {};
					obj[config.nameKey] = htmlencode($.trim($("#addNewBoxIpt").val()));
					$('#baseDataWarp').jsTree('updateData', data.__key, obj, config);
					//$('#baseDataWarp').jsTree('updateData', data.__key, obj, config);
					if (ADD_OPEN_WIN) {
						ADD_OPEN_WIN.close();
						ADD_OPEN_WIN = null;
					}
				} else {
					Win.alert(json.message);
				}
			},
			error : function() {
				Win.alert("添加失败！");
			}
		});
	};
	
	$("#addNewBtn_Semester").click(function(){<%-- 添加学段的窗口 --%>
		var data = {
			__parent: 'jsTree'
		};
		openAddWin(data, function () {
			addWinAjax(data, {
				url: '${root }/admin/semester/addSemester.do',
				opt: {
					semesterName : $.trim($("#addNewBoxIpt").val())
				}
			})
		}, "学段");
	});
	
	$('#baseDataWarp').on('click', '.add-link', function () {<%-- 点击添加节点 --%>
		var $li = $(this).parents(".jsTree-node:eq(0)");
		var data = $('#baseDataWarp').jsTree('getData', $li);
		switch(data.__deep) {
		case 1:	<%-- 等于1表示添加下一级 --%>
			openAddWin(data, function () {
				addWinAjax(data, {
					url: '${root }/admin/classlevel/addClasslevel.do',
					opt: {
						classlevelName : $.trim($("#addNewBoxIpt").val()),
						semesterId: data.baseSemesterId
					}
				})
			}, "年级");
			break;
		case 2:
			$.post('${root }/admin/baseconfig/getSubjectExculdeChoose.do', {
					classlevelId: data.baseClasslevelId
				}, function (tab) {
					ADD_OPEN_WIN = Win.open({
						id: "addClasslevelWin",
						title: '添加学科',
						width: 300,
						html : getHtml2(tab, data)
					});
					new BasicCheck({
						form : $id("addNewBoxForm"),
						ajaxReq : function () {
							var tab = [];
							$('input', ADD_OPEN_WIN.dom).each(function () {
								if (this.checked)
									tab.push(this.value)
							});
							if (tab.length == 0) {
								Win.alert('选择添加的学科');
								return false ;
							}
							var chooseId = [];
							chooseId.push({parentId:data.baseClasslevelId});
							chooseId.push({chooseId:tab})
							$.ajax({
								cache : false,
								url : '${root }/admin/baseconfig/addSubjectChoose.do',
								data : {"data":JSON.stringify(chooseId)},
								dataType : 'json',
								success : function(json) {
									if (json.result) {
										Win.alert(json.message);
										$('#baseDataWarp').jsTree('rushNode', data.__key, DEEP_OPT_MAP[data.__deep]);
										if (ADD_OPEN_WIN) {
											ADD_OPEN_WIN.close();
											ADD_OPEN_WIN = null;
										}
									} else {
										Win.alert(json.message);
									}
								},
								error : function() {
									Win.alert("添加失败！");
								}
							});
						},
						warm  : function(o,msg){
							Win.alert(msg);
						}
					})
				})
			break;
		case 3:
			$.post('${root }/admin/baseconfig/getVersionByClasslevelIdAndSubjectIdExculdeChoose.do', {
				classlevelId : data.baseClasslevelId,
				subjectId : data.baseSubjectId
			}, function (tab) {
				ADD_OPEN_WIN = Win.open({
					id: "addClasslevelWin",
					title: '添加版本',
					width: 300,
					html : getHtml3(tab, data)
				});
				new BasicCheck({
					form : $id("addNewBoxForm"),
					ajaxReq : function () {
						var tab = [];
						$('input', ADD_OPEN_WIN.dom).each(function () {
							if (this.checked)
								tab.push(this.value)
						});
						if (tab.length == 0) {
							Win.alert('选择添加的版本');
						}
						var chooseId = [];
						chooseId.push({parentId:data.baseClasslevelSubjectId});
						chooseId.push({chooseId:tab})
						$.ajax({
							cache : false,
							url : '${root }/admin/baseconfig/addVersionChoose.do',
							data : {"data":JSON.stringify(chooseId)},
							dataType : 'json',
							success : function(json) {
								if (json.result) {
									Win.alert(json.message);
									$('#baseDataWarp').jsTree('rushNode', data.__key, DEEP_OPT_MAP[data.__deep]);
									if (ADD_OPEN_WIN) {
										ADD_OPEN_WIN.close();
										ADD_OPEN_WIN = null;
									}
								} else {
									Win.alert(json.message);
								}
							},
							error : function() {
								Win.alert("添加失败！");
							}
						});
					},
					warm  : function(o,msg){
						Win.alert(msg);
					}
				})
			})
			break;
		case 4:
			openAddWin(data, function () {
				addWinAjax(data, {
					url: '${root }/admin/volume/addVolume.do',
					opt: {
						volumeName : $.trim($("#addNewBoxIpt").val()),
						baseClasslevelSubjectVerId: data.baseClasslevelSubjectVerId
					}
				})
			}, "分册");
			break;
		case 5:
			openAddWin(data, function () {
				addWinAjax(data, {
					url: '${root }/admin/chapter/addChapter.do',
					opt: {
						chapterName : $.trim($("#addNewBoxIpt").val()),
						baseVolumeId: data.baseVolumeId
					}
				})
			}, "章");
			break;
		case 6:
			openAddWin(data, function () {
				addWinAjax(data, {
					url: '${root }/admin/section/addSection.do',
					opt: {
						sectionName : $.trim($("#addNewBoxIpt").val()),
						baseChapterId: data.baseChapterId
					}
				})
			}, "节");
			break;
		}
	});
	
	$('#baseDataWarp').on('click', '.edit-link', function () {<%-- 点击编辑节点 --%>
		var $li = $(this).parents(".jsTree-node:eq(0)");
		var data = $('#baseDataWarp').jsTree('getData', $li);
		console.log(data);
		switch(data.__deep) {
		case 1:
			openAddWin(data, function () {
				editWinAjax(data, {
					url: '${root }/admin/semester/updateSemesterName.do',
					opt: {
						semesterName : $.trim($("#addNewBoxIpt").val()),
						semesterId: data.baseSemesterId
					}
				}, data.semesterName == $.trim($("#addNewBoxIpt").val()));
			}, "学段", '编辑');
			$("#addNewBoxIpt").val(htmldecode(data.semesterName));
			break;
		case 2:
			openAddWin(data, function () {
				editWinAjax(data, {
					url: '${root }/admin/classlevel/updateClasslevelName.do',
					opt: {
						classlevelName : $.trim($("#addNewBoxIpt").val()),
						semesterId : data.baseSemesterId,
						classlevelId :data.baseClasslevelId
					}
				}, data.classlevelName == $.trim($("#addNewBoxIpt").val()));
			}, "年级", '编辑');
			$("#addNewBoxIpt").val(htmldecode(data.classlevelName));
			break;
		case 3:
			break;
		case 4:
			break;
		case 5:
			openAddWin(data, function () {
				editWinAjax(data, {
					url: '${root }/admin/volume/updateVolumeName.do',
					opt: {
						volumeName : $.trim($("#addNewBoxIpt").val()),
						baseVolumeId: data.baseVolumeId,
						baseClasslevelSubjectVerId : data.baseClasslevelSubjectVerId
					}
				}, data.volumeName == $.trim($("#addNewBoxIpt").val()));
			}, "分册", '编辑');
			$("#addNewBoxIpt").val(htmldecode(data.volumeName));
			break;
		case 6:
			openAddWin(data, function () {
				editWinAjax(data, {
					url: '${root }/admin/chapter/updateChapterName.do',
					opt: {
						chapterName : $.trim($("#addNewBoxIpt").val()),
						baseChapterId: data.baseChapterId,
						baseVolumeId : data.baseVolumeId
					}
				}, data.chapterName == $.trim($("#addNewBoxIpt").val()))
			}, "章");
			$("#addNewBoxIpt").val(htmldecode(data.chapterName));
			break;
		case 7:
			openAddWin(data, function () {
				editWinAjax(data, {
					url: '${root }/admin/section/updateSectionName.do',
					opt: {
						sectionName : $.trim($("#addNewBoxIpt").val()),
						baseSectionId: data.baseSectionId,
						baseChapterId : data.baseChapterId
					}
				}, data.sectionName == $.trim($("#addNewBoxIpt").val()));
			}, "节", '编辑');
			$("#addNewBoxIpt").val(htmldecode(data.sectionName));
			break;
		}
	});
	
	$('#baseDataWarp').on('click', '.del-link', function () {<%-- 点击删除节点 --%>
		var $li = $(this).parents(".jsTree-node:eq(0)");
		var data = $('#baseDataWarp').jsTree('getData', $li);
		var deleteId = $li.attr('data-id');
		switch(data.__deep) {
		case 1:
			delete_element("semester/deleteSemester.do",data.baseSemesterId,"semesterId",deleteId);
			break;
		case 2:
			delete_element("classlevel/deleteClasslevel.do",data.baseClasslevelId,"classlevelId",deleteId);
			break;
		case 3:
			delete_element('baseconfig/classlevelSubject/delete.do',data.baseClasslevelSubjectId,"classlevelSubjectId",deleteId);
			break;
		case 4:
			delete_element('baseconfig/classlevelSubjectVersion/delete.do',data.baseClasslevelSubjectVerId,"classlevelSubjectVersionId",deleteId);
			break;
		case 5:
			delete_element("volume/deleteVolume.do",data.baseVolumeId,"volumeId",deleteId);
			break;
		case 6:
			delete_element("chapter/deleteChapter.do",data.baseChapterId,"chapterId",deleteId);
			break;
		case 7:
			delete_element("section/deleteSection.do",data.baseSectionId,"sectionId",deleteId);
			break;
		}
	});
	
	function delete_element(url,id,name,deleteId){
		var namedate = {};
		namedate[name] = id;
		Win.confirm({mask:true,html:"您确定要删除该条记录吗？"},function(){
			$.ajax({
				cache:false,
				url:'${root }/admin/'+url,
				data:namedate,
				dataType:'json',
				success:function(data){
					if(data.result){
						//Win.alert("删除成功");
						$('#baseDataWarp').jsTree('delData',deleteId);
					}else{
						Win.alert(data.message);
					}
				},
				error:function(){
					Win.alert("删除失败！");
				}
			});
		},function(){});
	}
</script>
</html>