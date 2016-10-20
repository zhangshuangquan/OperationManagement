<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../common/meta.jsp" %>
<head>
     <script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
     <script src="${root }/public/js/customer.js" type="text/javascript"></script>
     <script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
     <script type="text/javascript" src="${root }/public/upload/uploadfile.js"></script>
     <script type="text/javascript" src="${root}/public/js/extend.js"></script>
     <script src="${root }/public/js/customer.js" type="text/javascript"></script>
     <link href="${root}/public/css/reset.css" rel="stylesheet" type="text/css" media="all">
</head>     
     
<body>

<form id="addPicture">

         <input type="hidden" name="orderId" value="${requestScope.orderId}"/>
        图片描述:
           <textarea id="desc" style="height:100px; position: absolute; width:200px; margin-left:30px; border:1px solid silver; float:left; margin-top:30px;"></textarea>&nbsp;&nbsp;&nbsp;
          <div style="margin-left:300px; margin-top:30px; position: absolute;">
               <a href="javascript:;" class="uploadBox btn" onclick="return false;">
	                               请选择图片<span id="uploadCont" class="uploadCont"> </span>
              </a>&nbsp;&nbsp;<br/><br/>
               <input type="submit" class="uploadBox btn" style='margin-top:30px;margin-left:95px;'  value="确定"/>
          </div>
          
          <ul id="uploadInfoBox" class="commonUL" style="position:absolute; margin-top:160px;">
			
		  </ul>
		  
</form>		  
		  
 <script type="text/javascript">
 
 var domid = frameElement.getAttribute("domid");//进行关闭当前窗口的操作
 /*图片上传 */
 
 //获得上传的图片的原来的名字与新生成的名字
var params = {
     debug : 1,
     fileType : "*.jpg;*.gif;*.png;*.jpeg;",
     typeDesc : "图片",
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
	
              //显示上传的文件信息
	uploadSwf.uploadEvent.add("onOpen",function(){
		
		//获得对应图片的最新信息
		
		var descPic=$("#desc").val();
		
		var elm = arguments[0].message[0],
			info = arguments[0].message[1];
		
		//var jsonData = JSON.parse(arguments[0].message[1]);
		if($id(elm)) return false;
		$id("uploadInfoBox").innerHTML += "<li id='"+elm+"'>图片描述：<input type='text'  name='picDesc' value='"+descPic+"'/><span class='infoLabel'><b class='fileName mr10' title='"+info.name+"'>"+info.name+"</b></span><span class='progressBox mr20'><b class='progressBar mr10'><em class='progressRate'>&nbsp;</em></b>已上传<b class='uploaded'>0%</b></span><span class='uploadOperate'><a class='cancelUpload' href='javascript:;' file='"+elm+"'>取消上传</a></span><input type='hidden' name='oraginalFileName' value='"+info.name+"'/></li>";
	});
	            
 	                                           
   	 
   	/*                                                                                */
	$(
	     function(){
	    	 
	    	 new BasicCheck({
	    		    form: $id("addPicture"),
	    		    addition : function() {
	    		        return true;
	    		    },
	    		    ajaxReq : function(){
	    		        $.post('${root}/admin/maintenanceorder/insertPicture.do',$("#addPicture").serialize(),function(r){
			                try {
			                    if(!r.result){
			                        Win.alert('操作失败！');
			                    }else{
			                        parent.Win.alert('操作成功!');
			                        closeMe(); //关闭本窗口
			                    }
			                } catch(e) {
			                    Win.alert("错误提示:"+e.message);
			                }
			            });
	    		    }
	    		});
	     }		
	)
   
  //关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
   </script>
</body>
</html>