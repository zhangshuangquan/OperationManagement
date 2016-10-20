<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../../common/meta.jsp"%> 

<link rel="stylesheet" href="${root}/public/css/style.css">
<link rel="stylesheet" href="${root}/public/uploadPic/css/slide.css">

<script src="${root}/public/js/customer.js" type="text/javascript"></script>
<script src="${root}/public/js/basiccheck.js"></script>

<script type="text/javascript" src="${root}/public/js/jquery.js"></script>
<script type="text/javascript" src="${root}/public/uploadPic/js/slide.js"></script>

<style>
#slide {
    width:100%;
    height: 425px;
}
</style>
<script type="text/javascript">
	var domid = frameElement.getAttribute("domid");
</script>

</head>

<body style="text-align:left">

  
  <div id="slide"></div>
  
  
  <div style="margin-top:15px;" id="show">
	<span id="pic" class="mr40" style="width:500px;width:500px;margin-left:50px;text-align:center"></span>
	<a href="" id="download" class="mr40 btn">下载图片</a>
  </div>
  
 
<script type="text/javascript">  


    var flag = '${flag}';
    var attach = null;
    if(flag === 'back'){
    	attach = JSON.parse('${attachment}');
    }else{
    	attach = parent.attach["attach"];
    }
    var images = [];
    var picDesc = {};
    
    for (var i = 0, l = attach.length; i < l; i++){
	   images[i] = '${root}/images/'+attach[i].attachment_Url+'/'+encodeURIComponent(attach[i].name)+'';
	   picDesc[images[i]] = attach[i].remark;
    }
    
    var dddd = slide.init({
		"id"       : "slide",
		"basePath" : "",
		"images"   : images,
		"presentShow": function(present) {
			var html = '';
			for(var key in picDesc){
				if(key === present){
					$("#pic").html(picDesc[key]);
					$("#download").attr("href", present);
				}
			}
		}
	});
   

   
</script>

</body>
</html>