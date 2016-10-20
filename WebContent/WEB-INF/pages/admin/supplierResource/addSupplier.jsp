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
<script type="text/javascript" src="${root }/public/upload/uploadfile.js"></script>
<script type="text/javascript" src="${root}/public/js/extend.js"></script>
<link href="${root}/public/css/reset.css" rel="stylesheet" type="text/css" media="all">
</head>

<body>
   <form id="addSupplier">
     <ul class="commonUL" style="margin-left:20px; width: 600px">
        <li class="clearfix" style="margin:5px 2px 15px;">  
               <label>供应商名称:</label>
               <input type="text" name="name" needcheck nullmsg="请输入供应商名称!" />
         </li>
         <li class="clearfix" style="margin:5px -10px 15px;">  
               <label class="text">区域：</label>
				<span class="cont" id="chooseArea">
					<select class="mr20" id="province" needcheck nullmsg="请选择区域!">
						<option value="">请选择</option>
					</select>
				</span>
          </li>
          <li class="clearfix" style="margin:5px 40px 15px;"> 
		       <label>地址:</label>
		       <input type="text" name="address" needcheck nullmsg="请输入供应商地址!"/>
		  </li>
		  <li class="clearfix" style="margin:5px 30px 15px;"> 
		       <label>联系人:</label>
				  &nbsp;&nbsp;<input type="text" name="contactPersonNameOne" value="第一联系人" style='color:gray;text-align:center;' id='fName'/>&nbsp;&nbsp;<input type="text" name="contactPersonJobOne" value="职位" style='color:gray;text-align:center;' id='fJob'/>&nbsp;&nbsp;<input type="text" name="contactPersonPhoneOne" value="联系方式" style='color:gray; text-align:center;' id='fPhone'/><br/><br/>
				  &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"  name="contactPersonNameTwo" value="第二联系人" style='color:gray;text-align:center;' id='sName'/>&nbsp;&nbsp;<input type="text"  name="contactPersonJobTwo" value="职位" style='color:gray;text-align:center;' id='sJob'/>&nbsp;&nbsp;<input type="text" name="contactPersonPhoneTwo" value="联系方式" style='color:gray;text-align:center;' id='sPhone'/><br/><br/>
				  &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"  name="contactPersonNameThree" value="第三联系人" style='color:gray;text-align:center;' id='tName'/>&nbsp;&nbsp;<input type="text"  name="contactPersonJobThree" value="职位" style='color:gray;text-align:center;' id='tJob'/>&nbsp;&nbsp;<input type="text" name="contactPersonPhoneThree" value="联系方式" style='color:gray;text-align:center;' id='tPhone'/>
		  </li>
		  <li class="clearfix" style="margin:5px 20px 15px;"> 
		       <label>注册资金:</label>
		       <input type="text" name="registeredCapital" needcheck nullmsg="请输入注册资金!" reg="^\d+(\.\d+)?$" errormsg="输入的注册资金不合法！"/>&nbsp;(万元)
		  </li>
		  <li class="clearfix" style="margin:5px 22px 15px;">  
		       <label>合作项目:</label> 
		       <input type="button" id="selecProj" onclick="selectProject();" class="btn btnGreen"  value="项目选择"/>
               <span id="project"></span><br/><!-- 显示选中的项目 -->
		  </li>
		  <li class="clearfix" style="margin:5px 45px 15px;"> 
		       <label>资质:</label>
				 <select name="qualification" needcheck nullmsg="请选择供应商的资质!">
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
			
		         </ul>
		  </li>   
          
        <li class="clearfix" style="margin:5px -2px 15px;">   
              <label>主要服务内容:</label>
             <textarea name="serviceContent" cols="20" rows="5" needcheck nullmsg="请输入主要服务内容!"></textarea>
        </li>
        <li class="clearfix" style="margin:5px 80px 15px;"> 
              <input type="submit" class="btn btnGreen" value="确定"/>&nbsp;&nbsp;<input type="reset" class="btn btnGreen" onclick="closeMe()" value="取消"/>
        </li>     
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
    		
    	});
    	
 var domid = frameElement.getAttribute("domid");//进行关闭当前窗口的操作
      
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
 	

		     
		    
/*                                                                                */
    	
    //实现表单的验证并进行表单的提交，并获得区域资源的id值
      new BasicCheck({
			form: $id("addSupplier"),
			ajaxReq : function(){
			console.log($("#addSupplier").serialize());	
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
			
				//ajax提交
				
				$.ajax({
					type: 'POST',
					url: '${root}/admin/supplier/insertsupplier.do?projListString='+s+'&areaId='+baseAreaId,
					data: $("#addSupplier").serialize(),//将表单整体提交
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
		            }
					
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
</script>
<script type="text/javascript" src="${root }/public/js/click.js"></script>

</body>
</html>