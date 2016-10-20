<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
     <script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
     <script src="${root }/public/js/customer.js" type="text/javascript"></script>
     <script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
     <script type="text/javascript" src="${root }/public/upload/uploadfile.js"></script>
     <script type="text/javascript" src="${root}/public/js/extend.js"></script>
     <script type="text/javascript" src="${root}/public/js/showImage/showImage.js"></script>
     <link href="${root}/public/css/reset.css" rel="stylesheet" type="text/css" media="all">
    <style>
    	
		.hide{
		  display:none;
		}
		.neteq{
		  diplay:none;
		}
		.load{
		  display:none;
		}
		.shownet{
		  display:none;
		}
		.showserver{
		  display:none;
		}
		
	</style>
</head>
<body class="chase-ask">
<h1 style="text-align: center">在线课堂实施环境调查表</h1>
<form id="editForm">
    <ul class="searchWrap" >
         <li class="clearfix" style="margin:5px 0 5px;">
			<input id="clsClassroomId" name="clsClassroomId" value="${classroom.clsClassroomId }" type="hidden">
			<label class="labelText">学校名称：</label>
				<span>
					${classroom.clsSchoolName }
				</span>
        </li>
        <li class="clearfix" style="margin:5px 12px 5px;">
        	<label class="labelText">学校联系人：</label>
				<span>
					<input name="schoolContact"  type="text" value="${eSurvey.schoolContact}">
				</span>
			<label class="labelText">联系电话：</label>
				<span>
					<input  name="schoolContactPhone" type="text" value="${eSurvey.schoolContactPhone}">
				</span>
		</li>
		<li class="clearfix" style="margin:5px 0 15px;">
		    <label class="labelText" style="margin-left:12px;">现场商务：</label>
				<span>
					<input name="businessContact" id="bussiness" value="${eSurvey.businessContact}"/> 
				</span>
					<label class="labelText">联系电话：</label>
				<span>
					<input name=businessContactPhone id="bussiness_phone" value="${eSurvey.businessContactPhone}"/> 
				</span>
        </li>
     </ul>
     <ul class="searchWrap">
         <li class="clearfix" style="margin:5px 20px 5px;">
           <label class="labelText" style="font-weight:900;">教室装修情况：</label>
         </li>
         <li class="clearfix" style="margin:5px 0 5px;">
		   <label class="labelText">教室尺寸：</label>
				长 &nbsp;<span>
					<input name="classroomLength" class="w120" id="classroom_length" value="${eSurvey.classroomLength}"/>（米）
				</span>&nbsp;&nbsp;
				宽 &nbsp;<span>
					<input name=classroomWidth class="w120" id="classroom_width" value="${eSurvey.classroomWidth}"/> （米）
				</span>&nbsp;&nbsp;
				高 &nbsp;<span>
					<input name="classroomHeight" class="w120" id="classroom_heigth" value="${eSurvey.classroomHeight}"/> （米）
				</span>
				其他&nbsp;<span>
					<input name="classroomElse" class="w120" id="classroom_else" value="${eSurvey.classroomElse}"/>
				</span>
        </li>
         <li class="clearfix" style="margin:5px 0px 5px;">
			 <span style="margin-left:40px;">
			  <c:choose>
			   <c:when test="${eSurvey.classroomIsVoltage==null}">
			       <input type="radio" name="classroomIsVoltage" value="1">有 &nbsp;
			       <input type="radio" name="classroomIsVoltage" value="0">无  &nbsp;  220V强电接入
			     
			   </c:when>
			   <c:otherwise>
			      <c:if test="${eSurvey.classroomIsVoltage eq 1}">
			         <input type="radio" name="classroomIsVoltage" value="1" checked>有 &nbsp;
			         <input type="radio" name="classroomIsVoltage" value="0">无  &nbsp;  220V强电接入
			      </c:if>
			      <c:if test="${eSurvey.classroomIsVoltage eq 0}">
			         <input type="radio" name="classroomIsVoltage" value="1">有 &nbsp;
			         <input type="radio" name="classroomIsVoltage" value="0" checked>无  &nbsp;  220V强电接入
			      </c:if>
			   </c:otherwise>
			 </c:choose>
			 </span>
			 <span style="margin-left:180px;">
			  <c:choose>
			   <c:when test="${eSurvey.classroomIsPrower==null}">
			       <input type="radio" name="classroomIsPrower" value="1">有 &nbsp;
			       <input type="radio" name="classroomIsPrower" value="0">无  &nbsp;  各个点位有无电源接入
			   </c:when>
			   <c:otherwise>
			       
			     <c:if test="${eSurvey.classroomIsPrower eq 1}">
			       <input type="radio" name="classroomIsPrower" value="1" checked>有 &nbsp;
			       <input type="radio" name="classroomIsPrower" value="0">无  &nbsp;  各个点位有无电源接入
			     </c:if>
			      <c:if test="${eSurvey.classroomIsPrower eq 0}">
			       <input type="radio" name="classroomIsPrower" value="1">有 &nbsp;
			       <input type="radio" name="classroomIsPrower" value="0" checked>无  &nbsp;  各个点位有无电源接入
			     </c:if>
			   </c:otherwise>
			 </c:choose>
			 
			
			</span>
		 </li>
		 <li class="clearfix" style="margin:5px 0px 5px;">
			<span style="margin-left:40px;">
			  <c:choose>
			   <c:when test="${eSurvey.classroomIsLight==null}">
			         
			      <input type="radio" name="classroomIsLight" value="1">是 &nbsp;
			      <input type="radio" name="classroomIsLight" value="0">否  &nbsp;  室内光线是否充足
			   </c:when>
			   <c:otherwise>
			        <c:if test="${eSurvey.classroomIsLight eq 1}">
			          <input type="radio" name="classroomIsLight" value="1" checked>是 &nbsp;
			          <input type="radio" name="classroomIsLight" value="0">否  &nbsp;  室内光线是否充足
			        </c:if>
			         <c:if test="${eSurvey.classroomIsLight eq 0}">
			          <input type="radio" name="classroomIsLight" value="1">是 &nbsp;
			          <input type="radio" name="classroomIsLight" value="0" checked>否  &nbsp;  室内光线是否充足
			        </c:if>
			   </c:otherwise>
			 </c:choose>
			 
			
			  
			</span>
		
			<span style="margin-left:162px;">
			  <c:choose>
			   <c:when test="${eSurvey.classroomIsCurtain==null}">
			        
			    <input type="radio" name="classroomIsCurtain" value="1">有 &nbsp;
			    <input type="radio" name="classroomIsCurtain" value="0">无  &nbsp;  窗帘
			    
			   </c:when>
			   <c:otherwise>
			       <c:if test="${eSurvey.classroomIsCurtain eq 1}">
			          <input type="radio" name="classroomIsCurtain" value="1" checked>有 &nbsp;
			          <input type="radio" name="classroomIsCurtain" value="0">无  &nbsp;  窗帘
			       </c:if>
			       <c:if test="${eSurvey.classroomIsCurtain eq 0}">
			          <input type="radio" name="classroomIsCurtain" value="1">有 &nbsp;
			          <input type="radio" name="classroomIsCurtain" value="0" checked>无  &nbsp;  窗帘
			       </c:if>
			       
			   </c:otherwise>
			 </c:choose>
			
			</span>
		  <li class="clearfix" style="margin:5px 0px 5px;">
			<span style="margin-left:40px;">
			  <c:choose>
			   <c:when test="${eSurvey.classroomIsAirCondition==null}">
			     <input type="radio" name="classroomIsAirCondition" value="1">有 &nbsp;
			     <input type="radio" name="classroomIsAirCondition" value="0">无  &nbsp;  空调
			  
			   </c:when>
			   <c:otherwise>
			       <c:if test="${eSurvey.classroomIsAirCondition eq 1}">
			         <input type="radio" name="classroomIsAirCondition" value="1" checked>有 &nbsp;
			         <input type="radio" name="classroomIsAirCondition" value="0">无  &nbsp;  空调
			       </c:if>
			       <c:if test="${eSurvey.classroomIsAirCondition eq 0}">
			         <input type="radio" name="classroomIsAirCondition" value="1">有 &nbsp;
			         <input type="radio" name="classroomIsAirCondition" value="0" checked>无  &nbsp;  空调
			       </c:if>
			   </c:otherwise>
			 </c:choose>
			 
			
			</span>
			<span style="margin-left:234px;">
			  <c:choose>
			   <c:when test="${eSurvey.classroomIsCondoletop==null}">
			     <input type="radio" name="classroomIsCondoletop" value="1">有 &nbsp;
			     <input type="radio" name="classroomIsCondoletop" value="0">无  &nbsp;  吊顶
			 
			   </c:when>
			   <c:otherwise>
			       <c:if test="${eSurvey.classroomIsCondoletop eq 1}">
			         <input type="radio" name="classroomIsCondoletop" value="1" checked>有 &nbsp;
			         <input type="radio" name="classroomIsCondoletop" value="0">无  &nbsp;  吊顶
			 
			       </c:if>
			        <c:if test="${eSurvey.classroomIsCondoletop eq 0}">
			         <input type="radio" name="classroomIsCondoletop" value="1">有 &nbsp;
			         <input type="radio" name="classroomIsCondoletop" value="0" checked>无  &nbsp;  吊顶
			 
			       </c:if>
			   </c:otherwise>
			 </c:choose> 
			
			</span>
			
        </li>
         <li class="clearfix" style="margin:5px 0px 15px;">
			<span style="margin-left:25px;float:left;">
			    备注：
			</span>
			  <c:choose>
			   <c:when test="${eSurvey.classroomRemark==null}">
			         <textarea cols="80" rows="5" id="classroom_remark" name="classroomRemark"></textarea>
			   </c:when>
			   <c:otherwise>
			        <textarea cols="80" rows="5" id="classroom_remark" name="classroomRemark">${eSurvey.classroomRemark}</textarea>
			   </c:otherwise>
			 </c:choose>
			
			
        </li>
      </ul>
      <ul class="searchWrap">
         <li class="clearfix" style="margin:5px 0 5px 20px;">
           <label class="labelText" style="font-weight:900;">现场设备情况：</label>
         </li>
         <li class="clearfix" style="margin:5px 0 5px 20px;">
       
			  <c:choose>
			   <c:when test="${eSurvey.equipmentIsBalckboard==null}">
			    <span>
			        <input type="radio" name="equipmentIsBalckboard" value="1" class="isBlack">有 &nbsp;
		            <input type="radio" name="equipmentIsBalckboard" value="0" class="isBlack">无  &nbsp;&nbsp;
			        <label class="text">黑板</label>
			        <span style="margin-left:10px;" class="load">
                       
                         <input type="text" class="w150" name="equipmentBackboard" value="${eSurvey.equipmentBackboard}"/>
			         </span>
			    </span>
			   </c:when>
			   <c:otherwise>
			     
			       <span>
			        <input type="radio" name="equipmentIsBalckboard" value="1" class="isBlack" <c:if test="${eSurvey.equipmentIsBalckboard eq 1}">checked="checked"</c:if>>有 &nbsp;
		            <input type="radio" name="equipmentIsBalckboard" value="0" class="isBlack" <c:if test="${eSurvey.equipmentIsBalckboard eq 0}">checked="checked"</c:if>>无  &nbsp;&nbsp;
			        <label class="text">黑板</label>
			        <span style="margin-left:10px;" class="load">
                       <input type="text" class="w150" name="equipmentBackboard" value="${eSurvey.equipmentBackboard}"/>
			         </span>
			       </span>
			    
			    
              </c:otherwise>
			 </c:choose> 
			
		
			&nbsp;&nbsp;
			
			 <c:choose>
			   <c:when test="${eSurvey.equipmentIsProjector==null}">
			    <span>
			      <input type="radio" name="equipmentIsProjector" value="1" class="isBlack">有&nbsp;
         	      <input type="radio" name="equipmentIsProjector" value="0" class="isBlack">无&nbsp;&nbsp;
			      <label class="text">投影仪</label>
			      <span style="margin-left:10px;" class="load">
				    <input type="text" class="w150" id="equipment_projector_remark" name="equipmentProjector" value="${eSurvey.equipmentProjector}"/> 
				  </span>
			    </span>
			   </c:when>
			   <c:otherwise>
			      <span>
                   <input type="radio" name="equipmentIsProjector" value="1" class="isBlack" <c:if test="${eSurvey.equipmentIsProjector eq 1}">checked="checked"</c:if>>有&nbsp;
         	       <input type="radio" name="equipmentIsProjector" value="0" class="isBlack" <c:if test="${eSurvey.equipmentIsProjector eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
			       <label class="text">投影仪</label>
			       <span style="margin-left:10px;" class="load">
				   <input type="text" class="w150" id="equipment_projector_remark" name="equipmentProjector" value="${eSurvey.equipmentProjector}"/> 
				   </span>
				  </span>
			   </c:otherwise>
			 </c:choose>
		
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 
			 <c:choose>
			   <c:when test="${eSurvey.equipmentIsPlatform==null}">
			    <span>
			     <input type="radio" name="equipmentIsPlatform" value="1" class="isBlack">有&nbsp;
         	     <input type="radio" name="equipmentIsPlatform" value="0" class="isBlack">无&nbsp;&nbsp;
		         <label class="text">多媒体讲台</label>
		          <span style="margin-left:10px;" class="load">
					<input type="text" class="w150" id="equipment_platform_remark" name="equipmentPlatform" value="${eSurvey.equipmentPlatform }"/> 
				  </span> 
		        </span>
			   </c:when>
			   <c:otherwise>
			   <span>
                 <input type="radio" name="equipmentIsPlatform" value="1" class="isBlack" <c:if test="${eSurvey.equipmentIsPlatform eq 1}">checked="checked"</c:if>>有&nbsp;
         	     <input type="radio" name="equipmentIsPlatform" value="0" class="isBlack" <c:if test="${eSurvey.equipmentIsPlatform eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
		         <label class="text">多媒体讲台</label> 
		        <span style="margin-left:10px;" class="load">
					<input type="text" class="w150" id="equipment_platform_remark" name="equipmentPlatform" value="${eSurvey.equipmentPlatform }"/> 
				</span> 
				</span>
			   </c:otherwise>
			 </c:choose>
			 
        </li>
        <li class="clearfix" style="margin:5px 0 5px 20px;">
      
			
			  <c:choose>
			   <c:when test="${eSurvey.equipmentIsControl==null}">
			     <span>
			     <input type="radio" name="equipmentIsControl" value="1" class="isBlack">有&nbsp;&nbsp;
         	     <input type="radio" name="equipmentIsControl" value="0" class="isBlack">无&nbsp;&nbsp;
                 <label class="text" style="margin-left:4px;">中控</label>
                   <span style="margin-left:10px;" class="load">
					<input type="text" class="w150" id="equipment_control_text" name="equipmentControl" value="${eSurvey.equipmentControl}"/> 
				   </span>
                 </span>
			   </c:when>
			   <c:otherwise>
                   <span>
                   <input type="radio" name="equipmentIsControl" value="1" class="isBlack" <c:if test="${eSurvey.equipmentIsControl eq 1}">checked="checked"</c:if>>有&nbsp;&nbsp;
         	       <input type="radio" name="equipmentIsControl" value="0" class="isBlack" <c:if test="${eSurvey.equipmentIsControl eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
                   <label class="text" style="margin-left:4px;">中控</label>
                   <span style="margin-left:10px;" class="load">
					<input type="text" class="w150" id="equipment_control_text" name="equipmentControl" value="${eSurvey.equipmentControl}"/> 
				   </span>
                   </span>
			   </c:otherwise>
			 </c:choose>
			 
		   &nbsp;&nbsp;
		
		    
			   <c:choose>
			   <c:when test="${eSurvey.equipmentIsWhiteboard==null}">
			   <span>
			      <input type="radio" name="equipmentIsWhiteboard" value="1" class="isBlack">有&nbsp;
         	      <input type="radio" name="equipmentIsWhiteboard" value="0" class="isBlack">无&nbsp;&nbsp;
			      <label class="text" style="margin-left:2px;">电子白板</label>
			       <span style="margin-left:10px;" class="load">
					<input type="text" class="w150" id="equipment_whiteBoard_remark" name="equipmentWhiteboard" value="${eSurvey.equipmentWhiteboard }"/> 
				  </span>
			   </span>
			   </c:when>
			   <c:otherwise>
                   <span>
                     <input type="radio" name="equipmentIsWhiteboard" value="1" class="isBlack" <c:if test="${eSurvey.equipmentIsWhiteboard eq 1}">checked="checked"</c:if>>有&nbsp;
         	         <input type="radio" name="equipmentIsWhiteboard" value="0" class="isBlack" <c:if test="${eSurvey.equipmentIsWhiteboard eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
			        <label class="text" style="margin-left:2px;">电子白板</label>
			       <span style="margin-left:10px;" class="load">
					<input type="text" class="w150" id="equipment_whiteBoard_remark" name="equipmentWhiteboard" value="${eSurvey.equipmentWhiteboard }"/> 
				  </span>
                   </span>
			   </c:otherwise>
			 </c:choose> 
			      
			
			  &nbsp;&nbsp;
		
			 <c:choose>
			   <c:when test="${eSurvey.equipmentIsTv==null}">
			     <span>
		         <input type="radio" name="equipmentIsTv" value="1" class="isBlack">有&nbsp;
         	     <input type="radio" name="equipmentIsTv" value="0" class="isBlack">无&nbsp;&nbsp;
                 <label class="text">液晶电视</label>
                 <span style="margin-left:10px;" class="load">
					<input type="text" class="w150" id="equipment_tv_remark" name="equipementTv" value="${eSurvey.equipementTv}"/> 
				  </span>
                 </span>
			   </c:when>
			   <c:otherwise>
			    <span>
                 <input type="radio" name="equipmentIsTv" value="1" class="isBlack" <c:if test="${eSurvey.equipmentIsTv eq 1}">checked="checked"</c:if>>有&nbsp;
         	     <input type="radio" name="equipmentIsTv" value="0" class="isBlack" <c:if test="${eSurvey.equipmentIsTv eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
                 <label class="text">液晶电视</label>
                  <span style="margin-left:10px;" class="load">
					<input type="text" class="w150" id="equipment_tv_remark" name="equipementTv" value="${eSurvey.equipementTv}"/> 
				  </span>
                 </span>
			   </c:otherwise>
			 </c:choose>
			       
			    
        </li>
         <li class="clearfix" style="margin:5px 0 5px 20px;">
      
			<c:choose>
			   <c:when test="${eSurvey.equipmentIsBanbantong==null}">
			   <span>
			      <input type="radio" name="equipmentIsBanbantong" value="1" class="isBlack">有&nbsp;
                  <input type="radio" name="equipmentIsBanbantong" value="0" class="isBlack">无&nbsp;&nbsp;
		          <label class="text">班班通</label>
		           <span style="margin-left:5px;" class="load">
					<input type="text" class="w150" id="equipment_banbantong_text" name="equipmentBanbantong" value="${eSurvey.equipmentBanbantong}"/> 
				  </span>
		       </span>
			   </c:when>
			   <c:otherwise>
			   <span>
                  <input type="radio" name="equipmentIsBanbantong" value="1" class="isBlack" <c:if test="${eSurvey.equipmentIsBanbantong eq 1}">checked="checked"</c:if>>有&nbsp;
                  <input type="radio" name="equipmentIsBanbantong" value="0" class="isBlack" <c:if test="${eSurvey.equipmentIsBanbantong eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
		          <label class="text">班班通</label>
		          <span style="margin-left:5px;" class="load">
					<input type="text" class="w150" id="equipment_banbantong_text" name="equipmentBanbantong" value="${eSurvey.equipmentBanbantong}"/> 
				  </span>
				</span>    
			   </c:otherwise>
			 </c:choose>
			      
		     &nbsp;&nbsp;
		
			   <c:choose>
			    <c:when test="${eSurvey.equipmentIsTeachercamera==null}">
			    <span>
			       <input type="radio" name="equipmentIsTeachercamera" value="1" class="isBlack">有&nbsp;
                   <input type="radio" name="equipmentIsTeachercamera" value="0" class="isBlack">无&nbsp;&nbsp;
			       <label class="text">老师摄像机</label>
			       <span style="margin-left:5px;" class="load">
					<input type="text" class="w150" id="equipment_teacherCamera_remark" name="equipmentTeachcamera" value="${eSurvey.equipmentTeachcamera}"/> 
				   </span>
			   </span>
			   </c:when>
			   <c:otherwise>
			   <span>
                 <input type="radio" name="equipmentIsTeachercamera" value="1" class="isBlack" <c:if test="${eSurvey.equipmentIsTeachercamera eq 1}">checked="checked"</c:if>>有&nbsp;
                 <input type="radio" name="equipmentIsTeachercamera" value="0" class="isBlack" <c:if test="${eSurvey.equipmentIsTeachercamera eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
			     <label class="text">老师摄像机</label>
			     <span style="margin-left:5px;" class="load">
					<input type="text" class="w150" id="equipment_teacherCamera_remark" name="equipmentTeachcamera" value="${eSurvey.equipmentTeachcamera}"/> 
				</span>
				</span>
			   </c:otherwise>
			 </c:choose>
			      
		    
		     &nbsp;&nbsp;
			 <c:choose>
			       <c:when test="${eSurvey.equipmentIsStudentcamera==null}">
			       <span>
			         <input type="radio" name="equipmentIsStudentcamera" value="1" class="isBlack">有&nbsp;&nbsp;
                     <input type="radio" name="equipmentIsStudentcamera" value="0" class="isBlack">无&nbsp;&nbsp;
			 
		             <label class="text">学生摄像机</label>
		              <span style="margin-left:5px;" class="load">
					      <input type="text" class="w150" id="equipment_studentCamera_remark" name="equipmentStudentcamera" value="${eSurvey.equipmentStudentcamera}"/> 
				       </span>
		             </span>
			       </c:when>
			       <c:otherwise>
			        <span>
                      <input type="radio" name="equipmentIsStudentcamera" value="1" class="isBlack" <c:if test="${eSurvey.equipmentIsStudentcamera eq 1}">checked="checked"</c:if>>有&nbsp;&nbsp;
                      <input type="radio" name="equipmentIsStudentcamera" value="0" class="isBlack" <c:if test="${eSurvey.equipmentIsStudentcamera eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
			     
		             <label class="text">学生摄像机</label>
		               <span style="margin-left:5px;" class="load">
					      <input type="text" class="w150" id="equipment_studentCamera_remark" name="equipmentStudentcamera" value="${eSurvey.equipmentStudentcamera}"/> 
				       </span>
		             </span>
			       </c:otherwise>
			 </c:choose>
        </li>
        <li class="clearfix" style="margin:5px 0 5px 20px;">
			  <c:choose>
			   <c:when test="${eSurvey.equipmentIsMicr==null}">
			    <span>
			     <input type="radio" name="equipmentIsMicr" value="1" class="isBlack">有&nbsp;&nbsp;
                 <input type="radio" name="equipmentIsMicr" value="0" class="isBlack">无&nbsp;&nbsp;
			                 麦克风、拾音器
			     <span style="margin-left:20px;" class="load">
					<input type="text" class="w150" id="equipment_mirc_text" name="equipmentMicr" value="${eSurvey.equipmentMicr }"/> 
				 </span>
			    </span>
			   </c:when>
			   <c:otherwise>
                  <span>
                    <input type="radio" name="equipmentIsMicr" value="1" class="isBlack" <c:if test="${eSurvey.equipmentIsMicr eq 1}">checked="checked"</c:if>>有&nbsp;&nbsp;
                    <input type="radio" name="equipmentIsMicr" value="0" class="isBlack" <c:if test="${eSurvey.equipmentIsMicr eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
			                      麦克风、拾音器
			       <span style="margin-left:20px;" class="load">
					<input type="text" class="w150" id="equipment_mirc_text" name="equipmentMicr" value="${eSurvey.equipmentMicr }"/> 
				    </span>
                  </span>
			   </c:otherwise>
			 </c:choose>
			&nbsp;&nbsp;
			
			 <c:choose>
			   <c:when test="${eSurvey.equipIsSound==null}">
			   <span>
			    <input type="radio" name="equipIsSound" value="1" class="sound">有&nbsp;&nbsp;
                <input type="radio" name="equipIsSound" value="0" class="sound">无&nbsp;&nbsp;
			    <label class="text">音响</label>
			    <span style="margin-left:20px;" class="hide">
			     	 <input type="radio"  name="equipmentIsSound" id="equipment_music_on" value="1" />
			          <label class="text">有源</label>
			          <input type="radio" name="equipmentIsSound"  id="equipment_music_no" value="0" /> 
					  <label class="text">无源</label>
			    </span>
			   </span>
			   </c:when>
			   <c:otherwise>
			    <span>
			          <input type="radio" name="equipIsSound" value="1" class="sound" <c:if test="${eSurvey.equipIsSound eq 1}">checked="checked"</c:if>>有&nbsp;&nbsp;
                      <input type="radio" name="equipIsSound" value="0" class="sound" <c:if test="${eSurvey.equipIsSound eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
			          <label class="text">音响</label>
			        
			          <c:choose>
			            
			           <c:when test="${eSurvey.equipmentIsSound == null}">
			            <span style="margin-left:20px;" class="hide">
			             <input type="radio"  name="equipmentIsSound" value="1"/>
			                <label class="text">有源</label>
			             <input type="radio" name="equipmentIsSound" value="0"/> 
					        <label class="text"> 无源 </label>
					    </span>
				       </c:when>
				     
				     <c:otherwise>
			            <span style="margin-left:20px;" class="hide">
			               <input type="radio"  name="equipmentIsSound" id="equipment_music_on" value="1" <c:if test="${eSurvey.equipmentIsSound eq 1}">checked="checked"</c:if>/>
			               <label class="text">有源</label>
			               <input type="radio" name="equipmentIsSound"  id="equipment_music_no" value="0" <c:if test="${eSurvey.equipmentIsSound eq 0}">checked="checked"</c:if>/> 
					       <label class="text">无源 </label>
			            </span>
			         </c:otherwise>
			        
			         </c:choose>
			       </span>
                
			   </c:otherwise>
			 </c:choose>
			 
			 
           <li class="clearfix" style="margin:5px 20px 5px;">
           
		   
			   <c:choose>
			     <c:when test="${eSurvey.equipmentIsShowplat==null}">
			      <span>
			       <input type="radio" name="equipmentIsShowplat" value="1" class="isBlack">有&nbsp;&nbsp;
                   <input type="radio" name="equipmentIsShowplat" value="0" class="isBlack">无&nbsp;&nbsp;      
			                   实物展台
			       <span style="margin-left:20px;" class="load">
					 <input type="text" class="w150" id="equipShowPlat" name="equipShowPlat" value="${eSurvey.equipShowPlat}"/> 
				   </span>
			      </span>
			     </c:when>
			     <c:otherwise>
                  <span>
                     <input type="radio" name="equipmentIsShowplat" value="1" class="isBlack" <c:if test="${eSurvey.equipmentIsShowplat eq 1}">checked="checked"</c:if>>有&nbsp;&nbsp;
                     <input type="radio" name="equipmentIsShowplat" value="0" class="isBlack" <c:if test="${eSurvey.equipmentIsShowplat eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;      
			                        实物展台
                     <span style="margin-left:20px;" class="load">
					  <input type="text" class="w150" id="equipShowPlat" name="equipShowPlat" value="${eSurvey.equipShowPlat}"/> 
				     </span>
                  </span>
			      </c:otherwise>
			   </c:choose>
			   
			  &nbsp;&nbsp;&nbsp;&nbsp;
			   <c:choose>
			     <c:when test="${eSurvey.equipNetEquip==null}">
			      <span>
		           <input type="radio" name="equipNetEquip" value="1" class="netEquip">有&nbsp;&nbsp;
                   <input type="radio" name="equipNetEquip" value="0" class="netEquip">无&nbsp;&nbsp;      
			  
		           <label class="text">网络设备：</label>
		           <span style="margin-left:20px;" class="neteq">
		            <input type="checkbox" name="equipmentIsRouter" value="1">
		                                         路由器
		            <input type="checkbox" name="equipmentIsSwtich"  value="1"/>
		                                        交换机
		            <input type="text" style="margin-left:10px;" name="equipmentNetwork" id="equipment_network_remark" value="${eSurvey.equipmentNetwork }">
		           </span>
		          </span>
			   </c:when>
			   <c:otherwise>
			   <span>
                   <input type="radio" name="equipNetEquip" value="1" class="netEquip" <c:if test="${eSurvey.equipNetEquip eq 1}">checked="checked"</c:if>>有&nbsp;&nbsp;
                   <input type="radio" name="equipNetEquip" value="0" class="netEquip" <c:if test="${eSurvey.equipNetEquip eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;      
		           <label class="text">网络设备：</label>
		           <span style="margin-left:20px;" class="neteq">
		             <c:if test="${eSurvey.equipmentIsRouter==null}">
		               <input type="checkbox" name="equipmentIsRouter" value="1">          
		             </c:if>
		             <c:if test="${eSurvey.equipmentIsRouter != null}">
		               <input type="checkbox" name="equipmentIsRouter" checked="checked" value="1">
		                                                    
		             </c:if>
		                                         路由器                                         
		             <c:if test="${eSurvey.equipmentIsSwtich==null}">
		               <input type="checkbox" name="equipmentIsSwtich"  value="1"/>          
		             </c:if>
		             <c:if test="${eSurvey.equipmentIsSwtich != null}">
		               <input type="checkbox" name="equipmentIsSwtich" value="1" checked="checked"/>
		                                            
		             </c:if>
		                                          交换机                              
		             <input type="text" style="margin-left:10px;" name="equipmentNetwork" id="equipment_network_remark" value="${eSurvey.equipmentNetwork }">
		          
		          
		          
		          
		          </span>
		        </span>
			   </c:otherwise>
			  
			   </c:choose>
			      
        </li>
        <li class="clearfix" style="margin:5px 0px 15px;">
			<span style="margin-left:25px;float:left;">
			    备注：
			</span>
			 <c:choose>
			     <c:when test="${eSurvey.equipmentRemark==null}">
			    	<textarea cols="80" rows="5" id="equipment_remark" name="equipmentRemark"></textarea>	
			   </c:when>
			   <c:otherwise>
                 <textarea cols="80" rows="5" id="equipment_remark" name="equipmentRemark">${eSurvey.equipmentRemark}</textarea>	
			   </c:otherwise>
			   </c:choose>
					
		
        </li>
      </ul>
      
     <ul class="searchWrap">
       <li class="clearfix" style="margin:5px 20px 5px;">
     <c:choose>
      <c:when test="${eSurvey.equipIsNet==null}">
     
          <input type="radio" name="equipIsNet" value="1" class="net">有&nbsp;&nbsp;
          <input type="radio" name="equipIsNet" value="0" class="net">无&nbsp;&nbsp;      
		  <label class="text" style="font-weight:900;">网络情况：</label>       
	  
	  </c:when>
	  <c:otherwise>
	      <input type="radio" name="equipIsNet" value="1" class="net" <c:if test="${eSurvey.equipIsNet eq 1}">checked="checked"</c:if>>有&nbsp;&nbsp;
          <input type="radio" name="equipIsNet" value="0" class="net" <c:if test="${eSurvey.equipIsNet eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;      
		  <label class="text" style="font-weight:900;">网络情况：</label> 
	  
	  </c:otherwise>
      </c:choose>
      </li>
         <li class="clearfix shownet" style="margin:5px 0 5px 32px;">
		   <label class="labelText">运营商及宽带：</label>
				<span style="margin-left:10px;">
					<input type="text" id="networkBoardband " name="networkBoardband" value="${eSurvey.networkBoardband }"/> 
				</span>
		   <label class="labelText">网络环境：</label>
		         <c:choose>
			   <c:when test="${eSurvey.networkIsEnvir==null}">
			      <span style="margin-left:10px;">
					<input type="radio"  name="networkIsEnvir" id="network_share_all" value="1"/>
					共享 
				</span>
				<span style="margin-left:10px;">
					<input type="radio"  name="networkIsEnvir" id="network_share_only" value="0"/> 
					独享
				</span>
			   </c:when>
			   <c:otherwise>
			     <c:choose>
			       <c:when test="${eSurvey.networkIsEnvir eq 1}">
			         <span style="margin-left:10px;">
					<input type="radio"  name="networkIsEnvir" id="network_share_all" value="1" checked="checked"/>
					共享 
				   </span>
				 <span style="margin-left:10px;">
					<input type="radio"  name="networkIsEnvir" id="network_share_only" value="0"/> 
					独享
				  </span>
			       </c:when>
			       <c:otherwise>
			        <span style="margin-left:10px;">
					<input type="radio"  name="networkIsEnvir" id="network_share_all" value="1" />
					共享 
				   </span>
				 <span style="margin-left:10px;">
					<input type="radio"  name="networkIsEnvir" id="network_share_only" value="0" checked="checked"/> 
					独享
				  </span>
			       </c:otherwise>
			     </c:choose>
                   
			   </c:otherwise>
			 </c:choose>
		
        </li>
        <li class="clearfix shownet" style="margin:5px 20px 5px;">
		   <label class="labelText">运营商网站测试：</label>
		   <span class="mr20">
			
	                                     上传<span id="net1" class="uploadCont"> </span>
         
              &nbsp;&nbsp;
				<input type="text" id="network_website_upload" name="networkTestUpload" value="${eSurvey.networkTestUpload }"/>（KB）
				  </span>
				<span class="mr20">
			   下载&nbsp;&nbsp;
					<input type="text" id="network_website_download" name="networkTestDownload" value="${eSurvey.networkTestDownload }"/>（KB） 
				</span>
			
		</li>
        <li class="clearfix shownet" style="margin:5px 35px 5px;">
		   <label class="labelText">163镜像测试：</label>
			    <span class="mr20">
	                                           上传
                &nbsp;&nbsp;
					<input type="text" id="network_163_upload" name="networkTestMirrorUpload"  value="${eSurvey.networkTestMirrorUpload }"/>（KB） 
				</span>
				<span class="mr20">
			下载&nbsp;&nbsp;
					<input type="text" id="network_163_download" name="networkTestMirrorDownload"  value="${eSurvey.networkTestMirrorDownload }"/>（KB） 
				</span>
		
		</li>		
        <li class="clearfix shownet" style="margin:5px 25px 5px;">
				 <label class="labelText">FTP服务器测试：</label>
			    <span class="mr20">
	                       上传
          &nbsp;&nbsp;
					<input type="text" id="network_FTP_upload" name="networkTestFtpUpload"  value="${eSurvey.networkTestFtpUpload }"/>（KB） 
				</span>
				<span class="mr20">
			下载&nbsp;&nbsp;
					<input type="text" id="network_FTP_download" name="networkTestFtpDownload"  value="${eSurvey.networkTestFtpDownload }"/>（KB） 
				</span>
			
        </li>
         <li class="clearfix shownet" style="margin:5px 0px 15px;">
			<span style="margin-left:25px;float:left;">
			    备注：
			</span>
			<c:choose>
			     <c:when test="${eSurvey.networkRemark==null}">
			    	<textarea cols="80" rows="5" id="network_remark" name="networkRemark"></textarea>
			   </c:when>
			   <c:otherwise>
               <textarea cols="80" rows="5" id="network_remark" name="networkRemark">${eSurvey.networkRemark}</textarea>
			   </c:otherwise>
			   </c:choose>
				
        </li>
       
      </ul>
      <ul class="searchWrap">
         <li class="clearfix" style="margin:5px 20px 5px;">
         <c:choose>
           <c:when test="${eSurvey.serverIsExist == null}">
           	  <input type="radio" name="serverIsExist" value="1" class="net">有&nbsp;&nbsp;
              <input type="radio" name="serverIsExist" value="0" class="net">无&nbsp;&nbsp;      
		  
		      <label class="text" style="font-weight:900;">客户服务器状况：</label>
           </c:when>
           <c:otherwise>
              <input type="radio" name="serverIsExist" value="1" class="net" <c:if test="${eSurvey.serverIsExist eq 1}">checked="checked"</c:if>>有&nbsp;&nbsp;
              <input type="radio" name="serverIsExist" value="0" class="net" <c:if test="${eSurvey.serverIsExist eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;      
		      <label class="text" style="font-weight:900;">客户服务器状况：</label>
           </c:otherwise>
         
         </c:choose>
         
         </li>
         <li class="clearfix showserver" style="margin:5px 20px 5px;">
		  
		   <label class="labelText">内存大小：</label>
			    <span style="margin-left:10px;">
					<input type="text" id="server_memory" name="serverMemory" value="${eSurvey.serverMemory}"/>（G）
				</span>
        </li>
        <li class="clearfix showserver" style="margin:5px 20px 5px;">
		   <label class="labelText">服务器型号：</label>
				<span style="margin-left:20px;">
					<input type="text" id="server_typenum" name="serverTypeno" value="${eSurvey.serverTypeno}"/> 
				</span>
			 <label class="labelText">硬盘大小：</label>
				<span style="margin-left:20px;">
					<input type="text" id="server_harddisk" name="serverHarddisk" value="${eSurvey.serverHarddisk}"/>（G）
				</span>
		</li>
        <li class="clearfix showserver" style="margin:5px 20px 5px;">
		   <label class="labelText">处理器配置：</label>
			    <span style="margin-left:20px;">
					<input type="text" id="server_cpu" name="serverCpu" value="${eSurvey.serverCpu }"/> 
				</span>
	       <label class="labelText">操作系统：</label>
			    <span style="margin-left:20px;">
					<input type="text" id="server_os" name="serverOs"  value="${eSurvey.serverOs }"/> 
				</span>
		</li>		
         <li class="clearfix showserver" style="margin:5px 0px 15px;">
			<span style="margin-left:25px;float:left;">
			    备注：
			</span>
			    <c:choose>
			     <c:when test="${eSurvey.serverRemark==null}">
			    	<textarea cols="80" rows="5" id="server_remark" name="serverRemark"></textarea>	
			   </c:when>
			   <c:otherwise>
                 <textarea cols="80" rows="5" id="server_remark" name="serverRemark">${eSurvey.serverRemark}</textarea>	
			   </c:otherwise>
			   </c:choose>
			
        </li>
      </ul>
      
      <ul class="searchWrap">
         <li class="clearfix" style="margin:5px 20px 5px;">
         <c:choose>
          <c:when test="${eSurvey.equipIsFactory==null}">
          	<input type="radio" name="equipIsFactory" value="1" class="factory">有&nbsp;&nbsp;
            <input type="radio" name="equipIsFactory" value="0" class="factory">无&nbsp;&nbsp;      
		  
           <label class="text" style="font-weight:900;">第三方厂家接入情况：</label>
          </c:when>
          <c:otherwise>
            <input type="radio" name="equipIsFactory" value="1" class="factory" <c:if test="${eSurvey.equipIsFactory eq 1}">checked="checked"</c:if>>有&nbsp;&nbsp;
            <input type="radio" name="equipIsFactory" value="0" class="factory" <c:if test="${eSurvey.equipIsFactory eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
            <label class="text" style="font-weight:900;">第三方厂家接入情况：</label>
            
          </c:otherwise>
         
         
         </c:choose>
           
         </li>
         <li class="clearfix" style="margin:5px 20px 5px;display:none;" id="factory1">
		  <label style="margin-left:13px;">厂家安装设备清单：</label>
	      <span>
		     <input type="text" id="factorylist1"  style="margin-left:2px;" name="factoryFirstEquiplist" value="${eSurvey.factoryFirstEquiplist}">
	      </span>
	      <label style="margin-left:25px;">线路连接情况：</label>
	      <span>
		     <input type="text" id="factoryline1"  style="margin-left:2px;" name="factoryFirstLine" value="${eSurvey.factoryFirstLine}">
	      </span>
	      <span style="margin-left:20px;">
             <input id="addFactory" class="btn btnGreen" type="button" value="添加">
          </span>
        </li>
        <li class="clearfix" style="margin:5px 20px 5px; display:none;" id="factory2" no="0">
      
		  <label style="margin-left:13px;">厂家安装设备清单：</label>
	      <span>
		     <input type="text" id="factorylist2"  style="margin-left:2px;" name="factorySecondEquiplist" value="${eSurvey.factorySecondEquiplist}">
	      </span>
	      <label style="margin-left:25px;">线路连接情况：</label>
	      <span>
		     <input type="text" id="factoryline2" style="margin-left:2px;" name="factorySecondLine" value="${eSurvey.factorySecondLine}">
	      </span>
	      <span style="margin-left:20px;">
             <input id="delFactory1" class="btn btnGreen" type="button" value="删除">
          </span>
        </li>
        
         <li class="clearfix" style="margin:5px 20px 5px;display:none;" id="factory3" no="0">
		  <label style="margin-left:13px;">厂家安装设备清单：</label>
	      <span>
		     <input type="text" id="factorylist3" style="margin-left:2px;" name="factoryThirdEquiplist" value="${eSurvey.factoryThirdEquiplist}">
	      </span>
	      <label style="margin-left:25px;">线路连接情况：</label>
	      <span>
		     <input type="text" id="factoryline3"  style="margin-left:2px;" name="factoryThirdLine" value="${eSurvey.factoryThirdLine}">
	      </span>
	      <span style="margin-left:20px;">
             <input id="delFactory2" class="btn btnGreen" type="button" value="删除">
          </span>
        </li>
         <li class="clearfix" style="margin:5px 20px 5px;display:none;" id="factory4">
		  <label style="margin-left:13px;">厂家安装设备清单：</label>
	      <span>
		     <input type="text" id="factorylist4" style="margin-left:2px;" name="factoryFourthEquiplist" value="${eSurvey.factoryFourthEquiplist}">
	      </span>
	      <label style="margin-left:25px;">线路连接情况：</label>
	      <span>
		     <input type="text" id="factoryline4"  style="margin-left:2px;" name="factoryFourthLine" value="${eSurvey.factoryFourthLine}">
	      </span>
	      <span style="margin-left:20px;">
             <input id="delFactory3" class="btn btnGreen" type="button" value="删除">
          </span>
        </li>
         <li class="clearfix" style="margin:5px 20px 5px;display:none;" id="factory5">
		  <label style="margin-left:13px;">厂家安装设备清单：</label>
	      <span>
		     <input type="text" id="factorylist5"  style="margin-left:2px;" name="factoryFifthEquiplist" value="${eSurvey.factoryFifthEquiplist}">
	      </span>
	      <label style="margin-left:25px;">线路连接情况：</label>
	      <span>
		     <input type="text" id="factoryline5" style="margin-left:2px;" name="factoryFifthLine" value="${eSurvey.factoryFifthLine}">
	      </span>
	      <span style="margin-left:20px;">
             <input id="delFactory4" class="btn btnGreen" type="button" value="删除">
          </span>
        </li>
         <li class="clearfix" style="margin:5px 20px 5px;display:none;" id="factory6">
		  <label style="margin-left:13px;">厂家安装设备清单：</label>
	      <span>
		     <input type="text" id="factorylist6"  style="margin-left:2px;" name="factorySixthEquiplist" value="${eSurvey.factorySixthEquiplist}">
	      </span>
	      <label style="margin-left:25px;">线路连接情况：</label>
	      <span>
		     <input type="text" id="factoryline6"  style="margin-left:2px;" name="factorySixthLine" value="${eSurvey.factorySixthLine}">
	      </span>
	      <span style="margin-left:20px;">
             <input id="delFactory5" class="btn btnGreen" type="button" value="删除">
          </span>
        </li>
        
        
      </ul>
      <ul class="searchWrap">
         <li class="clearfix" style="margin:5px 20px 5px;">
           <label class="text">学校负责人：</label>
           <span  style="margin-left:20px;">
              <input type="text" name="schoolHead" value="${eSurvey.schoolHead }"/> 
           </span>
            <label class="text" style="margin-left:10px;">日期：</label>
            <span  style="margin-left:20px;">
              <c:choose>
			     <c:when test="${eSurvey.schoolTime==null}">
			    	  <input type="text" class="Wdate" id="schoolTime" onclick="WdatePicker();"   name="schoolTime"/>
			   </c:when>
			   <c:otherwise>
                   <input type="text" class="Wdate" id="schoolTime" onclick="WdatePicker();"  value="<fmt:formatDate value="${eSurvey.schoolTime}" pattern="yyyy-MM-dd"/>"  name="schoolTime"/>	
			   </c:otherwise>
			   </c:choose>
            
           </span>
         </li>
        <li class="clearfix" style="margin:5px 20px 5px;">
           <label class="text">现场勘查人员：</label>
           <span  style="margin-left:9px;">
              <input type="text" name="investPersonnel" value="${eSurvey.investPersonnel}"/> 
           </span>
            <label class="text" style="margin-left:10px;">日期：</label>
            <span  style="margin-left:20px;">
             <c:choose>
			     <c:when test="${eSurvey.investTime==null}">
			    	<input type="text" name="investTime" id="investTime" class="Wdate" onclick="WdatePicker();"/>
			   </c:when>
			   <c:otherwise>
                    <input type="text" name="investTime" id="investTime" class="Wdate" onclick="WdatePicker();" value="<fmt:formatDate value="${eSurvey.investTime}" pattern="yyyy-MM-dd"/>" />
			   </c:otherwise>
			   </c:choose>
           
           </span>
         </li>
      </ul>
       <ul class="searchWrap">
         <li class="clearfix" style="margin:25px 20px 5px;">
          <span class="mr20">共<span class="red" id="number">${attachments.size() == null?0:attachments.size()}</span>张照片</span>
          <a href="javascript:;" class="uploadBox btn mr20" onclick="return false;">
	                      上传<span id="uploadCont" class="uploadCont"> </span>
         </a>
         <a href="javascript:;" class="uploadBox btn mr20" onclick="editPicture();">编辑</a>
         <a href="javascript:;" class="uploadBox btn mr20" onclick="viewPicture();">查看</a>
         <br/><br/>
         <ul id="uploadInfoBox" class="commonUL">
	         <c:if test="${attachments!=null}"> 
	            <c:forEach items="${attachments}" var="attach">
	             
	                <li id="${attach.attachment_Url}">
	                  <span class="mr20">
	                                                         图片描述：<input type="text" name="picDesc" value="${attach.remark}">
	                  </span>
	                   <span class="mr20">
	                   <b class="fileName mr10" title="${attach.name}">${attach.name}</b>
                      </span>
 		               <span class="progressBox mr20">&nbsp;&nbsp;已上传！</span>
 		             <span class="uploadOperate">
 		               <a href='javascript:;'  file='${attach.attachment_Url}' class='delUploadFile'>删除</a>
 		             </span>
 		             <span>
	                  <input type ="hidden" name='newFileName' value="${attach.attachment_Url}">
 		              <input type="hidden" name='oraginalFileName' value="${attach.name}"/>
 		              </span>
	                </li>
	               
	                 
	            </c:forEach>
	         </c:if>
	      
         </ul>
          </li>
       </ul>
       
       <ul class="searchWrap">
         <li class="clearfix" style="margin:5px 20px 5px;">
           <div style="text-align:right;margin-bottom:5px;">
				<input type="submit" class="btn" value="确定" style="margin-right:20px;" />
		   </div>	 
          </li>
       </ul>
    </form>


