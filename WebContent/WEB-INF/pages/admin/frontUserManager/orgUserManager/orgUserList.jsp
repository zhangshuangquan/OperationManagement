<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../common/meta.jsp"%>
<script type="text/javascript" src="${root }/public/js/customer.js"></script>
</head>
<body>
	<h3 id="cataMenu">
		<a href="javascript:;">用户管理</a> &gt; <a href="javascript:;">账号管理</a>
	</h3>
	<div id="control">
		<div id="controlContent">
			<ul class="searchWrap borderBox">
				<li>
					<label class="labelText">用户名：</label>
					<input type="text" name="userName" id="userName" />
					<label class="labelText">姓名：</label>
					<input type="text" name="realName" id="realName" />
					<label class="labelText">联系电话：</label>
					<input type="text" name="contact" id="contact" />
					<label class="labelText">职位：</label>
					<input type="text" name="position" id="position" />
					<input type="button" class="submit btn" name="query" onclick="search();" value="查询"  style="margin-left: 30px;"/>
				</li>
			</ul>
			<div class="totalPageBox">
				<div class="fr">
					<a id="addOrgUser" class="btn btnGreen" href="javascript:;">新增</a>
				</div>
				<div>总共<span class="totalNum" id="totalNum">0</span> 条数据</div>
			</div>
		<table class="tableBox">
			<tr>
				<th width="5%">序号</th>
				<th width="10%">用户名</th>
				<th width="10%">姓名</th>
				<th width="8%">联系电话</th>
				<th width="8%">职位</th>
				<th width="12%">操作</th>
			</tr>
			<tbody id="pageBody">
			</tbody>
		</table>
		<div class="pageNavi" id="pager"></div>
		
		</div>
	</div>
	<script type="text/javascript">
	$(document).ready(function(){
		var defaultAreaOp = '<option value="-1">请选择</option>';
		$.post("${root}/admin/orgUser/getAreaByparentId.do",{"parentId":"-1"},function(data){
			var html = defaultAreaOp;
			for(var i = 0,j = data.length; i<j; i++){
				html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
			}
			$("#select1").html(html);
		},'json');
		
		selectBind("areaSelect","${root}/admin/orgUser/getAreaByparentId.do","parentId");
		
		$("#addOrgUser").click(function(){
			Win.open({id:"addOrgUserWin",url:"${root}/admin/orgUser/toAddOrgUser.html",title:"新增账号",width:600,height:400,mask:true});
		});
		var splitPage;
		alert("search");
		search();
	});
	
	
	function getOrgUserList(data,total){
		if(total || total != 0){
			if(data){
				$("#totalNum").html(total);
				var start = splitPage.req.start;
				var html ='';
				var baseUser;
				for(var i = 0,j = data.length;i<j;i++){
					baseUser = data[i];
					start++;
					html+='<tr>';
					html+='<td>'+start+'</td>';
					html+='<td>'+baseUser.userName+'</td>';
					html+='<td>'+baseUser.realName+'</td>';
					html+='<td>'+baseUser.contact+'</td>';
					html+='<td>'+baseUser.position+'</td>';
					html+='<td>'+etState(baseUser.locked)++'</td>';
					html+='<td><a href="javascript:;" onclick="editOrgUser(\''+baseUser.adminUserId+'\');">编辑</a>&nbsp;&nbsp;';
				    html+='<a href="javascript:;" class="delLink" onclick="deleteOrgUser(\''+baseUser.adminUserId+'\');">删除</a></td>';	
				}
				$("#pageBody").html(html);
			}else{
				$("#pageBody").html("<tr><td colspan='8'>抱歉，未查询到相关记录!</td></tr>");
				$("#totalNum").html("0");
			}
		}else{
			$("#pageBody").html("<tr><td colspan='8'>抱歉，未查询到相关记录!</td></tr>");
			$("#totalNum").html("0");
		}
	}
	function getCreateRealName(createRealName){
		if(createRealName == null || createRealName == 'null' || createRealName == ''){
			return '无';
		}
		return createRealName;
	}
	
	function getUserType(adminFlag){
		if('Y' == adminFlag){
			return '超级管理员';
		}else{
			return '用户';
		}
	}
	function getState(locked){
		if('Y' == locked){
			return '关闭';
		}else{
			return '开启';
		}
	}
	
	function deleteOrgUser(id){
		Win.confirm({'id':'deleteConfirm','html':'确认要删除吗?'},function(){
			$.post("${root}/admin/orgUser/deleteBaseUserById.do",{'baseUserId':id},function(data){
				if(data){
					if(data.result){
						Win.alert('删除成功');
						splitPage.reload();
					}else{
						Win.alert('删除失败！');
					}
				}else{
					Win.alert('删除失败！');
				}
			});
		},function(){});
	}
	
	function editOrgUser(baseUserId){
		Win.open({id:"addOrgUserWin",url:"${root}/admin/orgUser/toEditOrgUser.html?baseUserId="+baseUserId,title:"编辑账号",width:600,height:400,mask:true});
	}
	function search(){
		//var adminFlag = $("#adminFlag").val();
		var userName = $("#userName").val();
		var realName = $("#realName").val();
		var contact=$("#contact").val();
		var position=$("#position").val();
		/* var containFlag = "NO";
		if($('#containFlag').is(':checked')){
			containFlag = 'YES';
		}else{
			containFlag = 'NO';
		}
		var areas = $("#areaSelect select");
		var areaLength = areas.length;
		var baseAreaId = "";
		var baseAreaId1 = "";
		if(areaLength == 1){
			baseAreaId = $(areas[0]).val();
		}else{
			baseAreaId = $(areas[areaLength-2]).val();
			baseAreaId1 =$(areas[areaLength-1]).val();
			if("-1" != baseAreaId1){
				baseAreaId = baseAreaId1;
			}
		} */
		$("#pager").html("");
		alert("searchin");
		var config = {
				node:$id("pager"),
				url:"${root}/admin/orgUser/getOrgBaseUserList.do",
				count : 20,
				type :"post",
				callback:getOrgUserList,
				data:{
					userName:userName,
					realName:realName,
					contact:contact,
					position:position
				}
			};
			splitPage = new SplitPage(config);
	}
	
	function exportOrgUserList(){
		var adminFlag = $("#adminFlag").val();
		var userName = $("#userName").val();
		var locked = $("#locked").val();
		var containFlag = "NO";
		if($('#containFlag').is(':checked')){
			containFlag = 'YES';
		}else{
			containFlag = 'NO';
		}
		var areas = $("#areaSelect select");
		var areaLength = areas.length;
		var baseAreaId = "";
		var baseAreaId1 = "";
		if(areaLength == 1){
			baseAreaId = $(areas[0]).val();
		}else{
			baseAreaId = $(areas[areaLength-2]).val();
			baseAreaId1 =$(areas[areaLength-1]).val();
			if("-1" != baseAreaId1){
				baseAreaId = baseAreaId1;
			}
		}
		var url = "${root }/admin/orgUser/exportOrgUserList.do?adminFlag="+adminFlag
				+"&userName="+encodeURIComponent(encodeURIComponent(userName))+"&locked="+locked+"&containFlag="+containFlag+"&baseAreaId="+baseAreaId;
		window.location.href = url;
	}
	
	function orgUserImport(){
		Win.open({id:"uploadExcel",width:500,height:260,title:"批量导入机构用户",url:"${root}/admin/commons/importUserPage.do?userType=area",mask:true});
	}
	</script>
</body>
</html>