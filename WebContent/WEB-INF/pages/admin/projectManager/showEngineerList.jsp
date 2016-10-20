<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script src="${root }/public/js/basiccheck.js"></script>
<script src="${root }/public/js/map.js"></script>
</head>
</head>
<body>
<div class="commonWrap" style="">
			<ul class="commonUL">
				<li>
				 <label>已选择工程师：</label>
				 <span id="engineer">
				    
				 </span>
				 <span>
				   &nbsp;&nbsp;<input type="button" class="submit btn mr10" value="确定" onclick="commitEngineer()" />
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
				<div>总共<span class="totalNum" id="totalNum"></span> 条数据</div>
			</div>
		<table class="tableBox">
			<tr>
			    <th width="5%"><input type="checkbox" id="checkall" name="checkall" onclick="checkAll()"></th>
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
	var domid = frameElement.getAttribute("domid");
	var map=new Map();
	var engineers=null;
	$(document).ready(function(){
		var splitPage;
		editEngineers();
		search();
	});
	
	//关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
	
	function getOrgUserList(data,total){
		if(total || total != 0){
			if(data){
				$("#totalNum").html(total);
				var start = splitPage.req.start;
				var html ='';
				var baseUser;
				var cheall=false;
				if(map.size()>9){
					 $("input[name='checkall']").prop("checked",true);
				}
				for(var i = 0,j = data.length;i<j;i++){
					baseUser = data[i];
					start++;
					html+='<tr>';
					var flag = false;
				      //遍历map
					  if(map!=null){
						  map.each(function(key,value,index){
							  if(map.containsKey(baseUser.adminUserId)){
								  flag=true;
							  }  
						  });
					  }
					  if(flag){
				         html+='<td><input type="checkbox" id="'+baseUser.adminUserId+'" value="'+baseUser.realName+'" name="user" onchange="change(\''+baseUser.adminUserId+'\')" checked="checked"></td>';
					  }else{
					     $("input[name='checkall']").prop("checked",false);
						 html+='<td><input type="checkbox"  id="'+baseUser.adminUserId+'" value="'+baseUser.realName+'" name="user" onchange="change(\''+baseUser.adminUserId+'\')"></td>';
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
		var realName = $.trim($("#realName").val());
		var str='';
		var projectId='${projectId}';
		var state='N';
		$("#pager").html("");
		var config = {
				node:$id("pager"),
				url:"${root}/admin/adminuser/getadminlist.do",
				count:10,
				type:"post",
				callback:getOrgUserList,
				data:{
					realName : realName,
					projectId : projectId,
					state    : state
				}
			};
			splitPage = new SplitPage(config);
	}
	//==选择复选框事件
	function change(id){
		var html='';
		var ischecked=$("#"+id).is(':checked');		
		if(ischecked){
			//传过来的编辑对象不为null
		    map.put(id,$("#"+id).val());
			map.each(function(key,value,index){
		    html+='<span id='+key+' class="ch">'+value+'</span>';
		    html+='<span id='+key+'a>,</span>';
			});
			if($("input[type='checkbox']").length-1 == $(":checked").length){
					$("input[name='checkall']").prop("checked",true);
			}
		    $("#engineer").html(html);
		    $("#engineer").children().last().text('');
	    }else{
	       if(map.containsKey(id)){
		      $("input[name='checkall']").prop("checked",false);
	    	    map.remove(id);
	    	    $("#"+id).remove();
	    	    $("#"+id+"a").remove();
	    	  	$("#engineer").children().last().text('');
	        }
	    }  
	}
	 function checkAll(){
		    var html='';
			var ischecked=$("#checkall").is(':checked');
		    if(ischecked){
			   $("input[name='user']").each(function(){
					$("input[name='user']").prop("checked",true);
					 var id=$(this).attr("id");
					 map.put(id,$(this).val());
				});
			  map.each(function(key,value,index){
				 html+='<span id='+key+' class="ch">'+value+'</span>';
				 html+='<span id='+key+'a>,</span>';
			  });
			  $("#engineer").html(html);
			  $("#engineer").children().last().text('');
	        }else{
			     $("input[name='user']").each(function(){
				   $("input[name='user']").prop("checked",false);
				   if(map.containsKey($(this).attr("id"))){
					   map.remove($(this).attr("id"));
				       $("#"+$(this).attr("id")).remove();
				       $("#"+$(this).attr("id")+"a").remove();
				   }
				 });
			     
	        }
	 } 
	 
	 
	//==提交工程师
	function commitEngineer(){
		  $(".ch").each(function(){
		      map.put($(this).attr("id"),$(this).text());
		  });
		  if(realName!=''){
			  parent.showEngineer({
			  engineer:map//参数传递
		     });
			 closeMe();    
		  }
	}
	//== 展示要编辑的工程师
	function editEngineers(){
		if(parent.editEngs!=null){
			//parent.editEngs 是一个js原生map
			var html='';
			for(var prop in parent.editEngs){
				 html+='<span id='+prop+' class="ch">'+parent.editEngs[prop]+'</span>';
				 html+='<span id='+prop+'a>,</span>';
			  map.put(prop,parent.editEngs[prop]);
			} 
			$("#engineer").html(html);
			$("#engineer").children().last().text('');
		}
	   
	}
	
	</script>
</html>