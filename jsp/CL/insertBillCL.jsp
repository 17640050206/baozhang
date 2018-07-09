<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.erp.bean.Loanbill" %>
<%@ page import="com.erp.bean.Expitem" %>
<%
	//判断是否为修改页面
    Loanbill resultVo = null;  //定义一个临时的vo变量
        if(request.getAttribute("bean") != null) {  //如果request中取出的bean不为空
            resultVo = (Loanbill)request.getAttribute("bean");  //从request中取出vo, 赋值给resultVo
        }
%>
<!DOCTYPE html>
<html>
<head>
<!--头部-->
<%@ include file="/jsp/head.jsp" %>
<title>差旅费用报销单</title>
<script type="text/javascript">
function getSum(){
	var flag = true;

	var total =0;
	$('#tbody tr').each(function() {
		var hotelcost = $(this).find("input[name='hotelcost']").val()
		var transcost = $(this).find("input[name='transcost']").val()
		var othercost = $(this).find("input[name='othercost']").val()
		if(hotelcost == "" || hotelcost ==null){
			hotelcost="0";
	    }
		if(transcost == "" || transcost ==null){
			transcost="0";
	    }
		if(othercost == "" || othercost ==null){
			othercost="0";
	    }
		if(flag){
			var sum =  parseInt(hotelcost)+parseInt(transcost)+parseInt(othercost);
			if(sum!=0){
				$(this).find("input[name='sum']").val(sum);
			}
		}
		var fkje = $(this).find("input[name='sum']").val();
		if(fkje == "" || fkje ==null){
			fkje="0";
	    }
		total = parseInt(total)+parseInt(fkje);
	})
	$("#lzje").val(total);
	
}
$(document).ready(function(){
	$("#update_save").hide();
	$("#back_commit").hide();
	<% if(request.getAttribute("action")==null||request.getAttribute("action").equals("")){%>
	$("#save").show();
	$("#cancel").show();
	$("#commit").hide();
	$("#update").hide();
	$("#delete").hide();
	$(".bill .referenceDiv input").css("text-align","center");
	<%}else{%>
		$("input").attr("readonly","readonly");
		$("#add").hide();
		$("#cut").hide();
		$(".bill .referenceDiv input").css("text-align","center");
	<%}%>
});
var count = 0;
function deductionAdd_row(){
	count++;
	var a = "onclick=\"SelectDate(this,'yyyy\-MM\-dd')\"";
	var context = "";
	context+="<tr><td><input type='checkbox' name='check1' /><input type='hidden' name='pk_expitem' ></td>";
	context+="<td><div class='referenceDiv'><input name='area' class='tt' ></td><td><div class='referenceDiv'><input name='datefrom' class='tt' "+a+"></td>><td><div class='referenceDiv'><input name='daynum' class='tt'  ></td></td>";
	context+="<td><div class='referenceDiv'><input name='hotelcost' class='tt'  onchange='getSum()'></div></td>";
	context+="<td><div class='referenceDiv'><input name='transcost' class='tt'  onchange='getSum()'></div></td>";
	context+="<td><div class='referenceDiv'><input name='othercost' class='tt'   onchange='getSum()'></div></td>";
	context+="<td><div class='referenceDiv'><input name='sum' readonly='readonly'></div></td><td><div class='referenceDiv'><input name='digest' class='tt' ></div></td> </tr>";
    $("#tbody").append(context);
    $(".bill .referenceDiv input").css("text-align","center");
}
function delpayDeteil(){
	$('#rowTable-EXPITEM tr').each(function() {
		if ($(this).find("input[name='check1']").is(':checked') == true) {
			$(this).remove();
		}
	});
	getSum();
}
function save_onclick(){
	var digest = $("#digest").val();
	var account = $("#account").val();
	if(digest==""||digest==null){
		alert("摘要不能为空!");
		return;
	}
    if(account==""||account==null){
    	alert("收款账号不能为空!");
		return;
	}
    $('#tbody tr').each(function() {
		var area = $(this).find("input[name='area']").val();
		var datefrom = $(this).find("input[name='datefrom']").val();
		var daynum = $(this).find("input[name='daynum']").val();
		var hotelcost = $(this).find("input[name='hotelcost']").val();
		var transcost = $(this).find("input[name='transcost']").val();
		var othercost = $(this).find("input[name='othercost']").val();
		var digest = $(this).find("input[name='digest']").val();
		if(area == "" || area ==null){
			alert("表体出差地点不能为空!");
			return;
	    }
		if(datefrom == "" || datefrom ==null){
			alert("出差起始时间不能为空!");
			return;
	    }
		if(daynum == "" || daynum ==null){
			alert("表体天数不能为空!");
			return;
	    }
		if(hotelcost == "" || hotelcost ==null){
			alert("表体住宿费不能为空!");
			return;
	    }
		if(transcost == "" || transcost ==null){
			alert("表体交通费用不能为空!");
			return;
	    }
		if(othercost == "" || othercost ==null){
			alert("表体杂费不能为空!");
			return;
	    }
		if(digest == "" || digest ==null){
			alert("表体摘要不能为空!");
			return;
	    }
		
	})
	var expitemArray = new Array();  
	$('#tbody tr').each(function() {
		var area = $(this).find("input[name='area']").val();
		var datefrom = $(this).find("input[name='datefrom']").val();
		var daynum = $(this).find("input[name='daynum']").val();
		var hotelcost = $(this).find("input[name='hotelcost']").val();
		var transcost = $(this).find("input[name='transcost']").val();
		var othercost = $(this).find("input[name='othercost']").val();
		var sum = $(this).find("input[name='sum']").val();
		var digest = $(this).find("input[name='digest']").val();
		expitemArray.push({"area":area,"datefrom":datefrom,"daynum":daynum,"hotelcost":hotelcost,"transcost":transcost,"othercost":othercost,"sum":sum,"digest":digest});   
	});
	var loanbill = {};  
	loanbill.year  = $("#year").val();
	loanbill.month  = $("#month").val();
	loanbill.pk_psn  = $("#pk_psn").val();
	loanbill.psnname  = $("#psnname").val();
	loanbill.billdate  = $("#billdate").val();
	loanbill.email  = $("#email").val();
	loanbill.vbillno  = $("#vbillno").val();
	loanbill.deptid  = $("#deptid").val();
	loanbill.deptname  = $("#deptname").val();
	loanbill.mobile  = $("#mobile").val();
	loanbill.digest  = $("#digest").val();
	loanbill.lzje  = $("#lzje").val();
	loanbill.account  = $("#account").val();
	loanbill.pbillstatusname  = $("#pbillstatusname").val();
	loanbill.pbillstatus  = $("#pbillstatus").val();
	loanbill.expitems = expitemArray;
	loanbill.billtypecode =  $("#billtypecode").val();
	$.ajax({
	    type : "POST",  
	    url : "<%=request.getContextPath()%>/loanbill/saveBill.do",
        contentType : 'application/json',  
	    dataType: "json",
	    data: JSON.stringify(loanbill),//将对象序列化成JSON字符串  
	    success:function(data){
	    	if(data.state=="true"){
	    		alert("保存成功！");
	    		$("#pk_loanbill").val(""+data.bean.pk_loanbill);
	    		$("#add").hide();
	    		$("#cut").hide();
	    		$("#save").hide();
	    		$("#update").show();
	    		$("#commit").show();
	    		var all = "";
	    		$('#tbody tr').each(function() {
	    			$(this).remove();
	    		})
	    		for(var i=0;i<data.bean.expitems.length;i++){
	    			var context = "";
	    			context+="<tr><td><input type='checkbox' name='check1' /><input type='hidden' name='pk_expitem' value='"+data.bean.expitems[i].pk_expitem+"' ></td>";
	    			context+="<td><div class='referenceDiv'><input name='area' class='tt'  value='"+data.bean.expitems[i].area+"'></td><td><div class='referenceDiv'><input name='datefrom' class='tt'  onclick='SelectDate(this,'yyyy\-MM\-dd')'  value='"+data.bean.expitems[i].datefrom+"'></td><td><div class='referenceDiv'><input name='daynum' class='tt'  value='"+data.bean.expitems[i].daynum+"' ></td></td>";
	    			context+="<td><div class='referenceDiv'><input name='hotelcost' value='"+data.bean.expitems[i].hotelcost+"' class='tt'   onchange='getSum()'></div></td>";
	    			context+="<td><div class='referenceDiv'><input name='transcost' value='"+data.bean.expitems[i].transcost+"' class='tt'   onchange='getSum()'></div></td>";
	    			context+="<td><div class='referenceDiv'><input name='othercost' value='"+data.bean.expitems[i].othercost+"' class='tt'   onchange='getSum()'></div></td>";
	    			context+="<td><div class='referenceDiv'><input name='sum' value='"+data.bean.expitems[i].sum+"' readonly='readonly'></div></td><td><div class='referenceDiv'><input name='digest' value='"+data.bean.expitems[i].digest+"' class='tt' ></div></td> </tr>";
	    			all+=context;
	    		}
	    		 $("#tbody").append(all);
	    		$(".tt").attr("readonly","readonly");
	    		$(".bill .referenceDiv input").css("text-align","center");
	    		
	    	}else{
	    		
	    	}
	    }
	});
}
function update_save(){
	var pbillstatusname = $("#pbillstatusname").val();
	var digest = $("#digest").val();
	var account = $("#account").val();
	if(digest==""||digest==null){
		alert("摘要不能为空!");
		return;
	}
    if(account==""||account==null){
    	alert("收款账号不能为空!");
		return;
	}
    $('#tbody tr').each(function() {
		var area = $(this).find("input[name='area']").val();
		var datefrom = $(this).find("input[name='datefrom']").val();
		var daynum = $(this).find("input[name='daynum']").val();
		var hotelcost = $(this).find("input[name='hotelcost']").val();
		var transcost = $(this).find("input[name='transcost']").val();
		var othercost = $(this).find("input[name='othercost']").val();
		var digest = $(this).find("input[name='digest']").val();
		if(area == "" || area ==null){
			alert("表体出差地点不能为空!");
			return;
	    }
		if(datefrom == "" || datefrom ==null){
			alert("出差起始时间不能为空!");
			return;
	    }
		if(daynum == "" || daynum ==null){
			alert("表体天数不能为空!");
			return;
	    }
		if(hotelcost == "" || hotelcost ==null){
			alert("表体住宿费不能为空!");
			return;
	    }
		if(transcost == "" || transcost ==null){
			alert("表体交通费用不能为空!");
			return;
	    }
		if(othercost == "" || othercost ==null){
			alert("表体杂费不能为空!");
			return;
	    }
		if(digest == "" || digest ==null){
			alert("表体摘要不能为空!");
			return;
	    }
		
	})
	var expitemArray = new Array();  
	$('#tbody tr').each(function() {
		var area = $(this).find("input[name='area']").val();
		var datefrom = $(this).find("input[name='datefrom']").val();
		var daynum = $(this).find("input[name='daynum']").val();
		var hotelcost = $(this).find("input[name='hotelcost']").val();
		var transcost = $(this).find("input[name='transcost']").val();
		var othercost = $(this).find("input[name='othercost']").val();
		var sum = $(this).find("input[name='sum']").val();
		var digest = $(this).find("input[name='digest']").val();
		expitemArray.push({"area":area,"datefrom":datefrom,"daynum":daynum,"hotelcost":hotelcost,"transcost":transcost,"othercost":othercost,"sum":sum,"digest":digest});   
	});
	var loanbill = {};  
	loanbill.digest  = $("#digest").val();
	loanbill.lzje  = $("#lzje").val();
	loanbill.account  = $("#account").val();
	loanbill.billtypecode =  $("#billtypecode").val();
	loanbill.pk_loanbill  = $("#pk_loanbill").val();
	loanbill.expitems = expitemArray;
	$.ajax({
	    type : "POST",  
	    url : "<%=request.getContextPath()%>/loanbill/updateBill.do",
        contentType : 'application/json',  
	    dataType: "json",
	    data: JSON.stringify(loanbill),//将对象序列化成JSON字符串  
	    success:function(data){
	    	if(data.state=="true"){
	    		alert("修改成功！");
	    		$("#add").hide();
	    		$("#cut").hide();
	    		$("#save").hide();
	    		$("#update").show();
	    		$("#commit").show();
	    		if(pbillstatusname=="退单"){
	    			$("#back_commit").show();
	    		}
	    		$("#update_save").hide();
	    		$(".tt").attr("readonly","readonly");
	    		$(".bill .referenceDiv input").css("text-align","center");
	    	}else{
	    		
	    	}
	    }
	});
}
function commit_onClick(){
	var billid = $("#pk_loanbill").val();
	$.ajax({
	    type : "POST",  
	    url : "<%=request.getContextPath()%>/loanbill/commit.do?billid="+billid,
        contentType : 'application/json',  
	    dataType: "json",
	    success:function(data){
	    	if(data.state=="true"){
	    		alert("提交成功！");
	    		window.location="<%=request.getContextPath()%>/loanbill/toSavedBillPage.do";
	    	}else{
	    		alert(data.error);
	    	}
	    }
	});
}
function pass_onclick(){
	var pk_pubwork = $("#pk_pubwork").val();
	var pk_loanbill = $("#pk_loanbill").val();
	$.ajax({ 
	    type : "POST",  
	    url : "<%=request.getContextPath()%>/workflow/checkBill.do?flag=1&pk_loanbill="+pk_loanbill+"&pk_pubwork="+pk_pubwork,
        contentType : 'application/json',  
	    dataType: "json",
	    error:function(data){
	    },
	    success : function(data){
	    	if(data.state=="true"){
	    		location.href="<%=request.getContextPath()%>/workflow/toApprovePage.do";
	    	}else{
	    		alert(data.error);
	    	}
	    	
	    }
	});
}
function stop_onclick(){
	$('#askModal').show();
}
function closeMod(){
	$('#askModal').hide();
}
function approve(){
	var pk_pubwork = $("#pk_pubwork").val();
	var checknote = $("#checknote").val();
	$.ajax({ 
	    type : "POST",  
	    url : "<%=request.getContextPath()%>/workflow/checkBill.do?flag=2&pk_loanbill="+pk_loanbill+"&checknote="+checknote+"&pk_pubwork="+pk_pubwork,
        contentType : 'application/json',  
	    dataType: "json",
	    error:function(data){
	    },
	    success : function(data){
	    	if(data.state=="true"){
	    		location.href="<%=request.getContextPath()%>/workflow/toApprovePage.do";
	    	}else{
	    		alert(data.error);
	    	}
	    	
	    }
	});
}
function delete_onclick(){
	var billtype = $("#billtypecode").val();
	var pk_loanbill = $("#pk_loanbill").val();
	var r=confirm("您确定要删除此单据吗!");
	if (r==true){
		$.ajax({ 
		    type : "POST",  
		    url : "<%=request.getContextPath()%>/loanbill/deleteBill.do?pk_loanbill="+pk_loanbill+"&billtype="+billtype,
	        contentType : 'application/json',  
		    dataType: "json",
		    error:function(data){
		    },
		    success : function(data){
		    	if(data.state="true"){
		    		location.href="<%=request.getContextPath()%>/loanbill/toSavedBillPage.do";
		    	}else{
		    		alert(data.error);
		    	}
		    	
		    }
		});
	  }
	else
	  {
	  
	  }
}
var colHeight;
function clickToogle(that){
	if($(that).hasClass("active")){
		$(that).removeClass("active");
		$(that).parent().parent().css("height",colHeight);
	}else{
		colHeight = $(that).parent().parent().css("height");
		$(that).addClass("active");
		$(that).parent().parent().css("height","auto");
	}
}
function update_onClick(){
	$("#add").show();
	$("#cut").show();
	$("#update_save").show();
	$("#delete").hide();
	$("#commit").hide();
	$("#update").hide();
	$(".tt").attr("readonly",false);
}

