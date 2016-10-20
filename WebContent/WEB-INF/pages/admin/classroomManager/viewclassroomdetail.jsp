<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
    <link href="${root}/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
     <script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
     <script src="${root}/public/js/jsTree.js" type="text/javascript"></script>
    <style>
        .c-l{width: 200px;float: left;text-align: right;}
        .c-r{overflow: hidden;}
        .original-qs{padding: 0 20px;}
        .original-qs li{margin-bottom: 10px;}
        .chase-ask{font-size: 14px;color: #50732d;}
        .chase-ask h3{padding: 5px 20px;border-top: 1px solid #ccc;border-bottom: 1px solid #ccc;margin-bottom: 5px;}
    </style>
</head>
<body class="chase-ask">
    <ul class="original-qs">
        <li class="clearfix" >
        	<label class="c-l">区域：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                   ${classroom.schoolArea }                 </div>&nbsp;&nbsp;
               	 学校：
                <div style="display:inline-block;vertical-align:top;">
                    ${classroom.clsSchoolName}                </div>&nbsp;&nbsp;
               	教室：
                <div style="display:inline-block;vertical-align:top;">
                   ${classroom.roomName}                </div>&nbsp;&nbsp;
               	教室类别：
                <div style="display:inline-block;vertical-align:top;">
                    ${classroom.roomType}                </div>
            </div>
        </li>
        <li class="clearfix" >
            <label class="c-l">联系人：</label>
            <div class="c-r">
                 <div style="display:inline-block;width:161px;vertical-align:top;">
                    ${classroom.contactPersonName}                </div>&nbsp;&nbsp;
               	手机：
                <div style="display:inline-block;vertical-align:top;">
                    ${classroom.contactPersonPhone}                </div>
            </div>
        </li>
        <li class="clearfix" style="margin:5px 0 15px;">
     		<label class="labelTextEdit">工程师：</label>${classroom.installUserName}</span>
     	</li>
        <li class="clearfix" >
            <label class="c-l">TeamviewID：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    ${classroom.teamviewid}                </div>&nbsp;&nbsp;
               	Teamview密码：
                <div style="display:inline-block;vertical-align:top;">
                    ${classroom.teamviewpsd }</div>&nbsp;&nbsp;
            </div>
        </li>
        <li class="clearfix" >
            <label class="c-l">在线课堂服务器地址：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    ${classroom.zxktService}                </div>
            </div>
        </li>
        <li class="clearfix" >
            <label class="c-l">在线课堂服务器账号、密码：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    ${classroom.zxktUserNamePsd}                </div>
            </div>
        </li>
        <li class="clearfix" >
            <label class="c-l">导播/插件版本：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    ${classroom.dbcjVersion}                </div>&nbsp;&nbsp;
               	产品版本号：
                <div style="display:inline-block;vertical-align:top;">
                	
                    ${classroom.projectVersion }    </div>&nbsp;&nbsp;
            </div>
        </li>
        <li class="clearfix" >
            <label class="c-l">实施进展：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    ${classroom.implementationProgress}                </div>&nbsp;&nbsp;
               	实施时间：
                <div style="display:inline-block;vertical-align:top;">
                    <fmt:formatDate value="${classroom.implementationTimeBegin }" pattern="yyyy-MM-dd"/> 至  <fmt:formatDate value="${classroom.implementationTimeEnd }" pattern="yyyy-MM-dd"/>                </div>&nbsp;&nbsp;
            </div>
        </li>
        <li class="clearfix" >
            <label class="c-l">主材设备序列号：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    ${classroom.zcsbNum}                </div>&nbsp;&nbsp;
               	产品质保期：
                <div style="display:inline-block;vertical-align:top;">
                    ${classroom.productWarrantyPeriod }    </div>&nbsp;&nbsp;
            </div>
        </li>
        <li class="clearfix" >
            <label class="c-l">监管平台地址（内外网）：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    ${classroom.jgptAddress}                </div>
            </div>
        </li>
        <li class="clearfix" >
            <label class="c-l">监管平台服务器地址：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    ${classroom.jgptService}                </div>
            </div>
        </li>
        <li class="clearfix" >
            <label class="c-l">监管平台服务器账号、密码：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    ${classroom.jgptNamePsd}                </div>
            </div>
        </li>
        <li class="clearfix" >
            <label class="c-l">服务器配置：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    ${classroom.serviceInfo}                </div>
            </div>
        </li>
        <li class="clearfix" >
            <label class="c-l">黑板样式：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    ${classroom.blackboard}                </div>&nbsp;&nbsp;
               	讲台配置：
                <div style="display:inline-block;vertical-align:top;">
                    ${classroom.platform}                 </div>&nbsp;&nbsp;
            </div>
        </li>
         <li class="clearfix" >
            <label class="c-l">班班通情况：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    ${classroom.bbtInfo}                </div>&nbsp;&nbsp;
               	是否打标签：
                <div style="display:inline-block;vertical-align:top;">
                    ${classroom.isSign}                 </div>&nbsp;&nbsp;
            </div>
        </li>
         <li class="clearfix" >
            <label class="c-l">调试状态：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    ${classroom.status}                </div>&nbsp;&nbsp;
               	是否已培训：
                <div style="display:inline-block;vertical-align:top;">
                    ${classroom.isTrain}                 </div>&nbsp;&nbsp;
            </div>
        </li>
         <li class="clearfix" >
            <label class="c-l">培训讲师：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    ${classroom.trainTeacher}                </div>&nbsp;&nbsp;
               	是否验收：
                <div style="display:inline-block;vertical-align:top;">
                    ${classroom.isCheck}                 </div>&nbsp;&nbsp;
            </div>
        </li>
         <li class="clearfix" >
            <label class="c-l">培训时间：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    ${classroom.trainTime}                </div>&nbsp;&nbsp;
               	开课情况：
                <div style="display:inline-block;vertical-align:top;">
                    ${classroom.isStart}                 </div>&nbsp;&nbsp;
            </div>
        </li>
         <li class="clearfix" >
            <label class="c-l">备注：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    ${classroom.remark}                </div>
            </div>
        </li>
    </ul>
 
</body>
</html>