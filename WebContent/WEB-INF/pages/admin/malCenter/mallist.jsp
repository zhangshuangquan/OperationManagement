<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/meta.jsp" %>
	<link media="all" type="text/css" rel="stylesheet" href="${root}/public/css/photo.css"/>
	<script src="${root }/public/js/customer.js" type="text/javascript"></script>
    <link href="${root}/public/calendar/skin/WdatePicker.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${root}/public/calendar/WdatePicker.js"></script>
     <script type="text/javascript" src="${root}/public/js/basiccheck.js"></script>
     <script src="${root}/public/js/jsTree.js" type="text/javascript"></script>
	<style>
	.tree-warp.jsTree-warper {
		background-color: #fff;
		border: 1px solid #999;
		display: none;
		min-width: 157px;
		position: absolute;
	}
	</style>
</head>
<body>
<h3 id="cataMenu">
	<a href="javascript:;">报修中心</a> &gt; <a href="javascript:;">欢迎页</a>
</h3>
	<form id="form">
<div id="control">
	<div id="controlContent">
		<ul class="searchWrap">
			<li>
				<label class="text">行政区：</label>
					<span class="cont" id="chooseArea">
						<select class="mr20" id="province" name = "province">
							<option value="-1">请选择</option>
						</select>
					</span>
		         <label class="labelText">学校名称：</label><input type="text" id="sname" value=""  name="clsSchoolName"/>
	      		 <label class="labelText">报修编号：</label><input type="text" id="malfunction_code" value="" name="malCode" />
	            <label class="labelText">报修时间：</label>
	            <input type="text" class="Wdate" id="createTimeStart" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeEnd\')}'});" value="" name="createTimeStart">
	            --
	            <input type="text" class="Wdate" id="createTimeEnd" onclick="WdatePicker({minDate:'#F{$dp.$D(\'createTimeStart\')}'});" value="" name="createTimeEnd">
	        	<label class="labelText">
	         		   状态：
	            </label>
	            <select id="status" name="status">
	                <option value="">请选择</option>
	                <option value="NEW">待处理</option>
	                <option value="PROGRESS">处理中</option>
	                <option value="DONE">已处理</option>
	                <option value="VERIFIED">已验收</option>
	            </select>
         	</li>
	       	<li>
            <label class="labelText">故障类别：</label>
			 <div id="WebDesign" class="tree-select"> 
			     <div class="tree-selectVal"> 
			        <input readonly="readonly" value="请选择">
			    </div>  
			   <span class="tree-warp"></span>
			 </div> 
		<a href="javascript:;" id="editType">编辑故障类别</a>
<input type="hidden" id="classificationId" needcheck nullMsg="请请选择故障类别!" name="catalogId" value="">
<input type="hidden" id="classificationLevel" name="classificationLevel" value="">
        <label class="labelText">
            报修人：</label><input type="text" value="" id="repairman" maxlength="20"  name="reporter">
           <!--  <span style="display:block;" class="errorTip" id="repairman_tip"></span> -->
        <label class="labelText">
            处理人：</label><input type="text" value="" id="processors" maxlength="20" name="repairman">
        <label class="labelText">预计处理时间：</label>
            <input type="text" class="Wdate" id="planprocess_fromtime" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'planprocess_totime\')}'});" value="" name="planRepairTimeStart">
            --
            <input type="text" class="Wdate" id="planprocess_totime" onclick="WdatePicker({minDate:'#F{$dp.$D(\'planprocess_fromtime\')}'});" value="" name="planRepairTimeEnd">
	       		<input type="button" class="submit btn" name="query" value="查询"  onclick = "listAsync(1);"/>
	       	</li>
	    </ul>
		</form>
	  	<div class="totalPageBox">总共<span class="totalNum">0</span> 条数据</div>
		<table class="tableBox">
			<tr>
				<th width="6%">报修编号</th>
                <th width="7%">报修时间</th>
                <th width="6%">一级分类</th>
                <th width="6%">二级分类</th>
                <th width="6%">三级分类</th>
                <th width="6%">学校</th>
                <th width="6%">报修人</th>
                <th width="5%">报修人电话</th>
                <th width="6%">处理人</th>
                <th width="5%">处理人电话</th>
                <th width="6%">预计处理日期</th>
                <th width="4%">状态</th>
                <th width="6%">查看和编辑</th>
                <th width="6%">修改状态</th>
			</tr>
			<tbody id="mals">
			</tbody>
	</table>
	<div id="pageNavi"></div>
</div>
</div>	 	
<script>
$(document).ready(function(){
	$.post("${root}/admin/orgUser/getAreaByparentId.do",{"parentId":"-1"},function(data){
		var html = '<option value="-1">请选择</option>';
		for(var i = 0,j = data.length; i<j; i++){
			html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
		}
		$("#province").html(html);
	},'json');
	selectBind("chooseArea","${root}/admin/orgUser/getAreaByparentId.do","parentId");
});
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