</script>
</head>
<body>
<form name="form" id="form" method="post" enctype="multipart/form-data">
 <div class="container-fluid">
		<!--头部结束-->
		 <div class="row m-content bill">
        <div class="col-md-12">
              <div class="m-column">
                <div class="header">
                  <div class="title">页面编辑</div>
                </div>
                <div class="body clearfix">
                  <div class="cont">

<!-- 基本信息  -->

                    <div class="m-formbox mainlist">
                      <div class="title">
						<span class="toggle_btn" onclick="clickToogle(this)"></span>
						基本信息
					  </div>
                      <div class="cont clearfix">
                          <div class="row">
	                         <div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label"><span class="red">*</span>日期:</label>
	                          	<div class="inputbox">
									<input type="text" class="text_date_half" name="billdate" id="billdate" readonly value="${bean.billdate}"/>
								</div>
	                        </div>
	                        <div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label">经办人名称:</label>
	                          <div class="inputbox">
	                            <input type="text" name="psnname" id="psnname" readonly value="${bean.psnname}" />
	                            <input type="hidden" name="pk_psn" id="pk_psn" value="${bean.pk_psn}"/>
	                          </div>
	                        </div>
	                        <div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label">电子邮箱:</label>
	                          <div class="inputbox">
	                            <input type="text" name="email" id="email" readonly value="${bean.email}"  />
	                          </div>
	                        </div>
	                      </div>

                         <div class="row hide_div">
	                         <div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label">报账单编号:</label>
	                          <div class="inputbox">
	                            <input type="text" id="vbillno" name="vbillno" value="${bean.vbillno}" readonly/>
	                          </div>
	                        </div>
	                        <div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label">部门:</label>
	                          <div class="inputbox">
	                          	<input type="text" id="deptname" name="deptname" value="${bean.deptname}" readonly/>
	                            <input type="hidden" id="deptid" name="deptid" value="${bean.deptid}" readonly/>
	                          </div>
	                        </div>
	                        <div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label">手机号码:</label>
	                          <div class="inputbox">
	                          	 <input type="text" id="mobile" name="mobile" value="${bean.mobile}" readonly/>
	                          </div>
	                        </div>
                        </div>
                      </div>
                    </div>





