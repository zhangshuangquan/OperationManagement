<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=d3681724444d030e6a5020b5565c61b9"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
<title>驾车导航－使用默认皮肤</title>
<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main.css?v=1.0"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>Insert title here</title>
<style>
#container {width:1895px; height: 780px; }  
 #panel {
     position: fixed;
     background-color: white;
     max-height: 90%;
     overflow-y: auto;
     top: 10px;
     right: 10px;
     width: 280px;
 }
</style>
</head>
<body>
		<div id="container"></div> 
		<div id="panel"></div>
		<script type="text/javascript">
		var markers = new Array();
		var infowindows = new Array();
		
		var map = new AMap.Map('container',{
			resizeEnable: true,
	        zoom: 20,
	        /* center: [120.714706,31.366057], */
	        center: [120.716493, 31.365823]
	    });
		
		AMap.plugin(['AMap.ToolBar','AMap.Scale'],function(){
		    var toolBar = new AMap.ToolBar();
		    var scale = new AMap.Scale();
		    map.addControl(toolBar);
		    map.addControl(scale);
		})
		

		$.post("map1date.do",{}, function(data){
			 for(var i=0;i<data.length;i++){
				markers.push ( new AMap.Marker({
			       	 position: [data[i].y, data[i].x],
			       	 map:map,
			       	extData:i
			   	}));
				console.log(data[i].img);
				infowindows.push( new AMap.InfoWindow({
            	content: '<h3 class="title">售后记录'+i+'</h1><div class="content">'+
                '<img class="slide_img" height="125" src="../../images/'+data[i].img+'/'+data[i].img+'" '+
                '<br/>'+
                '</div>',
           		 offset: new AMap.Pixel(0, -30),
           		 size:new AMap.Size(300,0)
   			 	}));
				
			}
				for(var i=0;i<markers.length;i++){
				markers[i].on('click',function(e){
					infowindows[e.target.getExtData()].open(map,e.target.getPosition());
					})
				} 
				
				

				
				AMap.service(["AMap.Driving"], function() {
			        var driving = new AMap.Driving({
			            map: map,
			            panel: "panel"
			        }); //构造路线导航类
			        // 根据起终点坐标规划步行路线
			        driving.search([data[13].y, data[13].x], [data[14].y, data[14].x]); 
			        //driving.search([{keyword:'方恒国际',city:'北京'},{keyword:'壶口瀑布'}]);
			    });
				
		
				
				console.log(data[14].y+"***"+ data[14].x+"***"+data[13].y+"***"+data[13].x);
				
				
				/*  driving.search([data[0].y, data[0].x], [data[data.length-1].y, data[data.length-1].x], function(status, result) {
				        //TODO 解析返回结果，自己生成操作界面和地图展示界面
				    }); */
				
		},"json") ;  
		
		
	    //步行导航
	    AMap.service(["AMap.Driving"], function() {
	        var driving = new AMap.Driving({
	            map: map,
	            panel: "panel"
	        }); //构造路线导航类
	        // 根据起终点坐标规划步行路线
	        driving.search([data[13].y, data[13].x], [data[14].y, data[14].x]); 
	    });
		</script> 
</body>
</html>