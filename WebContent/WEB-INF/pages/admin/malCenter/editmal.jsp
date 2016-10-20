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
<form id="submitForm">
    <ul>
        <li class="clearfix" style="margin:5px 0 15px;">
            <label class="c-l">故障类别：</label>
            <div class="c-r">
			<div id="WebDesign" class="tree-select"> 
			     <div class="tree-selectVal"> 
			        <input readonly="readonly" value="${mal.malCatalogName}">
			    </div>  
			   <span class="tree-warp"></span>
			 </div> 
<a href="javascript:;" id="editType">编辑故障类别 </a>
<input type="hidden" id="classificationId" needcheck nullMsg="请请选择故障类别!" name="catalogId" value="${mal.catalogId}">
<input type="hidden" id="upstatus"  name="upstatus" value="${upstatus}">

<input type="hidden" id="classificationLevel" name="classificationLevel" value="1">
<script>
default_ification = window["default_ification"] || [];
$('.tree-warp').jsTree({
    hasCheckBox: false,
    isExpand: true,
    treeType: 2,
    clickItem:function (data, type, $li) {
         this.$elm.hide()
         			.siblings('.tree-selectVal')
         			.find('input').val(data.name);
        $("#classificationId").val(data.id);
        $("#classificationLevel").val(data.level);
    }
});
$('.tree-selectVal').on('click', function () {
    var $warp = $(this).siblings('.tree-warp');
    if ($warp.css('display') == 'none') {
        $('.tree-warp').jsTree('clear');
        $.get('${root}/admin/malCenter/getCatalogTree.do',function(treeData){
            $('.tree-warp').jsTree('loadData', default_ification.concat(treeData));
            $warp.show();
        },'json');
    } else {
        $warp.hide();
    }
});

/*     $("#editType").click(function(){
        //console.log(Window)
        win_malTypeList = top.Win.open({
            'id':'malTypeList',
            'title':'编辑故障分类',
            'url':'admin.php?a=repair&type=malTypeList',
            'width':800,
            'height':560,
            'mask': true,
            'beforeClose': function(){
                top.malClassification = [];
                $.ajax({
                    url:'admin.php?a=repair&type=getClass',
                    dataType:'json',
                    success:function(data){
                        top.malClassification = data;
                        mySplit.reload();
                    }
                });

            }
        });
    }); */
    
    $("#editType").click(function(){
        //console.log(Window)
        win_malTypeList = top.Win.open({
            'id':'malTypeList',
            'title':'编辑故障分类',
            'url':'${root}/admin/malCenter/toeditcatalog.do',
            'width':800,
            'height':560,
            'mask': true,
            'beforeClose': function(){
               /*  top.malClassification = [];
                $.ajax({
                    url:'admin.php?a=repair&type=getClass',
                    dataType:'json',
                    success:function(data){
                        top.malClassification = data;
                        mySplit.reload();
                    }
                }); */

            }
        });
    });
</script>               
            </div>
        </li>
        <li class="clearfix">
            <label class="c-l">预计处理日期：</label>
            <div class="c-r">
                <input type="text" class="Wdate" id="planprocess_time" onclick="WdatePicker();"  name="planRepairTime" value="<fmt:formatDate value="${mal.planRepairTime }" pattern="yyyy-MM-dd"/>" needcheck nullMsg="请选时间!" name="planprocess_time" >
            </div>
        </li>
        <li class="clearfix" style="margin-bottom:5px;">
            <label class="c-l">处理人名字：</label>
            <div class="c-r">
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    <input type="text" name="repairman" id="repairman" class="repairman" needcheck nullMsg="请输入处理人名字!" limit="4,20" limitmsg="很抱歉，处理人名字长度需要是2到10个字符" value="${mal.repairman}">
                </div>&nbsp;&nbsp;
                处理人电话：
                <div style="display:inline-block;width:161px;vertical-align:top;">
                    <input type="text" name="repairmanContact" id="repairmanContact" class="repairman_contact" value="${mal.repairmanContact}"  errormsg="请输入正确的电话号码！" reg="^\d{7,8}$|^\d{3,4}-\d{7,8}$|^1[3|4|5|8][0-9]\d{4,8}$" allownull needcheck>
                    <!--  needcheck nullMsg="请输入处理人电话!" reg="\d{3,4}-\d{7,8}$|^1[3|4|5|7|8][0-9]\d{4,8}$" errormsg="请输入正确的电话号码！" -->
                </div>
            </div>
        </li>
        <li class="clearfix" style="margin-bottom:5px;">
            <label class="c-l">处理过程：</label>
            <div class="c-r">
                <textarea name="responseContent" needcheck nullMsg="请输入处理过程!" style="width:444px;height:100px;resize:none;">${mal.responseContent} </textarea>
            </div>
        </li>
    </ul>
    <input type="hidden" value="${mal.malDetailId}" name="malDetailId">
    <input type="hidden" value="0" name="editStatus">
    <div style="text-align:right;margin-bottom:5px;">
        <input type="submit" class="btn" value="更新" style="margin-right:20px;" />
        <input type="button" class="btn btnGray" value="取消" style="margin-right:20px;" id="cancel" />
    </div>
</form>
   <c:forEach items="${mal.appends }" var="append" >
    <h3>追问<fmt:formatDate value="${append.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/></h3>
    <ul class="original-qs">
   	 <li class="clearfix">
		    <label class="c-l">故障描述：</label>
		    <span class="c-r">
           		 ${append.appendDescription }       
      		 </span>
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
    var mySplit = parent.mySplit;
    new BasicCheck({
        form: $id("submitForm"),
        addition : function() {
            return true;
        },
        ajaxReq : function(){
            $.post('${root}/admin/malCenter/editmal.do',$("#submitForm").serialize(),function(r){
                try {
                    if(!r.result){
                        Win.alert('发送失败！');
                    }else{
                        parent.Win.alert('发送成功!');
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