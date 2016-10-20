<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
    <link href="${root}/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
     <script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
     <script src="${root}/public/js/jsTree.js" type="text/javascript"></script>
    <style>
        .c-l{width: 100px;float: left;text-align: right;}
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
        	<label class="c-l">项目区域：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                   ${classroom.projectArea }                 </div>
            </div>
        </li>
        <li class="clearfix" >
        	<label class="c-l">项目：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                   ${classroom.projectName }                 </div>
            </div>
        </li><li class="clearfix" >
        	<label class="c-l">学校区域：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                   ${classroom.schoolArea }                 </div>
            </div>
        </li><li class="clearfix" >
        	<label class="c-l">学校：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                   ${classroom.clsSchoolName }                 </div>
            </div>
        </li><li class="clearfix" >
        	<label class="c-l">教室：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                   ${classroom.roomName }                 </div>
            </div>
        </li><li class="clearfix" >
        	<label class="c-l">教室类别：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                   ${classroom.roomType }                 </div>
            </div>
        </li>
    </ul>
  
</body>
</html>