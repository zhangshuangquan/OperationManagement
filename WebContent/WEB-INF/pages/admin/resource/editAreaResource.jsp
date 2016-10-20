<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script type="text/javascript" src="${root }/public/upload/uploadfile.js"></script>
<script src="${root }/public/js/basiccheck.js"></script>
<script src="${root }/public/js/map.js"></script>

<script type="text/javascript">
var domid = frameElement.getAttribute("domid");//进行关闭当前窗口的操作

//进行用户编辑验证
$(
		function(){
			
			new BasicCheck({
				form: $id("editAreaResource"),
				ajaxReq : function(){
					console.log("tijiao");
					
					var s='';
					var str='';
					if($(".e").attr("id")==null){
				       $("#showProjectName").children().each(function(){
				    	    str+=$(this).attr("id");
							str+=",";
				       });
				       s=str.substring(0,str.length-1);
					}else{
						$(".e").each(function(){
							str+=$(this).attr("id");
							str+=",";
						});
						s=str.substring(0,str.length-1);
					}
					
					//ajax提交
					$.ajax({
						type: 'POST',
						url: '${root}/admin/arearesource/updateregresource.do?projList='+s,
						data:$("#editAreaResource").serialize(),
						success : function(r){
			                try {
			                    if(!r.result){
			                        Win.alert('操作失败！');
			                    }else{
			                        parent.Win.alert('操作成功!');
			                        parent.location.reload(); 
			                    }
			                } catch(e) {
			                    Win.alert("错误提示:"+e.message);
			                }
			            },
						  
					});
				},
				warm: function warm(o, msg) {
					Win.alert(msg);
				} 
			});
			
			
			//让已选的单选菜单处于选中状态
			$('#select option[value=${requestScope.regresObj.type}]').attr('selected','selected');
			
		}
		
		
);


//关闭窗口
function closeMe() {
	parent.Win.wins[domid].close();
}
		

//进行项目编辑的弹框		
function selectProject(){
	
	if($(".e")!=null){
	
			parent.editEngs={};
			  $(".e").each(function (){
				  parent.editEngs[this.id]=this.innerHTML;
			    });  
		}
	
		parent.Win.open({
			id:"project",
			url:"${root}/admin/area/jumptoeditselecpro.do",
			title:"项目编辑",
			width:650,
			height:700,
			mask:true}).css('left:700px;top:300px');
	
}

//显示编辑后的项目
parent.showproject = function (data) {
    var map=data.project;
    var html='';
    map.each(function(key,value,index){
    	html+='<span id='+key+' class="e">'+value+'</span>';
    	html+='<span id='+key+'a>,</span>';
    });
    $("#showProjectName").html(html);
    $("#showProjectName").children().last().remove();
}


//将指定资源对应的所有项目在指定位置进行显示
$(
        function(){
        	//alert("ok");
        	//获得本资源的id
        	 var $reginalResourceId =$("input[type='hidden']").val();
        	//alert("reginalResourceId="+$reginalResourceId);
             var url="${root}/admin/arearesource/selcprobyId.do";
                var args={
                		
                		RegionalResourceId:$reginalResourceId	
                };
                $.post(
                  url,
                  args,
                  function(data){
                	  var html='';
                	  //alert("len="+data.length);
                	for(var i=0; i<data.length; i++){
                		
					    //alert("projId="+data[i].projectId+"----proName="+data[i].projectName);
                		html+='<span id='+data[i].projectId+' class="e">'+data[i].projectName+'</span>&nbsp;&nbsp;&nbsp;';
                	}
                	
                	$("#showProjectName").html(html);
                  }
                );
                
                return false; 
         
        }
     )
</script>
</head>

