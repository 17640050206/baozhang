<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.erp.bean.Loanbill" %>
<%@ page import="com.erp.bean.Cashbill" %>
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
<title>下拨资金支付</title>
<script type="text/javascript">
function ybje_sum(){
	var total =0;
	$('#tbody tr').each(function() {
		var ybje = $(this).find("input[name='ybje']").val()
		var whje = $(this).find("input[name='whje']").val()
		if(parseInt(ybje)>parseInt(whje)){
			alert("本次实拨金额不能大于未实拨金额！")
			$(this).find("input[name='ybje']").val("");
			return;
		}
		if(ybje == "" || ybje ==null){
			ybje="0";
	    }
		total = parseInt(total)+parseInt(ybje);
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
	var context = "";
	context+=" <tr class='rowPrototype'><td><input type='checkbox' name='check1'/><input type='hidden' name='pk_cashbill' /></td>";
	context+=" <td><div class='referenceDiv'> <input type='text' name='billno' class='tt' onchange='getCashbill(this);' /></div></td>";
	context+="<td><div class='referenceDiv'><input type='text' name='account'  readonly/></div></td>	";
	context+="<td><div class='referenceDiv'><input type='text' name='jkje'  readonly/></div></td>	";
	context+="<td><div class='referenceDiv'><input type='text' name='whje'  readonly /></div></td>";
	context+="<td><div class='referenceDiv'><input type='text' name='yhje'  readonly /></div></td>";
	context+="<td><div class='referenceDiv'><input type='text' name='ybje' class='tt' onchange='ybje_sum();'/></div></td>";
	context+="<td><div class='referenceDiv'><input type='text' name='digest' class='tt' /></div></td> </tr>";
    $("#tbody").append(context);
    $(".bill .referenceDiv input").css("text-align","center");
}
function delpayDeteil(){
	$('#tbody tr').each(function() {
		if ($(this).find("input[name='check1']").is(':checked') == true) {
			$(this).remove();
		}
	});
	ybje_sum();
}
function save_onclick(){
	var digest = $("#digest").val();
	var appreason = $("#appreason").val();
	var account = $("#account").val();
	if(digest==""||digest==null){
		alert("摘要不能为空!");
		return;
	}
	if(appreason==""||appreason==null){
		alert("下拨原因不能为空!");
		return;
	}
	if(account==""||account==null){
		alert("汇出账号不能为空!");
		return;
	}
	$('#tbody tr').each(function() {
		var billno = $(this).find("input[name='billno']").val();
		var ybje = $(this).find("input[name='ybje']").val();
		var digest = $(this).find("input[name='digest']").val();
		if(billno==""||billno==null){
			alert("表体下拨资金申请单编号不能为空!");
			return;
		}
		if(ybje==""||ybje==null){
			alert("表体本次实拨金额不能为空!");
			return;
		}
		if(digest==""||digest==null){
			alert("表体摘要不能为空!");
			return;
		}
	});
	var cashitemArray = new Array();  
	$('#tbody tr').each(function() {
		var billno = $(this).find("input[name='billno']").val();
		var account = $(this).find("input[name='account']").val();
		var jkje = $(this).find("input[name='jkje']").val();
		var yhje = $(this).find("input[name='yhje']").val();
		var whje = $(this).find("input[name='whje']").val();
		var ybje = $(this).find("input[name='ybje']").val();
		var digest = $(this).find("input[name='digest']").val();
		cashitemArray.push({"billno":billno,"account":account,"jkje":jkje,"yhje":yhje,"whje":whje,"ybje":ybje,"digest":digest});   
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
	loanbill.appreason  = $("#appreason").val();
	loanbill.account  = $("#account").val();
	loanbill.pbillstatusname  = $("#pbillstatusname").val();
	loanbill.pbillstatus  = $("#pbillstatus").val();
	loanbill.cashbills = cashitemArray;
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
	    		for(var i=0;i<data.bean.cashbills.length;i++){
	    			var context = "";
	    			context+=" <tr class='rowPrototype'><td><input type='checkbox' name='check1'/><input type='hidden' name='pk_cashbill' value='"+data.bean.cashbills[i].pk_cashbill+"'/></td>";
	    			context+=" <td><div class='referenceDiv'> <input type='text' name='billno' class='tt' onchange='getCashbill(this);' value='"+data.bean.cashbills[i].billno+"' /></div></td>";
	    			context+="<td><div class='referenceDiv'><input type='text' name='account' value='"+data.bean.cashbills[i].account+"'  readonly/></div></td>	";
	    			context+="<td><div class='referenceDiv'><input type='text' name='jkje' value='"+data.bean.cashbills[i].jkje+"' readonly/></div></td>	";
	    			context+="<td><div class='referenceDiv'><input type='text' name='whje' value='"+data.bean.cashbills[i].whje+"' readonly /></div></td>";
	    			context+="<td><div class='referenceDiv'><input type='text' name='yhje' value='"+data.bean.cashbills[i].yhje+"'  readonly /></div></td>";
	    			context+="<td><div class='referenceDiv'><input type='text' name='ybje' value='"+data.bean.cashbills[i].ybje+"' class='tt' onchange='ybje_sum();'/></div></td>";
	    			context+="<td><div class='referenceDiv'><input type='text' name='digest' value='"+data.bean.cashbills[i].digest+"' class='tt' /></div></td> </tr>";
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
	var appreason = $("#appreason").val();
	var account = $("#account").val();
	if(digest==""||digest==null){
		alert("摘要不能为空!");
		return;
	}
	if(appreason==""||appreason==null){
		alert("下拨原因不能为空!");
		return;
	}
	if(account==""||account==null){
		alert("汇出账号不能为空!");
		return;
	}
	$('#tbody tr').each(function() {
		var billno = $(this).find("input[name='billno']").val();
		var ybje = $(this).find("input[name='ybje']").val();
		var digest = $(this).find("input[name='digest']").val();
		if(billno==""||billno==null){
			alert("表体下拨资金申请单编号不能为空!");
			return;
		}
		if(ybje==""||ybje==null){
			alert("表体本次实拨金额不能为空!");
			return;
		}
		if(digest==""||digest==null){
			alert("表体摘要不能为空!");
			return;
		}
	});
	var cashitemArray = new Array();  
	$('#tbody tr').each(function() {
		var billno = $(this).find("input[name='billno']").val();
		var account = $(this).find("input[name='account']").val();
		var jkje = $(this).find("input[name='jkje']").val();
		var yhje = $(this).find("input[name='yhje']").val();
		var whje = $(this).find("input[name='whje']").val();
		var ybje = $(this).find("input[name='ybje']").val();
		var digest = $(this).find("input[name='digest']").val();
		cashitemArray.push({"billno":billno,"account":account,"jkje":jkje,"yhje":yhje,"whje":whje,"ybje":ybje,"digest":digest});   
	});
	var loanbill = {};  
	loanbill.digest  = $("#digest").val();
	loanbill.lzje  = $("#lzje").val();
	loanbill.appreason  = $("#appreason").val();
	loanbill.account  = $("#account").val();
	loanbill.pk_loanbill  = $("#pk_loanbill").val();
	loanbill.cashbills = cashitemArray;
	loanbill.billtypecode =  $("#billtypecode").val();
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
function getCashbill(that){
	var total = 0;
	var flag = true;
	var tr = $(that).parents('tr');
	var billno = tr.find('input[name="billno"]').val();
	$('#tbody tr').each(function() {
		var billno1 = $(this).find("input[name='billno']").val();
		if(billno==billno1){
			total+=1;
			if(total>=2){
				alert("表体已经包含此申请单!");
				$(this).find("input[name='billno']").val("");
				flag =false;
			}
			
		}
	});
	if(flag==false){
		return;
	}
	$.ajax({
	    type : "POST",  
	    url : "<%=request.getContextPath()%>/loanbill/getCashbill.do?billno="+billno,
        contentType : 'application/json',  
	    dataType: "json",
	    success:function(data){
	    	if(data.state=="true"){
	    		$(".bill .referenceDiv input").css("text-align","center");
	    		tr.find('input[name="jkje"]').val(data.cashbill.jkje);
	    		tr.find('input[name="account"]').val(data.cashbill.account);
	    		tr.find('input[name="yhje"]').val(data.cashbill.yhje);
	    		tr.find('input[name="whje"]').val(data.cashbill.whje);
	    	}else{
	    		alert(data.error);
	    		tr.find('input[name="billno"]').val("");
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
									<input type="text" class="text_date_half" name="billdate" id="billdate"  readonly value="${bean.billdate}" />
								</div>
	                        </div>
	                        <div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label">还款人名称:</label>
	                          <div class="inputbox">
	                            <input type="text" name="psnname" id="psnname" readonly value="${bean.psnname}" />
	                            <input type="hidden" name="pk_psn" id='pk_psn' value="${bean.pk_psn}"/>
	                             
	                          </div>
	                        </div>
	                       <div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label">电子邮箱:</label>
	                          <div class="inputbox">
	                            <input type="text" name="email" id="email" readonly value="${bean.email}"  />
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
                    </div>
                                                                                                                        
<!-- 其他信息  -->       
             
                    <div class="m-formbox mainlist clear" style="height:auto;">
                      <div class="title">
						<span class="toggle_btn" style='visibility:hidden'></span>
						其他信息
					  </div>
                      <div class="cont clearfix">
                          <div class="row">
                           <div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label"><span class="red">*</span>下拨原因:</label>
	                          <div class="inputbox">
	                            <input name="appreason" id="appreason" class="form-control tt" value="${bean.appreason}"  />
	                          </div>
	                        </div>
							 <div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label"><span class="red">*</span>下拨金额:</label>
	                          <div class="inputbox">
	                            <input name="lzje" id="lzje" class="form-control" value="${bean.lzje}"  readonly/>
	                          </div>
	                        </div>
							 <div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label"><span class="red">*</span>汇出账号:</label>
	                          <div class="inputbox">
	                            <input name="account" id="account" class="form-control tt" value="${bean.account}"  />
	                          </div>
	                        </div>
	                        <div class="col-md-4 col-sm-6 col-xs-12">
								<label class="label"><span class="red">*</span>摘要:</label>
								<div class="inputbox">
									<input type="text" id="digest" name="digest" class="tt"  maxlength="30" value="${bean.digest}"  />
								<p class="digest_tip" id="digest_tip" 	>30字以内</p>
								</div>
							</div>
	                        <div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label">原始单据状态:</label>
	                          <div class="inputbox">
	                            <input type="text" name="pbillstatusname"  id="pbillstatusname"  value="${bean.pbillstatusname}" readonly />
	                             <input type="hidden" name="pbillstatus" readonly id="pbillstatus" value="${bean.pbillstatus}" />
	                          </div>
	                        </div>
                        </div>
                      </div>
                    </div>
 					
 <!-- 费用明细  -->                   
                    
                    <div class="m-formbox m-formbox-nofloat">
                      <div class="title">还款明细
                        <div class="pull-right">
							<a class="btn btn-mini btn-success" onclick="deductionAdd_row();" id="add">增行</a>
                          <a class="btn btn-mini btn-success" onclick="delpayDeteil()" id="cut">删行</a>
                        </div>
                      </div>
                      <div class="cont clearfix">
                        <div class="table-responsive">
                          <table class="table table-bordered table-hover table-striped" namespace=""  name=""  id="" >
                            <thead>
                              <tr>
                              	<th>选择</th>
                        		<th class="red">下拨资金申请单号</th>
                               <th>银行账号</th>
                               <th>申请下拨金额</th>
                               <th>未实拨金额</th>
                               <th>累计已实拨金额</th>
                                <th class="red">本次实拨金额</th>
                                <th class="red">备注</th>
                                
                              </tr>
                            </thead>
                            <tbody id="tbody">
                               <% 
                                        List<Cashbill> vos = resultVo.getCashbills();
								        if(vos!=null&&vos.size()>0){
								        	for(int i=0;i<vos.size();i++){
								        		Cashbill item = vos.get(i);
		                        	%>
                              <tr class="rowPrototype">
                              	<td><input type="checkbox" name="check1"/><input type="hidden" name="pk_cashbill" value="<%=item.getPk_cashbill() %>" /></td>
		                        <td><div class="referenceDiv"> <input type="text" name="billno" class="tt"  value="<%=item.getBillno()%>" onchange="getCashbill(this);"/></div></td>
				        		<td><div class="referenceDiv"><input type="text" name="account" value="<%=item.getAccount()%>" readonly/></div></td>	
				        		<td><div class="referenceDiv"><input type="text" name="jkje" value="<%=item.getJkje()%>" readonly/></div></td>	
				        		<td><div class="referenceDiv"><input type="text" name="whje" value="<%=item.getWhje()%>" readonly /></div></td>
				        		<td><div class="referenceDiv"><input type="text" name="yhje" value="<%=item.getYhje()%>" readonly /></div></td>
				        		<td><div class="referenceDiv"><input type="text" name="ybje" class="tt" value="<%=item.getYbje()%>" onchange="ybje_sum();"/></div></td>
				        		<td><div class="referenceDiv "><input type="text" name="digest" class="tt" value="<%=item.getDigest()%>"/></div></td>
                             </tr>
                             <%}}else{ %>
                                <tr class="rowPrototype">
                              	<td><input type="checkbox" name="check1"/><input type="hidden" name="pk_cashbill" /></td>
		                        <td><div class="referenceDiv"> <input type="text" name="billno" class="tt" onchange="getCashbill(this);"/></div></td>
				        		<td><div class="referenceDiv"><input type="text" name="account" readonly/></div></td>	
				        		<td><div class="referenceDiv"><input type="text" name="jkje"  readonly/></div></td>	
				        		<td><div class="referenceDiv"><input type="text" name="whje" readonly /></div></td>
				        		<td><div class="referenceDiv"><input type="text" name="yhje"  readonly /></div></td>
				        		<td><div class="referenceDiv"><input type="text" name="ybje" class="tt" onchange="ybje_sum();"/></div></td>
				        		<td><div class="referenceDiv "><input type="text" name="digest" class="tt" /></div></td>
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
      <input name="billtypecode" id="billtypecode" type="hidden" value="ZJZF"/>
      <input name="pk_loanbill" id="pk_loanbill" type="hidden" value="${bean.pk_loanbill}"/>
  	 <input name="year" id="year" type="hidden" value="${bean.year}"/>
  	 <input name="month" id="month" type="hidden" value="${bean.month}"/>
</form>
 			
 			
</body>
</html>
<script type="text/javascript">
</script>