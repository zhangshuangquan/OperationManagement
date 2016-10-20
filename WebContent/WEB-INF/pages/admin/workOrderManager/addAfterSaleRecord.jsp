<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
<script src="${root }/public/js/customer.js" type="text/javascript"></script>
<script src="${root }/public/js/basiccheck.js"></script>
<script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
<script src="${root }/public/js/map.js"></script>
</head>
<body class="chase-ask">
<form id="addSaleForm">
    <ul class="commonUL">
      <li class="clearfix" style="margin:5px 0 8px;">
       <input type="submit" class="btn" value="保存" style="margin-left:255px;margin-top:10px; width:100px; position:absolute; font-weight:bolder;" />
        <!-- <input type="button" class="btn btnGray" value="取消" style="margin-right:50px;" id="cancel" /> -->
       <label class="text"  style="font-weight:bold; margin-left:-10px;">单号：</label>
	   <label class="text"  style="font-weight:bold; margin-left:280px;">工单提交人：</label>${requestScope.realName}<br/>	
        <label class="text" style="font-weight: bold">项目信息</label>
            <li class="clearfix">
			<label class="text">项目区域：</label>
				<span class="cont" id="chooseArea">
					<select class="mr20"  id="province" needcheck nullMsg="请选择项目区域!">
						<option value="-1">-- 请选择 --</option>
					</select>
				</span>
           </li>
           <li class="clearfix">
        	 <label class="text">项目：</label>
				<span class="cont" id="chooseProject">
					<select class="mr20" id="project" needcheck nullMsg="请选择项目">
						<option value="-1">-- 请选择 --</option>
					</select>
				</span>
          </li>
          <li class="clearfix">
            <span class="mr20">
        	 <label class="text">项目经理：</label>
				<span id="mgName"></span>
			</span>
			<span class="mr20"><label class="text">联系电话：</label>
				<span id="mgContact"></span>
			</span>	
          </li>
       <hr/>
        <li class="clearfix" style="margin:5px 0 8px;">
        <label class="text" style="font-weight:bold">客户信息</label>
         <li class="clearfix" style="margin:5px 0 0px;">
			<label class="text">学校区域：</label>
				<span class="cont" id="schoolchooseArea">
					<select class="mr20" id="schoolprovince">
						<option value="-1">-- 请选择 --</option>
					</select>
				</span>
        </li>
        <li class="clearfix">
        	<label class="text">学校：</label>
				<span class="cont" id="chooseSchool" style="float:left;">
					<select class="mr20" id="school" name="clsSchoolId" needcheck nullMsg="请选择学校!" >
						<option value="">-- 请选择 --</option>
					</select>
				</span><a href="javascript:;" class="btn btnGreen" id="showSchool">请选择</a>
        </li>
          <li>
				<span class="mr20">
				    <label class="text">详细地址：</label>
					<input type="text" id="address" name="address" size="60"/>
				</span>
		  </li>
         <li class="clearfix">
        	<label class="text">联系人：</label>
				<span class="mr20">
					<input type="text" id="contact" name="contact" needcheck nullmsg="请输入联系人!"/>
				</span>
				<span class="mr20">
				    <label class="text">联系电话：</label>
					<input type="text" id="phone" name="phone" needcheck nullmsg="请输入联系电话!" reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" errormsg="联系电话格式不正确！"/>
				</span>
				</li>
				
		 <hr/>
         <li class="clearfix">

	        <li class="clearfix" style="margin:5px 0 10px;">
	          <label class="text" style="font-weight:bold">问题类型:</label>
	          <span>
	              <c:if test="${requestScope.problemTypeViewList!=null}">
	                  <c:forEach items="${problemTypeViewList}" var="problemType">
	                     <label><input name="problemType" type="checkbox" value="${problemType.problemId}"/>${problemType.problemName}</label>&nbsp;&nbsp;&nbsp;&nbsp;
	                  </c:forEach>
	              </c:if>
	          </span><br/><br/>
	          <label class="text" style="font-weight:bold">问题描述:</label>
	          <textarea cols="50" rows="3" name="problemDescrip" id="problemDescrip"></textarea><br/><br/>
	           <label class="text" style="font-weight:bold">售后跟踪进程</label>
	            <li class="clearfix">
				    <label class="text">客户来电：</label>
				    <span class="mr20">
					 <input type="text" class="Wdate" id="customerCall" onclick="WdatePicker();"  name="customerCall" value=""/>  
		            </span>
		         </li>
		          <li class="clearfix">
				    <label class="text">派工流程：</label>
				    <span class="mr20">
					 <input type="text" class="Wdate" id="worker" onclick="WdatePicker();"  name="worker" value=""/>  
		            </span>
		         </li>
		         <li class="clearfix">
				    <label class="text">任务分配：</label>
				    <span class="mr20">
					 <input type="text" class="Wdate" id="task" onclick="WdatePicker();"  name="project" value=""/>  
		            </span>
		         </li>
		         <li class="clearfix">
				    <label class="text">售后回访：</label>
				    <span class="mr20">
					 <input type="text" class="Wdate" id="visit" onclick="WdatePicker();"  name="project" value=""/>  
		            </span>
		         </li>
		    </li>
		    
		    <hr/>
		    <li class="clearfix" style="margin:5px 0 8px;">
               <label class="text" style="font-weight:bold">售后维护信息</label>
		   </li>
		   <li>
			   <label class="text">工程师：</label>
				 <span class="cont">
					<a id="showEngineerList" class="btn btnGreen" href="javascript:;">工程师</a>
					 <span id="engineer">
					    <ul class="commonUL" id="engs">
					    </ul>
					 </span>
				</span>
		   </li>
		    <hr/>
		    <li class="clearfix" style="margin:5px 0 8px;">
               <label class="text" style="font-weight:bold">设备寄送信息</label>
		   </li>
		   <ul class="clearfix"  style="margin:5px 0 8px;" id="eqm">
		     <li id="1">
		      <span style="margin-left:20px;">
			    <input type="text" style="margin-left:55px;" class="Wdate" id="equipTime" onclick="WdatePicker();"  name="project"/>  
		      </span>
				    <label style="margin-left:13px;">&nbsp;设备：</label>
				    <span>
				    <input type="text" id="equipMsg" style="margin-left:2px;"  name="equip">
				   </span><br/>
				   <label style="margin-left:8px;margin-top:5px;">快递公司：</label>
				    <span>
				    <input type="text" id="expressCompany" class="expressCompany" style="margin-left:5px;" name="expressCompany">
				   </span>
				   <label style="margin-left:18px;">单号：</label>
				    <span>
				    <input type="text" id="expressNum" class="expressNum" name="expressNum">
				   </span>
				   <span style="margin-left:20px;">
				     <input type="button" value="添加" id="addEquip" class="btn btnGreen" onclick="add()">
				   </span>
		     </li>
		   </ul>
		   <hr/>
		     <li class="clearfix">
               <label class="text" style="font-weight:bold;margin-left:-50px;">备注</label>
		     </li>
		       <li class="clearfix">
		         <span style="margin-left:20px;">
		           <textarea rows="8" cols="100" id="remark"></textarea>
		         </span>
		      </li>
    </ul>
    <br/>  