<body>

   <form id="editAreaResource">
     <ul class="commonUL" style="margin-left:20px; width: 600px">
        <li class="clearfix" style="margin:5px 2px 15px;">
             <input type="hidden" name="regionalResourceId"  value="${requestScope.regresObj.regionalResourceId}"/>
             <label>供应商名称:</label>
             <input type="text" name="name" id="name" value="${requestScope.regresObj.name}" needcheck nullmsg="请输入供应商名称!"/>
        </li> 
        <li class="clearfix" style="margin:5px 40px 15px;">     
           <label>类别:</label>
	         <select name="type" class="type" id="select">
			  <option value="材料">材料</option>
			  <option value="餐饮">餐饮</option>
			  <option value="住宿">住宿</option>
			  <option value="交通">交通</option>
			  <option value="其他">其他</option>
	         </select>
         </li>
         <li class="clearfix" style="margin:5px 50px 15px;">
             <label>已选项目显示:</label>
	         &nbsp;&nbsp;<span id="showProjectName"></span><br/><br/>
	        <!-- 必须使用input标签的button-->
	        <input type="button" class="btn btnGreen" onclick="selectProject()" value="编辑项目"/>
          </li>
          <li class="clearfix" style="margin:5px 38px 15px;">
            <label>区域:</label>
            <span>${requestScope.regresObj.baseArea.areaPath}</span>
          </li> 
         <li class="clearfix" style="margin:5px 40px 15px;">   
            <label>地址:</label>
            <input type="text" name="address" id="address" value="${requestScope.regresObj.address}" needcheck nullmsg="请输入联系人地址!"/>
         </li>
         <li class="clearfix" style="margin:5px 30px 15px;">       
            <label>联系人:</label>
            <input type="text" name="contactPersonName" id="contactPersonName" value="${requestScope.regresObj.contactPersonName}" needcheck nullmsg="请输入联系人名称!"/>
        </li>
        <li class="clearfix" style="margin:5px 20px 15px;">
            <label>联系电话:</label>
            <input type="text" name="contactPersonPhone" id="contactPersonPhone" value="${requestScope.regresObj.contactPersonPhone}" needcheck nullmsg="请输入联系电话!" reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" errormsg="联系电话格式不正确！"/>
        </li> 
        <li class="clearfix" style="margin:5px 20px 15px;"> 
            <label>服务内容:</label>
            <input type="text" name="serviceContent" id="serviceContent" value="${requestScope.regresObj.serviceContent}" needcheck nullmsg="请输入服务内容!"/>
        </li> 
        <li class="clearfix" style="margin:5px 45px 15px;"> 
            <label>备注:</label>
            <textarea name="remark" cols="20" rows="5" id="remark">${requestScope.regresObj.remark}</textarea><br/><br/>
            <label>附件:</label>
             <a href="javascript:;" class="uploadBox btn" onclick="return false;" style="margin-left:30px; margin-top:3px;">
	                               上传<span id="uploadCont" class="uploadCont"> </span>
             </a>
        </li>
        <li class="clearfix" style="margin:5px 60px 15px;">
		         <ul id="uploadInfoBox" class="commonUL">
			        <c:if test="${requestScope.attachList!=null}">
			              <c:forEach items="${requestScope.attachList}" var="quali">
			                 <li id='${quali.attachment_Url}'><span class='infoLabel'><b class='fileName mr10' title='${quali.name}'>${quali.name}</b><b class='fileSize mr10'>"+(info.size/1024/1024).toFixed(2)+"MB</b></span><span class='progressBox mr20'><b class='progressBar mr10'><em class='progressRate'>&nbsp;</em></b>&nbsp;&nbsp;<b class='uploaded'></b></span><span class='uploadOperate'></span><span><a href='javascript:;' file='${quali.attachment_Url}' class='delUploadFile'>删除</a></span><input type='hidden' name='oraginalFileName' value='${quali.name}'/><input type='hidden' name='newFileName' value='${quali.attachment_Url}'/></li>
			              </c:forEach>
			          </c:if>
		         </ul>
		  </li>  
        <li class="clearfix" style="margin:5px 70px 15px;">
            <input type="submit" class="btn btnGreen" value="确定"/>&nbsp;&nbsp;<input class="btn btnGreen" type="reset" value="取消" onclick="closeMe()"/>
        </li>
    </ul>  
  </form>
  <script>
//获得上传的图片的原来的名字与新生成的名字
	 var params = {
	        debug : 1,
	        fileType : "*.flv;*.pdf;*.doc;*.ppt;*.docx;*.pptx;*.xls;*.xlsx;*.PDF;*.DOC;*.PPT;*.DOCX;*.PPTX;*.XLS;*.XLSX;*.jpg;*.gif;*.png;*.jpeg;*.bmp;*.swf;*.rar;",
	        typeDesc : "office文档、图片、pdf文档",
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
	 	});
	 	
	 	//var orginalFileName='';
	 	                                           //显示上传的文件信息
	 	uploadSwf.uploadEvent.add("onOpen",function(){
	 		
	 		
	 		var elm = arguments[0].message[0],
	 			info = arguments[0].message[1];
	 		//var jsonData = JSON.parse(arguments[0].message[1]);
	 		if($id(elm)) return false;
	 		$id("uploadInfoBox").innerHTML += "<li id='"+elm+"'><span class='infoLabel'><b class='fileName mr10' title='"+info.name+"'>"+info.name+"</b><b class='fileSize mr10'></b></span><span class='progressBox mr20'><b class='progressBar mr10'><em class='progressRate'>&nbsp;</em></b>已上传<b class='uploaded'>0%</b></span><span class='uploadOperate'><a class='cancelUpload' href='javascript:;' file='"+elm+"'>取消上传</a></span><input type='hidden' name='oraginalFileName' value='"+info.name+"'/></li>";
	 	});
	 	
  </script>
</body>
</html>