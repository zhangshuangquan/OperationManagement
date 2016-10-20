<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script src="${root }/public/js/basiccheck.js"></script>
<script src="${root }/public/js/map.js"></script>

<script type="text/javascript">

//行政区的选择
$(document).ready(function(){
	$.post("${root}/admin/area/getBaseAreaByParentId.do",{"parentId":"-1"},function(data){
		var html = '<option value="">-- 请选择 --</option>';
		for(var i = 0,j = data.length; i<j; i++){
		     html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
			
		}
		$("#province").html(html);
	},'json');
	selectBind("chooseArea","${root}/admin/area/getBaseAreaByParentId.do","parentId");		
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
		
	   //alert("baseAreaId="+baseAreaId);
	   //getAreaValue(baseAreaId);
	   //将区域的id值注入隐藏域中
	   $("input:hidden[name='areaId']").val(baseAreaId);
		
	});
});


var domid = frameElement.getAttribute("domid");//进行关闭当前窗口的操作

</script>
</head>
<body>
<div class="commonWrap" style="">
			<ul class="commonUL">
				<li>
				 <label class="cont">已选项目：</label>
				 <span id="project">
				    
				 </span>
				 <span class="cont">
						<input type="button" class="submit btn mr10" value="确定" onclick="commitProject()" />
				</span>
			    </li>
				<li>
					<input  type="hidden" name="areaId" value=""/>
                 <label class="text">区域：</label>
					<span class="cont" id="chooseArea">
						<select class="mr20" id="province">
							<option value="-1">请选择</option>
						</select>
						
						<!-- 查询必须使用input的button-->
					</span>&nbsp;项目名称:<input type="text" id="projName"/>&nbsp;<input type="button" id = "queryBtn" class="submit btn" name="query" value="查询" /><br/><hr/>
					
					 <input id="userId" type="hidden" value="${requestScope.uId}"/>
			   </li>
			</ul>
		<div class="totalPageBox">
				 <div class="totalPageBox">总共<span class="totalNum">0</span> 条项目</div> 
			</div>
		 <table class="tableBox">
			<tr>
			    <th width="5%"><input type="checkbox" id="checkall" name="checkall" onclick="checkAll()"></th>
				<th>项目名称</th>
				<th>项目编号</th>
				<th>项目区域</th>
			</tr>
			<tbody id="pageBody">
			</tbody>
		</table>
		<div id="pageNavi" class="pageNavi"></div>
	</div>
	  				
	
<script type="text/javascript">


var map=new Map();//创建一个Map对象
$(function(){
	
	editProject();
})

	
//==选择复选框事件
	//==选择复选框事件
