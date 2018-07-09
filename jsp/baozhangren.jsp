<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
	<%@ include file="head.jsp"%>
<meta http-equiv="X-UA-Compatible" content="IE=8,edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>财务集中管理报账平台</title>
<script>
var index_box;
var codenow ='';
var namenow ='';
var arr ='';
var arr1 ='';
var arr2 ='';
$(document).ready(function(){
	$("#baozhangren").attr("style","background-color: green;");
	$.ajax({
		type : "POST",  
	    url : "<%=request.getContextPath()%>/user/billtype.do",
        contentType : 'application/json',
	    dataType: "json",
	    success : function(data){
	    	if(data.state=="true"){
	    		for(var i = 0;i<data.bills.length;i++){
	    			$('.index-box .col-md-2').find('a').each(function(){
						if($(this).attr('href').indexOf(data.bills[i])>0){
							$(this).parents('.col-md-2').show();
						}
					})
	    		}
	    		codenow = data.bills;
			}else{
				alert(data.error);
			}
	    }
	})  
	
	loadProperties();
});

$(window).load(function() {
	getInfo();
});

function toAdd_onClick(pk_billtype) {  //到增加记录页面
    window.location="<%=request.getContextPath()%>/loanbill/addBill.do?pk_billtype="+pk_billtype;
}