</form>

<script>
    var count=1;//统计点击学校选择按钮触发项目区域选择按钮的次数
    var sCount=1;//学校区域触发
    var timer;
    var m=1;
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
		
		$("#showEngineerList").click(function(){
			if($(".e")!=null){
				 parent.editEngs={};
				  $(".e").each(function (){
					  parent.editEngs[this.id]=this.innerHTML;
				    });  
				}
			parent.Win.open({id:"showEngineerListWin",
				url:"${root}/admin/workorder/toshowengineerlist.html",
				title:"人员列表",
				width:700,
				height:600,
				mask:true}).css('left:950px;top:200px');
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
			//获得项目列表
			$.post("${root}/admin/projectmanager/getprojectbyarea.do",{"areaId":baseAreaId},function(data){
				var html = '<option value="">-- 请选择 --</option>';
				for(var i = 0,j = data.length; i<j; i++){
					html += '<option langName="'+data[i].managerName+'" langContact="'+data[i].managerContact+'" value="'+data[i].projectId+'">'+data[i].projectName+'</option>';
				}
				$("#project").html(html);
			},'json');
			
			//alert("p="+$("#project").val());
			if($("#province").val()==""){
				$("#mgName").html("");
				$("#mgContact").html("");
			}
		});
		
		$('#schoolchooseArea').on("change","select",function(){
			var project = $("#project").val();
			var areas = $("#schoolchooseArea select");
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
			
			
			if(project != '-1'){
				$.post("${root}/admin/schoolmanager/getschoollist.do",{"areaId":baseAreaId,"projectId":project},function(data){
					var html = '<option value="">-- 请选择 --</option>';
					for(var i = 0,j = data.length; i<j; i++){
						html += '<option value="'+data[i].clsSchoolId+'">'+data[i].schoolName+'</option>';
					}
					$("#school").html(html);
				},'json'); 
			}
		});
		
		$('#chooseProject').on("change","select",function(){
			var project = $("#project").val();

			if(project!=''){
				//选择指定项目的同时显示本项目的项目经理的名字和其联系方式
				selectObj=$("#project").find("option:selected");
				managerName=$(selectObj).attr("langName");
				managerContact=$(selectObj).attr("langContact");
				$("#mgName").html(managerName);
				$("#mgContact").html(managerContact);
			}else{
				$("#mgName").html("");
				$("#mgContact").html("");
			}
	
			var areas = $("#schoolchooseArea select");
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
			
			$.post("${root}/admin/schoolmanager/getschoollist.do",{"areaId":baseAreaId,"projectId":project},function(data){
				var html = '<option value="">-- 请选择 --</option>';
				for(var i = 0,j = data.length;i<j; i++){
					html += '<option value="'+data[i].clsSchoolId+'">'+data[i].schoolName+'</option>';
				}
				$("#school").html(html);
			},'json'); 
		});
		
	});
	
	//添加设备
	function add(){
		m=m+1;
		html ='<li class="clearfix" style="margin-left:50px;" id='+m+'><input type="text" style="margin-left:25px;" class="Wdate" id='+m+'1 onclick="WdatePicker();"/>'
              +'<label style="margin-left:23px;">设备：</label>'
              +'<span class="mr20" style="margin-left:5px;"><input type="text" id='+m+'2 name="equip"></span><br/>'
              +'<label style="margin-left:-40px;">快递公司：</label>'
              +'<span class="mr20" style="margin-left:5px;"><input type="text" id='+m+'3 class="expressCompany" name="expressCompany"></span>'
              +'<label style="margin-left:3px;">单号：</label>'
              +'<span class="mr20" style="margin-left:5px;"><input type="text" id='+m+'4 class="expressNum" name="expressNum"></span>'
              +'<span class="mr20" style="margin-left:3px;"><input type="button" value="删除" id="del" class="btn btnGreen" onclick="dela('+m+')"></span></li>';
              $("#eqm").append(html);   
	}
	
	//删除设备
	function dela(m){
		$("#"+m).remove();
		
	}
	
	  //删除工程师
    function delEngineer(id){
    	$("#"+id).remove();
    }
	
