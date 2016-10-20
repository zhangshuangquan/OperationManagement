<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="../../../common/meta.jsp"%>
 <style>
    body {
        font-size: 12px;
        padding: 10px;
    }
    .map-btn {
        margin-left: 4px;
        padding: 2px 10px;
        background-color: #fff;
        color: #333;
        -moz-user-select: none;
        background-image: none;
        border: 1px solid #ccc;
        border-radius: 4px;
        cursor: pointer;
        font-weight: normal;
        margin-bottom: 0;
        padding: 6px 12px;
        text-align: center;
        vertical-align: middle;
        white-space: nowrap;
        padding: 2px 10px;
        margin-left: 4px;
    }
    
    .map-btn:hover {
        color: #333;
        background-color: #e6e6e6;
        border-color: #adadad
    }
    
    .del-btn {
        /*background-color: #DFBED3;*/
    }
    
    #svgLoad,#addSvgBox {
        border: 1px solid #ddd;
        background-color: rgba(173, 225, 255, 0.7);
        height: 660px;
        width: 660px;
    }
    
    .configure-box {
        border: 1px solid #ddd;
        border-radius: 4px;
        position: absolute;
        left: 670px;
        padding: 5px 10px;
        min-width: 500px;
       	background-color: rgba(238, 238, 238, 0.8);
       	z-index: 1000;
    }
    
    .configure-box > div {
        height: 30px;
        line-height: 30px;
    }
    
    select {
        margin-left: 4px;
    }
    
    .color-sel div {
        display: inline-block;
        width: 14px;
        height: 14px;
        border: 1px solid #ccc;
    }
    
    .color-sel div.sel {
        border: 1px solid #000;
    }
    
    .color-sel .color1 {
        background-color: #d9d9d9;
    }
    
    .color-sel .color2 {
        background-color: #faf6d8;
    }
    
    .color-sel .color3 {
        background-color: #bae9ee;
    }
    
    .color-sel .color4 {
        background-color: #dfbfd2;
    }
    
    .color-sel .color5 {
        background-color: #cbe6c8;
    }
    
    .circle-btn {
        width: 10px;
        height: 10px;
        border-radius: 5px;
        background-color: #f00;
        position: absolute;
        left: 0;
        top: 0;
        z-index: 100;
        cursor: pointer;
    }
    
    .text-btn {
        width: 10px;
        height: 10px;
        background-color: blue;
        position: absolute;
        left: 10px;
        top: 0;
        z-index: 50;
        cursor: pointer;
    }
    
    .svg-box, #addSvgBox {
        position: relative;
    }
    .uploadBoxMap {
	    overflow: hidden;
	    position: relative;
	    text-align: center;
	    visibility: visible;
	    margin-left: 4px;
    	padding: 2px 10px;
    }
    .map-popTip {
    	color: #f00;
	    height: 39px;
	    position: absolute;
	    z-index: 999999;
	    display: none;
    }
    .map-popTip-l {
	    background: url("${root}/public/img/map/pop-ui-l.png") no-repeat scroll 0 0 rgba(0, 0, 0, 0);
	    display: inline-block;
	    float: left;
	    height: 39px;
	    width: 20px;
	}
	.map-popTip-m {
	    background: url("${root}/public/img/map/pop-ui-m.png") repeat-x scroll 100% 0 rgba(0, 0, 0, 0);
	    display: inline-block;
	    float: left;
	    height: 39px;
	    line-height: 35px;
	    min-width: 2px;
	    text-indent: -0.5em;
	}
	.map-popTip-r {
	    background: url("${root}/public/img/map/pop-ui-r.png") no-repeat scroll 0 0 rgba(0, 0, 0, 0);
	    display: inline-block;
	    float: left;
	    height: 39px;
	    width: 13px;
	}
    </style>
	<script type="text/javascript" src="${root }/public/upload/uploadfile.js"></script>
	<script type="text/javascript" src="${root }/public/js/avalon.js"></script>
	<script type="text/javascript">
		var KD_RRT = { root: '${root }'};
	</script>
    <script>
	    var COLOR_GROUP_MAP = {
	    	0: '#d89026,#c46912,#d9d9d9',
	        1: '#faf6d8,#d5d794,#dddcd3',
	        2: '#bae9ee,#77c8ca,#c2d9da',
	        3: '#dfbfd2,#dc97c6,#d3ccd1',
	        4: '#cbe6c8,#79d466,#cfdde1'
	    };

	    var COLOR_GROUP_MAP2 = {};


	    var SHAP_MAP = {
	        polygon: "path",
	        circle: "center",
	        path: "path"
	    };
	    var SHAP_NAME_MAP = {
	        path: '块',
	        center: '行政中心',
	        star: '星星',
	        text: '文字'
	    };
	    var SVG_PATH = {
	        key: "${areaCode}",
	        svgTab: []
	    };
	    var AREA_ID = '${param.areaId}';
	    (function() {
	    	var dataBase = ${areas};
	    	var keyMap = {};
	    	var parentMap = {};
	    	var id2KeyMap = {};
	    	var keyTree = {
	    		"0": [SVG_PATH.key]
	    	};
	    	for (var key in COLOR_GROUP_MAP) {
	    		COLOR_GROUP_MAP2[COLOR_GROUP_MAP[key]] = key;
	    	}
	    	$.each(dataBase, function () {
	    		id2KeyMap[this.baseAreaId] = this.areaCode;
	    		keyMap[this.areaCode] = this.areaName;
	    	})
	    	$.each(dataBase, function () {
	    		if (this.parentId) {
	    			var parentKey = id2KeyMap[this.parentId];
	    			parentMap[this.areaCode] = parentKey;
	    			keyTree[parentKey] = keyTree[parentKey] || [];
	    			keyTree[parentKey].push(this.areaCode);
	    		}
	    	})
	    	SVG_PATH.parentMap = parentMap;
	    	SVG_PATH.keyMap = keyMap;
	    	SVG_PATH.keyTree = keyTree;

	        /*var m = SVG_PATH.keyMap;
	        m[0] = m[0].split(',');
	        m[1] = m[1].split(',');
	        var keyMap = {};
	        $.each(m[0], function(index) {
	            keyMap[this] = m[1][index];
	        })
	        SVG_PATH.keyMap = keyMap;
			

	        $.each(SVG_PATH.svgTab, function() {
	            if (this.shap == "path") {
	                this.color = COLOR_GROUP_MAP[this.color] || this.color;
	            }
	        });
	        

	        var tab = [];
	        for (var key in SVG_PATH.keyTree) {
	            tab.push(key);
	            SVG_PATH.keyTree[key] = SVG_PATH.keyTree[key].split(',');
	        }
	        SVG_PATH.keyTree[SVG_PATH.key] = tab;
	        SVG_PATH.keyTree["0"] = [SVG_PATH.key];*/
	    })();
	    require(["domReady!"], function() {
	        var $doc = $(document);
	        window.vmSvgMap = avalon.define({
	            $id: "svgMap",
				areaName: SVG_PATH.keyMap[SVG_PATH.key],
	            selectCode: "",
	            hasRoom: [],
	            svgTab: [],
	            addShap: {
	                shap: "",
	                key: "",
	                path: '',
	                x: '',
	                y: '',
	                textArea: '',
	                color: COLOR_GROUP_MAP[0],
	                level: 1,
	                hasRoom: true,
	                isMultiPath: false,
	                isLeft: true
	            }
	        });
	        var getInsertObj = function(addShap, oldShap) {
	            var shap = addShap.shap;
	            if (shap == 'path') {
	                var obj = {
	                    key: addShap.key,
	                    shap: shap,
	                    path: addShap.path,
	                    color: addShap.color
	                }
	                if (addShap.isMultiPath) {
	                    if (oldShap && oldShap.path) {
	                        obj.path = oldShap.path + obj.path;
	                    }
	                }
	            } else if (shap == 'center') {
	                obj = {
	                    key: addShap.key,
	                    shap: shap,
	                    level: addShap.level,
	                    x: addShap.x,
	                    y: addShap.y,
	                    text: 0
	                }
	                if (addShap.textArea) {
	                	obj.textArea = addShap.textArea;
	                }
	            } else if (shap == 'star') {
	                obj = {
	                    key: addShap.key,
	                    shap: shap,
	                    x: addShap.x,
	                    y: addShap.y
	                }
	                if (addShap.textArea) {
	                	obj.textArea = addShap.textArea;
	                }
	            } else if (shap == 'text') {
	                obj = {
	                    key: addShap.key,
	                    shap: shap,
	                    x: addShap.x,
	                    y: addShap.y
	                }
	                if (addShap.textArea) {
	                	obj.textArea = addShap.textArea;
	                }
	            }
	            return obj;
	        };
	        var getAddShap = function (obj, addShap) {

	        	var shap = obj.shap;
	            if (shap == 'path') {
	            	addShap.color = obj.color;
	            	if (COLOR_GROUP_MAP2[obj.color]) {
	            		vmConfigureBox.selectColor = COLOR_GROUP_MAP2[obj.color];
	            	} else {
	            		vmConfigureBox.textColor = obj.color;
	            	}
	            	vmConfigureBox.hasRoom = vmSvgMap.hasRoom.indexOf(obj.key) != -1;
	            	vmConfigureBox.isMultiPath = false;
	            } else if (shap == 'center') {
	            	vmConfigureBox.selectLevel = obj.level;
	            	addShap.x = obj.x;
	            	addShap.y = obj.y;
	            } else if (shap == 'star') {
	               	addShap.x = obj.x;
	            	addShap.y = obj.y;
	            } else if (shap == 'text') {
	                addShap.x = obj.x;
	            	addShap.y = obj.y;
	            }
	        };
	        window.vmConfigureBox = avalon.define({
	            $id: "configureBox",
				areaName: SVG_PATH.keyMap[SVG_PATH.key],
	            selectShapType: "",
	            selectColor: "0",
	            textColor: "",
	            selectLevel: '1',
	            isMultiPath: false,
	            hasRoom: true,
	            selectArea: "",
	            textArea: '',
	            areas: SVG_PATH.key,
	            areaShap: [SVG_PATH.key, ""],
	            info: '',
	            $onSelectchange2: true,
	            addShapFn: function() {
	                var addShap = vmSvgMap.addShap;
	                if (!addShap.shap || !addShap.key) return;
	                var shap = addShap.shap;
	                var svgTab = vmSvgMap.svgTab;
	                var hasSame = false;
	                //根据覆盖关系, 图形排序, path, center, text, star
	                var weight = {
	                    path: 1,
	                    center: 2,
	                    text: 3,
	                    star: 4
	                };
	                var oldShap = [];
	                var shapWeight = weight[shap];
	                var hasInsert = -1;
	                var i = 0,
	                    len = 0;
	                if (addShap.isLeft == false) {//右边编辑，先删除原图形
						var delRKey = selectShap.getAttribute('key');
						var delRShap = selectShap.getAttribute('data-shap');
						for (i = 0, len = svgTab.size(); i < len; i++) {
							var obj = svgTab[i];
							if (obj.key == delRKey && obj.shap == delRShap) {
								svgTab.splice(i, 1);
								break;
							}
						}
					}
	                for (i = 0, len = svgTab.size(); i < len; i++) {
	                    var obj = svgTab[i];
	                    var objWeight = weight[obj.shap];
	                    if (shapWeight == 3 && objWeight == 2 && obj.key == addShap.key) { //插入文字，点数据修正
	                        obj.text = 1;
	                    }
	                    if (objWeight > shapWeight) { //当前位置是该图像最后位置，插入图形
	                        hasInsert = i;
	                        break;
	                    } else if (objWeight == shapWeight) { //相同图形
	                        if (obj.key == addShap.key) {
	                            oldShap = svgTab.splice(i, 1);
	                            i--;
	                            len--;
	                        }
	                    }
	                }
	                var insertObj = getInsertObj(addShap, oldShap[0]);
	                if (hasInsert != -1) {
	                    if (insertObj.shap == 'center') {
	                        for (; i < len; i++) {
	                            var obj = svgTab[i];
	                            if (obj.shap == 'text' && obj.key == insertObj.key) {
	                                insertObj.text = 1;
	                            }
	                        }
	                    }
	                    svgTab.splice(hasInsert, 0, insertObj);
	
	                } else {
	                    svgTab.push(insertObj);
	                }
	                if (addShap.hasRoom) {
	                    vmSvgMap.hasRoom.ensure(addShap.key);
	                } else {
	                    vmSvgMap.hasRoom.removeAll([addShap.key]);
	                }
	            },
	            delShapFn: function() {
	                var addShap = vmSvgMap.addShap;
	                var svgTab = vmSvgMap.svgTab;
	                if (!addShap.shap || !addShap.key) return;
	                var isText = addShap.shap == 'text';
	                var len = svgTab.size();
	                var flag = false;
	                while (len--) {
	                    var obj = svgTab[len];
	                    if (obj.key == addShap.key) {
	                    	if (isText && obj.shap == 'center') {
	                    		obj.text = 0;
	                    	}
	                        if (obj.shap == addShap.shap) {
	                            svgTab.splice(len, 1);
	                        } else {
	                            flag = true;
	                        }
	                    }
	                }
	                if (!flag) {
	                    vmSvgMap.hasRoom.removeAll([addShap.key]);
	                }
	            },
	            delKeyFn: function() {
	                vmSvgMap.hasRoom.removeAll([vmConfigureBox.selectArea]);
	                vmSvgMap.svgTab.removeAll(function(shap) {
	                    return shap.key == vmConfigureBox.selectArea;
	                });
	            },
	            clearShapFn: function() {
	                vmSvgMap.svgTab.clear();
	                vmSvgMap.hasRoom.clear();
	            },
	            saveShapFn: function() {
	            	var keyMap = SVG_PATH.keyMap;
	            	var _keyMap = {};
	            	var svgTab = vmSvgMap.$model.svgTab;
	            	for (var i = 0, len = svgTab.length; i < len ; i++) {
	            		var obj = svgTab[i];
	            		if (obj.shap == 'path') {
	            			obj.color = COLOR_GROUP_MAP2[obj.color] || obj.color;
	            		}
	            		if (!obj.textarea) {
	            			_keyMap[obj.key] = SVG_PATH.keyMap[obj.key];
	            		}
	            	}
	                $.post(ROOT + '/admin/system/area/saveAreaMap.do', {
	                	areaId: AREA_ID,
	                	svgString: JSON.stringify({
	                		hasRoom: vmSvgMap.hasRoom.join(),
	                		svgData: svgTab,
	                		keyMap: _keyMap,
							areaName: vmSvgMap.areaName
	                	})
	                }, function (data) {
	                	for (var i = 0, len = svgTab.length; i < len ; i++) {
		            		var obj = svgTab[i];
		            		if (obj.shap == 'path') {
		            			obj.color = COLOR_GROUP_MAP[obj.color] || obj.color;
		            		}
		            	}
	                	if (data.result) {
	                		Win.alert('保存成功！');
	                	} else {
	                		Win.alert(data.message);
	                	}
	                }, 'json')
	            },
	            /*selectchange: function(val, m) {
	                var index = m.args[0].$index;
	                var areas = vmConfigureBox.areas;
	                if (SVG_PATH.keyTree[val] || val === "") {
	                    for (var i = areas.length - 1, end = index; i > end; i--) {
	                        areas.removeAt(i);
	                    }
	                    if (val !== "")
	                        areas.push("");
	                }
	                for (var i = index; i >= 0; i--) {
	                    if (areas[i]) {
	                        vmConfigureBox.areaShap = [areas[i], ""];
	                        break;
	                    }
	                }
	                vmSvgMap.svgTab = [];
	            },*/
	            selectchange2: function(val, m) {
	            	if (!vmConfigureBox.$onSelectchange2) return;
	            	//vmConfigureBox.textArea = "";
	                var index = m.args[0].$index;
		        	var areas = vmConfigureBox.areaShap;
	                if (SVG_PATH.keyTree[val] || val === "") {
	                    for (var i = areas.length - 1, end = index; i > end; i--) {
	                        areas.removeAt(i);
	                    }
	                    if (val !== "")
	                        areas.push("");
	                }
	                var len = areas.size();
	                while (len--) {
	                    if (areas[len] && areas[len] != "0" && len != 0) {
	                        vmConfigureBox.selectArea = areas[len];
	                        return;
	                    }
	                }
	                vmConfigureBox.selectArea = "";
	       
	            },
	            selectColorFn: function(c) {
	                vmConfigureBox.selectColor = c;
	            }
	        });
	        var watchCallBack = function(key, value, oldValue) {
	            var selectShapType = vmConfigureBox.selectShapType;
	            var selectArea = vmConfigureBox.selectArea;
	            var addShap = vmSvgMap.addShap;
	            if (key == "selectShapType") { //修改了图形
	                var showShap = selectShap || hoverShap;
	                var $showShap = $(showShap);
	                if (selectShapType == 'path') {
	                	var str = "";
	                    if (showShap.tagName == 'polygon') {
	                        str = "M" + $.trim(showShap.getAttribute('points')).split(' ').join('L') + 'Z';
	                    } else {
	                        str = showShap.getAttribute('d') || showShap.getAttribute('path');
	                    }
	                    addShap.path = str.replace(/\s+/g,'');
	                    /*.replace(/[MLHV].*?[CSQTZ]/gi, function (a) {
	                    	return a.replace(/\.\d+/g, '');
	                    });*/
	                } else if (selectShapType == 'center') {
	                    if (showShap.tagName.toLowerCase() == 'div') {
	                        addShap.x = parseInt($showShap.css('left'), 10)>>0;
	                        addShap.y = parseInt($showShap.css('top'), 10)>>0;
	                    } else {
	                        addShap.x = showShap.getAttribute('cx')>>0;
	                        addShap.y = showShap.getAttribute('cy')>>0;
	                    }
	                } else if (selectShapType == 'star') {
	                    if (showShap.tagName.toLowerCase() == 'div') {
	                        addShap.x = (parseInt($showShap.css('left'), 10)>>0) + 5;
	                        addShap.y = (parseInt($showShap.css('top'), 10)>>0) + 5;
	                    } else {
	                        addShap.x = showShap.getAttribute('cx')>>0;
	                        addShap.y = showShap.getAttribute('cy')>>0;
	                    }
	                } else if (selectShapType == 'text') {
						if (showShap.tagName.toLowerCase() == 'div') {
	                        addShap.x = (parseInt($showShap.css('left'), 10)>>0) + 5;
	                        addShap.y = (parseInt($showShap.css('top'), 10)>>0) + 5;
	                    } else {
	                        addShap.x = showShap.getAttribute('x')>>0;
	                        addShap.y = showShap.getAttribute('y')>>0;
	                    }
					}
	                if (selectShapType && selectArea) {
	                    addShap.shap = selectShapType;
	                } else {
	                    addShap.shap = "";
	                }
	            } else if (key == "textArea") {
	            	addShap.textArea = value;
	            } else if (key == "textColor" || key == "selectColor") {
	                addShap.color = vmConfigureBox.textColor || COLOR_GROUP_MAP[vmConfigureBox.selectColor];
	            } else if (key == "hasRoom" || key == "isMultiPath") {
	                addShap[key] = value;
	            } else if (key == "selectLevel") {
	                addShap.level = value;
	            } else if (key == "selectArea") {
	                addShap.key = value;
	                if (selectShapType && selectShapType != addShap.shap) {
	                    addShap.shap = selectShapType;
	                }
	            } else if (key == "areaName") {
					vmSvgMap.areaName = value;
				}
	        };
	        $.each("selectShapType,selectColor,textColor,selectLevel,isMultiPath,hasRoom,selectArea,textArea,areaName".split(','), function() {
	            vmConfigureBox.$watch(this, (function(key) {
	                return function(value, oldValue) {
	                    watchCallBack(key, value, oldValue);
	                }
	            })(this));
	        })
	
	        //vmSvgMap.svgTab = SVG_PATH.svgTab;
	        avalon.scan();
			
	        var selectShap = null;
	        var hoverShap = null;
	        var action = {
	            on: function(ele) {
	                if (!ele) return;
	                var isText = ele.tagName == 'text';
	                var oldStroke = ele.getAttribute('stroke');
	                var oldStrokeWidth = ele.getAttribute('stroke-width');
	                ele.setAttribute('stroke', 'red');
	                if (!isText) {
	                	ele.setAttribute('stroke-width', 6);
	                }
	                if (!ele.getAttribute('oldStroke')) {
	                    ele.setAttribute('oldStroke', oldStroke);
	                    ele.setAttribute('oldStrokeWidth', oldStrokeWidth);
	                }
	            },
	            off: function(ele) {
	                if (!ele) return;
	                var isText = ele.tagName == 'text';
	                var oldStroke = ele.getAttribute('oldStroke');
	                var oldStrokeWidth = ele.getAttribute('oldStrokeWidth');
	                ele.setAttribute('stroke', oldStroke);
	                if (!isText) {
	                	ele.setAttribute('stroke-width', oldStrokeWidth);
	                }
	            }
	        };
	        $('#svgLoad').on('mouseenter', 'polygon,path,circle', function() {
	            if (!selectShap) {
	                action.on(this);
	                hoverShap = this;
	               	vmSvgMap.addShap.isLeft = true;
	                vmConfigureBox.selectShapType = SHAP_MAP[this.tagName.toLowerCase()];
	            }
	        }).on('mouseleave', 'polygon,path,circle', function() {
	            if (!selectShap) {
	                action.off(this);
	                hoverShap = null;
	                vmConfigureBox.selectShapType = "";
	            }
	        }).on('click', 'polygon,path,circle', function() {
	            if (selectShap == this) {
	                action.off(selectShap);
	                selectShap = null;	          
	                vmConfigureBox.selectShapType = "";
	            } else {
	                action.off(selectShap);
	                action.on(this);
	                selectShap = this;
	                hoverShap = null;
	                vmSvgMap.addShap.isLeft = true;
	                vmConfigureBox.selectShapType = "";
	                vmConfigureBox.selectShapType = SHAP_MAP[this.tagName];
	            }
	        });
	        $('#addSvgBox').on('click', 'path,image,text', function() {
	            var key = this.getAttribute('key');
	            var shap = this.getAttribute('data-shap');
	            if (!key) return;
	            for (var i = 0, len = vmSvgMap.svgTab.size();i< len; i++) {
	            	var obj = vmSvgMap.svgTab[i];
	            	if (obj.key == key && obj.shap == shap) {
	            		var parentMap = SVG_PATH.parentMap;
	            		var mainKey = SVG_PATH.key;
	            		action.off(selectShap);
	            		if (selectShap == this) {
	            			selectShap = null;
	            		} else {
	            			selectShap = this;
	            			action.on(selectShap);
	            			vmSvgMap.addShap.isLeft = false;
	            			vmConfigureBox.selectShapType = shap;
	            			var tab = [key];
	            			var tKey = key;
	            			while((tKey = parentMap[tKey])) {
								tab.unshift(tKey);
	            			}
	            			vmConfigureBox.areaShap = [mainKey, ""];
	            			for (var i = 1, len = tab.length; i < len; i++) {
	            				vmConfigureBox.$onSelectchange2 = false;
            					setTimeout((function(i, k, isEnd) {
	            					return function () {
	            						vmConfigureBox.areaShap.set(i, k);
	            						if (SVG_PATH.keyTree[k]) {
	            							vmConfigureBox.areaShap.push("");
	            						}
	            						if (isEnd) {
	            							vmConfigureBox.selectArea = k;
	            							vmConfigureBox.textArea = obj.textArea;
	            							vmConfigureBox.$onSelectchange2 = true;
	            						}
	            					}
	            				})(i, tab[i], i == len-1), i*100);       				
	            			}
	            			getAddShap(obj, vmSvgMap.addShap);
	            		} 
	            		break;
	            	}
	            }
	            vmConfigureBox.info = '显示 <span style="color:#79d466;">' + SVG_PATH.keyMap[key] + '</span> 数据';
	        }).on('mouseenter', 'path,image,text', function() {
	            var key = this.getAttribute('key');
	            vmSvgMap.selectCode = key;
				if (key) {
					vmConfigureBox.info = '显示 <span style="color:#79d466;">' + SVG_PATH.keyMap[key] + '</span> 数据';
				}
	        }).on('mouseleave', 'path,image,text', function() {
	            vmSvgMap.selectCode = "";
	            vmConfigureBox.info = '';
	        });
	        
	        var _clearSelect;
	        if (window.getSelection) {
	            _clearSelect = function() {
	                window.getSelection().removeAllRanges()
	            }
	        } else {
	            _clearSelect = function() {
	                document.selection.empty();
	            }
	        }
	        $('.circle-btn,.text-btn').on('mousedown', function(e) {
	            _clearSelect();
	            var $elm = $(this);
	            var $parent = $elm.parent();
	            var mouse = [e.clientX, e.clientY],
	                start = [parseInt($elm.css('left'), 10), parseInt($elm.css('top'), 10)];
	            if (selectShap != this) {
	                action.off(selectShap);
	                selectShap = this;
	                hoverShap = null;
	                vmConfigureBox.selectShapType = "";
	                vmConfigureBox.selectShapType = this.getAttribute('data-shap');
	            }
	            $parent.on("mousemove", function(e) {
	                _clearSelect();
	                var left = start[0] + e.clientX - mouse[0];
	                var top = start[1] + e.clientY - mouse[1];
	                if (vmSvgMap.addShap.shap == 'star') {
	                    vmSvgMap.addShap.x = left + 5;
	                    vmSvgMap.addShap.y = top + 5;
	                } else {
	                    vmSvgMap.addShap.x = left;
	                    vmSvgMap.addShap.y = top;
	                }
	
	                $elm.css({
	                    left: left,
	                    top: top
	                });
	            }).one("mouseup", function() {
	                $parent.off("mousemove");
	            });
	        });
 			window.uploadSwf = new UploadFile($id("uploadCont"), "uploadSwf", ROOT + "/public/upload/uploadFile.swf", {
		        fileType : "*.svg",
		        typeDesc : "svg图片",
		        autoStart : true,
		        server: encodeURIComponent(ROOT + "/admin/system/area/readMapFile.do?areaId=" + AREA_ID)		
 			});
		 	/* 注册一些自定义事件 */
		 	uploadSwf.uploadEvent.add("noticeTypeError",function(){
		 		var data = arguments[0].message;
		 		Win.alert("文件类型错误：只支持以下文件类型：" + data[0]);
		 	});
		 	uploadSwf.uploadEvent.add("noticeSizeError",function(){
		 		var data = arguments[0].message;
		 		Win.alert("上传文件过大：限制大小：" + (data[0]/1024/1024)+"MB");
		 	});
		 	uploadSwf.uploadEvent.add("onSelect",function(){
		         uploadSwf.startUpload();
		 	});
		 	uploadSwf.uploadEvent.add("onComplete",function(){
		 		var data = arguments[0].message;
		 		if (data.indexOf('0:') == 0 ) {
		 			Win.alert(data.substring(2));
		 		} else {
		 			$('#svgLoad').html(data.replace(/^.*?<\s*svg\s*/, '<svg ').replace(/<\/\s*svg\s*>.*?$/, '</svg>'));
		 		}	 		
		 	});
		 	$('#svgLoad').html('${mapSource}'.replace(/^.*?<\s*svg\s*/, '<svg ').replace(/<\/\s*svg\s*>.*?$/, '</svg>'));
	    	var dataBase = ${mapOutput};
	    	dataBase.svgData = dataBase.svgData || [];
	    	if (dataBase.hasRoom) {
	    		vmSvgMap.hasRoom = dataBase.hasRoom.split(',');
	    	} else {
	    		vmSvgMap.hasRoom = [];
	    	}
	    	if (typeof dataBase.areaName != "undefined")
				vmConfigureBox.areaName = dataBase.areaName;
			
	    	var svgData = dataBase.svgData;
	    	for (var i =0 ,len = svgData.length; i < len; i++) {
	    		var obj = svgData[i];
	    		if (obj.shap == 'path') {
	    			obj.color = COLOR_GROUP_MAP[obj.color] || obj.color;
	    		}
	    	}
	    	vmSvgMap.svgTab = dataBase.svgData;
	    	
	    	
	    	var $mapPopTip = $('<div class="map-popTip"><div class="map-popTip-l"></div><div class="map-popTip-m"></div><div class="map-popTip-r"></div></div>').appendTo('body');
	    	var mapPopTipTime = 0;
	    	$('#addSvgBox').on('mouseenter', 'text', function (){
	    		var pathKey = this.getAttribute('key');
	    		var shap = this.getAttribute('data-shap');
	    		if (shap == 'star') {
	    			var elm = this;
	    			var textArea = this.getAttribute('textarea');
	    			clearTimeout(mapPopTipTime);
	    			mapPopTipTime = setTimeout(function(){
	    				var offset = $(elm).offset();
	    				$mapPopTip.css({left: offset.left-10, top: offset.top-30});
						$mapPopTip.find('.map-popTip-m').html( textArea || SVG_PATH.keyMap[pathKey]);
						$mapPopTip.show();
					},200);
	    		}
	    	}).on('mouseleave', 'text', function (){
	    		clearTimeout(mapPopTipTime);
	    		$mapPopTip.hide();
	    	})

	    	var $configureBox = $('.configure-box');
	    	var activeBox = 'left';
	    	$('.svg-box').on('mouseenter', function (){
	    		if (activeBox != 'left') {
	    			$configureBox.css({
	    				left: 670,
	    				right: "auto"
	    			});
	    			activeBox = 'left';
	    		}
	    	})
			$('#addSvgBox').on('mouseenter', function (){
	    		if (activeBox != 'right') {
	    			$configureBox.css({
	    				right: 670,
	    				left: "auto"
	    			});
	    			activeBox = 'right';
	    		}
	    	})
	    });
    </script>
