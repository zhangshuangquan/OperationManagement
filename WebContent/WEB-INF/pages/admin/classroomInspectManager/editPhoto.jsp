<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../../common/meta.jsp"%> 
<link rel="stylesheet" href="${root}/public/css/style.css">
<link rel="stylesheet" href="${root}/public/uploadPic/css/slide.css">

<script src="${root}/public/js/customer.js" type="text/javascript"></script>
<script src="${root}/public/js/basiccheck.js"></script>
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
	<input id="pic" class="mr40" type="text" style="width:500px;margin-left:50px;">
	<input id="save" class="mr40" type="button" value="保存">
	<input id="del" class="mr40" type="button" value="删除图片">
   </div>
 
<script type="text/javascript">
    
       var attach = parent.attach["attach"];
       var images = [];
       var picDesc = {};
       var picNames = [];
    
      for (var i=0, l = attach.length; i < l; i++){
    	images[i] = '${root}/images/'+attach[i].attachment_Url+'/'+attach[i].name+'';
    	picDesc[images[i]] = attach[i].remark;
    	picNames[i] = attach[i].remark;
      }
    
    var dddd = slide.init({
		"id"       : "slide",
		"basePath" : "",
		"images"   : images,
		"presentShow": function(present) {
			var html = '';
			
			for(var key in picDesc){
				
				if(key === present){
					$("#pic").val(picDesc[key]);
				}
				
			}
		}
	});
    
    //删除图片
    $("#del").click(function(){
    	
    	var imgs = $(".slide_img").attr("src");
    	var currentPage = $($(".count_wrap").find("span")[0]).text();
    	var totalPage = $($(".count_wrap").find("span")[1]).text();
    	dddd.delImage(imgs);
    	parent.deleteImg({
        	  imgs : imgs
        });
    	
    	for(var key in picDesc){
			if(key === imgs){
				delete picDesc[key];
				break;
			}	
		}
    	
    	if(images.length > 0){
    		if(currentPage == totalPage){
    			$($(".count_wrap").find("span")[0]).html("1");
    			$("#pic").val(picDesc[images[0]]);
    		}
    		
    		if(currentPage < totalPage){
    			$("#pic").val(picDesc[images[0]]);
    		}
    	}else{
    		$($(".count_wrap").find("span")[0]).html("0");
    		$("#pic").val("");
    		Win.alert("暂无照片！");
    		return false;
    	}
    });

  
    //保存图片描述
    $("#save").click(function(){
        var newVal = $("#pic").val();
        var index = $($(".count_wrap").find("span")[0]).text();
        var img = $(".slide_img").attr("src");
        for(var key in picDesc){
			if(key === img){
				picDesc[key] = newVal;
				break;
			}
			
		}
        picNames[index-1] = newVal;
        parent.editPicDesc({
          picNames : picNames
        });
    });
   
   
</script>

</body>
</html>