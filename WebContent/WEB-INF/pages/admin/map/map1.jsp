<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp"%>
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=cb047dc786c066ece015c08fc56109d3"></script> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>Insert title here</title>
<style>
#container {width:1895px; height: 780px; }  
</style>
</head>
<body>
		<div id="container"></div> 
		<script type="text/javascript">
		var markers = new Array();
		var infowindows = new Array();
		
		var map = new AMap.Map('container',{
	        zoom: 20,
	        center: [120.714706,31.366057]
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
		},"json") ;  
		
		</script> 
</body>
</html>