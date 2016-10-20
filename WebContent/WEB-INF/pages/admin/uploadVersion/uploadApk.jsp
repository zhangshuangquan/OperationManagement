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

<form id="addApk">
<div style="margin-left:600px;margin-top:60px;">
          <label style="margin-top:10px;position:absolute; margin-left:-25px;">版本描述：</label> <textarea id="desc" style="height:100px; position: absolute; width:200px; margin-left:30px; border:1px solid silver; float:left; margin-top:30px;" name="updateMessage"></textarea>&nbsp;&nbsp;&nbsp;
          <div style="margin-left:300px; margin-top:30px; position: absolute;">
               <a href="javascript:;" class="uploadBox btn" onclick="return false;">
	                               请选择Apk包<span id="uploadCont" class="uploadCont"> </span>
              </a>&nbsp;&nbsp;<br/><br/>
               <input type="submit" class="uploadBox btn" style='margin-top:10px;margin-left:2px;'  value="确定"/>
          </div>
          
          <ul id="uploadInfoBox" class="commonUL" style="position:absolute; margin-top:120px;">
			
		  </ul>
		  <div style="margin-top:150px;margin-left:7px;">
		 <label>版本名：</label><input type='text'   name='versionName'/><br/><br/>
		 <label>版本号：</label><input type='text' onkeyup="return validateNum(this);"  name='versionCode'/><br/>
		  </div>
</div>		  
		  
</form>		  
		  
 <script type="text/javascript">
 
 //var domid = frameElement.getAttribute("domid");//进行关闭当前窗口的操作
 /*图片上传 */
 
 //获得上传的图片的原来的名字与新生成的名字
var params = {
     debug : 1,
     fileType : "*.apk;",
     typeDesc : "apk",
     autoStart : true,
     multiSelect : 0,
     server: encodeURIComponent("${root}/ImageUploadServlet")
	};
	window.uploadSwf = new UploadFile($id("uploadCont"), "uploadSwf", "${root}/public/upload/uploadFile.swf",params);
	
	
	uploadSwf.uploadEvent.add("onComplete",function(){
		var elm = arguments[0].message[0],
			data = arguments[0].message[1];
		var myProgressBox = $class("progressBox",$id(elm))[0],
			myUploadOperate = $class("uploadOperate",$id(elm))[0];
		myProgressBox.innerHTML = "上传完成!<input type ='hidden' name='downUrl' value="+JSON.parse(data).message+"/app.apk"+">";	
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
		
		var elm = arguments[0].message[0],
			info = arguments[0].message[1];
		
		/* var liNum =$("#uploadInfoBox li").size();
		if(liNum>=1){
			Win.alert("只能上传一个!");
			return;
		} */
		if($id(elm)) return false;
		$id("uploadInfoBox").innerHTML += "<li id='"+elm+"'><span class='infoLabel'><b class='fileName mr10' title='"+info.name+"'>"+info.name+"</b></span><span class='progressBox mr20'><b class='progressBar mr10'><em class='progressRate'>&nbsp;</em></b>已上传<b class='uploaded'>0%</b></span><span class='uploadOperate'><a class='cancelUpload' href='javascript:;' file='"+elm+"'>取消上传</a></span><input type='hidden' name='oraginalFileName' value='"+info.name+"'/></li>";
		
	});
	            
 	                                           
   	 
   	/*                                                                                */
	$(
	     function(){
	    	 
	    	 new BasicCheck({
	    		    form: $id("addApk"),
	    		    addition : function() {
	    		        return true;
	    		    },
	    		    ajaxReq : function(){
	    		        $.post('${root}/admin/apk/insertApk.do',$("#addApk").serialize(),function(r){
			                try {
			                    if(!r.result){
			                        Win.alert('操作失败！');
			                    }else{
			                       Win.alert('操作成功!');
			                    }
			                } catch(e) {
			                    Win.alert("错误提示:"+e.message);
			                }
			            });
	    		    }
	    		});
	     }		
	)
	
	
	//给分值的时候随时对输入的分值进行校验	
	          function validateNum(e){
					e.value=e.value.replace(/\D/g,'');
				}
  
   </script>
</body>
</html>