function seachBillType(){
	var inputname = $('input[name="bill_type"]').val();
	if(inputname == ''||inputname == '请在此搜索报账类型'){
		$('.index-box .col-md-2').find('a').each(function(){
					for(var i =0;i<codenow.length;i++){
						if($(this).attr('href').indexOf(codenow[i])>0){
							$(this).parents('.col-md-2').show();
					    }
					}
		});
		return;
	}
	
		$('.index-box .col-md-2').find('a').each(function(){
			var name = $(this).children().children('p').text()
				if(name.indexOf(inputname)>=0){
					for(var i =0;i<codenow.length;i++){
						if($(this).attr('href').indexOf(codenow[i])>0){
							$(this).parents('.col-md-2').show();
							var name = $(this).children().children('p');
							break;
						}else{
							$(this).parents('.col-md-2').hide();
						}
					}
				}else{
					$(this).parents('.col-md-2').hide();
				}
		});
	
}
function viewBill_onClick(id,billtype){
	 window.location="<%=request.getContextPath()%>/loanbill/viewBill.do?pk_loanbill="+id+"&billtype="+billtype+"&action=backBillView"; 
 }
    function getInfo(){

    	$("li[name='index']").addClass('active');

	//系统通知查询
    	 $.ajax({
    	    type : "POST",
    	    url : "<%=request.getContextPath()%>/pubmessage/getpubmessage.do",
            contentType : 'application/json',
    	    dataType: "json",
    	    error:function(data){
//     	    	alert("系统通知查询失败，请联系管理员。");
    	    	$("tbody[name='pubNotices']").children('tr').remove();
    	    	$("tbody[name='pubNotices']").append("<tr><td><font color='red'>系统通知查询失败，请联系管理员。</font></td></tr>");
    	    },
    	    success : function(data){
    	    	if(data.state=="true"){
    	    		$("tbody[name='pubNotices']").children('tr').remove();
        	    	for(var i=0;i<data.msgList.length;i++){
        	    		$("tbody[name='pubNotices']").append("<tr><td><div style='width:540px;' overflow:hidden; title='"+data.msgList[i].title+"' class='splitStr'><a href = 'javascript:void(0)' onclick = 'javascript:openPubMessageinfo(\""+data.msgList[i].pk_messageinfo+"\");'><font id='styleOne' style='display:block;width: 540px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;'>"+data.msgList[i].title+"</font></a></div></td><td width='85'>"+data.msgList[i].senddate.substring(2, 10)+"</td></tr>");
        	    	}
    	    	}else if(data.state=="false"){
    	    		$("tbody[name='pubNotices']").children('tr').remove();
    	    		$("tbody[name='pubNotices']").append("<tr><td><font color='red'>"+data.error+"</font></td></tr>");
    	    	}
    	    	
    	    }
    	}); 

    		//待处理单据
    	    	 $.ajax({
    	    	    type : "POST",
    	    	    url : "<%=request.getContextPath()%>/loanbill/savedBillPageExap.do?statetype=dcl",
    	            contentType : 'application/json',
    	    	    dataType: "json",
    	    	    error:function(data){
    	    	    	$("tbody[name='pendingBill']").children('tr').remove();
    	    	    	$("tbody[name='pendingBill']").append("<tr><td><font color='red'>待处理单据查询失败，请联系管理员。</font></td></tr>");
    	    	    },
    	    	    success : function(data){
    	    	    	if(data.state=="true"){
    	    	    		$("tbody[name='pendingBill']").children('tr').remove();
    	        	    	for(var i=0;i<data.beans.length;i++){
    	        	    		$("tbody[name='pendingBill']").append("<tr><td><div style='width:240px;' overflow:hidden; title='"+data.beans[i].vbillno+"' class='splitStr'><a href = 'javascript:void(0)' onclick = 'javascript:viewBill_onClick(\""+data.beans[i].pk_loanbill+"\",\""+data.beans[i].billtypecode+"\");'><font id='styleOne' style='display:block;width: 240px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;'>"+data.beans[i].vbillno+"</font></a></div></td><td width='360'><div style='width:340px;' overflow:hidden; title='"+data.beans[i].digest+"' class='splitStr'><font  style='display:block;width: 340px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;'>"+data.beans[i].digest+"</font></div></td><td width='85'>"+data.beans[i].billdate.substring(2, 10)+"</font></td></tr>");
    	        	    	}
    	    	    	}else if(data.state=="false"){
    	    	    		$("tbody[name='pendingBill']").children('tr').remove();
    	    	    		$("tbody[name='pendingBill']").append("<tr><td><font color='red'>"+data.error+"</font></td></tr>");
    	    	    	}
    	    	    	
    	    	    }
    	    	}); 
    


		    	//补退单信息
		    	$.ajax({
		    	    type : "POST",
		    	    url : "<%=request.getContextPath()%>/workflow/getBtdListExce.do",
		            contentType : 'application/json',
		    	    dataType: "json",
		    	    error:function(data){
 						//alert("补退单信息查询失败，请联系管理员!");
		    	    	$("tbody[name='getBillMsg']").children('tr').remove();
		    	    	$("tbody[name='getBillMsg']").append("<tr><td><font color='red'>补退单信息查询失败，请联系管理员!</font></td></>");
		    	    },
		    	    success : function(data){
		    	    	if(data.state=="true"){
		    	    		$("tbody[name='getBillMsg']").children('tr').remove();
				    	    for(var i=0;i<data.list.length;i++){
		            	    	$("tbody[name='getBillMsg']").append("<tr><td  onclick= \"viewBill_onClick('"+data.list[i].billid+"','"+data.list[i].billtypecode+"') \"><div title="+data.list[i].billno+" class='splitStr' style='width:200px;' ><font id='styleOne'>"+data.list[i].billno+"</font></div></td><td ><div class='splitStr' style='width:880px;'  overflow:hidden; title="+data.list[i].checknote+"><font style='display:block;width: 880px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;'>"+data.list[i].checknote+"</font></div></td><td style=' width: 85px;'>"+data.list[i].checkmanname+"</td><td style=' width: 85px;'>"+data.list[i].senddate.substring(2, 10)+"</td></tr>");
				    	    }
		    	    	}else{
		    	    		$("tbody[name='getBillMsg']").children('tr').remove();
			    	    	$("tbody[name='getBillMsg']").append("<tr><td><font color='red'>"+data.error+"</font></td></>");
		    	    	}
		    	    	

		    	    }
		    	});
    }
    function viewBill_onClick(id,billtype){
 	   window.location="<%=request.getContextPath()%>/loanbill/viewBill.do?pk_loanbill="+id+"&billtype="+billtype+"&action=savedView"; 
 	  }
    //系统通知详情
     function openPubMessageinfo(messageid){
    	$.ajax({
    	    type : "POST",
    	    url : "<%=request.getContextPath()%>/pubmessage/getMessagebyid.do?pk="+messageid,
            contentType : 'application/json',
    	    dataType: "json",
    	    error:function(data){
			//alert("系统通知查询失败，请联系管理员。");
    	    },
    	    success : function(data){
    		    	$("div[name=gonggao1] pre[name=gonggaot]").text(data.msg.title+"\n\n");
    		    	$("div[name=gonggao1] pre[name=gonggao]").text(data.msg.context+"\n\n");
    		    	$("div[name=gonggao1] pre[name=gonggaow]").text("\n发布时间："+data.msg.senddate+"\n发送人:"+data.msg.psnname+"\n部门:"+data.msg.deptname);
					$('#xttzModal').show();
    	    }
    	});
    }; 



