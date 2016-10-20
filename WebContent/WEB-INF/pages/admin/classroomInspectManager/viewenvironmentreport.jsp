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
     <script type="text/javascript" src="${root }/public/js/customer.js"></script>
     <link href="${root}/public/css/reset.css" rel="stylesheet" type="text/css" media="all">
    <style>
    	.labelTextEdit {
			width: 170px;
		    display: inline-block;
		    min-width: 80px;
		    text-align: right;
		}
		
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
		
		.showfatory{
		   display:none;
		
		}
		
		
	</style>
</head>
<body class="chase-ask">
<h1 style="text-align: center">在线课堂实施环境调查表</h1>
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
					${eSurvey.schoolContact}
				
				</span>
			<label class="labelText">联系电话：</label>
				<span>
					${eSurvey.schoolContactPhone}
				</span>
		</li>
		<li class="clearfix" style="margin:5px 0 15px;">
		    <label class="labelText" style="margin-left:12px;">现场商务：</label>
				<span>
					${eSurvey.businessContact}
				</span>
					<label class="labelText">联系电话：</label>
				<span>
					${eSurvey.businessContactPhone}
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
					${eSurvey.classroomLength}（米）
				</span>&nbsp;&nbsp;
				宽 &nbsp;<span>
					${eSurvey.classroomWidth}（米）
				</span>&nbsp;&nbsp;
				高 &nbsp;<span>
					${eSurvey.classroomHeight}（米）
				</span>
				其他&nbsp;<span>
					${eSurvey.classroomElse}
				</span>
        </li>
         <li class="clearfix" style="margin:5px 0px 5px;">
			 <span style="margin-left:20px;">
			  <c:choose>
			   <c:when test="${eSurvey.classroomIsVoltage==null}">
			       <input type="radio" name="classroomIsVoltage" value="1" disabled="disabled">有 &nbsp;
			       <input type="radio" name="classroomIsVoltage" value="0" disabled="disabled">无  &nbsp;  220V强电接入
			     
			   </c:when>
			   <c:otherwise>
			      <c:if test="${eSurvey.classroomIsVoltage eq 1}">
			         <input type="radio" name="classroomIsVoltage" value="1" checked disabled="disabled">有 &nbsp;
			         <input type="radio" name="classroomIsVoltage" value="0" disabled="disabled">无  &nbsp;  220V强电接入
			      </c:if>
			      <c:if test="${eSurvey.classroomIsVoltage eq 0}">
			         <input type="radio" name="classroomIsVoltage" value="1" disabled="disabled">有 &nbsp;
			         <input type="radio" name="classroomIsVoltage" value="0" checked disabled="disabled">无  &nbsp;  220V强电接入
			      </c:if>
			   </c:otherwise>
			 </c:choose>
			 </span>
			 <span style="margin-left:80px;">
			   <c:choose>
			   <c:when test="${eSurvey.classroomIsPrower==null}">
			       <input type="radio" name="classroomIsPrower" value="1" disabled="disabled">有 &nbsp;
			       <input type="radio" name="classroomIsPrower" value="0" disabled="disabled">无  &nbsp;  各个点位有无电源接入
			   </c:when>
			   <c:otherwise>
			       
			     <c:if test="${eSurvey.classroomIsPrower eq 1}">
			       <input type="radio" name="classroomIsPrower" value="1" checked disabled="disabled">有 &nbsp;
			       <input type="radio" name="classroomIsPrower" value="0" disabled="disabled">无  &nbsp;  各个点位有无电源接入
			     </c:if>
			      <c:if test="${eSurvey.classroomIsPrower eq 0}">
			       <input type="radio" name="classroomIsPrower" value="1" disabled="disabled">有 &nbsp;
			       <input type="radio" name="classroomIsPrower" value="0" checked disabled="disabled">无  &nbsp;  各个点位有无电源接入
			     </c:if>
			   </c:otherwise>
			 </c:choose>
			</span>
			<span  style="margin-left:40px;">
			 <c:choose>
			   <c:when test="${eSurvey.classroomIsLight==null}">
			         
			      <input type="radio" name="classroomIsLight" value="1" disabled="disabled">是 &nbsp;
			      <input type="radio" name="classroomIsLight" value="0" disabled="disabled">否  &nbsp;  室内光线是否充足
			   </c:when>
			   <c:otherwise>
			        <c:if test="${eSurvey.classroomIsLight eq 1}">
			          <input type="radio" name="classroomIsLight" value="1" checked disabled="disabled">是 &nbsp;
			          <input type="radio" name="classroomIsLight" value="0" disabled="disabled">否  &nbsp;  室内光线是否充足
			        </c:if>
			         <c:if test="${eSurvey.classroomIsLight eq 0}">
			          <input type="radio" name="classroomIsLight" value="1" disabled="disabled">是 &nbsp;
			          <input type="radio" name="classroomIsLight" value="0" checked disabled="disabled">否  &nbsp;  室内光线是否充足
			        </c:if>
			   </c:otherwise>
			 </c:choose>
			  
			</span>
		</li>
	    <li class="clearfix" style="margin:5px 0px 0px;">
			<span style="margin-left:20px;">
			  <c:choose>
			   <c:when test="${eSurvey.classroomIsCurtain==null}">
			        
			    <input type="radio" name="classroomIsCurtain" value="1" disabled="disabled">有 &nbsp;
			    <input type="radio" name="classroomIsCurtain" value="0" disabled="disabled">无  &nbsp;  窗帘
			    
			   </c:when>
			   <c:otherwise>
			       <c:if test="${eSurvey.classroomIsCurtain eq 1}">
			          <input type="radio" name="classroomIsCurtain" value="1" checked disabled="disabled">有 &nbsp;
			          <input type="radio" name="classroomIsCurtain" value="0" disabled="disabled">无  &nbsp;  窗帘
			       </c:if>
			       <c:if test="${eSurvey.classroomIsCurtain eq 0}">
			          <input type="radio" name="classroomIsCurtain" value="1" disabled="disabled">有 &nbsp;
			          <input type="radio" name="classroomIsCurtain" value="0" checked disabled="disabled">无  &nbsp;  窗帘
			       </c:if>
			       
			   </c:otherwise>
			 </c:choose>
			
			</span>
			<span style="margin-left:133px;">
			    <c:choose>
			   <c:when test="${eSurvey.classroomIsAirCondition==null}">
			     <input type="radio" name="classroomIsAirCondition" value="1" disabled="disabled">有 &nbsp;
			     <input type="radio" name="classroomIsAirCondition" value="0" disabled="disabled">无  &nbsp;  空调
			  
			   </c:when>
			   <c:otherwise>
			       <c:if test="${eSurvey.classroomIsAirCondition eq 1}">
			         <input type="radio" name="classroomIsAirCondition" value="1" checked disabled="disabled">有 &nbsp;
			         <input type="radio" name="classroomIsAirCondition" value="0" disabled="disabled">无  &nbsp;  空调
			       </c:if>
			       <c:if test="${eSurvey.classroomIsAirCondition eq 0}">
			         <input type="radio" name="classroomIsAirCondition" value="1" disabled="disabled">有 &nbsp;
			         <input type="radio" name="classroomIsAirCondition" value="0" checked disabled="disabled">无  &nbsp;  空调
			       </c:if>
			   </c:otherwise>
			 </c:choose>
			  
			</span>
			<span style="margin-left:136px;">
			  <c:choose>
			   <c:when test="${eSurvey.classroomIsCondoletop==null}">
			     <input type="radio" name="classroomIsCondoletop" value="1" disabled="disabled">有 &nbsp;
			     <input type="radio" name="classroomIsCondoletop" value="0" disabled="disabled">无  &nbsp;  吊顶
			 
			   </c:when>
			   <c:otherwise>
			       <c:if test="${eSurvey.classroomIsCondoletop eq 1}">
			         <input type="radio" name="classroomIsCondoletop" value="1" checked disabled="disabled">有 &nbsp;
			         <input type="radio" name="classroomIsCondoletop" value="0" disabled="disabled">无  &nbsp;  吊顶
			 
			       </c:if>
			        <c:if test="${eSurvey.classroomIsCondoletop eq 0}">
			         <input type="radio" name="classroomIsCondoletop" value="1" disabled="disabled">有 &nbsp;
			         <input type="radio" name="classroomIsCondoletop" value="0" checked  disabled="disabled">无  &nbsp;  吊顶
			 
			       </c:if>
			   </c:otherwise>
			 </c:choose> 
			
			 
			</span>
			
        </li>
         <li class="clearfix" style="margin:5px 0px 15px;">
			<span style="margin-left:25px;float:left;">
			    备注：
			
			        ${eSurvey.classroomRemark}
			  
			</span>
			
			
        </li>
      </ul>
      <ul class="searchWrap">
         <li class="clearfix" style="margin:5px 20px 5px;">
           <label class="labelText" style="font-weight:900;">现场设备情况：</label>
         </li>
         <li class="clearfix" style="margin:5px 20px 5px;">
		  <c:choose>
			   <c:when test="${eSurvey.equipmentIsBalckboard==null}">
			    <span>
			        <input type="radio" name="equipmentIsBalckboard" value="1" class="isBlack" disabled="disabled">有 &nbsp;
		            <input type="radio" name="equipmentIsBalckboard" value="0" class="isBlack" disabled="disabled">无  &nbsp;&nbsp;
			        <label class="text">黑板</label>
			        <span style="margin-left:10px;">
                       <span>${eSurvey.equipmentBackboard}</span>
			         </span>
			    </span>
			   </c:when>
			   <c:otherwise>
			     
			       <span>
			        <input type="radio" name="equipmentIsBalckboard" value="1" class="isBlack" <c:if test="${eSurvey.equipmentIsBalckboard eq 1}">checked="checked"</c:if> disabled="disabled">有 &nbsp;
		            <input type="radio" name="equipmentIsBalckboard" value="0" class="isBlack" <c:if test="${eSurvey.equipmentIsBalckboard eq 0}">checked="checked"</c:if> disabled="disabled">无  &nbsp;&nbsp;
			        <label class="text">黑板</label>
			        <span style="margin-left:10px;">
                       <span>${eSurvey.equipmentBackboard}</span>
			         </span>
			       </span>
			    
			    
              </c:otherwise>
			 </c:choose> 
			   
			<c:choose>
			   <c:when test="${eSurvey.equipmentIsProjector==null}">
			    <span style="margin-left:100px;">
			      <input type="radio" name="equipmentIsProjector" value="1" class="isBlack" disabled="disabled">有&nbsp;
         	      <input type="radio" name="equipmentIsProjector" value="0" class="isBlack" disabled="disabled">无&nbsp;&nbsp;
			      <label class="text">投影仪</label>
			      <span style="margin-left:10px;">
				     <span>${eSurvey.equipmentProjector}</span> 
				  </span>
			    </span>
			   </c:when>
			   <c:otherwise>
			      <span style="margin-left:100px;">
                   <input type="radio" name="equipmentIsProjector" value="1" class="isBlack" <c:if test="${eSurvey.equipmentIsProjector eq 1}">checked="checked"</c:if> disabled="disabled">有&nbsp;
         	       <input type="radio" name="equipmentIsProjector" value="0" class="isBlack" <c:if test="${eSurvey.equipmentIsProjector eq 0}">checked="checked"</c:if> disabled="disabled">无&nbsp;&nbsp;
			       <label class="text">投影仪</label>
			       <span style="margin-left:10px;">
				   <span>${eSurvey.equipmentProjector}</span>
				   </span>
				  </span>
			   </c:otherwise>
			 </c:choose>
		     <c:choose>
			   <c:when test="${eSurvey.equipmentIsPlatform==null}">
			    <span style="margin-left:100px;">
			     <input type="radio" name="equipmentIsPlatform" value="1" class="isBlack" disabled="disabled">有&nbsp;
         	     <input type="radio" name="equipmentIsPlatform" value="0" class="isBlack" disabled="disabled">无&nbsp;&nbsp;
		         <label class="text">多媒体讲台</label>
		          <span style="margin-left:10px;">
					<span>${eSurvey.equipmentPlatform }</span> 
				  </span> 
		        </span>
			   </c:when>
			   <c:otherwise>
			   <span style="margin-left:100px;">
                 <input type="radio" name="equipmentIsPlatform" value="1" class="isBlack" <c:if test="${eSurvey.equipmentIsPlatform eq 1}">checked="checked"</c:if> disabled="disabled">有&nbsp;
         	     <input type="radio" name="equipmentIsPlatform" value="0" class="isBlack" <c:if test="${eSurvey.equipmentIsPlatform eq 0}">checked="checked"</c:if> disabled="disabled">无&nbsp;&nbsp;
		         <label class="text">多媒体讲台</label> 
		        <span style="margin-left:10px;">
					<span>${eSurvey.equipmentPlatform }</span>  
				</span> 
				</span>
			   </c:otherwise>
			 </c:choose>
        </li>
        <li class="clearfix" style="margin:5px 20px 5px;">
		  
			 
			  <c:choose>
			   <c:when test="${eSurvey.equipmentIsControl==null}">
			     <span>
			     <input type="radio" name="equipmentIsControl" value="1" class="isBlack" disabled="disabled">有&nbsp;&nbsp;
         	     <input type="radio" name="equipmentIsControl" value="0" class="isBlack" disabled="disabled">无&nbsp;&nbsp;
                 <label class="text" style="margin-left:4px;">中控</label>
                   <span style="margin-left:10px;">
					<span>${eSurvey.equipmentControl}</span>  
				   </span>
                 </span>
			   </c:when>
			   <c:otherwise>
                   <span>
                   <input type="radio" name="equipmentIsControl" value="1" class="isBlack" disabled="disabled" <c:if test="${eSurvey.equipmentIsControl eq 1}">checked="checked"</c:if>>有&nbsp;&nbsp;
         	       <input type="radio" name="equipmentIsControl" value="0" class="isBlack" disabled="disabled" <c:if test="${eSurvey.equipmentIsControl eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
                   <label class="text" style="margin-left:4px;">中控</label>
                   <span style="margin-left:10px;">
					<span>${eSurvey.equipmentControl}</span> 
				   </span>
                   </span>
			   </c:otherwise>
			 </c:choose>
			  <c:choose>
			   <c:when test="${eSurvey.equipmentIsWhiteboard==null}">
			   <span style="margin-left:100px;">
			      <input type="radio" name="equipmentIsWhiteboard" value="1" class="isBlack" disabled="disabled">有&nbsp;
         	      <input type="radio" name="equipmentIsWhiteboard" value="0" class="isBlack" disabled="disabled">无&nbsp;&nbsp;
			      <label class="text" style="margin-left:2px;">电子白板</label>
			       <span style="margin-left:10px;">
					<span>${eSurvey.equipmentWhiteboard }</span> 
				  </span>
			   </span>
			   </c:when>
			   <c:otherwise>
                   <span style="margin-left:100px;">
                     <input type="radio" name="equipmentIsWhiteboard" value="1" class="isBlack" disabled="disabled" <c:if test="${eSurvey.equipmentIsWhiteboard eq 1}">checked="checked"</c:if>>有&nbsp;
         	         <input type="radio" name="equipmentIsWhiteboard" value="0" class="isBlack" disabled="disabled" <c:if test="${eSurvey.equipmentIsWhiteboard eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
			        <label class="text" style="margin-left:2px;">电子白板</label>
			       <span style="margin-left:10px;">
					<span>${eSurvey.equipmentWhiteboard }</span>
				  </span>
                   </span>
			   </c:otherwise>
			 </c:choose> 
		    <c:choose>
			   <c:when test="${eSurvey.equipmentIsTv==null}">
			     <span style="margin-left:100px;">
		         <input type="radio" name="equipmentIsTv" value="1" class="isBlack"  disabled="disabled">有&nbsp;
         	     <input type="radio" name="equipmentIsTv" value="0" class="isBlack"  disabled="disabled">无&nbsp;&nbsp;
                 <label class="text">液晶电视</label>
                 <span style="margin-left:10px;">
					<span>${eSurvey.equipementTv}</span>  
				  </span>
                 </span>
			   </c:when>
			   <c:otherwise>
			    <span style="margin-left:100px;">
                 <input type="radio" name="equipmentIsTv" value="1" class="isBlack"  disabled="disabled" <c:if test="${eSurvey.equipmentIsTv eq 1}">checked="checked"</c:if>>有&nbsp;
         	     <input type="radio" name="equipmentIsTv" value="0" class="isBlack"  disabled="disabled" <c:if test="${eSurvey.equipmentIsTv eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
                 <label class="text">液晶电视</label>
                  <span style="margin-left:10px;">
					<span>${eSurvey.equipementTv}</span> 
				  </span>
                 </span>
			   </c:otherwise>
			 </c:choose>
			       
        </li>
         <li class="clearfix" style="margin:5px 20px 5px;">
		    <c:choose>
			   <c:when test="${eSurvey.equipmentIsBanbantong==null}">
			   <span>
			      <input type="radio" name="equipmentIsBanbantong" value="1" class="isBlack" disabled="disabled">有&nbsp;
                  <input type="radio" name="equipmentIsBanbantong" value="0" class="isBlack" disabled="disabled">无&nbsp;&nbsp;
		          <label class="text">班班通</label>
		           <span style="margin-left:5px;">
					<span>${eSurvey.equipmentBanbantong}</span> 
				  </span>
		       </span>
			   </c:when>
			   <c:otherwise>
			   <span>
                  <input type="radio" name="equipmentIsBanbantong" value="1" class="isBlack" disabled="disabled" <c:if test="${eSurvey.equipmentIsBanbantong eq 1}">checked="checked"</c:if>>有&nbsp;
                  <input type="radio" name="equipmentIsBanbantong" value="0" class="isBlack" disabled="disabled" <c:if test="${eSurvey.equipmentIsBanbantong eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
		          <label class="text">班班通</label>
		          <span style="margin-left:5px;">
					<span>${eSurvey.equipmentBanbantong}</span>
				  </span>
				</span>    
			   </c:otherwise>
			 </c:choose>
			 <c:choose>
			    <c:when test="${eSurvey.equipmentIsTeachercamera==null}">
			    <span style="margin-left:100px;">
			       <input type="radio" name="equipmentIsTeachercamera" value="1" class="isBlack" disabled="disabled">有&nbsp;
                   <input type="radio" name="equipmentIsTeachercamera" value="0" class="isBlack" disabled="disabled">无&nbsp;&nbsp;
			       <label class="text">老师摄像机</label>
			       <span style="margin-left:5px;">
					 <span>${eSurvey.equipmentTeachcamera}</span> 
				   </span>
			   </span>
			   </c:when>
			   <c:otherwise>
			   <span style="margin-left:100px;">
                 <input type="radio" name="equipmentIsTeachercamera" value="1" class="isBlack" disabled="disabled" <c:if test="${eSurvey.equipmentIsTeachercamera eq 1}">checked="checked"</c:if>>有&nbsp;
                 <input type="radio" name="equipmentIsTeachercamera" value="0" class="isBlack" disabled="disabled" <c:if test="${eSurvey.equipmentIsTeachercamera eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
			     <label class="text">老师摄像机</label>
			     <span style="margin-left:5px;">
					<span>${eSurvey.equipmentTeachcamera}</span>
				</span>
				</span>
			   </c:otherwise>
			 </c:choose>
		     <c:choose>
			       <c:when test="${eSurvey.equipmentIsStudentcamera==null}">
			       <span style="margin-left:100px;">
			         <input type="radio" name="equipmentIsStudentcamera" value="1" class="isBlack" disabled="disabled">有&nbsp;&nbsp;
                     <input type="radio" name="equipmentIsStudentcamera" value="0" class="isBlack" disabled="disabled">无&nbsp;&nbsp;
			 
		             <label class="text">学生摄像机</label>
		              <span style="margin-left:5px;">
					      <span>${eSurvey.equipmentStudentcamera}</span>
				       </span>
		             </span>
			       </c:when>
			       <c:otherwise>
			        <span style="margin-left:100px;">
                      <input type="radio" name="equipmentIsStudentcamera" value="1" class="isBlack" disabled="disabled" <c:if test="${eSurvey.equipmentIsStudentcamera eq 1}">checked="checked"</c:if>>有&nbsp;&nbsp;
                      <input type="radio" name="equipmentIsStudentcamera" value="0" class="isBlack" disabled="disabled" <c:if test="${eSurvey.equipmentIsStudentcamera eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
			     
		             <label class="text">学生摄像机</label>
		               <span style="margin-left:5px;">
					       <span>${eSurvey.equipmentStudentcamera}</span> 
				       </span>
		             </span>
			       </c:otherwise>
			 </c:choose>	
        </li>
        <li class="clearfix" style="margin:5px 20px 5px;">
		   <c:choose>
			   <c:when test="${eSurvey.equipmentIsMicr==null}">
			    <span>
			     <input type="radio" name="equipmentIsMicr" value="1" class="isBlack" disabled="disabled">有&nbsp;&nbsp;
                 <input type="radio" name="equipmentIsMicr" value="0" class="isBlack" disabled="disabled">无&nbsp;&nbsp;
			                 麦克风、拾音器
			     <span style="margin-left:20px;">
					<span>${eSurvey.equipmentMicr}</span> 
				 </span>
			    </span>
			   </c:when>
			   <c:otherwise>
                  <span>
                    <input type="radio" name="equipmentIsMicr" value="1" class="isBlack" disabled="disabled" <c:if test="${eSurvey.equipmentIsMicr eq 1}">checked="checked"</c:if>>有&nbsp;&nbsp;
                    <input type="radio" name="equipmentIsMicr" value="0" class="isBlack" disabled="disabled" <c:if test="${eSurvey.equipmentIsMicr eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
			                      麦克风、拾音器
			       <span style="margin-left:20px;">
					<span>${eSurvey.equipmentMicr}</span>  
				    </span>
                  </span>
			   </c:otherwise>
			 </c:choose>
				 <c:choose>
			   <c:when test="${eSurvey.equipIsSound==null}">
			   <span style="margin-left:200px;">
			    <input type="radio" name="equipIsSound" value="1" class="sound" disabled="disabled">有&nbsp;&nbsp;
                <input type="radio" name="equipIsSound" value="0" class="sound" disabled="disabled">无&nbsp;&nbsp;
			    <label class="text">音响</label>
			    <span style="margin-left:20px;" class="load">
			     	 <input type="radio"  name="equipmentIsSound" id="equipment_music_on" value="1" disabled="disabled"/>
			          <label class="text">有源</label>
			          <input type="radio" name="equipmentIsSound"  id="equipment_music_no" value="0" disabled="disabled"/> 
					  <label class="text"> 无源 </label>
			    </span>
			   </span>
			   </c:when>
			   <c:otherwise>
			    <span style="margin-left:200px;">
			          <input type="radio" name="equipIsSound" value="1" class="sound" disabled="disabled" <c:if test="${eSurvey.equipIsSound eq 1}">checked="checked"</c:if>>有&nbsp;&nbsp;
                      <input type="radio" name="equipIsSound" value="0" class="sound" disabled="disabled" <c:if test="${eSurvey.equipIsSound eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
			          <label class="text">音响</label>
			        
			          <c:choose>
			            
			           <c:when test="${eSurvey.equipmentIsSound == null}">
			            <span style="margin-left:20px;" class="load">
			             <input type="radio"  name="equipmentIsSound" id="equipment_music_on" value="1" disabled="disabled"/>
			                <label class="text">有源</label>
			         
					     <input type="radio" name="equipmentIsSound"  id="equipment_music_no" value="0" disabled="disabled"/> 
					        <label class="text"> 无源 </label>
					    </span>
				       </c:when>
				     
				     <c:otherwise>
			            <span style="margin-left:20px;" class="load">
			               <input type="radio"  name="equipmentIsSound" id="equipment_music_on" value="1" disabled="disabled" <c:if test="${eSurvey.equipmentIsSound eq 1}">checked="checked"</c:if>/>
			               <label class="text">有源</label>
			               <input type="radio" name="equipmentIsSound"  id="equipment_music_no" value="0" disabled="disabled" <c:if test="${eSurvey.equipmentIsSound eq 0}">checked="checked"</c:if>/> 
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
			       <input type="radio" name="equipmentIsShowplat" value="1" class="isBlack" disabled="disabled">有&nbsp;&nbsp;
                   <input type="radio" name="equipmentIsShowplat" value="0" class="isBlack" disabled="disabled">无&nbsp;&nbsp;      
			                   实物展台
			       <span style="margin-left:20px;">
					 <span>${eSurvey.equipShowPlat}</span> 
				   </span>
			      </span>
			     </c:when>
			     <c:otherwise>
                  <span> 
                     <input type="radio" name="equipmentIsShowplat" value="1" class="isBlack" disabled="disabled" <c:if test="${eSurvey.equipmentIsShowplat eq 1}">checked="checked"</c:if>>有&nbsp;&nbsp;
                     <input type="radio" name="equipmentIsShowplat" value="0" class="isBlack" disabled="disabled" <c:if test="${eSurvey.equipmentIsShowplat eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;      
			                        实物展台
                     <span style="margin-left:20px;">
					   <span>${eSurvey.equipShowPlat}</span>  
				     </span>
                  </span>
			      </c:otherwise>
			   </c:choose>
			   
       
        
              <c:choose>
			     <c:when test="${eSurvey.equipNetEquip==null}">
			      <span style="margin-left:200px;">
		           <input type="radio" name="equipNetEquip" value="1" class="sound" disabled="disabled">有&nbsp;&nbsp;
                   <input type="radio" name="equipNetEquip" value="0" class="sound" disabled="disabled">无&nbsp;&nbsp;      
			  
		           <label class="text">网络设备：</label>
		           <span style="margin-left:20px;" class="hide load">
		            <input type="checkbox" name="equipmentIsRouter" value="1" disabled="disabled">
		                                         路由器
		            <input type="checkbox" name="equipmentIsSwtich"  value="1" disabled="disabled"/>
		                                        交换机
		             <span>${eSurvey.equipmentNetwork }</span>
		           </span>
		          </span>
			   </c:when>
			   <c:otherwise>
			   <span style="margin-left:222px;">
                   <input type="radio" name="equipNetEquip" value="1" class="sound" disabled="disabled"  <c:if test="${eSurvey.equipNetEquip eq 1}">checked="checked"</c:if>>有&nbsp;&nbsp;
                   <input type="radio" name="equipNetEquip" value="0" class="sound" disabled="disabled"  <c:if test="${eSurvey.equipNetEquip eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;      
		           <label class="text">网络设备：</label>
		           <span style="margin-left:20px;" class="hide load">
		             <c:if test="${eSurvey.equipmentIsRouter==null}">
		               <input type="checkbox" name="equipmentIsRouter" value="1" disabled="disabled">          
		             </c:if>
		             <c:if test="${eSurvey.equipmentIsRouter != null}">
		              <input type="checkbox" name="equipmentIsRouter" checked="checked" value="1" disabled="disabled">
		                                                路由器
		             </c:if>
		           
		             <c:if test="${eSurvey.equipmentIsSwtich==null}">
		               <input type="checkbox" name="equipmentIsSwtich"  value="1" disabled="disabled"/>          
		             </c:if>
		             <c:if test="${eSurvey.equipmentIsSwtich != null}">
		               <input type="checkbox" name="equipmentIsSwtich" value="1" checked="checked" disabled="disabled"/>
		             </c:if>
		                                              交换机
		             <span>${eSurvey.equipmentNetwork }</span>
		          </span>
		        </span>
			   </c:otherwise>
			  
			   </c:choose>
			      
        </li>
        <li class="clearfix" style="margin:5px 0px 15px;">
			<span style="margin-left:25px;float:left;">
			    备注：
			${eSurvey.equipmentRemark}
			</span>
					
		
        </li>
      </ul>
      
     <ul class="searchWrap">
     <li class="clearfix" style="margin:5px 20px 5px;">
      <c:choose>
      <c:when test="${eSurvey.equipIsNet==null}">
     
          <input type="radio" name="equipIsNet" value="1" class="net" disabled="disabled">有&nbsp;&nbsp;
          <input type="radio" name="equipIsNet" value="0" class="net" disabled="disabled">无&nbsp;&nbsp;      
		  <label class="text" style="font-weight:900;">网络情况：</label>       
	  
	  </c:when>
	  <c:otherwise>
	      <input type="radio" name="equipIsNet" value="1" class="net" disabled="disabled" <c:if test="${eSurvey.equipIsNet eq 1}">checked="checked"</c:if>>有&nbsp;&nbsp;
          <input type="radio" name="equipIsNet" value="0" class="net" disabled="disabled" <c:if test="${eSurvey.equipIsNet eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;      
		  <label class="text" style="font-weight:900;">网络情况：</label> 
	  
	  </c:otherwise>
      </c:choose>
      </li>
         <li class="clearfix shownet" style="margin:5px 0 5px 32px;">
		   <label class="labelText">运营商及宽带：</label>
				<span style="margin-left:10px;">
					<span>${eSurvey.networkBoardband }</span> 
				</span>
		   <label class="labelText">网络环境：</label>
		         <c:choose>
			   <c:when test="${eSurvey.networkIsEnvir==null}">
			      <span style="margin-left:10px;">
					<input type="radio"  name="networkIsEnvir" id="network_share_all" value="1" disabled="disabled"/>
					共享 
				</span>
				<span style="margin-left:10px;">
					<input type="radio"  name="networkIsEnvir" id="network_share_only" value="0" disabled="disabled"/> 
					独享
				</span>
			   </c:when>
			   <c:otherwise>
			     <c:choose>
			       <c:when test="${eSurvey.networkIsEnvir eq 1}">
			         <span style="margin-left:10px;">
					<input type="radio"  name="networkIsEnvir" id="network_share_all" value="1" checked="checked" disabled="disabled"/>
					共享 
				   </span>
				 <span style="margin-left:10px;">
					<input type="radio"  name="networkIsEnvir" id="network_share_only" value="0" disabled="disabled"/> 
					独享
				  </span>
			       </c:when>
			       <c:otherwise>
			        <span style="margin-left:10px;">
					<input type="radio"  name="networkIsEnvir" id="network_share_all" value="1" disabled="disabled"/>
					共享 
				   </span>
				 <span style="margin-left:10px;">
					<input type="radio"  name="networkIsEnvir" id="network_share_only" value="0" checked="checked" disabled="disabled"/> 
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
				<span>${eSurvey.networkTestUpload }</span>（KB）
				  </span>
				<span class="mr20">
			   下载&nbsp;&nbsp;
					<span>${eSurvey.networkTestDownload }</span>（KB） 
				</span>
			
		</li>
        <li class="clearfix shownet" style="margin:5px 35px 5px;">
		   <label class="labelText">163镜像测试：</label>
			    <span class="mr20">
	                                           上传
                &nbsp;&nbsp;
					<span>${eSurvey.networkTestMirrorUpload }</span>（KB） 
				</span>
				<span class="mr20">
			下载&nbsp;&nbsp;
					<span>${eSurvey.networkTestMirrorDownload }</span>（KB） 
				</span>
		
		</li>		
        <li class="clearfix shownet" style="margin:5px 25px 5px;">
				 <label class="labelText">FTP服务器测试：</label>
			    <span class="mr20">
	                       上传
          &nbsp;&nbsp;
					<span>${eSurvey.networkTestFtpUpload }</span>（KB） 
				</span>
				<span class="mr20">
			下载&nbsp;&nbsp;
					<span>${eSurvey.networkTestFtpDownload }</span>（KB） 
				</span>
			
        </li>
         <li class="clearfix shownet" style="margin:5px 0px 15px;">
			<span style="margin-left:25px;float:left;">
			    备注：${eSurvey.networkRemark}
			</span>
        </li>
      </ul>
      <ul class="searchWrap">
         <li class="clearfix" style="margin:5px 20px 5px;">
         <c:choose>
           <c:when test="${eSurvey.serverIsExist == null}">
           	  <input type="radio" name="serverIsExist" value="1" class="net" disabled="disabled">有&nbsp;&nbsp;
              <input type="radio" name="serverIsExist" value="0" class="net" disabled="disabled">无&nbsp;&nbsp;      
		  
		      <label class="text" style="font-weight:900;">客户服务器状况：</label>
           </c:when>
           <c:otherwise>
              <input type="radio" name="serverIsExist" value="1" class="net" disabled="disabled" <c:if test="${eSurvey.serverIsExist eq 1}">checked="checked"</c:if>>有&nbsp;&nbsp;
              <input type="radio" name="serverIsExist" value="0" class="net" disabled="disabled" <c:if test="${eSurvey.serverIsExist eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;      
		      <label class="text" style="font-weight:900;">客户服务器状况：</label>
           </c:otherwise>
         
         </c:choose>
         
         </li>
         <li class="clearfix showserver" style="margin:5px 20px 5px;">
		  
		   <label class="labelText">内存大小：</label>
			    <span style="margin-left:10px;">
					<span>${eSurvey.serverMemory }</span>（G）
				</span>
        </li>
        <li class="clearfix showserver" style="margin:5px 20px 5px;">
		   <label class="labelText">服务器型号：</label>
				<span style="margin-left:20px;">
					<span>${eSurvey.serverTypeno }</span>
				</span>
			 <label class="labelText">硬盘大小：</label>
				<span style="margin-left:20px;">
					<span>${eSurvey.serverHarddisk }</span>（G）
				</span>
		</li>
        <li class="clearfix showserver" style="margin:5px 20px 5px;">
		   <label class="labelText">处理器配置：</label>
			    <span style="margin-left:20px;">
					<span>${eSurvey.serverCpu }</span>
				</span>
	       <label class="labelText">操作系统：</label>
			    <span style="margin-left:20px;">
					<span>${eSurvey.serverOs }</span> 
				</span>
		</li>		
         <li class="clearfix showserver" style="margin:5px 0px 15px;">
			<span style="margin-left:25px;float:left;">
			    备注： ${eSurvey.serverRemark}
			</span>
			
			
        </li>
        
      </ul>
      
      <ul class="searchWrap">
         <li class="clearfix" style="margin:5px 20px 5px;">
            <c:choose>
          <c:when test="${eSurvey.equipIsFactory==null}">
          	<input type="radio" name="equipIsFactory" value="1" class="factory" disabled="disabled">有&nbsp;&nbsp;
            <input type="radio" name="equipIsFactory" value="0" class="factory" disabled="disabled">无&nbsp;&nbsp;      
           <label class="text" style="font-weight:900;">第三方厂家接入情况：</label>
          </c:when>
          <c:otherwise>
            <input type="radio" name="equipIsFactory" value="1" class="factory" disabled="disabled" <c:if test="${eSurvey.equipIsFactory eq 1}">checked="checked"</c:if>>有&nbsp;&nbsp;
            <input type="radio" name="equipIsFactory" value="0" class="factory" disabled="disabled" <c:if test="${eSurvey.equipIsFactory eq 0}">checked="checked"</c:if>>无&nbsp;&nbsp;
            <label class="text" style="font-weight:900;">第三方厂家接入情况：</label>
          </c:otherwise>
         </c:choose>
         </li>
         <li class="clearfix showfatory" style="margin:5px 20px 5px;">
		  <table class="tableBox center">
		    <tr>
		       <th width="5%">序号</th>
		       <th width="10%">厂家安装设备清单</th>
		       <th width="10%">线路连接情况</th>
		      </tr>
		      <tbody>
		        <tr><td>1</td><td>${eSurvey.factoryFirstEquiplist}</td><td>${eSurvey.factoryFirstLine}</td></tr>
		         <tr><td>2</td><td>${eSurvey.factorySecondEquiplist}</td><td>${eSurvey.factorySecondLine}</td></tr>
		          <tr><td>3</td><td>${eSurvey.factoryThirdEquiplist}</td><td>${eSurvey.factoryThirdLine}</td></tr>
		           <tr><td>4</td><td>${eSurvey.factoryFourthEquiplist}</td><td>${eSurvey.factoryFourthLine}</td></tr>
		            <tr><td>5</td><td>${eSurvey.factoryFifthEquiplist}</td><td>${eSurvey.factoryFifthLine}</td></tr>
		             <tr><td>6</td><td>${eSurvey.factorySixthEquiplist}</td><td>${eSurvey.factorySixthLine}</td></tr>
		       </tbody>
		  </table>
        </li>
      </ul>
      
      <ul class="searchWrap">
         <li class="clearfix" style="margin:5px 20px 5px;">
           <label class="text">学校负责人：</label>
           <span  style="margin-left:20px;">
             ${eSurvey.schoolHead }
           </span>
            <label class="text" style="margin-left:10px;">日期：</label>
            <span  style="margin-left:20px;">    
			  <fmt:formatDate value="${eSurvey.schoolTime}" pattern="yyyy-MM-dd"/>
           </span>
         </li>
        <li class="clearfix" style="margin:5px 20px 5px;">
           <label class="text">现场勘查人员：</label>
           <span  style="margin-left:9px;">
           ${eSurvey.investPersonnel}
           </span>
            <label class="text" style="margin-left:10px;">日期：</label>
            <span  style="margin-left:20px;">
             <fmt:formatDate value="${eSurvey.investTime}" pattern="yyyy-MM-dd"/>
           
           </span>
         </li>
      </ul>
      
      <!--   <div class="totalPageBox">总共<span class="totalNum" id="totalNum">0</span> 条项目</div> 
          <ul class="searchWrap">
         <li class="clearfix" style="margin:5px 20px 5px;">
          <table class="tableBox center">
			<tr>
			    <th>图片名称</th>
				<th>图片描述</th>
				<th>图片下载</th>
			</tr>
			<tbody id="pageBody">
		      <c:choose>
		         <c:when test="${attachments!=null&&attachments.size()>0}">
		            <c:forEach items="${attachments}" var="attachment">
                 <tr>
                 <td>${attachment.name}</td>
                 <td>${attachment.remark==null?"-":attachment.remark}</td>
                 <td><a href="${root}/images/${attachment.attachment_Url}/${attachment.name}">下载</a></td>
                 </tr>
                 </c:forEach>
		         </c:when>
		         <c:otherwise>
		             <tr><td colspan="3">抱歉，未查询到相关记录!</td></tr>
		         </c:otherwise>
		      </c:choose>
			   
			</tbody>
		 </table> 
		 </li>
		 </ul>-->
	 <ul class="searchWrap">
         <li class="clearfix" style="margin:25px 20px 5px;">
          <span class="mr20">共<span class="red" id="number">${attachments.size()==null?0:attachments.size()}</span>张照片</span>
          <span class="mr20"><a href="javascript:;" class="uploadBox btn mr20" onclick="viewPicture();">查看</a></span>
     </li>
     </ul>
	
	<script type="text/javascript">
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
	   if($(".factory").attr("value") == 1 && $(".factory").attr("checked") == 'checked'){
		   $(".factory").parent().siblings().show();
	   }else{
		   $(".factory").parent().siblings().hide();
	  }
	
	   
	//查看图片
	function viewPicture(){
		var size = '${attachments.size()}';
		var envirSurveyId = '${eSurvey.envirSurveyId}';
		if(size > 0){
			   parent.Win.open({
					id:"viewPicture",
					url:"${root}/admin/classroominspect/toviewphoto.do?flag=back&identify=envir&envirSurveyId="+envirSurveyId,
					title:"查看照片",
					width:750,
					height:550,
					mask:true
			    });
		   }else{
			   Win.alert("暂无照片！");
		   }
		  
	}
	   
	   
	</script>
		 
</body>
</html>