<script>
  var cnt = 0;
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
	    
	    var $radiocheck = null;
	    var boxcheck1 = null;
	    var boxcheck2 = null;
	    $(".sound").on("click", function(){
	    	var $elm = $(this);
			if($elm.val() == 1){
				$elm.parent().find("span").show();
				
				if($radiocheck != null){
					$radiocheck.prop("checked","checked");
					$radiocheck.attr("checked","checked");
				}
				
				if($(boxcheck1) != null){
					$(boxcheck1).prop("checked","checked");
					$(boxcheck1).attr("checked","checked");
				}
				
				if($(boxcheck2) != null){
					$(boxcheck2).prop("checked","checked");
					$(boxcheck2).attr("checked","checked");
				}
				
				
				$elm.parent().find("span").find("input[type='text']").attr("name",$elm.parent().find("span").find("input[type='text']").attr("namedel"));
				$elm.parent().find("span").find("input[type='text']").removeAttr("namedel");
				
			}else{
				$elm.parent().find("span").hide();
				//单选框
				$radiocheck = $elm.parent().find("span").find("input[type='radio']:checked");
				$elm.parent().find("span").find("input[type='radio']").removeAttr("checked");
				
				//多选框
				boxcheck1 = $elm.parent().find("span").find("input[type='checkbox']:checked")[0];
				boxcheck2 = $elm.parent().find("span").find("input[type='checkbox']:checked")[1];
				$elm.parent().find("span").find("input[type='checkbox']:checked").removeAttr("checked");
				
				//文本框
				$elm.parent().find("span").find("input[type='text']").attr("namedel",$elm.parent().find("span").find("input[type='text']").attr("name"));
				$elm.parent().find("span").find("input[type='text']").removeAttr("name");
			}
	    	
	    });
	    
	    var $radio = null;
	    var txt = null;
	    $(".net").on("click", function(){
	    	var $elm = $(this);
			if($elm.val() == 1){
				$elm.parent().siblings().show();
				console.log($radio);
				if($radio != null){
					$radio.prop("checked","checked");
					$radio.attr("checked","checked");
				}
			  if(txt != null){
				txt.each(function(index){
		 	        	$(this).attr("name", $(txt[index]).attr("namedel"));
		 	        	
		 	    });
				txt.removeAttr("namedel");
			  }
			  
			  $elm.parent().siblings().find("textarea").attr("name", $elm.parent().siblings().find("textarea").attr("namedel"));
		      $elm.parent().siblings().find("textarea").removeAttr("namedel");
			}else{
				$elm.parent().siblings().hide();
				
				//单选框
				$radio = $elm.parent().siblings().find("input[type='radio']:checked");
				$elm.parent().siblings().find("input[type='radio']").removeAttr("checked");
				
				//文本框
				txt = $elm.parent().siblings().find("input[type='text']");
				txt.each(function(index){
					$(this).attr("namedel", $(txt[index]).attr("name"));
				});
				txt.removeAttr("name");
				$elm.parent().siblings().find("textarea").attr("namedel", $elm.parent().siblings().find("textarea").attr("name"));
				$elm.parent().siblings().find("textarea").removeAttr("name");
			} 
	    	
	    });
	    
	    
	    $(".netEquip").on("click", function(){
	    	var $elm = $(this);
	    	console.log($elm);
	    	if($elm.val() == 1){
	    		$elm.parent().find("span").show();
	    		
	    		if($(boxcheck1) != null){
					$(boxcheck1).prop("checked","checked");
					$(boxcheck1).attr("checked","checked");
				}
				
				if($(boxcheck2) != null){
					$(boxcheck2).prop("checked","checked");
					$(boxcheck2).attr("checked","checked");
				}
	    		
	    		$elm.parent().find("span").find("input[type='text']").attr("name",$elm.parent().find("span").find("input[type='text']").attr("namedel"));
				$elm.parent().find("span").find("input[type='text']").removeAttr("namedel");
	    	}else{
	    		$elm.parent().find("span").hide();
	    		
	    		//多选框
				boxcheck1 = $elm.parent().find("span").find("input[type='checkbox']:checked")[0];
				boxcheck2 = $elm.parent().find("span").find("input[type='checkbox']:checked")[1];
				$elm.parent().find("span").find("input[type='checkbox']:checked").removeAttr("checked");
				
				
				//文本框
				$elm.parent().find("input[type='text']").attr("namedel",$elm.parent().siblings().find("input[type='text']").attr("name"));
				$elm.parent().find("input[type='text']").removeAttr("name");
	    		
	    		
	    	}
	    });
	    
	
	        
	 
	    var dom = $(".load").parent().find("input[type='radio']:checked");
	    dom.each(function(index){
	        if($(dom[index]).val() == 1){
	        	$(dom[index]).parent().find("span").show();
	        }else{
	        	$(dom[index]).parent().find("span").hide();
	        }
	    });
	    
	    
	    var hide = $(".hide").parent().find("input[type='radio']:checked");
	    if(hide.val() == 1){
	    	$(".hide").show();
	    }else{
	    	$(".hide").hide();
	    }
	    
	    var neteq = $(".neteq").parent().find("input[type='radio']:checked");
	    if(neteq.val() == 1){
	    	$(".neteq").show();
	    }else{
	    	$(".neteq").hide();
	    }
	    
	    
	    var shownet = $(".shownet").parent().children().eq(0).find("input[type='radio']:checked");
	    if(shownet.val() == 1){
	    	$(".shownet").show();
	    }else{
	    	$(".shownet").hide();
	    }
	    
	    
	    var showserver = $(".showserver").parent().children().eq(0).find("input[type='radio']:checked");
	    if(showserver.val() == 1){
	    	$(".showserver").show();
	    }else{
	    	$(".showserver").hide();
	    }
	    
	    
	   //第三方厂家显示
	   var  factorydom = null;
	   if($(".factory").attr("value") == 1 && $(".factory").attr("checked") == 'checked'){
		   $(".factory").parent().siblings().show();
		   var li = $(".factory").parent().siblings().nextAll();
		   var length = li.length;
		   var listV = null;
		   var lineV = null;
		   li.each(function(index, elem){
			  listV = $($(li[length-index-1]).find("span").find("input")[0]).val();
			  lineV = $($(li[length-index-1]).find("span").find("input")[1]).val();
			  if (listV == '' && lineV == ''){
				  $(li[length-index-1]).hide();
			  }
			 
		   });
		   
	   }else{
		   $(".factory").parent().siblings().hide();
	  }
	    
	    
	    
	    $(".factory").on("click", function(){
	    	var $elm = $(this);
	    	if($elm.val() == 1){
	    		$("#factory1").show();
	    		
	  		  
	  		   var li = $(".factory").parent().siblings().nextAll();
	  		   var length = li.length;
			   var listV = null;
			   var lineV = null;
			   li.each(function(index, elem){
				  listV = $($(li[length-index-1]).find("span").find("input")[0]).val();
				  lineV = $($(li[length-index-1]).find("span").find("input")[1]).val();
				  if (listV == '' && lineV == ''){
					  $(li[length-index-1]).hide();
				  }else{
					  $(li[length-index-1]).show();
				  }
				 
			   });
			   if(factorydom != null){
		  		     factorydom.each(function(index){
		 	        	$(this).attr("name", $(factorydom[index]).attr("namedel"));
		 	        	
		 	         });
		  		   factorydom.removeAttr("namedel");
		  	   }
	  		
	    	}else{
	    		$("#factory1").hide();
	    		$("#factory2").hide();
	    		$("#factory3").hide();
	    		$("#factory4").hide();
	    		$("#factory5").hide();
	    		$("#factory6").hide();
	    	    //$(".factory").parent().siblings().find("input[type='text']").attr("namedel",  $(".factory").parent().siblings().find("input[type='text']").attr("name"));
	 		    //$(".factory").parent().siblings().find("input[type='text']").removeAttr("name");
	 	        factorydom = $(".factory").parent().siblings().find("input[type='text']");
	 	        factorydom.each(function(index){
	 	        	$(this).attr("namedel", $(factorydom[index]).attr("name"));
	 	        	
	 	        });
	 	       factorydom.removeAttr("name");
	    	}
	    });
	    
	    
	    $("#addFactory").on("click", function(){
	    	
	    	var fac = $("#factory1");
	    	var in1 = $(fac.find("input")[0]);
	    	var in2 = $(fac.find("input")[1]);
	    	while(true){
	    		if(in1.val() === '' || in2.val() === ''){
	    			Win.alert("请填全整信息再添加！");
	    			break;
	    		}
		    	if(fac.next().is(":hidden")){
		    		 //如果下一个是隐藏的
		    			fac.next().show();
		    			break;
		    	}else{
		    		if(fac.next().length == 0){
		    			console.log("最多支持6个厂家");
		    			Win.alert("最多支持6个厂家！");
		    			break;
		    		}
		    		
		    		fac = fac.next();
		    		in1 = $(fac.find("input")[0]);
			    	in2 = $(fac.find("input")[1]);
		    	}
	    	}
	    		    	  
	    });
	    
	  //删除厂家
	    $("#delFactory1").on("click", function(){
	        var fac = $(this).parent().parent();
	    	var in1 = $(fac.find("input")[0]);
	    	var in2 = $(fac.find("input")[1]);
	    	while(true){
	    	
	    	    if(fac.next().is(':hidden')){
					fac.hide();
					in1.val("");
					in2.val("");
					break;
	    		}else{
	    			
	    			in1.val($(fac.next().find("input")[0]).val());
		    		in2.val($(fac.next().find("input")[1]).val());
	    			
	    			fac = fac.next();
	    			in1 = $(fac.find("input")[0]);
			    	in2 = $(fac.find("input")[1]);
	    		}
	    	} 
	    	
	    });
	  
	  //删除厂家
	    $("#delFactory2").on("click", function(){
	        var fac = $(this).parent().parent();
	    	var in1 = $(fac.find("input")[0]);
	    	var in2 = $(fac.find("input")[1]);
	    	while(true){
	    	
	    	
	    	    if(fac.next().is(':hidden')){
					fac.hide();
					in1.val("");
					in2.val("");
					break;
	    		}else{
	    			
	    		
	    			in1.val($(fac.next().find("input")[0]).val());
		    		in2.val($(fac.next().find("input")[1]).val());
	    			
	    			fac = fac.next();
	    			in1 = $(fac.find("input")[0]);
			    	in2 = $(fac.find("input")[1]);
	    		}
	    	} 
	    	
	    });
	  
	  //删除厂家
	    $("#delFactory3").on("click", function(){
	        var fac = $(this).parent().parent();
	    	var in1 = $(fac.find("input")[0]);
	    	var in2 = $(fac.find("input")[1]);
	    	while(true){
	    		
	    	    if(fac.next().is(':hidden')){
					fac.hide();
					in1.val("");
					in2.val("");
					break;
	    		}else{
	    			
	    			
		    		in1.val($(fac.next().find("input")[0]).val());
			    	in2.val($(fac.next().find("input")[1]).val());
	    			
	    			fac = fac.next();
	    			in1 = $(fac.find("input")[0]);
			    	in2 = $(fac.find("input")[1]);
	    		}
	    	} 
	    	
	    });
	  
	  //删除厂家
	    $("#delFactory4").on("click", function(){
	        var fac = $(this).parent().parent();
	    	var in1 = $(fac.find("input")[0]);
	    	var in2 = $(fac.find("input")[1]);
	    	while(true){
	    		
	    	     if(fac.next().is(':visible') && $(fac.next().find("input")[0]).val() === '' && $(fac.next().find("input")[1]).val() === ''){
	    			fac.next().hide();
	    			break;
	    		}
	    		
	    	
	    	    if(fac.next().is(':hidden')){
					fac.hide();
					in1.val("");
					in2.val("");
					break;
	    		}else{
	    			
	    			in1.val($(fac.next().find("input")[0]).val());
		    		in2.val($(fac.next().find("input")[1]).val());
	    			
	    			fac = fac.next();
	    			in1 = $(fac.find("input")[0]);
			    	in2 = $(fac.find("input")[1]);
	    		}
	    	} 
	    	
	    });
	  //删除厂家
	    $("#delFactory5").on("click", function(){
	        var fac = $(this).parent().parent();
	    	var in1 = $(fac.find("input")[0]);
	    	var in2 = $(fac.find("input")[1]);
	    	while(true){
	    	
	    	
	    	    if(fac.next().is(':hidden')){
					fac.hide();
					in1.val("");
					in2.val("");
					break;
	    		}else{
	    			
	    	 		in1.val($(fac.next().find("input")[0]).val());
		    		in2.val($(fac.next().find("input")[1]).val());
	    			
	    			fac = fac.next();
	    			in1 = $(fac.find("input")[0]);
			    	in2 = $(fac.find("input")[1]);
	    		}
	    	} 
	    	
	    });
	  
  
   });
  
  
  
  
  