var currPage=1;
var  PROGRESS ='PROGRESS';
var DONE = 'DONE';
//动态的创建一个table，同时将后台获取的数据动态的填充到相应的单元格  
function createShowingTable(data,total,req) {
	$(".totalNum").html(total);
	 //获取后台传过来的jsonData,并进行解析  
	//alert("-----   进入当前的数据展现:" + data.pageCount);
	var dataArray = data;
	//此处需要让其动态的生成一个table并填充数据  
	var tableStr = "";
	var len = dataArray.length;
	if (len > 0) {
		 for ( var i = 0; i < len; i++) {
			tableStr += '<tr><td>' + '<a href="javascript:;" onclick="openDetail(\''+data[i].malDetailId+'\')">'+dataArray[i].malCode+'</a>';
			tableStr += "</td><td>" + dataArray[i].createTime
				+ "</td><td>" + (dataArray[i].malCatalogName1 == null ?'':dataArray[i].malCatalogName1)
				+ "</td><td>" + (dataArray[i].malCatalogName2 == null ?'':dataArray[i].malCatalogName2)
				+ "</td><td>" + (dataArray[i].malCatalogName3 == null ?'':dataArray[i].malCatalogName3)
				+ "</td><td>" + (dataArray[i].clsSchoolName== null ?'':dataArray[i].clsSchoolName)
				+ "</td><td>" + (dataArray[i].reporter== null ?'':dataArray[i].reporter)
				+ "</td><td>" + (dataArray[i].reporterContact== null ?'':dataArray[i].reporterContact)
				+ "</td><td>" + (dataArray[i].repairman== null ?'':dataArray[i].repairman)
				+ "</td><td>" + (dataArray[i].repairmanContact== null ?'':dataArray[i].repairmanContact)
				+ "</td><td>" + (dataArray[i].planRepairTime== null ?'':dataArray[i].planRepairTime);
				if(dataArray[i].status == 'NEW' ){
					//待处理
					tableStr += '</td><td>' + '待处理'
					+ '</td><td>' + '<a href="javascript:;" onclick="openDetail(\''+data[i].malDetailId+'\')">查看</a> <a href="javascript:;" onclick="edit(\''+data[i].malDetailId+'\')">编辑</a>'
					+ '</td><td>' + '<a href="javascript:;" onclick="edit(\''+data[i].malDetailId+'\',\'PROGRESS\')">进入处理</a>'
					+ '</td></tr>';
				}else if(dataArray[i].status == 'PROGRESS' ){
					//处理中
					tableStr += '</td><td>' + '处理中'
					+ '</td><td>' + '<a href="javascript:;" onclick="openDetail(\''+data[i].malDetailId+'\')">查看</a> <a href="javascript:;" onclick="edit(\''+data[i].malDetailId+'\')">编辑</a>'
					+ '</td><td>' + '<a href="javascript:;" onclick="edit(\''+data[i].malDetailId+'\',\'DONE\')">处理完成</a>'
					+ '</td></tr>';
				}else if(dataArray[i].status == 'DONE' ){
					//已处理
					tableStr += '</td><td>' + '已处理'
					+ '</td><td>' + '<a href="javascript:;" onclick="openDetail(\''+data[i].malDetailId+'\')">查看</a> <a href="javascript:;" onclick="edit(\''+data[i].malDetailId+'\')">编辑</a>'
					+ '</td><td>' 
					+ '</td></tr>';
				}else if(dataArray[i].status == 'VERIFIED' ){
					//已验收
					tableStr += '</td><td>' + '已验收'
					+ '</td><td>' + '<a href="javascript:;" onclick="openDetail(\''+data[i].malDetailId+'\')">查看</a> '
					+ '</td><td>'
					+ '</td></tr>';
				}
		} 	
	} else {
		tableStr += '<tr><td colspan="14">抱歉，未查询到相关记录 </td></tr>';
	}
 
	//alert(tableStr);
	$("#mals").html(tableStr||'<tr/>');
	window.scrollTo(0,0);
	
	$("a.assignExam").click(function(){
		popAssignExam($(this).attr("value"));
		return false;
	}); 
	$("a.delExam").click(function(){
		delExamAsync($(this).attr("value"));
	}); 
	
}
 

$(function() {
	listAsync(1);
});

function listAsync( currentPage) {
		var formdata = $("#form").serialize();
		var baseAreaId = getBaseAreaId('chooseArea');
		formdata +="&baseAreaId="+baseAreaId;
		currPage=currentPage;
		var criteria = {
				'currentPage' : currentPage
			};
	    var url = '${root}/admin/malCenter/searchlist.do?'+formdata;
		 var mySplit = new SplitPage({
		        node : $id("pageNavi"),
		        url : url,
		        data :  criteria,
		        count : 20,
		        callback : createShowingTable,
		        type : 'get' //支持post,get,及jsonp
		    });			 
	
		 mySplit.search(url,criteria);
}
function edit(malDetailId,upstatus){
    win_edit_malfunction = Win.open({
        'id':'edit_malfunction',
        'title':'更新处理信息',
        'url':'${root}/admin/malCenter/toeditmal.do?id='+malDetailId+'&upstatus='+upstatus,
        'width':563,
        'height':560
    });
}
function openDetail(malDetailId){
    win_edit_malfunction = Win.open({
        'id':'edit_malfunction',
        'title':'查看处理信息',
        'url':'${root}/admin/malCenter/viewmal.do?id='+malDetailId,
        'width':563,
        'height':560
    });
}

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
</body>
</html>