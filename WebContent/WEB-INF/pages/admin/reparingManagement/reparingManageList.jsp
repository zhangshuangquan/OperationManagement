<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${root }/public/upload/uploadfile.js"></script>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script type="text/javascript">
//行政区的选择
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
		
	});
		
</script>
</head>
<body>

   <h3 id="cataMenu">
		<a href="javascript:;">售后维护保障记录</a> &gt; <a href="javascript:;">现场维修</a>
   </h3>
 <div id="control">
		<div id="controlContent">
		<ul class="searchWrap borderBox">
			<li class="clearfix" style="margin:5px 0 15px;">
    <label class="labelText">项目区域：</label>
				<span class="cont" id="chooseArea">
					<select class="mr20" id="province">
						<option value="-1">请选择</option>
					</select>
				</span>
	<label class="labelText">项目：</label><input type="text" id="projectName"/>
	<label class="labelText">最新状态：</label><select id="status">
	          <option value="">请选择</option>
						<option value="客户来电">客户来电</option>
						<option value="派工流程">派工流程</option>
						<option value="任务分配">任务分配</option>
						<option value="上门维修">上门维修</option>
						<option value="问题解决">问题解决</option>
						<option value="售后回访">售后回访</option>
						
	       </select><br/><br/>
	      
    <label class="labelText">学校区域：</label>
				<span class="cont" id="schoolchooseArea">
					<select class="mr20" id="schoolprovince">
						<option value="-1">-- 请选择 --</option>
					</select>
				</span>
	 <label class="labelText">学校：</label>
	   <span>
	    <input type="text" id="schoolName"/>
	   </span>
	 <label class="labelText">联系人：</label><input type="text" id="concat"/>
	 <label class="labelText">联系电话：</label><input type="text" id="phone"/>
	 <span style="margin-left:20px;">
	 <input type="button" id ="queryBtn" class="submit btn" name="query" value="查询" />
	 </span>
	 </li>
	 </ul>
	 <div class="totalPageBox">
	  <div class="fr">
	    <a class="btn btnGreen" style='margin-right:20px;' href="javascript:;" onclick="exportReparingList();">导出</a>
	  </div> 
	  总共<span class="totalNum">0</span> 条数据</div>
		<table class="tableBox">
			<tr>
				<th width="10%">单号</th>
				<th width="10%">学校名称</th>
				<th width="15%">学校区域</th>
				<th width="5%">联系人</th>
				<th width="5%">联系电话</th>
				<th width="10%">项目</th>
				<th width="5%">最新状态</th>
				<th width="5%">售后保障表</th>
				<th width="5%">图片附件</th>
				<th width="5%">操作</th>
				<th width="25%">备注</th>
			</tr>
			<tbody id="tbody"></tbody>
		</table>
		<div id="pageNavi" class="pageNavi"></div>
   </div>
 </div>
	<script type="text/javascript">
	
	  
	   	var mySplit = new SplitPage({
	    node : $id("pageNavi"),
	    url :"${root}/admin/maintenanceorder/getmainorderreplist.do",
	    data:   {
		},
	    count : 20,
	    callback : showList,
	    type : 'post'
	});
	   	
	   
		function showList(data,totalCnt){
			var len = data.length;
			//alert("len="+len);
			var html = '';
			if(len>0){
				for(var i = 0; i< len; i++){
					var resObj = data[i];
					var downLoadHtml='javascript:;';  //可以防止刷新本页面
					var corStr="color:gray;";
					if(resObj.attachment_Url!=null && resObj.name!=null){
						corStr="color:#72A53E;";
					    downLoadHtml='${root}/images/'+resObj.attachment_Url+'/'+encodeURIComponent(resObj.name);
					}
				    html += '<tr>';
					html += '<td>'+(resObj.order_Num==null?'-':resObj.order_Num)+'</td>';
					html += '<td>'+(resObj.school_name==null?'-':resObj.school_name)+'</td>';
					html += '<td>'+(resObj.schArea==null?'-':resObj.schArea)+'</td>';
					html += '<td>'+(resObj.concat==null?'-':resObj.concat)+'</td>';
					html += '<td>'+(resObj.phone==null?'-':resObj.phone)+'</td>';
					html += '<td>'+(resObj.project_name==null?'-':resObj.project_name)+'</td>';
					html += '<td><span>'+(resObj.maxdate==null?'':resObj.maxdate)+'</span><br/><span>'+(resObj.maxdatestr==null?'-':resObj.maxdatestr)+'</span></td>';
					html += '<td class="verticalBottom"><a href="javascript:;" class="uploadBox"  onclick="return false;">上传<span id="uploadCont'+resObj.maintenance_Order_Id+'" class="uploadCont"></span></a>&nbsp;&nbsp;<a  style='+corStr+'   href='+downLoadHtml+'>下载</a></td>';
					html += '<td><a href="javascript:;" onclick="uploadPicture(\''+resObj.maintenance_Order_Id+'\');" >上传</a>&nbsp;&nbsp;<a href="javascript:;" onclick="editPicture(\''+resObj.maintenance_Order_Id+'\');">编辑</a></td>';
					html +='<td>';
				    html += '<a href="javascript:;" class="viewLink"  lang="'+resObj.maintenance_Order_Id+'">查看</a>&nbsp;&nbsp;';
				    html += '<a href="javascript:;" class="editLink"  lang="'+resObj.maintenance_Order_Id+'">编辑</a>';
					html += '</td>';
					html += '<td>'+(resObj.remark==null?'-':resObj.remark)+'</td>';
					html += '</tr>'; 
				}
			} else {
				html += '<tr><td colspan="11">抱歉！没有搜索到您想要的信息！</td></tr>';
			}
			$("#tbody").html(html);//将拼接好的数据放置到表格体中	
			for(var i = 0; i< len; i++){
				var resObj = data[i];
				initSwf(resObj.maintenance_Order_Id);
			}
			$(".totalNum").html(totalCnt);
		}
		
		//单击查看按钮
		  $(".tableBox").on("click",".viewLink",function(){
			  	var $resId = $(this).attr("lang");
			     
			  	Win.open({id:"addOrgUserWin",url:"${root}/admin/maintenanceorder/jumptorepmanagedetail.html?maintenanceOrderId="+$resId,title:"售后保障记录",width:800,height:420,mask:true});
				});
		
		//单击编辑按钮
		  $(".tableBox").on("click",".editLink",function(){
			  	var $resId = $(this).attr("lang");  
			  	Win.open({id:"addOrgUserWin",url:"${root}/admin/maintenanceorder/jumptoupdaterepmange.html?maintenanceOrderId="+$resId,title:"售后保障记录",width:800,height:420,mask:true});
				});
		
		
		  //条件查询操作
		  $("#queryBtn").click(function(){
			  //alert("ok");
				search();
			});
		  
			//按条件进行查询函数
		  function search(){
			
			//alert("ok");
			//获取项目选择的区域
			  var areasP = $("#chooseArea select");
				var baseAreaIdPro = "";
				var baseAreaId11 = "";
				if(areasP.length == 1){
					baseAreaIdPro = $(areasP[0]).val();
				}else{
					baseAreaIdPro = $(areasP[areasP.length-2]).val();
					baseAreaId11 =$(areasP[areasP.length-1]).val();
					if("-1" != baseAreaId11){
						baseAreaIdPro = baseAreaId11;
					}	
				}
				
	        //获取学校区域
				  var areasS = $("#schoolchooseArea select");
					var baseAreaIdSch = "";
					var baseAreaId12 = "";
					if(areasS.length == 1){
						baseAreaIdSch = $(areasS[0]).val();
					}else{
						baseAreaIdSch = $(areasS[areasS.length-2]).val();
						baseAreaId12 =$(areasS[areasS.length-1]).val();
						if("-1" != baseAreaId12){
							baseAreaIdSch = baseAreaId12;
						}	
					}
					
					
		  	var projectArea=baseAreaIdPro;
		  	var schoolArea=baseAreaIdSch;
		  	var projectName=$("#projectName").val();
		  	var status=$("#status").val();
		  	var schoolName=$("#schoolName").val();
		  	var concat=$("#concat").val();
		  	var phone=$("#phone").val();
		  	var url="${root}/admin/maintenanceorder/getmainorderreplist.do";
		  	var param  = {
		  			projectArea:projectArea,
		  			schoolArea:schoolArea,
		  			projectName:projectName,
		  			status:status,
		  			schoolName:schoolName,
		  			concat:concat,
		  			phone:phone
		  	};
		  	mySplit.search(url,param);
		  }
		  
			
	//维修列表导出功能		
			function exportReparingList(){
				
				 var areasP = $("#chooseArea select");
					var baseAreaIdPro = "";
					var baseAreaId11 = "";
					if(areasP.length == 1){
						baseAreaIdPro = $(areasP[0]).val();
					}else{
						baseAreaIdPro = $(areasP[areasP.length-2]).val();
						baseAreaId11 =$(areasP[areasP.length-1]).val();
						if("-1" != baseAreaId11){
							baseAreaIdPro = baseAreaId11;
						}	
					}
					
		        //获取学校区域
					  var areasS = $("#schoolchooseArea select");
						var baseAreaIdSch = "";
						var baseAreaId12 = "";
						if(areasS.length == 1){
							baseAreaIdSch = $(areasS[0]).val();
						}else{
							baseAreaIdSch = $(areasS[areasS.length-2]).val();
							baseAreaId12 =$(areasS[areasS.length-1]).val();
							if("-1" != baseAreaId12){
								baseAreaIdSch = baseAreaId12;
							}	
						}
					
						var projectArea=baseAreaIdPro;
					  	var schoolArea=baseAreaIdSch;
					  	var projectName=$("#projectName").val();
					  	var status=$("#status").val();
					  	var schoolName=$("#schoolName").val();
					  	var concat=$("#concat").val();
					  	var phone=$("#phone").val();
				  	
				var url = "${root}/admin/maintenanceorder/exportreparinglist.do?projectArea="+projectArea
						+"&projectName="+encodeURIComponent(projectName)
						+"&status="+encodeURIComponent(status)
						+"&schoolName="+encodeURIComponent(schoolName)
						+"&concat="+encodeURIComponent(concat)
						+"&phone="+phone
						+"&schoolArea="+schoolArea
						;
				window.location.href = url;
				
			}
	
	
			function initSwf(id){
				 var params = {
		                 debug : 1,
		                 fileType : "*.flv;*.pdf;*.doc;*.ppt;*.docx;*.pptx;*.xls;*.xlsx;*.PDF;*.DOC;*.PPT;*.DOCX;*.PPTX;*.XLS;*.XLSX;*.jpg;*.gif;*.png;*.jpeg;*.bmp;*.swf;*.rar;",
		                 typeDesc : "office文档、图片、pdf文档",
		                 autoStart : true,
		                 multiSelect : 0,  //表示每次只能上传一个     1 表示可以进行批量上传
		                 server: encodeURIComponent("${root}/ImageUploadServlet")
		         	};
		          	window["uploadSwf"+id] = new UploadFile($id("uploadCont"+id), "uploadSwf"+id, "${root}/public/upload/uploadFile.swf",params);
		          	
		          	
		          	window["uploadSwf"+id].uploadEvent.add("onComplete",function(){
		          		var elm = arguments[0].message[0],
		          			data = arguments[0].message[1];
		          		
		          		//控制台打印信息
		          		console.log(data);
		          		console.log(JSON.parse(data).message);
		          		console.log(JSON.parse(data).realname);
		          	
		          	//在这里拿到单号的id并使用ajax在后台数据库查看有没有上传过文件,如果存在文件，弹出是否覆盖
		          	//若点击确认则执行覆盖操作(即根据单号删除对应的文件并添加新的文件)
		          	//下载文件必须在打开本页面的时候从数据库中将对应工单号的图片的新名字拿到(需要left join 图片表attachment
		          			//每次刚新上传的图片立即将新上传图片的新名字填在 对应的工单记录上------对应的下载的id为对应工单的编号
		          			
		          	//即可以实现上传之后立即可以下载)
		          	
		          		//Win.alert("上传附件成功!");
		          		//已获得上传文件的原文件名和服务器端生成的文件名
		          		/* $("#newFileName").attr("value",JSON.parse(data).message);
		          		$("#orginalFileName").attr("value",JSON.parse(data).realname); */
		         		
		          		 var url="${root}/admin/maintenanceorder/getorderattachmentbyid.do?orderId="+id;
		                 var args={};
		                 $.post(
		                   url,
		                   args,
		                   function(datas){
		                 	  
		                	   // 根据工单的id在存放图片的表中进行查询   若存在图片即给予提示是否覆盖
		                	   //console.log(datas);
		                	   if(''!=datas){//表示附件已存在
		                		   
		                			Win.confirm({mask:true,html:"确定要覆盖原来上传的文件吗?"},function(){
		            				    var url = "${root}/admin/maintenanceorder/delInsertAttachment.do";
		            					$.ajax({
		            						   type: "POST",
		            						   url: url,
		            						   data:{
		            							   'relationShipId':id,
		            							   'name':JSON.parse(data).realname,
		            							   'attachment_Url':JSON.parse(data).message
		            						   },
		            						   success: function(msg){
		            						     Win.alert("附件上传成功！");
		            						     window.location.reload();//刷新页面让下载链接获得最新下载资源信息
		            						   }
		            					 }); 
		            				},function(){});
		                	   
		                	   }else{
		                		   
		                		   //Win.alert("附件没有！");
		                		   //直接进行文件上传(即原来没有上传的文件)
		                		    var url = "${root}/admin/maintenanceorder/insertattachment.do";
		                		
	            					$.ajax({
	            						   type: "POST",
	            						   url: url,
	            						   data:{
	            							   'relationShipId':id,
	            							   'name':JSON.parse(data).realname,
	            							   'attachment_Url':JSON.parse(data).message
	            						   },
	            						   success: function(msg){
	            						     Win.alert("附件上传成功！");
	            						     window.location.reload();//刷新页面让下载链接获得新值
	            						   }
	            					 }); 
		                	   }
		                   }
		                 );
		                 
		                 return false;
		          
		          		
		          	});
		          	
		          	
		          	window["uploadSwf"+id].uploadEvent.add("onOpen",function(){
		          		console.log(arguments[0].message);
		          		
		          		var elm = arguments[0].message[0],
		          			info = arguments[0].message[1];
		          		
		          	});
		          	
			}
			
			
			//进行图片上传操作  打开图片上传窗口
          	function uploadPicture(orderId){
          		
          		Win.open({id:"addOrgUserWin",url:"${root}/admin/maintenanceorder/jumptouploadpic.do?maintenanceOrderId="+orderId,title:"图片附件查看",width:700,height:420,mask:true});
			 
          	}
			
          //编辑图片
        	function editPicture(maintenanceOrderId){
        		Win.open({
        			id:"addAfterSaleWin",
        			url:"${root}/admin/maintenanceorder/jumptoeditpicture.do?maintenanceOrderId="+maintenanceOrderId,
        			title:"图片附件编辑",
        			width:800,
        			height:420,
        			mask:true
        	    });
        	}
          	
		
	</script>
	       			
</body>
</html>