<!-- 其他信息  -->

                    <div class="m-formbox mainlist clear">
                      <div class="title">
						<span class="toggle_btn" onclick="clickToogle(this)"></span>
						其他信息
					  </div>
                      <div class="cont clearfix">
                          <div class="row">
	                         <div class="col-md-4 col-sm-4 col-xs-12">
								<label class="label"><span class="red">*</span>摘要:</label>
								<div class="inputbox">
									<input type="text" id="digest" name="digest" class="tt" maxlength="30" value="${bean.digest}"  />
								<p class="digest_tip" id="digest_tip">30字以内</p>
								</div>
							</div>
							 <div class="col-md-4 col-sm-4 col-xs-12">
								<label class="label"><span class="red">*</span>列账金额:</label>
								<div class="inputbox">
									<input type="text" id="lzje" name="lzje"  value="${bean.lzje}"  readonly/>
								</div>
							</div>
							 <div class="col-md-4 col-sm-4 col-xs-12">
								<label class="label"><span class="red">*</span>收款账号:</label>
								<div class="inputbox">
									<input type="text" id="account" name="account" class="tt"  value="${bean.account}"  />
								</div>
							</div>
							
                         <div class="row hide_div">
	                        <div class="col-md-4 col-sm-4 col-xs-12">
	                          <label class="label">原始单据状态:</label>
	                          <div class="inputbox">
	                            <input type="text" name="pbillstatusname" id="pbillstatusname" value="${bean.pbillstatusname}"   readonly />
	                             <input type="hidden" name="pbillstatus" readonly id="pbillstatus" value="${bean.pbillstatus}" />
	                          </div>
	                        </div>
                        </div>
                      </div>
                    </div>