//进行选择学校的搜索
    $("#showSchool").click(function(){
    	
    	schoolArr=$("#schoolchooseArea select");
    	var reaId="";
    	for(var i=schoolArr.length-1; i>=0; i--){
    		arId =$(schoolArr[i]).val();
    		//alert("arId="+arId);
    	 	if(arId!='' && arId!='-1'){
    			reaId=arId;
    			break;
    		} 
    	}
    	var projId=$("#project").val();
		Win.open({
			id:"addAfterSaleWin",
			url:"${root}/admin/workorder/jumptoschoollist.do?SchoolBaseAreaId="+reaId+"&projId="+projId,
			title:"学校列表",
			width:600,
			height:600,
			mask:true
	    }).css('left:200px;top:100px');
	});
	
	
    if(window.frameElement)  var domid =frameElement.getAttribute("domid");
    var mySplit = parent.mySplit;
    new BasicCheck({
    	form: $id("addSaleForm"),
		ajaxReq : function(){
			var schoolId = $("#school").val();
			var problemDescrip=$("#problemDescrip").val();//问题描述
			var problemResolveDescrip=$("#problemResolveDescrip").val();//问题解决描述
			var contact=$.trim($("#contact").val());
			var phone=$.trim($("#phone").val());
			var address=$.trim($("#address").val());
			var customer=$("#customerCall").val();
			var worker=$("#worker").val();
			var task=$("#task").val();
			var door=$("#door").val();
			var solve=$("#solve").val();
			var visit=$("#visit").val();
			var remark=$.trim($("#remark").val());
			var areas = $("#chooseArea select");
			var areaLength = areas.length;
			var baseAreaId = "";
			var baseAreaId1 = "";
			if(areaLength == 1){
				baseAreaId = $(areas[0]).val();
			}else{
				baseAreaId = $(areas[areaLength-2]).val();
				baseAreaId1 =$(areas[areaLength-1]).val();
				if("-1" != baseAreaId1){
					baseAreaId = baseAreaId1;
				}
			}
			if(baseAreaId == "-1"){
				Win.alert("请选择行政区！");
				return;
			}
			var str='';
			$(".e").each(function(){
				str+=$(this).attr("id");
				str+=",";
			});
			var s=str.substring(0,str.length-1);
			
		
			var time='';
			var msg='';
			//设备寄送信息
			var equipTime=$("#equipTime").val();
			var equipMsg=$.trim($("#equipMsg").val());
			
			time+=equipTime;
			time+=',';
			msg+=equipMsg;
			msg+=',';
			var t='';
			var m='';
			$("#eqm").children().each(function(){
			 
			     t=$("#"+$(this).attr("id")+'1').val();
			     m=$("#"+$(this).attr("id")+'2').val();
			    if (typeof(t) != "undefined") {
			    	 time+=t;
				     time+=','
                 }   
			    if (typeof(m) != "undefined") {
			    	 msg+=m;
				     msg+=',';
                }   
			   /*  if(t==''||m==''){
			    	flag=true;
			    } */
			    
			});
		    /* if(flag){
		    	Win.alert("请填写设备寄送信息");
				return;
		    } */
			
			var t=time.substring(0,time.length-1);
		    var m=msg.substring(0,msg.length-1);
		  
			
			// === 新增保障记录
			var checkedListObj =$('input:checkbox[name="problemType"]:checked');//获得选中的问题类型
			var expressCompanyArr=$(".expressCompany");
			var expressNumArr=$(".expressNum");
			
			var problemType="";
			var expressCompanyStr="";
			var expressNumStr="";
			
			checkedListObj.each(function(){ 
				var problemVal = this.value; 
				problemType +=problemVal+","; 
				});
			
			expressCompanyArr.each(function(){ 
				var Company = this.value; 
				expressCompanyStr +=Company+","; 
				});
			
			expressNumArr.each(function(){ 
				var Num = this.value; 
				expressNumStr +=Num+","; 
				});
			expressCompanyStr=expressCompanyStr.substring(0,expressCompanyStr.length-1);
			expressNumStr=expressNumStr.substring(0,expressNumStr.length-1);
			problemType=problemType.substring(0,problemType.length-1);
		   
			
			$.post("${root}/admin/workorder/addaftersale.do",
					{
					 'clsSchoolId'        :   schoolId,
					 'address'            :   address,
					 'concat'		      :	contact,
					 'phone'              :   phone,
					 'customerCallsTime'  :	customer,
					 'laborProcessTime'	  :	worker,
					 'taskTime'           :   task,
					 'doorMaintenance'    :   door,
					 'solvingTime'		  :	solve,
					 'returnVisit'		  :	visit,
					 'taskTime'           :   task,
					 'remark'             :   remark,      
					 'engineer'           :  s,
					 'equipTime'          :  t,
					 'equipMsg'           :  m,
					 'expressCompanyStr'  :  expressCompanyStr,
					 'expressNumStr'      :  expressNumStr,
					 'problemType'        : problemType,
					 'problemDescrip'     : problemDescrip,
					 'problemResolveDescrip' : problemResolveDescrip
					 
				},function(data){
				if(data){
					if(!data.result) {
						Win.alert(data.message) ;
					} else {
						if(data.result){
							Win.alert("添加成功！");
							setTimeout("closeMe()",1000);
							parent.splitPage.reload();
							
						}else{
							Win.alert("添加失败！");
						}
					}
					
				}else{
					Win.alert("添加失败！");
				}
			},'json');
		},
		warm: function warm(o, msg) {
			Win.alert(msg);
		}
    });
    
  //关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
    
    
    
    $("#cancel").click(function(){
        parent.Win.wins[domid].close();
    });
    $("#imgview").on("click", ".imgview-close", function(){
        $(this).parent(".imgview-list").remove();
    });
    
    parent.showEngineer = function (data) {
        var map=data.engineer;
        var html='';
        if(map!=null){
        	var s='';
        	for(var i=0;i<map.keys.length;i++){
        		s+=map.keys[i];
        		s+=',';
        	}
        	var id=s.substring(0,s.length-1);
        	$.post("${root}/admin/workorder/getengineers.do",
        			{"id":id},function(data){
				var html = '';
				console.log(data);
				for(var i = 0,j = data.length; i<j; i++){
				   html+='<li class="clearfix" id='+data[i].adminUserId+'>'
					+'<label class="mr20">工程师：</label><span class="e" style="display: inline-block;width: 100px;" id='+data[i].adminUserId+'>'+data[i].realName+'</span>'
				    +'<label class="mr20" style="margin-left:20px;"> 联系电话：</label><span class="mr20">'+data[i].contact+'</span>'
				    +'&nbsp;<input type="button" value="删除" class="btn btnGreen" onclick="delEngineer(\''+data[i].adminUserId+'\')"/></li>'; 
			    }
				$("#engs").html(html);
			},'json');
        }
	} 

    //接收选择学校窗口传来的内容
	showArea = function (data) {
    	
	      var areaObj=data.area;
	      schoolAreaIdLevalArr=areaObj[0].split(",");
	      schoolAllAreaPath=areaObj[1].split(",");
	      projectAreaIdLevalArr=areaObj[3].split(",");
	      projectAllAreaPath=areaObj[2].split(",");
	      schoolName=areaObj[4];
	      schoolId=areaObj[7]; 
	      projectName=areaObj[5];
	      projectId=areaObj[6];
	     //进行项目区域的回填
	      areaObjArr =$("#chooseArea select");
	      $(areaObjArr[0]).val(projectAreaIdLevalArr[0]);
		  //$(areaObjArr[0]).nextAll().remove();
		  $("#chooseArea>select:eq(1)").remove();//将第一个删除即只剩一个(结构已发生改变)
	      $("#chooseArea>select:eq(1)").remove();
		  console.log(count);
		  //alert("len="+projectAreaIdLevalArr.length);
		  var proAreaLen=areaLength=projectAreaIdLevalArr.length; //项目区域的长度  如果长度为1进行特殊处理
    	  //执行
    	 var projAreaLen=projectAreaIdLevalArr.length;
		  
		  if(projAreaLen==1){
			  $("#province").change();
			  
		  }else{
			  if(1==count){
	    		  AreaSelects("chooseArea","${root}/admin/area/getBaseAreaByParentId.do",projectAreaIdLevalArr[0],projectAreaIdLevalArr[1],projectAreaIdLevalArr[2],projectId,"p",schoolId);
	    		  count++;
	    	  }else{
	    		  //清除以前的追加信息   重新追加
	    		 /*  $("#chooseArea>select:eq(1)").remove();//将第一个删除即只剩一个(结构已发生改变)
	    		  $("#chooseArea>select:eq(1)").remove();//再将剩下的删除 */
	    		  AreaSelects("chooseArea","${root}/admin/area/getBaseAreaByParentId.do",projectAreaIdLevalArr[0],projectAreaIdLevalArr[1],projectAreaIdLevalArr[2],projectId,"p",schoolId);
	    	  }
	
		  }
		  
		  //进行学校区域的回填sCount  schoolchooseArea
    	  schoolareaObjArr =$("#schoolchooseArea select");
	      $(schoolareaObjArr[0]).val(schoolAreaIdLevalArr[0]);
		  $("#schoolchooseArea>select:eq(1)").remove();//将第一个删除即只剩一个(结构已发生改变)
		  $("#schoolchooseArea>select:eq(1)").remove();//再将剩下的删除 
		  
    	  //执行
    	  if(1==sCount){
    		  AreaSelects("schoolchooseArea","${root}/admin/area/getBaseAreaByParentId.do",schoolAreaIdLevalArr[0],schoolAreaIdLevalArr[1],schoolAreaIdLevalArr[2],schoolId,"s",projectId);
    		  sCount++;
    	  }else{
    		  //清除以前的追加信息   重新追加
    		  /* $("#schoolchooseArea>select:eq(1)").remove();//将第一个删除即只剩一个(结构已发生改变)
    		  $("#schoolchooseArea>select:eq(1)").remove();//再将剩下的删除 */
    		  AreaSelects("schoolchooseArea","${root}/admin/area/getBaseAreaByParentId.do",schoolAreaIdLevalArr[0],schoolAreaIdLevalArr[1],schoolAreaIdLevalArr[2],schoolId,"s",projectId);
    	  } 

        	//循环检测填值
    	   timer=window.setInterval(function() {fScoolVal(schoolId,projectId,proAreaLen,projectAreaIdLevalArr[0]);}, 500); //其中 starttime是参数
     	 
		}
     
    function fScoolVal(schId,proId,len,provinceId){
 
    	var schvalId =$("#school").val();
    	var projId=$("#project").val();
    	 if(projId==""){
    		$("#project").val(proId); 
    		$("#project").change();	
    	}else{
    		if(""==schvalId){
    			$("#school").val(schId);
    		}
             clearInterval(timer);
    	} 
    	 
    	 if(""==schvalId){
 			$("#school").val(schId);
 		}
    }
    
	function AreaSelects(id,url,paramValue,paramCity,paramCountry,AreaId,status,sprojId){
		//alert("projectAreaId="+projectAreaId);
		if("-1"!=paramValue || ""!=paramValue){
			
			$.post(url,{"parentId":paramValue},function(data){
				console.log("2222");
				var html = '<select class="mr20"><option value="-1">请选择</option>';
				var j = data.length;
				if(j == 0){
					return ;
				}
				for(var i = 0; i<j; i++){
					html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
				}
				html += '</select>';
				$("#"+id).append(html);
				//触发change事件 加载所属区县列表
				if("-1"!=paramCity){
					if("p"==status){
						$("#chooseArea>select:eq(1)").val(paramCity);//将城市加载完后进行选中指定的市
					}else if("s"==status){
						$("#schoolchooseArea>select:eq(1)").val(paramCity);
					}
					
					
					var paramAreaId="";
					if(paramCountry!="-1" && paramCountry!=""){
						paramAreaId=paramCountry;
					}
					if(paramCity!="-1" && paramCity!="" && paramCountry=="-1"){
						paramAreaId=paramCity;
					}
					
					if(paramValue!="-1" || paramValue!="" && paramCity=="-1" && paramCountry=="-1"){
						paramAreaId=paramValue;
					}
					
					$.post(url,{"parentId":paramCity},function(data){
						var html = '<select class="mr20"><option value="-1">请选择</option>';
						var j = data.length;
						if(j == 0){
							return ;
						}
						for(var i = 0; i<j; i++){
							html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
						}
						html += '</select>';
						$("#"+id).append(html);
						if("p"==status){
							$("#chooseArea>select:eq(2)").val(paramCountry);//将城市加载完后进行选中指定的市
							//获得项目列表
							$.post("${root}/admin/projectmanager/getprojectbyarea.do",{"areaId":paramAreaId},function(data){
								var htmls = '<option value="">-- 请选择 --</option>';
								for(var i = 0,j = data.length; i<j; i++){
									htmls += '<option langName="'+data[i].managerName+'" langContact="'+data[i].managerContact+'" value="'+data[i].projectId+'">'+data[i].projectName+'</option>';
								}
								$("#project").html(htmls);
					        //将项目信息进行填充  并触发本事件
					    	   // $("#project").val(AreaId);
					    	   //$("#project").change();
						  
							},'json');
						}else if("s"==status){
							$("#schoolchooseArea>select:eq(2)").val(paramCountry);
							//获得学校列表
							$.post("${root}/admin/schoolmanager/getschoollist.do",{"areaId":paramAreaId,"projectId":sprojId},function(data){
								var html = '<option value="">-- 请选择 --</option>';
								for(var i = 0,j = data.length; i<j; i++){
									html += '<option value="'+data[i].clsSchoolId+'">'+data[i].schoolName+'</option>';
								}
								$("#school").html(html);
								//$("#school").val(AreaId);
								
							},'json');
						}
						
					},'json');
				}
				
			},'json');  
		}
	}
	
</script>
</body>
</html>