//锁定屏幕
function zhezhao(){
	document.getElementById('zhezhao').style.display = "block";
}
//解锁屏幕
function zhezhaofinish(){
	document.getElementById('zhezhao').style.display = "none";
}
function setleaderCensor_onClick(){  //单据审批
	this.location.href="<%=request.getContextPath()%>/common/getLeaderCensor";
}
function closeMod(){
	$('#xttzModal').hide();
}
function dclOnclick(){
	//待处理单据
	 $.ajax({
	    type : "POST",
	    url : "<%=request.getContextPath()%>/loanbill/savedBillPageExap.do?statetype=dcl",
       contentType : 'application/json',
	    dataType: "json",
	    error:function(data){
	    	$("tbody[name='pendingBill']").children('tr').remove();
	    	$("tbody[name='pendingBill']").append("<tr><td><font color='red'>待处理单据查询失败，请联系管理员。</font></td></tr>");
	    },
	    success : function(data){
	    	if(data.state=="true"){
	    		$("tbody[name='pendingBill']").children('tr').remove();
   	    	for(var i=0;i<data.beans.length;i++){
	    		$("tbody[name='pendingBill']").append("<tr><td><div style='width:240px;' overflow:hidden; title='"+data.beans[i].vbillno+"' class='splitStr'><a href = 'javascript:void(0)' onclick = 'javascript:viewBill_onClick(\""+data.beans[i].pk_loanbill+"\",\""+data.beans[i].billtypecode+"\");'><font id='styleOne' style='display:block;width: 240px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;'>"+data.beans[i].vbillno+"</font></a></div></td><td width='360'><div style='width:340px;' overflow:hidden; title='"+data.beans[i].digest+"' class='splitStr'><font  style='display:block;width: 340px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;'>"+data.beans[i].digest+"</font></div></td><td width='85'>"+data.beans[i].billdate.substring(2, 10)+"</font></td></tr>");
   	    	}
	    	}else if(data.state=="false"){
	    		$("tbody[name='pendingBill']").children('tr').remove();
	    		$("tbody[name='pendingBill']").append("<tr><td><font color='red'>"+data.error+"</font></td></tr>");
	    	}
	    	
	    }
	}); 
}
function spzOnclick(){
	//审批中单据
	 $.ajax({
	    type : "POST",
	    url : "<%=request.getContextPath()%>/loanbill/savedBillPageExap.do?statetype=spz",
       contentType : 'application/json',
	    dataType: "json",
	    error:function(data){
	    	$("tbody[name='approvalBill']").children('tr').remove();
	    	$("tbody[name='approvalBill']").append("<tr><td><font color='red'>审批中单据查询失败，请联系管理员。</font></td></tr>");
	    },
	    success : function(data){
	    	if(data.state=="true"){
	    		$("tbody[name='approvalBill']").children('tr').remove();
   	    	for(var i=0;i<data.beans.length;i++){
	    		$("tbody[name='approvalBill']").append("<tr><td><div style='width:240px;' overflow:hidden; title='"+data.beans[i].vbillno+"' class='splitStr'><a href = 'javascript:void(0)' onclick = 'javascript:viewBill_onClick(\""+data.beans[i].pk_loanbill+"\",\""+data.beans[i].billtypecode+"\");'><font id='styleOne' style='display:block;width: 240px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;'>"+data.beans[i].vbillno+"</font></a></div></td><td width='360'><div style='width:340px;' overflow:hidden; title='"+data.beans[i].digest+"' class='splitStr'><font  style='display:block;width: 340px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;'>"+data.beans[i].digest+"</font></div></td><td width='85'>"+data.beans[i].billdate.substring(2, 10)+"</font></td></tr>");
   	    	}
	    	}else if(data.state=="false"){
	    		$("tbody[name='approvalBill']").children('tr').remove();
	    		$("tbody[name='approvalBill']").append("<tr><td><font color='red'>"+data.error+"</font></td></tr>");
	    	}
	    	
	    }
	}); 
}
function toSavedBills_onClick(){
	 window.location="<%=request.getContextPath()%>/loanbill/toSavedBillPage.do";
}
</script>
<style type="text/css">
#styleOne:hover {color:blue;text-decoration:underline;}
#style1:hover {color:blue;text-decoration:underline;cursor:pointer;}
#flow:{
	overflow: hidden;/*内容超出后隐藏*/
