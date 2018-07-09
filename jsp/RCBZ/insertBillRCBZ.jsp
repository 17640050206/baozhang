<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.erp.bean.Loanbill" %>
<%@ page import="com.erp.bean.Paydetail" %>
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
<%@ include file="/jsp/head.jsp" %>
<title>日常及其他费用报账单</title>
<script type="text/javascript">
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
	var context = "";
	context+="<tr class='rowPrototype'><td><input type='checkbox' name='check1'/></td><td><div class='referenceDiv'><input type='text' class='tt' name='vendorcode' onchange='getVendorInf(this)' /></div></td>";
	context+="<td><div class='referenceDiv'><input type='text' name='vendorname' readonly/></div></td>";
	context+="<td><div class='referenceDiv'><input type='text' name='bankname'  readonly/></div></td>";
	context+="<td><div class='referenceDiv'><input type='text' name='account'  readonly /></div></td>";
	context+="<td><div class='referenceDiv'><input type='text' class='tt' name='fkje' onchange='setfkje_total()'/></div></td>";
	context+="<td><div class='referenceDiv'><input type='text' name='digest'  class='tt' /></div></td></tr>";
    $("#tbody").append(context);
    $(".bill .referenceDiv input").css("text-align","center");
}
function delpayDeteil(){
	$('#rowTable-PAYDETAIL tr').each(function() {
		if ($(this).find("input[name='check1']").is(':checked') == true) {
			$(this).remove();
		}
	});
	setfkje_total();
}
function setfkje_total(){
	var total=0;
	$('#tbody tr').each(function() {
		var fkje = $(this).find("input[name='fkje']").val();
		if(fkje == "" || fkje ==null){
			fkje="0";
	    }
		total = parseInt(total)+parseInt(fkje);
	})
	$("#lzje").val(total);
}
function save_onclick(){
	var digest = $("#digest").val();
	var xmbm = $("#xmbm").val();
	if(digest==""||digest==null){
		alert("摘要不能为空!");
		return;
	}
    if(xmbm==""||xmbm==null){
    	alert("项目编码不能为空!");
		return;
	}
    $('#tbody tr').each(function() {
		var vendorcode = $(this).find("input[name='vendorcode']").val();
		var fkje = $(this).find("input[name='fkje']").val();
		var digest = $(this).find("input[name='digest']").val();
		if(vendorcode == "" || vendorcode ==null){
			alert("供应商编码不能为空!");
			return;
	    }
		if(fkje == "" || fkje ==null){
			alert("表体付款金额不能为空!");
			return;
	    }
		if(digest == "" || digest ==null){
			alert("表体摘要不能为空!");
			return;
	    }
		
	})
	var paydetailArray = new Array();  
	$('#tbody tr').each(function() {
		var vendorcode = $(this).find("input[name='vendorcode']").val();
		var vendorcode = $(this).find("input[name='vendorcode']").val();
		var vendorname = $(this).find("input[name='vendorname']").val();
		var bankname = $(this).find("input[name='bankname']").val();
		var account = $(this).find("input[name='account']").val();
		var digest = $(this).find("input[name='digest']").val();
		var fkje = $(this).find("input[name='fkje']").val();
		paydetailArray.push({"vendorcode":vendorcode,"vendorname":vendorname,"bankname":bankname,"account":account,"digest":digest,"fkje":fkje});   
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
	loanbill.xmbm  = $("#xmbm").val();
	loanbill.xmmc  = $("#xmmc").val();
	loanbill.pk_project = $("#pk_project").val();
	loanbill.pbillstatusname  = $("#pbillstatusname").val();
	loanbill.pbillstatus  = $("#pbillstatus").val();
	loanbill.paydetails = paydetailArray;  
	$.ajax({
	    type : "POST",  
	    url : "<%=request.getContextPath()%>/loanbill/saveRCBZ.do",
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
	    		for(var i=0;i<data.bean.paydetails.length;i++){
	    			var context = "";
	    			context+="<tr class='rowPrototype'><td><center><input type='checkbox' name='check1'/><input type='hidden' name='pk_paydetail' value='"+data.bean.paydetails[i].pk_paydetail+"'/></center></td><td><div class='referenceDiv'><center><input type='text' class='tt' name='vendorcode' value='"+data.bean.paydetails[i].vendorcode+"' onchange='getVendorInf(this)' /></center></div></td>";
	    			context+="<td><div class='referenceDiv'><center><input type='text' value='"+data.bean.paydetails[i].vendorname+"' name='vendorname' readonly/></center></div></td>";
	    			context+="<td><div class='referenceDiv'><center><input type='text' value='"+data.bean.paydetails[i].bankname+"' name='bankname'  readonly/></center></div></td>";
	    			context+="<td><div class='referenceDiv'><center><input type='text' value='"+data.bean.paydetails[i].account+"' name='account'  readonly /></center></div></td>";
	    			context+="<td><div class='referenceDiv'><center><input type='text' value='"+data.bean.paydetails[i].fkje+"' class='tt' name='fkje' onchange='setfkje_total()'/></center></div></td>";
	    			context+="<td><div class='referenceDiv'><center><input type='text' value='"+data.bean.paydetails[i].digest+"' name='digest'  class='tt' /></center></div></td></tr>";
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
	var digest = $("#digest").val();
	var pbillstatusname = $("#pbillstatusname").val();
	var xmbm = $("#xmbm").val();
	if(digest==""||digest==null){
		alert("摘要不能为空!");
		return;
	}
    if(xmbm==""||xmbm==null){
    	alert("项目编码不能为空!");
		return;
	}
    $('#tbody tr').each(function() {
		var vendorcode = $(this).find("input[name='vendorcode']").val();
		var fkje = $(this).find("input[name='fkje']").val();
		var digest = $(this).find("input[name='digest']").val();
		if(vendorcode == "" || vendorcode ==null){
			alert("供应商编码不能为空!");
			return;
	    }
		if(fkje == "" || fkje ==null){
			alert("表体付款金额不能为空!");
			return;
	    }
		if(digest == "" || digest ==null){
			alert("表体摘要不能为空!");
			return;
	    }
		
	})
	var paydetailArray = new Array();  
	$('#tbody tr').each(function() {
		var vendorcode = $(this).find("input[name='vendorcode']").val();
		var vendorcode = $(this).find("input[name='vendorcode']").val();
		var vendorname = $(this).find("input[name='vendorname']").val();
		var bankname = $(this).find("input[name='bankname']").val();
		var account = $(this).find("input[name='account']").val();
		var digest = $(this).find("input[name='digest']").val();
		var fkje = $(this).find("input[name='fkje']").val();
		paydetailArray.push({"vendorcode":vendorcode,"vendorname":vendorname,"bankname":bankname,"account":account,"digest":digest,"fkje":fkje});   
	});
	var loanbill = {};  
	loanbill.digest  = $("#digest").val();
	loanbill.lzje  = $("#lzje").val();
	loanbill.xmbm  = $("#xmbm").val();
	loanbill.pk_loanbill  = $("#pk_loanbill").val();
	loanbill.pk_project = $("#pk_project").val();
	loanbill.billtypecode = $("#billtypecode").val();
	loanbill.paydetails = paydetailArray;  
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
function getxmmc(){
	var xmbm = $("#xmbm").val();
	$.ajax({
	    type : "POST",  
	    url : "<%=request.getContextPath()%>/loanbill/getXmmc.do?xmbm="+xmbm,
        contentType : 'application/json',  
	    dataType: "json",
	    success:function(data){
	    	if(data.state=="true"){
	    		$("#xmmc").val(data.xmmc.projectname);
	    		$("#pk_project").val(data.xmmc.pk_project);
	    	}else{
	    		alert(data.error);
	    		$("#xmbm").val("");
	    	}
	    }
	});
}
function getVendorInf(that){
	var total = 0;
	var flag = true;
	var tr = $(that).parents('tr');
	var vendorcode = tr.find('input[name="vendorcode"]').val();
	$('#tbody tr').each(function() {
		var vendorcode1 = $(this).find("input[name='vendorcode']").val();
		if(vendorcode==vendorcode1){
			total+=1;
			if(total>=2){
				alert("表体已经包含此供应商!");
				$(this).find("input[name='vendorcode']").val("");
				flag =false;
			}
			
		}
	});
	if(flag==false){
		return;
	}
	
	var pk_project = $("#pk_project").val();
	$.ajax({
	    type : "POST",  
	    url : "<%=request.getContextPath()%>/loanbill/getVendor.do?vendorcode="+vendorcode+"&pk_project="+pk_project,
        contentType : 'application/json',  
	    dataType: "json",
	    success:function(data){
	    	if(data.state=="true"){
	    		$(".bill .referenceDiv input").css("text-align","center");
	    		tr.find('input[name="vendorname"]').val(data.vendor.vendorname);
	    		tr.find('input[name="bankname"]').val(data.vendor.bank);
	    		tr.find('input[name="account"]').val(data.vendor.account);
	    	}else{
	    		alert(data.error);
	    		tr.find('input[name="vendorcode"]').val("");
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
<form name="form" id="form" method="post">
 <div class="container-fluid">
		<!--头部-->
		
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
									<input type="text" class="text_date_half" name="billdate" id="billdate"  readonly value="${bean.billdate}"/>
								</div>
	                        </div>
	                        <div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label">经办人名称:</label>
	                          <div class="inputbox">
	                            <input type="text" name="psnname" id="psnname" value="${bean.psnname}"  readonly/>
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

                    <div class="m-formbox mainlist clear" style="height:80px">
                      <div class="title">
						<span class="toggle_btn" style='visibility:hidden'></span>
						其他信息
					  </div>
                      <div class="cont clearfix">
                          <div class="row">
	                         <div class="col-md-4 col-sm-6 col-xs-12">
								<label class="label"><span class="red">*</span>摘要:</label>
								<div class="inputbox">
									<input type="text" id="digest" name="digest" class="tt"  maxlength="30" value="${bean.digest}" />
								<p class="digest_tip" id="digest_tip">30字以内</p>
								</div>
							</div>
							<div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label"><span class="red">*</span>列账金额:</label>
	                          <div class="inputbox">
	                           <input name="lzje" id="lzje" class="form-control"  readonly="readonly"  type='text' value="${bean.lzje}"  />
	                          </div>
	                        </div>
	                        <div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label">原始单据状态:</label>
	                          <div class="inputbox">
	                            <input type="text" name="pbillstatusname" id="pbillstatusname"   value="${bean.pbillstatusname}"   readonly />
	                             <input type="hidden" name="pbillstatus" readonly id="pbillstatus" value="${bean.pbillstatus}" />
	                          </div>
	                        </div>
							<div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label"><span class="red">*</span>项目编码:</label>
	                          <div class="inputbox">
	                           <input name="xmbm" id="xmbm" class="form-control tt"  onchange="getxmmc()"  type='text' value="${bean.xmbm}"  />
	                           <input name="pk_project" id="pk_project" class="form-control tt"  type='hidden' value="${bean.pk_project}"  />
	                          </div>
	                        </div>
							<div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label">项目名称:</label>
	                          <div class="inputbox">
	                            <input name="xmmc" id="xmmc" class="form-control" readonly="readonly"  type='text' value="${bean.xmmc}"  />
	                          </div>
	                        </div>
                      </div>
                    </div>
</div>

<!-- 付款清单 -->
					            
					<div id="table-paydetail" class="m-formbox m-formbox-nofloat"  >
                      <div class="title">付款清单
                        <div class="pull-right">
                          <a class="btn btn-mini btn-success" id="add" onclick="deductionAdd_row();">增行</a>
                          <a class="btn btn-mini btn-success" id="cut" onclick="delpayDeteil()">删行</a>
                        </div>
                      </div>
                      <div class="cont clearfix">
                        <div class="table-responsive">
                          <table class="table table-bordered table-hover table-striped" namespace="PAYDETAIL"  name="deductiont4"  id="rowTable-PAYDETAIL" >
                            <thead>
                              <tr>
                              		<th>选择</th>
                              		<th class="red">供应商编码</th>
                              		<th>供应商名称</th>
                              		<th>开户行</th>
                              		<th>银行账户</th>
                              		<th class="red">付款金额</th>
                              		<th class="red">摘要</th>
                              </tr>
                            </thead>
                            <tbody id="tbody">
                                    <% 
                                        List<Paydetail> vos = resultVo.getPaydetails();
								        if(vos!=null&&vos.size()>0){
								        	for(int i=0;i<vos.size();i++){
								        		Paydetail item = vos.get(i);
		                        	%>
		                        	<tr class="rowPrototype">
                              	<!-- 选择 -->
                              		<td>
                              			<input type="checkbox" name="check1" value="<%=item.getPk_paydetail()%>"/>
                              			<input type="hidden" name="pk_paydetail" value="<%=item.getPk_paydetail()%>">
	                       			</td>
			        			<!-- 供应商编码 -->
	                              	<td>
	                              		<div class="referenceDiv">
	                              			<input type="text" name="vendorcode" onchange="getVendorInf(this)" value="<%=item.getVendorcode()%>" class="tt"/>
				 						</div>
					        		</td>
					        			<!-- 供应商名称 -->
	                              	<td>
	                              		<div class="referenceDiv">
	                              			<input type="text" name="vendorname" value="<%=item.getVendorname()%>" readonly/>
				 						</div>
					        		</td>
					        	<!-- 开户行 -->
					        		<td>
				 						<div class="referenceDiv">
				 							<input type="text" name="bankname" value="<%=item.getBankname()%>" readonly/>
				 						</div>
					        		</td>
					        	<!-- 银行账号 -->
					        		<td>
				 						<div class="referenceDiv">
				 							<input type="text" name="account"  value="<%=item.getAccount()%>" readonly />
				 						</div>
					        		</td>
					        	<!-- 付款金额 -->
					        		<td>
				 						<div class="referenceDiv">
				 							<input type="text" name="fkje" class="tt" value="<%=item.getFkje()%>" onchange="setfkje_total()" />
				 						</div>
					        		</td>
					        	<!-- 摘要 -->
					        		<td>
				 						<div class="referenceDiv">
				 							<input type="text" name="digest" value="<%=item.getDigest()%>" class="tt"  />
				 						</div>
					        		</td>
                              </tr>   
		                        	<%}}else{ %>
		                        	<tr class="rowPrototype">
                              	<!-- 选择 -->
                              		<td>
                              			<input type="checkbox" name="check1" />
	                       			</td>
			        			<!-- 供应商编码 -->
	                              	<td>
	                              		<div class="referenceDiv">
	                              			<input type="text" name="vendorcode" onchange="getVendorInf(this)" class="tt"/>
				 						</div>
					        		</td>
					        			<!-- 供应商名称 -->
	                              	<td>
	                              		<div class="referenceDiv">
	                              			<input type="text" name="vendorname" readonly/>
				 						</div>
					        		</td>
					        	<!-- 开户行 -->
					        		<td>
				 						<div class="referenceDiv">
				 							<input type="text" name="bankname"  readonly/>
				 						</div>
					        		</td>
					        	<!-- 银行账号 -->
					        		<td>
				 						<div class="referenceDiv">
				 							<input type="text" name="account"  readonly />
				 						</div>
					        		</td>
					        	<!-- 付款金额 -->
					        		<td>
				 						<div class="referenceDiv">
				 							<input type="text" name="fkje" class="tt" onchange="setfkje_total()" />
				 						</div>
					        		</td>
					        	<!-- 摘要 -->
					        		<td>
				 						<div class="referenceDiv">
				 							<input type="text" name="digest" class="tt"  />
				 						</div>
					        		</td>
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

<script>


    </script>
    <input name="pk_pubwork" id="pk_pubwork" type="hidden" value="${bean.pk_pubwork}"/>
      <input name="billtypecode" id="billtypecode" type="hidden" value="RCBZ"/>
      <input name="pk_loanbill" id="pk_loanbill" type="hidden" value="${bean.pk_loanbill}"/>
    <input name="year" id="year" type="hidden" value="${bean.year}"/>
  	 <input name="month" id="month" type="hidden" value="${bean.month}"/>
  	 
</form>

</body>
</html>
<script type="text/javascript">
</script>
