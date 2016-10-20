<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script src="${root }/public/js/basiccheck.js"></script>
<script type="text/javascript">
	var domid = frameElement.getAttribute("domid");
</script>
<body>
	<div class="commonWrap">
			<ul class="commonUL">
				<li>
				 <label>已选择项目经理：</label>
				  <span  id="userlist">
				  </span>
				   <span>
						&nbsp;&nbsp;<input type="button" class="submit btn mr10" value="确定" onclick="commitManager()" />
					</span>
			    </li>
				<li>
					<label class="lableText">姓名：</label>
					<span class="text">
						<input type="text" id="realName" name="realName"/> 
					</span>
				<span class="text">
					&nbsp;&nbsp;<input type="button" class="submit btn mr10" value="查询" onclick="search()" />
			    </span>
			   </li>
			</ul>
		<div class="totalPageBox">
				<div>总共<span class="totalNum" id="totalNum"></span>条数据</div>
			</div>
		<table class="tableBox">
			<tr>
			    <th width="5%"></th>
				<th width="10%">姓名</th>
				<th width="15%">联系电话</th>
			</tr>
			<tbody id="pageBody">
			</tbody>
		</table>
		<div class="pageNavi" id="pager"></div>
	</div>
	</body>
	<script type="text/javascript">
	var id=null;
	var name=null;
	$(document).ready(function(){
		var splitPage;
		search();	
		edit();
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
					if(id!=null&&name!=null&&baseUser.adminUserId==$(".name").attr("id")){
						html+='<td><input type="radio" id="'+$(".name").attr("id")+'" name="rad" value="'+$(".name").text()+'" onchange="change(\''+$(".name").attr("id")+'\')" checked></td>';
					}else{
					  if($(".name").text()!=''&&baseUser.adminUserId==$(".name").attr("id")){
						html+='<td><input type="radio" id="'+baseUser.adminUserId+'" name="rad" value="'+baseUser.realName+'" onchange="change(\''+baseUser.adminUserId+'\')" checked></td>';
					  }else{
					    html+='<td><input type="radio" id="'+baseUser.adminUserId+'" name="rad" value="'+baseUser.realName+'" onchange="change(\''+baseUser.adminUserId+'\')"></td>';
				      }
					}
					html+='<td>'+baseUser.realName+'</td>';
					html+='<td>'+baseUser.contact+'</td>';
					html+='</tr>';
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
	function search(){
		var realName =$.trim($("#realName").val());
		var state='N';
		var projectId='${projectId}';
		$("#pager").html("");
		var config = {
				node:$id("pager"),
				url:"${root}/admin/adminuser/getadminlist.do",
				count:10,
				type:"post",
				callback:getOrgUserList,
				data:{
					realName  : realName,
					projectId :projectId,
					state     : state
				}
			};
			splitPage = new SplitPage(config);
	}
	//==选择单选框事件
	function change(managerId){
		  var realName=$('input:radio[name="rad"]:checked').val();
		  $("#userlist").html('<span id='+managerId+' class="name">'+realName+'</span>'); 
	
		
	}
	
	//关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
	
	//==提交项目经理
	function commitManager(){
	  var managerId=$(".name").attr("id");
	  var realName=$(".name").text();
	  if(realName!=''){
		  parent.showManager({
		  realName: realName,
		  managerId:managerId
	     });
	     closeMe();     
	  }
	}
	
    //展示项目经理
	function edit(){
        id='${managerId}';  //不加引号 会认为是变量
		name='${managerName}';
		if(id!=null&&name!=null){
		  $("#userlist").html('<span id='+id+' class="name">'+name+'</span>'); 
		}
	}
    
	</script>
</html>