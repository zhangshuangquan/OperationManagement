<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script src="${root }/public/js/basiccheck.js"></script>
<script src="${root }/public/js/map.js"></script>
<script type="text/javascript" src="${root }/public/upload/uploadfile.js"></script>
<script type="text/javascript" src="${root}/public/js/extend.js"></script>
<link href="${root}/public/css/reset.css" rel="stylesheet" type="text/css" media="all">

<script type="text/javascript">
var domid = frameElement.getAttribute("domid");//进行关闭当前窗口的操作
</script>
</head>

<body>

       <form id="editSupplier">
          <ul class="commonUL" style="margin-left:20px; width: 600px">
            <li class="clearfix" style="margin:5px 2px 15px;">
                <input type="hidden" name="supplierId" value="${requestScope.supplyer.supplierId}"/>
                <label>供应商名称:</label>
                <input type="text" name="name" value="${requestScope.supplyer.name}" needcheck nullmsg="请输入供应商名称!"/>
            </li>
            <li class="clearfix" style="margin:5px -10px 15px;">
                <label class="text">区域：</label>&nbsp;&nbsp;<span>${requestScope.supplyer.baseArea.areaPath}</span>
		    </li>
            <li class="clearfix" style="margin:5px 40px 15px;">
		        <label>地址:</label>
		        <input type="text" name="address" value="${requestScope.supplyer.address}"  needcheck nullmsg="请输入供应商地址!"/>
		    </li> 
		    <li class="clearfix" style="margin:5px 30px 15px;">
		        <label>联系人:</label>
				   &nbsp;<input type="text" id='fName' style="color:gray; text-align:center;" value="${requestScope.supplyer.contactPersonNameOne==null?'第一联系人':requestScope.supplyer.contactPersonNameOne}" name="contactPersonNameOne"/>&nbsp;&nbsp;<input type="text" id='fJob' style="color:gray; text-align:center;" value="${requestScope.supplyer.contactPersonJobOne==null?'职位':requestScope.supplyer.contactPersonJobOne}" name="contactPersonJobOne"/>&nbsp;&nbsp;<input type="text" style="color:gray; text-align:center;" id='fPhone' value="${requestScope.supplyer.contactPersonPhoneOne==null?'联系方式':requestScope.supplyer.contactPersonPhoneOne}" name="contactPersonPhoneOne"/><br/><br/>
				   &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" style="color:gray; text-align:center;" id='sName' value="${requestScope.supplyer.contactPersonNameTwo==null?'第二联系人':requestScope.supplyer.contactPersonNameTwo}" name="contactPersonNameTwo"/>&nbsp;&nbsp;<input type="text" style="color:gray; text-align:center;" id='sJob' value="${requestScope.supplyer.contactPersonJobTwo==null?'职位':requestScope.supplyer.contactPersonJobTwo}" name="contactPersonJobTwo"/>&nbsp;&nbsp;<input type="text" style="color:gray; text-align:center;" id='sPhone' name="contactPersonPhoneTwo" value="${requestScope.supplyer.contactPersonPhoneTwo==null?'联系方式':requestScope.supplyer.contactPersonPhoneTwo}"/><br/><br/>
				   &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id='tName' style="color:gray; text-align:center;" value="${requestScope.supplyer.contactPersonNameThree==null?'第三联系人':requestScope.supplyer.contactPersonNameThree}" name="contactPersonNameThree"/>&nbsp;&nbsp;<input type="text" id='tJob' style="color:gray; text-align:center;" value="${requestScope.supplyer.contactPersonJobThree==null?'职位':requestScope.supplyer.contactPersonJobThree}" name="contactPersonJobThree"/>&nbsp;&nbsp;<input type="text" style="color:gray; text-align:center;" id='tPhone' name="contactPersonPhoneThree" value="${requestScope.supplyer.contactPersonPhoneThree==null?'联系方式':requestScope.supplyer.contactPersonPhoneThree}"/>
		    </li>
		    <li class="clearfix" style="margin:5px 20px 15px;">
		        <label>注册资金:</label>
		        <input type="text" name="registeredCapital" value="${requestScope.supplyer.registeredCapital}" needcheck nullmsg="请输入注册资金!" reg="^\d+(\.\d+)?$" errormsg="输入的注册资金不合法！"/>&nbsp;(万元)
		    </li>
		    <li class="clearfix" style="margin:5px 22px 15px;">
		        <label>合作项目:</label> 
		        <input type="button" id="selecProj" class="btn btnGreen" onclick="selectProject()"  value="项目选择"/>
            </li>
            <li class="clearfix" style="margin:5px 25px 15px;">            
                <label>已选项目:</label>
                <span id="showProjectName"></span><!-- 显示选中的项目 -->
            </li>
            <li class="clearfix" style="margin:5px 45px 15px;">           
		        <label>资质:</label>
				 <select name="qualification" id="select" needcheck nullmsg="请选择供应商的资质!">
					     <option value="">--请选择--</option>
					     <option value="特一级资质">特一级资质</option>
					     <option value="一级资质">一级资质</option>
					     <option value="二级资质">二级资质</option>
					     <option value="三级资质">三级资质</option>
					     <option value="四级资质">四级资质</option>
					     <option value="普通提供商">普通提供商</option>
		          </select>  &nbsp;&nbsp; 
		          <a href="javascript:;" class="uploadBox btn" onclick="return false;">
			                       上传<span id="uploadCont" class="uploadCont"> </span>
		         </a>
           </li>
           <li class="clearfix" style="margin:5px 60px 15px;">
		           <ul id="uploadInfoBox" class="commonUL">
			          <c:if test="${requestScope.quaList!=null}">
			              <c:forEach items="${requestScope.quaList}" var="quali">
			                 <li id='${quali.attachment_Url}'><span class='infoLabel'><b class='fileName mr10' title='${quali.name}'>${quali.name}</b><b class='fileSize mr10'>"+(info.size/1024/1024).toFixed(2)+"MB</b></span><span class='progressBox mr20'><b class='progressBar mr10'><em class='progressRate'>&nbsp;</em></b>&nbsp;&nbsp;<b class='uploaded'></b></span><span class='uploadOperate'></span><span><a href='javascript:;' file='${quali.attachment_Url}' class='delUploadFile'>删除</a></span><input type='hidden' name='oraginalFileName' value='${quali.name}'/><input type='hidden' name='newFileName' value='${quali.attachment_Url}'/></li>
			              </c:forEach>
			          </c:if>
		           </ul>
           <li class="clearfix" style="margin:5px -2px 15px;">
          
               <label>主要服务内容:</label>
               <textarea name="serviceContent" cols="20" rows="5"  needcheck nullmsg="请输入主要服务内容!">${requestScope.supplyer.serviceContent}</textarea><br/><br/>
               <span style="margin-left:70px;"><input type="submit" class="btn btnGreen" value="确定"/>&nbsp;&nbsp;<input type="reset" class="btn btnGreen" value="取消" onclick="closeMe()"/></span><br/>
          </ul>    
       </form>
       
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
    		
    		//让已选的单选菜单处于选中状态
			$('#select option[value=${requestScope.supplyer.qualification}]').attr('selected','selected');
    		
    	});
    	
      
      
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
      	

      	                                           //显示上传的文件信息
      	uploadSwf.uploadEvent.add("onOpen",function(){
      		
      		
      		var elm = arguments[0].message[0],
      			info = arguments[0].message[1];
      		//var jsonData = JSON.parse(arguments[0].message[1]);
      		if($id(elm)) return false;
      		$id("uploadInfoBox").innerHTML += "<li id='"+elm+"'><span class='infoLabel'><b class='fileName mr10' title='"+info.name+"'>"+info.name+"</b><b class='fileSize mr10'></b></span><span class='progressBox mr20'><b class='progressBar mr10'><em class='progressRate'>&nbsp;</em></b>已上传<b class='uploaded'>0%</b></span><span class='uploadOperate'><a class='cancelUpload' href='javascript:;' file='"+elm+"'>取消上传</a></span><input type='hidden' name='oraginalFileName' value='"+info.name+"'/></li>";
      	});
      	


    	
    	
    //实现表单的验证并进行表单的提交，并获得区域资源的id值
      new BasicCheck({
			form: $id("editSupplier"),
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
  			
  			//处理返回的项目id的字符串
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
					url: "${root}/admin/supplier/updateSupper.do?projectList="+s,
					data: $("#editSupplier").serialize(),//将表单整体提交  
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
  				url:"${root}/admin/supplier/jumptoprojectlist.do",
  				title:"项目列表",
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
  
  	$(
  	        function(){
  	        	//alert("ok");
  	        	//获得本资源的id
  	        	 var $supplyId =$("input[type='hidden']").val();
  	        	
  	             var url="${root}/admin/supplier/selcprojlistbysuid.do";
  	                var args={
  	                		
  	                		supplyId:$supplyId	
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
  	     
  	     
  	  //关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
	
</script>
<%-- <script type="text/javascript" src="${root }/public/js/click.js"></script> --%>
</body>
</html>