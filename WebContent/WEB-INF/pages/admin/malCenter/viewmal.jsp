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

        .errorTip{color: #f00;min-height: 18px;display: inline-block;}
        #imgview{min-height: 42px;margin-top: 5px;}
        #imgview img{float: left;margin-right: 1px;}
        #imgview .imgview-list:hover .imgview-close{display: block;}
        .imgview-list{float: left;position: relative;}
        .imgview-close{display: none;position: absolute;right: 2px;top: 2px;width: 15px;height: 15px;background: url(/public/img/green/imgview-close.png) no-repeat 0 0;}

        .img-view img{width: 48px;}

        .repairman,
        .repairman_contact{width: 161px;}
        .baoxiu-name{width:140px;display:inline-block;margin-right:20px;word-break:break-all}
        .baoxiu-phone{width:140px;display:inline-block;vertical-align:top;word-break:break-all;}
    </style>
</head>
<body class="chase-ask">
    <ul class="original-qs">
        <li class="clearfix">
            <label class="c-l">故障类别：</label>
            <div class="c-r">
                ${mal.malCatalogName }            </div>
        </li>
        <li class="clearfix">
            <label class="c-l">预计处理日期：</label>
            <div class="c-r">
               <fmt:formatDate value="${mal.planRepairTime }" pattern="yyyy-MM-dd"/>            </div>
        </li>
        <li class="clearfix" style="margin-bottom:5px;">
            <label class="c-l">处理人名字：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    ${mal.repairman}                </div>&nbsp;&nbsp;
                处理人电话：
                <div style="display:inline-block;vertical-align:top;">
                    ${mal.repairmanContact}                </div>
            </div>
        </li>
        <li class="clearfix">
            <label class="c-l">处理过程：</label>
            <div class="c-r">
                 ${mal.responseContent}             </div>
        </li>
    </ul>
    <div style="text-align:right;margin-bottom:5px;">
        <input type="button" class="btn" value="关闭" style="margin-right:20px;" id="cancel" />
    </div>
    <c:forEach items="${mal.appends }" var="append" >
    <h3>追问<fmt:formatDate value="${append.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/></h3>
    <ul class="original-qs">
   	 <li class="clearfix">
		    <label >故障描述：${append.appendDescription }</label>
	</li>
	<li class="c-r img-view">
	 	<label class="c-l">附加图片：</label>
	 	<div class="c-r img-view">
        	<c:forEach items="${append.imgs}" var="img" >
        		<img style="cursor:pointer" width="100" src="${root}/images/${img.imageName}">
        	</c:forEach>
        </div>
   </li>
	</ul>
    </c:forEach>
<h3>原问题 <fmt:formatDate value="${mal.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/></h3>
<ul class="original-qs">
    <li class="clearfix">
        <label class="c-l">故障类别：</label>
        <div class="c-r">${mal.malCatalogName } </div>
    </li>
    <li class="clearfix">
        <label class="c-l">报修人名字：</label>
        <div class="c-r">
            <div class="baoxiu-name">${mal.reporter} </div>
            报修人电话：<div class="baoxiu-phone">${mal.reporterContact} </div>
        </div>
    </li>
    <li class="clearfix">
        <label class="c-l">故障描述：</label>
        <div class="c-r">
            ${mal.malDescription}         </div>
    </li>
    <li class="clearfix">
        <label class="c-l">附加图片：</label>
        <div class="c-r img-view">
        	<c:forEach items="${mal.imgs}" var="img" >
        		<img style="cursor:pointer" width="100" src="${root}/images/${img.imageName}">
        	</c:forEach>
         </div>
    </li>
</ul>

<script>
    if(window.frameElement)  var domid =frameElement.getAttribute("domid");
    $("#cancel").click(function(){
        parent.Win.wins[domid].close();
    });
    $("#imgview").on("click", ".imgview-close", function(){
        $(this).parent(".imgview-list").remove();
    });

    $(function(){
        $('body').on('click', '.img-view img', function(){
            var imgsrcs = [];
            var index  = $(this).index();
            $(this).parents('.img-view').find('img').each(function(){
                var src = $(this).attr('src').replace(/\/s\//, '/');
                imgsrcs.push(src);
            });
            top.feed.picDetail.show(imgsrcs, index)
        })
    })
</script>
</body>
</html>