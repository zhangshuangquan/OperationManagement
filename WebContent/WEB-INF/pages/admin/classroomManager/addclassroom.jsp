<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
     <script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
     <script src="${root }/public/js/customer.js" type="text/javascript"></script>
</head>
<body class="chase-ask">
<form id="submitForm">
    <ul class="commonUL">
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="text">项目区域：</label>
				<span class="cont" id="chooseArea">
					<select class="mr20" id="province" needcheck nullMsg="请选择项目区域!" >
						<option value="-1">-- 请选择 --</option>
					</select>
				</span>
        </li>
        <li class="clearfix">
        	<label class="text">项目：</label>
				<span class="cont" id="chooseProject">
					<select class="mr20" id="project" needcheck nullMsg="请选择项目!" >
						<option value="-1">-- 请选择 --</option>
					</select>
				</span>
        </li>
        
        <li class="clearfix" style="margin:5px 0 15px;">
			<label class="text">学校区域：</label>
				<span class="cont" id="schoolchooseArea">
					<select class="mr20" id="schoolprovince">
						<option value="-1">-- 请选择 --</option>
					</select>
				</span>
        </li>
        <li class="clearfix">
        	<label class="text">学校：</label>
				<span class="cont" id="chooseSchool">
					<select class="mr20" id="school" name="clsSchoolId" needcheck nullMsg="请选择学校!" >
						<option value="">-- 请选择 --</option>
					</select>
				</span>
        </li>
        <li class="clearfix" style="margin-bottom:5px;">
            <label class="text">教室：</label>
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    <input type="text" name="roomName" id="roomName"  needcheck nullMsg="请输入教室名字!"  >
               	</div>&nbsp;&nbsp;
        </li>
         <li class="clearfix" style="margin-bottom:5px;">
            <label class="text">教室类别：</label>
                <span class="cont" id="chooseClassroomType">
					<select class="mr20"  name="roomType" needcheck nullMsg="请输入教室类别!">
						<option value="">-- 请选择 --</option>
						<option value="主讲教室">主讲教室 </option>
						<option value="接收教室">接收教室 </option>
					</select>
				</span>
        </li>
    </ul>
    <div style="text-align:center;margin-bottom:5px;">
        <input type="submit" class="btn" value="确定" style="margin-right:20px;" />
        <input type="button" class="btn btnGray" value="取消" style="margin-right:20px;" id="cancel" />
    </div>
</form>

<script>
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
			$.post("${root}/admin/projectmanager/getprojectbyarea.do",{"areaId":baseAreaId},function(data){
				var html = '<option value="">-- 请选择 --</option>';
				for(var i = 0,j = data.length; i<j; i++){
					html += '<option value="'+data[i].projectId+'">'+data[i].projectName+'</option>';
				}
				$("#project").html(html);
			},'json');
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
				for(var i = 0,j = data.length; i<j; i++){
					html += '<option value="'+data[i].clsSchoolId+'">'+data[i].schoolName+'</option>';
				}
				$("#school").html(html);
			},'json'); 
		});
	});
    if(window.frameElement)  var domid =frameElement.getAttribute("domid");
    var mySplit = parent.mySplit;
    new BasicCheck({
        form: $id("submitForm"),
        addition : function() {
            return true;
        },
        ajaxReq : function(){
            $.post('${root}/admin/classroom/finishadd.do',$("#submitForm").serialize(),function(r){
                try {
                    if(!r.result){
                        Win.alert('操作失败！');
                    }else{
                        parent.Win.alert('操作成功!');
                        parent.location.reload()
                        parent.Win.wins[domid].close();
                    }
                } catch(e) {
                    Win.alert("错误提示:"+e.message);
                }
            });
        }
    });
    $("#cancel").click(function(){
        parent.Win.wins[domid].close();
    });
    $("#imgview").on("click", ".imgview-close", function(){
        $(this).parent(".imgview-list").remove();
    });


</script>
</body>
</html>