</head>

<body>
    <div class="configure-box" ms-controller="configureBox">
        <div>配置地图信息
            <a href="javascript:;" id="uploadBtn" class="map-btn uploadBoxMap" onclick="return false;">
				载入svg图形<span id="uploadCont" class="uploadCont"></span>
			</a>         
            <button class="map-btn" ms-click="saveShapFn">保存svg数据</button>
        </div>
        <div>选择配置区域
            <div style="display: inline-block;margin-left: 5px;color:#79d466;">{{SVG_PATH.keyMap[areas]}}</div>
            <input ms-duplex="areaName">
            <button class="map-btn del-btn" ms-click="clearShapFn">清空图形</button>
            <!--span ms-each-area="areas">
                    <select  ms-if-loop="$index != 0" ms-duplex="area" data-duplex-changed="selectchange">
                        <option value="">请选择</option>
                        <option ms-repeat="SVG_PATH.keyTree[areas[$index-1]]" ms-attr-value="{{el}}">{{SVG_PATH.keyMap[el]}}</option>
                    </select>
                </span-->
        </div>
        <div>当前选择图形
            <div style="display: inline-block;margin-left: 5px;color:#79d466;">{{SHAP_NAME_MAP[selectShapType]}}</div>
            <span ms-if="selectShapType=='center' || selectShapType=='star'">
                    <label><input ms-duplex-string="selectShapType" type="radio" value="center"/>行政中心</label>
                    <label><input ms-duplex-string="selectShapType" type="radio" value="star"/>星星</label>
                </span>
        </div>
       
        <div>图形对应区域
            <span ms-each-area="areaShap">
                    <select  ms-if-loop="$index != 0" ms-duplex="area" data-duplex-changed="selectchange2">
                        <option value="">请选择</option>
                        <option ms-repeat="SVG_PATH.keyTree[areaShap[$index-1]]" ms-attr-value="{{el}}" ms-attr-selected="{{el==area}}" >{{SVG_PATH.keyMap[el]}}</option>
                    </select>
                </span>
            <button class="map-btn del-btn" ms-click="delKeyFn">清空区域</button>
        </div>
        <div ms-if="selectShapType=='center' || selectShapType=='star' || selectShapType=='text'" >页面显示文字
             <input ms-duplex="textArea">
        </div>
        <div ms-if="selectShapType=='path'" class="color-sel">颜色值
            <div class="color1" ms-class="sel:selectColor=='0' && !textColor" ms-click="selectColorFn('0')"></div>
            <div class="color2" ms-class="sel:selectColor=='1' && !textColor" ms-click="selectColorFn('1')"></div>
            <div class="color3" ms-class="sel:selectColor=='2' && !textColor" ms-click="selectColorFn('2')"></div>
            <div class="color4" ms-class="sel:selectColor=='3' && !textColor" ms-click="selectColorFn('3')"></div>
            <div class="color5" ms-class="sel:selectColor=='4' && !textColor" ms-click="selectColorFn('4')"></div>
            <label>
                <input ms-duplex="textColor">
            </label>
        </div>
        <div ms-if="selectShapType=='path'">
            <label>
                <input type="checkbox" ms-duplex-checked="isMultiPath">支持多块</label>
            <label>
                <input type="checkbox" ms-duplex-checked="hasRoom">存在在线教室</label>
        </div>
        <div ms-if="selectShapType=='center'">
            <select ms-duplex="selectLevel">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
            </select><img ms-attr-src="${root}/public/img/map/{{selectLevel}}.png" ms-attr-alt="等级{{selectLevel}}" style="margin-left:5px;" width='10px;' height="10px;">
        </div>
        <div>
            <button class="map-btn" ms-click="addShapFn">添加图形</button>
            <button class="map-btn del-btn" ms-click="delShapFn">删除图形</button>
        </div>
        <div>{{info|html}}</div>
    </div>
    <div ms-controller="svgMap" style="float: right;" id="addSvgBox">
        <div class='circle-btn' data-shap="center"></div>
        <div class='text-btn' data-shap="text"></div>
        <svg height="660" version="1.1" width="660" style="overflow: hidden; position: relative;" xmlns="http://www.w3.org/2000/svg">
			<text ms-attr-x="{{660-15*areaName.length}}" y="30" text-anchor="middle" stroke="none" fill="#000000" font-size="30px" font-family="Microsoft YaHei,微软雅黑,STXihei,华文细黑,serif">{{areaName}}</text>
			<g ms-each-shap="svgTab">
                <path ms-if-loop="shap.shap == 'path'" ms-attr-fill="{{shap.color.split(',')[hasRoom.indexOf(shap.key)!=-1?(selectCode==shap.key?1:0):2]}}" ms-attr-d="shap.path" ms-attr-key="shap.key" stroke="#eeeeee" stroke-width="2" stroke-linejoin="round" style="cursor: pointer;" data-shap="path"></path>
                <image ms-if-loop="shap.shap == 'center'" ms-attr-x="shap.x" ms-attr-y="shap.y" width="10" height="10" ms-attr-xlink:href="${root}/public/img/map/{{shap.level}}.png" xlink:href="" style="cursor: pointer;" ms-attr-key="shap.key" data-shap="center"/>
                <text ms-if-loop="shap.shap == 'center' && shap.text != 1" ms-attr-x="shap.x" ms-attr-y="shap.y" text-anchor="middle" stroke="none" fill="#000000" font-size="15px" font-family="Microsoft YaHei,微软雅黑,STXihei,华文细黑,serif" style="cursor: pointer;" ms-attr-key="shap.key" data-shap="center">{{shap.textArea||SVG_PATH.keyMap[shap.key]}}</text>
                <text ms-if-loop="shap.shap == 'text'" ms-attr-x="shap.x" ms-attr-y="shap.y" text-anchor="middle" stroke="none" fill="#000000" font-size="15px" font-family="Microsoft YaHei,微软雅黑,STXihei,华文细黑,serif" style="cursor: pointer;" ms-attr-key="shap.key" data-shap="text">{{shap.textArea||SVG_PATH.keyMap[shap.key]}}</text>
                <text ms-if="shap.shap == 'star'" ms-attr-x="shap.x" ms-attr-y="shap.y" text-anchor="middle" stroke="none" fill="#FF2424" font-size="15px" font-family="Microsoft YaHei,微软雅黑,STXihei,华文细黑,serif" style="cursor: pointer;" ms-attr-key="shap.key" data-shap="star" ms-attr-textarea="shap.textArea" >★</text>
            </g>
            <g ms-if="addShap.key && addShap.isLeft">
	            <path ms-if="addShap.shap == 'path'" ms-attr-fill="{{addShap.color.split(',')[addShap.hasRoom?(selectCode==addShap.key?1:0):2]}}" fill-opacity="0.5" stroke="#eeeeee" stroke-width="2" stroke-dasharray="5,5" stroke-linejoin="round" style="cursor: pointer;" ms-attr-d="addShap.path" ms-attr-key="addShap.key" data-shap="path"></path>
	            <image ms-if="addShap.shap == 'center'" ms-attr-x="addShap.x" ms-attr-y="addShap.y" width="10" height="10" ms-attr-xlink:href="${root}/public/img/map/{{addShap.level}}.png" xlink:href="" style="cursor: pointer;" ms-attr-key="addShap.key" data-shap="center"/>
	            <text ms-if="addShap.shap == 'center' && addShap.text != 1" ms-attr-x="addShap.x" ms-attr-y="addShap.y" text-anchor="middle" stroke="none" fill="#000000" fill-opacity="0.5" font-size="15px" font-family="Microsoft YaHei,微软雅黑,STXihei,华文细黑,serif" style="cursor: pointer;" ms-attr-key="addShap.key" data-shap="center">{{addShap.textArea||SVG_PATH.keyMap[addShap.key]}}</text>
	            <text ms-if="addShap.shap == 'text'" ms-attr-x="addShap.x" ms-attr-y="addShap.y" text-anchor="middle" stroke="none" fill="#000000" fill-opacity="0.5" font-size="15px" font-family="Microsoft YaHei,微软雅黑,STXihei,华文细黑,serif" style="cursor: pointer;" ms-attr-key="addShap.key" data-shap="text">{{addShap.textArea||SVG_PATH.keyMap[addShap.key]}}</text>
	            <text ms-if="addShap.shap == 'star'" ms-attr-x="addShap.x" ms-attr-y="addShap.y" text-anchor="middle" stroke="none" fill="#FF2424" fill-opacity="0.5" font-size="15px" font-family="Microsoft YaHei,微软雅黑,STXihei,华文细黑,serif" style="cursor: pointer;" ms-attr-key="addShap.key" data-shap="star" ms-attr-textarea="addShap.textArea" >★</text>
            </g>
        </svg>
    </div>
    <div class="svg-box" style="float: left;">
        <div class='circle-btn' data-shap="center"></div>
        <div class='text-btn' data-shap="text"></div>
        <div id="svgLoad" style="float: left;"></div>
    </div>
</body>

</html>