//==选择复选框事件

	var mySplit = new SplitPage({
	    node : $id("pageNavi"),
	    url :"${root}/admin/projectmanager/getprojectlist.do",
	    data:   {
		},
	    count : 10,
	    callback : showList,
	    type : 'post'
	});
	
	  
		//按条件进行查询函数
		function search(){
			var baseAreaId=$("input:hidden[name='areaId']").val();
			var $projName=$("#projName").val();
			var url="${root}/admin/projectmanager/getprojectlist.do";
			var param  = {
					baseAreaId:baseAreaId,
					projName:$projName
			};
			mySplit.search(url,param);
		}
		
		function showList(data,totalCnt){
			var len = data.length;
			//alert("len="+len);
			//alert("data[1].projectId="+data[1].projectId+" ,data[1].projectName="+data[1].projectName);
			var html = '';   
			if(len>0){
				if(map.size()>9){
					 $("input[name='checkall']").prop("checked",true);
				}
				for(var i = 0; i< len; i++){
					
					var resObj = data[i];
					 html+='<tr>';
					var flag = false;
					  if(map!=null){  //遍历传来的Map集合，将已选的选中
						  map.each(function(key,value,index){
							  if(map.containsKey(resObj.projectId)){
								  flag=true;
							  }  
						  });
					  }
				
					/*   if(flag){
						    html+='<tr>';
							html+='<td><input type="checkbox" checked="checked"  id="'+resObj.projectId+'" value="'+resObj.projectName+'" name="user" onchange="change(\''+resObj.projectId+'\')"></td>';
							html+='<td>'+resObj.projectName+'</td>';
							html+='<td>'+resObj.projectCode+'</td>';
							html+='<td>'+resObj.baseArea.areaPath+'</td>';
							html+='</tr>';
						  
					  }else{
						  $("input[name='checkall']").prop("checked",false);
							    html+='<tr>';
								html+='<td><input type="checkbox"  id="'+resObj.projectId+'" value="'+resObj.projectName+'" name="user" onchange="change(\''+resObj.projectId+'\')"></td>';
								html+='<td>'+resObj.projectName+'</td>';
								html+='<td>'+resObj.projectCode+'</td>';
								html+='<td>'+resObj.baseArea.areaPath+'</td>';
								html+='</tr>';
						  } */
					if(flag){
						html+='<td><input type="checkbox" checked="checked"  id="'+resObj.projectId+'" value="'+resObj.projectName+'" name="user" onchange="change(\''+resObj.projectId+'\')"></td>';
					}else{
						 $("input[name='checkall']").prop("checked",false);
						 html+='<td><input type="checkbox"  id="'+resObj.projectId+'" value="'+resObj.projectName+'" name="user" onchange="change(\''+resObj.projectId+'\')"></td>';
					}
					html+='<td>'+resObj.projectName+'</td>';
					html+='<td>'+resObj.projectCode+'</td>';
					html+='<td>'+resObj.baseArea.areaPath+'</td>';
					html+='</tr>';
					
					
				}
			} else {
				html += '<tr><td colspan="6">抱歉！没有搜索到您想要的信息！</td></tr>';
			}
			$("#pageBody").html(html);//将拼接好的数据放置到表格体中		
			$(".totalNum").html(totalCnt);
		}
	
		
		
		

		 $("#queryBtn").click(function(){
				search();
			});
		 
		 
		 /////////////////////////////


//获得原来选中的Map对象的项目集合

		//关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
	
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
			/* if(parent.editEngs==null){
				  if(map.size()>9){
				   $("input[name='checkall']").prop("checked",true);
			      }
				}else{
					var i=0;
					for(var prop in parent.editEngs){
					     i++;
					}
					if((map.size()-i)%10==0){
					   $("input[name='checkall']").prop("checked",true);
					}
				} */
				console.log($("input[type='checkbox']").length);
				console.log($(":checked").length);
			if($("input[type='checkbox']").length == $(":checked").length){
				$("input[name='checkall']").prop("checked",true);
		}
				
		    $("#project").html(html);
		    $("#project").children().last().text('');
	    }else{
	       if(map.containsKey(id)){
		      $("input[name='checkall']").prop("checked",false);
	    	    map.remove(id);
	    	    $("#"+id).remove();
	    	    $("#"+id+"a").remove();
	    	  	$("#project").children().last().text('');
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
			  $("#project").html(html);
			  $("#project").children().last().text('');
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
	 
	 
	//==提交
	function commitProject(){
		  $(".ch").each(function(){
		      map.put($(this).attr("id"),$(this).text());
		  });
	
	 parent.showproject({
			  project:map//参数传递
		     });
			 closeMe();    
		  
	}
	
	// 展示要编辑的
	function editProject(){
		if(parent.editEngs!=null){
			//parent.editEngs 是一个js原生map
			var html='';
			for(var prop in parent.editEngs){
				 html+='<span id='+prop+' class="ch">'+parent.editEngs[prop]+'</span>';
				 html+='<span id='+prop+'a>,</span>';
			  map.put(prop,parent.editEngs[prop]);
			} 
			$("#project").html(html);
			$("#project").children().last().text('');
		}
	   
	}
	
	
	//关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
		
	
	</script>			
					
</body>
</html>