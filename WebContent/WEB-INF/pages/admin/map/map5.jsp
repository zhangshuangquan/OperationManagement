<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en" >
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="chrome=1">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <style type="text/css">
      html,body,.map{
        height: 100%;
        margin: 0px;
      }
    </style>
    <title>自定义图层</title>
  </head>
  <body>
    <div id="mapDiv" class="map" tabindex="0"></div>
     <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=d3681724444d030e6a5020b5565c61b9"></script>
    <script type="text/javascript">
      var map, provinces, redPoint, bluePoint, canvas, colorFlag = 0,
        started;
      function buildPoint(color) {
          var c = document.createElement("canvas");
          c.width = c.height = 40;
          var ctx = c.getContext("2d");
          var grd = ctx.createRadialGradient(20, 20, 0, 20, 20, 20);
          grd.addColorStop(0, color);
          grd.addColorStop(1, "white");
          ctx.fillStyle = grd;
          ctx.beginPath();
          ctx.arc(20, 20, 20, 0, 2 * Math.PI);
          ctx.fill();
          return c;
      }
      function onRender() {
          for (var i = 0; i < provinces.length; i += 1) {
              provinces[i].containerPos = map.lngLatToContainer(provinces[i].center);
          }
          draw();
          if(!started){
             autoSize();
             started = true;
          }
      }
      function autoSize () {
          draw();
          setTimeout(autoSize, 250);
      }
      function draw() {
          var point = colorFlag ? bluePoint : redPoint;
          var context = canvas.getContext('2d');
          context.clearRect(0, 0, canvas.width, canvas.height)
          for (var i = 0; i < provinces.length; i += 1) {
              var province = provinces[i];
              var radious = province.radious;
              context.drawImage(point,
                                province.containerPos.x - radious,
                                province.containerPos.y - radious,
                                radious * 2,
                                radious * 2
                              );
              province.radious = (radious + 1) % 10;
          }
          colorFlag = (colorFlag + 1) % 2;
      }
      function create() {
        map = new AMap.Map('mapDiv', {
            resizeEnable: true,
            center: new AMap.LngLat(116.306206, 39.975468),
            zoom:3
        });
        map.plugin(['AMap.CustomLayer', 'AMap.DistrictSearch'], function() {
            var search = new AMap.DistrictSearch();
            search.search('中国', function(status, data) {
                if (status === 'complete') {
                    provinces = data['districtList'][0]['districtList']
                    for (var i = 0; i < provinces.length; i += 1) {
                       provinces[i].radious = Math.max(2, Math.floor(Math.random() * 10));
                    }
                    redPoint = buildPoint('red');
                    bluePoint = buildPoint('rgba(17,0,255,255');
                    canvas = document.createElement('canvas');
                    canvas.width = map.getSize().width;
                    canvas.height = map.getSize().height;
                    var cus = new AMap.CustomLayer(canvas, {
                        zooms: [3, 8],
                        zIndex: 12
                    });
                    cus.render = onRender;
                    cus.setMap(map)
                }
            });
        });
      }
      create()
    </script>

  </body>
  
</html>