</div>
 <!-- 差旅费明细  -->

                    <div class="m-formbox m-formbox-nofloat">
                      <div class="title">差旅费明细
                          <div class="pull-right">
                          <a class="btn btn-mini btn-success" id="add" onclick="deductionAdd_row();">增行</a>
                          <a class="btn btn-mini btn-success" id="cut" onclick="delpayDeteil()">删行</a>
                          </div>
                      </div>
                      <div class="cont clearfix">
                        <div class="table-responsive">
                          <table class="table table-bordered table-hover table-striped" namespace="EXPITEM"  name=""  id="rowTable-EXPITEM" >
                            <thead>
                              <tr>
                              	<th width="4%">选择</th>
                               <th class="red" width="8%">出差地点</th>
                               <th class="red" width="8%">起始时间</th>
                               <th class="red" width="6%">天数</th>
                               <th width="5%">住宿费用</th>
                               <th width="5%">交通费用</th>
                               <th width="5%">杂费</th>
                               <th  width="8%" class="red">小计</th>
                               <th class="red" width="10%">摘要</th>
                              </tr>
                            </thead>
                            <tbody id="tbody">
                              <% 
                                        List<Expitem> vos = resultVo.getExpitems();
								        if(vos!=null&&vos.size()>0){
								        	for(int i=0;i<vos.size();i++){
								        		Expitem item = vos.get(i);
		                        	%>
                              <tr>
                                <td>
                              		<input type="checkbox" name="check1" value="<%=item.getPk_expitem()%>"/>
                              		<input type="hidden" name="pk_expitem" value="<%=item.getPk_expitem()%>">
	                       		</td>
                              	
                              	<td><div class="referenceDiv"><input name="area" class='tt' value="<%=item.getArea()%>"></div></td>
                              	<td><div class="referenceDiv"><input name="datefrom" class='tt'  value="<%=item.getDatefrom()%>" onclick="SelectDate(this,'yyyy\-MM\-dd')"></div></td>
                              	<td><div class="referenceDiv"><input name="daynum" class='tt'  value="<%=item.getDaynum()%>"></div></td>
                              	<td><div class="referenceDiv"><input name="hotelcost" class='tt' value="<%=item.getHotelcost()%>"  onchange="getSum()"></div></td>
                              	<td><div class="referenceDiv"><input name="transcost" class='tt' value="<%=item.getTranscost()%>" onchange="getSum()"></div></td>
                              	<td><div class="referenceDiv"><input name="othercost" class='tt' value="<%=item.getOthercost()%>" onchange="getSum()"></div></td>
                              	<td><div class="referenceDiv"><input name="sum" value="<%=item.getSum()%>"  readonly="readonly"></div></td>
                              	<td><div class="referenceDiv"><input name="digest" class='tt' value="<%=item.getDigest()%>"></div></td>
                              </tr>
                              <%}}else{ %>
                               <tr>
                                <td>
                              		<input type="checkbox" name="check1" value=""/>
                              		<input type="hidden" name="pk_expitem" >
	                       		</td>
                              	<td><div class="referenceDiv"><input name="area"></div></td>
                              	<td><div class="referenceDiv"><input name="datefrom" onclick="SelectDate(this,'yyyy\-MM\-dd')" ></div></td>
                              	<td><div class="referenceDiv"><input name="daynum" ></div></td>
                              	<td><div class="referenceDiv"><input name="hotelcost"  onchange="getSum()"></div></td>
                              	<td><div class="referenceDiv"><input name="transcost"  onchange="getSum()"></div></td>
                              	<td><div class="referenceDiv"><input name="othercost"  onchange="getSum()"></div></td>
                              	<td><div class="referenceDiv"><input name="sum"  readonly="readonly"></div></td>
                              	<td><div class="referenceDiv"><input name="digest"></div></td>
                              </tr>
                              <%} %>
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                    <div class="next">
                			<%@ include file="/jsp/button2.jsp" %>
                    </div>
                  </div>
                </div>
            </div>
        </div>
      </div>
    </div>
			
  

    <input name="pk_pubwork" id="pk_pubwork" type="hidden" value="${bean.pk_pubwork}"/>
    <input name="billtypecode" id="billtypecode" type="hidden" value="CL"/>
      <input name="pk_loanbill" id="pk_loanbill" type="hidden" value="${bean.pk_loanbill}"/>
    <input name="year" id="year" type="hidden" value="${bean.year}"/>
  	 <input name="month" id="month" type="hidden" value="${bean.month}"/>



</form>

</body>
</html>