text-overflow: ellipsis;/* 超出内容显示为省略号*/
white-space: nowrap;/*文本不进行换行*/
}


</style>
</head>
<body>
<!-- ajax异步请求时锁定屏幕用，半透明div -->
<div id="zhezhao" style="background-color: #000; filter: alpha(opacity : 30); opacity: 0.3; position: fixed; left: 0; top: 0; width: 100%; height: 100%; z-index: 99999; display: none" >
<table style="width: 100%; height: 100%;">
<tr valign=middle align=center>
</tr>
</table>
</div>
	<div class="container-fluid">

<!--   -----------------------------------报账人门户开始-------------------------------------------  -->
      <div class="row m-content index" id="index_C" >
        <div class="col-md-8 left">
          <div class="row">
           <div class="col-md-12">
						<div class="m-column ">
							<div class="header">
								<div class="title">报账类型</div>
								<div class="pull-right">
								<input name="bill_type" id="search" value="" type="text" style="width: 200px; position:relative;" class="form-control"
											placeholder="请在此搜索报账类型" onkeydown="javascript:quick_search_code_onkeydown(event);"
											style="padding-right: 25px;"> <a
											class="btn btn-mini btn-primary"
											style="line-height: 15px; height: 25px; width: 55px; position:absolute; right:25px; top:5px" onclick="seachBillType();">搜索</a></div>
							</div>
							<div class="body clearfix index-box">
								<div class="col-md-2 col-sm-3 col-xs-6">
									<a href="javascript:toAdd_onClick('RCBZ')">
										<div class="m-panel m-panel-rcfy">
											<span><img src="${pageContext.request.contextPath }/images/1.png"  width="58px" height="58px"></span>
											<p>日常费用管理</p>
										</div>
									</a>
								</div>
								<div class="col-md-2 col-sm-3 col-xs-6 cl">
									<a href="javascript:toAdd_onClick('CL')">
										<div class="m-panel m-panel-cl">
											<span><img src="${pageContext.request.contextPath }/images/15.png"  width="58px" height="58px"></span>
											<p>差旅费报销单</p>
										</div>
									</a>
								</div>
								<div class="col-md-2 col-sm-3 col-xs-6">
									<a href="javascript:toAdd_onClick('JK')">
										<div class="m-panel m-panel-jk">
											<span><img src="${pageContext.request.contextPath }/images/11.png"  width="58px" height="58px"></span>
											<p>员工借款单</p>
										</div>
									</a>
								</div>
								<div class="col-md-2 col-sm-3 col-xs-6">
									<a href="javascript:toAdd_onClick('JKHK')">
										<div class="m-panel m-panel-jkhk">
											<span><img src="${pageContext.request.contextPath }/images/12.png"  width="58px" height="58px"></span>
											<p>借款还款单</p>
										</div>
									</a>
								</div>
							<div class="col-md-2 col-sm-3 col-xs-6">
									<a href="javascript:toAdd_onClick('ZJXB')">
										<div class="m-panel m-panel-zjxb">
											<span><img src="${pageContext.request.contextPath }/images/10.png"  width="58px" height="58px"></span>
											<p>资金下拨申请单</p>
										</div>
									</a>
								</div>
								<div class="col-md-2 col-sm-3 col-xs-6">
									<a href="javascript:toAdd_onClick('ZJZF')">
										<div class="m-panel m-panel-zjzf">
											<span><img src="${pageContext.request.contextPath }/images/9.png"  width="58px" height="58px"></span>
											<p>下拨资金支付报账单</p>
										</div>
									</a>
								</div>
								 <%-- <div class="col-md-2 col-sm-3 col-xs-6">
									<a href="javascript:exportExcel('DJCX')">
										<div class="m-panel m-panel-djcx">
											<span><img src="${pageContext.request.contextPath }/images/baobiao.jpg"  width="58px" height="58px"></span>
											<p>单据查询报表</p>
										</div>
									</a>
								</div>  --%>
								
							

							</div>
						</div>
					</div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <div class="m-column">
              <div class="header">
                <div class="title">补退单信息</div>
                <i class="next" title="更多" onclick="javascript:moreNotice_onClick_2()"></i>
              </div>
              <div class="body" style="height: 177px;">
                <table class="table table-bordered table-striped">
                    <tbody name="getBillMsg">
                    </tbody>
                  </table>
              </div>
            </div>
            </div>
				</div>
			</div>
			<div class="col-md-4 right">
			<!-- 单据信息栏 -->
				<div class="row">
					<div class="col-md-12">
						<div class="m-column" id="tabswitch">
							<div class="header">
								<div class="title">
									<span class="tab active" onclick="javascript:dclOnclick()" id="pendingTab">待处理单据</span><span class="tab" id="approvalTab" onclick="javascript:spzOnclick()">审批中单据</span>
								</div>
								<i class="next" title="更多" onclick="javascript:toSavedBills_onClick()"></i>
							</div>
							<div class="body" style="height: 410px;">
								<table id="pendingBill" class="table table-bordered table-striped active" style="table-layout:fixed;" >
									<tbody name="pendingBill">
							
									</tbody>
								</table>
								<table id="approvalBill" class="table table-bordered table-striped" style="table-layout:fixed;">
									<tbody name="approvalBill">
		
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="m-column">
							<div class="header">
								<div class="title" onclick="aaaaa()">公告栏</div>
								<i class="next" title="更多" onclick="javascript:moreNotice_onClick()"></i>
							</div>
							<div class="body" style="height: 177px;">
								<table class="table table-bordered table-striped" style="table-layout:fixed;">
									<tbody name="pubNotices">
						
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					</div>
				</div>
			</div>
		</div>
		<!--   -----------------------------------报账人门户结束-------------------------------------------  -->
		<!-- 系统通知Modal -->
		<div class="modal modal-1" id="xttzModal" tabindex="-1" role="dialog"
			data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" style="width: 60%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true" onclick="closeMod();">&times;</span><span  class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">系统通知</h4>
					</div>
					<div class="modal-body clearfix"
						style="max-height: 400px; overflow: auto;">
						<div name='gonggao1' style="margin: 0 auto;">
							<pre name='gonggaot'
								style="padding-left: 2%; word-wrap: break-word; white-space: pre-wrap; text-align: center; font-family: 'Microsoft YaHei'; font-size: 20px"></pre>
							<pre name='gonggao'
								style="padding-left: 2%; word-wrap: break-word; white-space: pre-wrap; text-align: left; font-family: 'Microsoft YaHei'; font-size: 15px"></pre>
							<pre name='gonggaow'
								style="padding-left: 2%; word-wrap: break-word; white-space: pre-wrap; text-align: right; font-family: 'Microsoft YaHei'; font-size: 15px"></pre>
						</div>
					</div>
				</div>
			</div>
		</div>
</body>

<script>
 	//报账人首页待处理单据、审批中单据tab切换
 	$('#tabswitch .tab').on('click',function(){
 		var index = $(this).index();
 		$(this).addClass('active').siblings().removeClass('active');
 		$('#tabswitch .table').removeClass('active').eq(index).addClass('active');
 	});
	document.getElementById("bs-example-navbar-collapse-1").style.display="block";
</script>
</html>
