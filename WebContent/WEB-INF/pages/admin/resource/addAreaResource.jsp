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

</head>
<!-- style="overflow: hidden;width: 100%;"  隐藏滚动条 -->
<body>

<script type="text/javascript">
    var domid = frameElement.getAttribute("domid");//进行关闭当前窗口的操作
</script>
   <!--  width: 600px来添加外面div宽度-->
   <form id="addAreaResource">
   <ul class="commonUL" style="margin-left:20px; width: 600px">
        <li class="clearfix" style="margin:5px 2px 15px;">
          <label>供应商名称:</label>
          <input type="text" name="name" id="name" needcheck nullmsg="请输入供应商名称!"/>
        </li>
        <li class="clearfix" style="margin:5px 40px 15px;">     
           <label>类别:</label>
         <select name="type" id="type" needcheck nullmsg="请选择类别!">
          <option value="">请选择</option>
		  <option value="材料">材料</option>
		  <option value="餐饮">餐饮</option>
		  <option value="住宿">住宿</option>
		  <option value="交通">交通</option>
		  <option value="其他">其他</option>
         </select>
        </li>
        <li class="clearfix" style="margin:5px 60px 15px;">
           <input type="button" id="selecProj" class="btn btnGreen" onclick="selectProject();"  value="项目选择"/>
           <span id="project"></span><!-- 显示选中的项目 -->
        </li>	
        <li class="clearfix" style="margin:5px -7px 15px;">	
			<label class="text">区域：</label>
					<span class="cont" id="chooseArea">
						<select class="mr20" id="province" needcheck nullmsg="请选择区域!">
							<option value="">请选择</option>
						</select>
					</span>
		</li>			
		<li class="clearfix" style="margin:5px 40px 15px;">			
             <label>地址:</label>
             <input type="text" name="address" id="address" needcheck nullmsg="请输入联系人地址!"/>
        </li>
        <li class="clearfix" style="margin:5px 30px 15px;">   
             <label>联系人:</label>
             <input type="text" name="contactPersonName" id="contactPersonName" needcheck nullmsg="请输入联系人名称!"/>
        </li>
       <!--  <li class="clearfix" style="margin:5px 8px 15px;">       
             <label>联系人职位:</label>
             <input type="text" name="contactPersonJob" id="contactPersonJob" needcheck nullmsg="请输入联系人职位!" limit="1,20" limitmsg="很抱歉，姓名长度为1到10个字"/> 
        </li> -->
        <li class="clearfix" style="margin:5px 20px 15px;">     
             <label>联系电话:</label>
             <input type="text" name="contactPersonPhone" id="contactPersonPhone" needcheck nullmsg="请输入联系电话!" reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" errormsg="联系电话格式不正确！"/>
        </li>
        <li class="clearfix" style="margin:5px 20px 15px;">   
             <label>服务内容:</label>
             <input type="text" name="serviceContent" id="serviceContent" needcheck nullmsg="请输入服务内容!"/>
        </li>
        <li class="clearfix" style="margin:5px 45px 15px;">    
             <label>备注:</label>
             <textarea cols="20" rows="5" name="remark" id="remark"></textarea><br/><br/>
             <label>附件:</label>
             <a href="javascript:;" class="uploadBox btn" onclick="return false;" style="margin-left:30px; margin-top:3px;">
	                               上传<span id="uploadCont" class="uploadCont"> </span>
              </a>
        </li> 
         <li class="clearfix" style="margin:5px 60px 15px;">
		         <ul id="uploadInfoBox" class="commonUL">
			
		         </ul>
		  </li>  
		  
        <li class="clearfix" style="margin:5px 70px 15px;">  
             <input type="submit" class="btn btnGreen" value="确定">&nbsp;<input type="reset" class="btn btnGreen" onclick="closeMe()" value="取消"/> 
        </li>
         </ul>  
      </form>
      
      <!-- 获得子页面传来的项目的map集合-->
      <script type="text/javascript">
      
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
    		
    	});

      
     
      new BasicCheck({
			form: $id("addAreaResource"),
			ajaxReq : function(){
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
    			
				
				var str='';
				$(".e").each(function(){
					str+=$(this).attr("id");
					str+=",";
				});
				var s=str.substring(0,str.length-1);
				
				$.ajax({
					type: 'POST',
					url: '${root}/admin/arearesource/insertareasource.do?baseAreaId='+baseAreaId+'&projectIdStr='+s,
					data: $("#addAreaResource").serialize(),//将表单整体提交
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
    	//进行项目选择的弹框		
    	function selectProject(){
    		if($(".e")!=null){
    			
    			parent.editEngs={};
    			  $(".e").each(function (){
    				  parent.editEngs[this.id]=this.innerHTML;
    			    });  
    		}
    			parent.Win.open({id:"showEngineerListWin",
    				url:"${root}/admin/area/jumptoselcproj.do",
    				title:"项目列表",
    				width:650,
    				height:700,
    				mask:true}).css('left:700px;top:300px');
    		
    	}		

		
  	parent.showProject = function (data) {
        var map=data.project;
        var html='';
        map.each(function(key,value,index){
        	html+='<span id='+key+' class="e">'+value+'</span>';
        	html+='<span id='+key+'a>,</span>';
        });
        $("#project").html(html);
        $("#project").children().last().remove();
	}
  	
  	
  	
  //关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
  
  
  
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