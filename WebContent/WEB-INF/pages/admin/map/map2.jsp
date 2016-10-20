<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>公交线路查询</title>
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main.css?v=1.0"/>
    <script type="text/javascript"
            src="http://webapi.amap.com/maps?v=1.3&key=d3681724444d030e6a5020b5565c61b9"></script>
</head>
<body>
<div id="mapContainer"></div>
<script language="javascript">
    /*
     * 该示例主要流程分为三个步骤
     * 1. 首先调用公交路线查询服务(lineSearch)
     * 2. 根据返回结果解析，输出解析结果(lineSearch_Callback)
     * 3. 在地图上绘制公交线路()
     */
    var resLine = ''; //结果表格对象

    var map = new AMap.Map("mapContainer", {
        resizeEnable: true,
        center: [116.397428, 39.90923],//地图中心点
        zoom: 13 //地图显示的缩放级别
    });
    /*
     *清空地图覆盖物与查询结果
     */
    function mapclear() {
        btContent = '';
        resLine = '';
        map.clearMap();
    }
    /*
     *公交线路查询
     */
    function lineSearch() {
        //加载公交线路查询插件
        //实例化公交线路查询类，只取回一条路线
        AMap.service(["AMap.LineSearch"], function() {
            var linesearch = new AMap.LineSearch({
                pageIndex: 1,
                city: '北京',
                pageSize: 1,
                extensions: 'all'
            });
            //搜索“536”相关公交线路
            linesearch.search('536', function(status, result) {
                if (status === 'complete' && result.info === 'OK') {
                    lineSearch_Callback(result);
                } else {
                    alert(result);
                }
            });
        });
    }
    /*
     * 公交路线查询服务返回数据解析概况
     * param Array[]  lineArr     返回公交线路总数
     * param String   lineName    公交线路名称
     * param String   lineCity    公交所在城市
     * param String   company     公交所属公司
     * param Number   stime       首班车时间
     * param Number   etime       末班车时间
     * param Number   bprice      公交起步票价
     * param Number   tprice      公交全程票价
     * param Array[]  pathArr     公交线路路径数组
     */
    function lineSearch_Callback(data) {
        var lineArr = data.lineInfo;
        var lineNum = data.lineInfo.length;
        if (lineNum == 0) {
            resLine = data.info;
        }
        else {
            for (var i = 0; i < lineNum; i++) {
                var pathArr = lineArr[i].path;
                var stops = lineArr[i].via_stops;
                var startPot = stops[0].location;
                var endPot = stops[stops.length - 1].location;
                
                if (i == 0) drawbusLine(startPot, endPot, pathArr);
            }
        }
    }
    /*
     *绘制路线
     */
    function drawbusLine(startPot, endPot, BusArr) {
        //绘制起点，终点
        var stmarker = new AMap.Marker({
            map: map,
            position: [startPot.lng, startPot.lat], //基点位置
            icon: "http://webapi.amap.com/theme/v1.3/markers/n/start.png",
            zIndex: 10
        });
        var endmarker = new AMap.Marker({
            map: map,
            position: [endPot.lng, endPot.lat], //基点位置
            icon: "http://webapi.amap.com/theme/v1.3/markers/n/end.png",
            zIndex: 10
        });
        //绘制乘车的路线
        busPolyline = new AMap.Polyline({
            map: map,
            path: BusArr,
            strokeColor: "#09f",//线颜色
            strokeOpacity: 0.8,//线透明度
            strokeWeight: 6//线宽
        });
        map.setFitView();
    }
    lineSearch()
</script>
</body>
</html>