//获得上传的图片的原来的名字与新生成的名字
  var params = {
         debug : 1,
         fileType : "*.jpg;*.gif;*.png;*.jpeg;*.bmp;",
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
 		myProgressBox.innerHTML = "上传完成！<input type ='hidden' name='newFileName' class='newFileName' id='n"+elm+"' value="+JSON.parse(data).message+">";	
 		myUploadOperate.innerHTML = "<a href='javascript:;' file='"+elm+"' class='delUploadFile'>删除</a>";
 		
  	});
  	

  	events.delegate($id("uploadInfoBox"),".delUploadFile","click",function(){
  		//删除
  		var e = arguments[0] || window.event,
 			target = e.srcElement || e.target,
 			fileIndex = target.getAttribute("file"),
 			liElm = $id(fileIndex);
  		liElm.parentNode.removeChild(liElm);
  		 $("#number").html($("#uploadInfoBox").children().length);
  	});
                //显示上传的文件信息
  	uploadSwf.uploadEvent.add("onOpen",function(){
  		
  		
  		var elm = arguments[0].message[0],
  			info = arguments[0].message[1];
  		if($id(elm)) return false;
  		//$id("uploadInfoBox").innerHTML += "<li id='"+elm+"'><span class='mr20'>图片描述：<input type='text' name='picDesc'></span><span class='infoLabel'><b class='fileName mr10' title='"+info.name+"'>"+info.name+"</b></span><span class='progressBox mr20'><b class='progressBar mr10'><em class='progressRate'>&nbsp;</em></b>已上传<b class='uploaded'>0%</b></span><span class='uploadOperate'><a class='cancelUpload' href='javascript:;' file='"+elm+"'>取消上传</a></span><input type='hidden' name='oraginalFileName' value='"+info.name+"'/></li>";
  	    html="<li id='"+elm+"'><span class='mr20'>图片描述：<input type='text' name='picDesc' class='picDesc' id='p"+elm+"'></span><span class='mr20'><b class='fileName mr10' title='"+info.name+"'>"+info.name+"</b></span><span class='progressBox mr20'><b class='progressBar mr10'><em class='progressRate'>&nbsp;</em></b>已上传<b class='uploaded'>0%</b></span><span class='uploadOperate'><a class='cancelUpload' href='javascript:;' file='"+elm+"'>取消上传</a></span><input type='hidden' name='oraginalFileName' class='oraginalFileName' id='o"+elm+"' value='"+info.name+"'/></li>";
  	    $("#uploadInfoBox").append(html);
  	    $("#number").html($("#uploadInfoBox").children().length);
  	});

    if(window.frameElement)  var domid =frameElement.getAttribute("domid");
    var mySplit = parent.mySplit;
    
    var lock = false;
	new BasicCheck({
	    form: $id("editForm"),
	    ajaxReq : function(){
	    	if(!lock){
	    	lock = true;
		        $.post('${root}/admin/classroominspect/editenvironmentreport.do',$("#editForm").serialize(),function(r){
		            try {
		                if(!r.result){
		                	lock = false;
		                	Win.alert(r.message);
		                }else{
		                	 lock = false;
		                	 Win.alert('编辑成功!');
		                	 setTimeout("closeMe()",1000);
						     parent.splitPage.reload();
		                }
		            } catch(e) {
		                Win.alert("错误提示:"+e.message);
		            }
		        });
	    	}else{
	    		console.log("请勿重复提交");
	    	}
	    }
	});
	
	$("#cancel").click(function(){
	    parent.Win.wins[domid].close();
	});
	
	//关闭窗口
	function closeMe() {
		parent.Win.wins[domid].close();
	}
    
	$(document).on('click', '.isBlack', function (event) {
		var $elm = $(this);
		if($elm.val() == 1){
			$elm.parent().find("span").show();
			$elm.parent().find("span").find("input[type='text']").attr("name",$elm.parent().find("span").find("input[type='text']").attr("namedel"));
			$elm.parent().find("span").find("input[type='text']").removeAttr("namedel");
		}else{
			$elm.parent().find("span").hide();
			$elm.parent().find("span").find("input[type='text']").attr("namedel",$elm.parent().find("span").find("input[type='text']").attr("name"));
			$elm.parent().find("span").find("input[type='text']").removeAttr("name");
		}
	});
</script>



</body>
</html>