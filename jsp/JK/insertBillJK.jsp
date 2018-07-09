<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.erp.bean.Loanbill" %>
<%
    Loanbill resultVo = null;  //定义一个临时的vo变量
        if(request.getAttribute("bean") != null) {  //如果request中取出的bean不为空
            resultVo = (Loanbill)request.getAttribute("bean");  //从request中取出vo, 赋值给resultVo
        }
%>
<!DOCTYPE html>
<html>
<head>
<!--头部-->
<%@ include file="/jsp/head.jsp"%>
<title>员工借款单</title>

<script type="text/javascript">
function save_onclick(){
	var appreason = $("#appreason").val();
	var lzje = $("#lzje").val();
	var account = $("#account").val();
	var digest = $("#digest").val();
	if(appreason==""||appreason==null){
		alert("借款原因不能为空!");
		return;
	}if(lzje==""||lzje==null){
		alert("借款金额不能为空!");
		return;
	}
	if(digest==""||digest==null){
		alert("摘要不能为空!");
		return;
	}
    if(account==""||account==null){
    	alert("账户不能为空!");
		return;
	}

	form.action="<%=request.getContextPath()%>/loanbill/saveJK.do";
    form.submit();
}
$(document).ready(function(){
	$("#update_save").hide();
	$("#back_commit").hide();
	<% if(request.getAttribute("action")!=null){%>
		$(".tt").attr("readonly","readonly");
	<%}%>
	if('<%=request.getAttribute("action")%>'=="detail"){
		alert("保存成功");
		$(".tt").attr("readonly","readonly");
	}
	if('<%=resultVo.getZffs()%>'!=null){
		$("#<%=resultVo.getZffs()%>").attr("selected","selected");
	}
});
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
function update_save(){
	var pbillstatusname = $("#pbillstatusname").val();
	var appreason = $("#appreason").val();
	var lzje = $("#lzje").val();
	var account = $("#account").val();
	var digest = $("#digest").val();
	if(appreason==""||appreason==null){
		alert("借款原因不能为空!");
		return;
	}if(lzje==""||lzje==null){
		alert("借款金额不能为空!");
		return;
	}
	if(digest==""||digest==null){
		alert("摘要不能为空!");
		return;
	}
    if(account==""||account==null){
    	alert("账户不能为空!");
		return;
	}
	var loanbill = {};  
	loanbill.digest  = $("#digest").val();
	loanbill.lzje  = $("#lzje").val();
	loanbill.account  = $("#account").val();
	loanbill.appreason =  $("#appreason").val();
	loanbill.billtypecode =  $("#billtypecode").val();
	loanbill.zffs =  $("#zffs  option:selected").val();
	loanbill.pk_loanbill  = $("#pk_loanbill").val();
	$.ajax({
	    type : "POST",  
	    url : "<%=request.getContextPath()%>/loanbill/updateBill.do",
        contentType : 'application/json',  
	    dataType: "json",
	    data: JSON.stringify(loanbill),//将对象序列化成JSON字符串  
	    success:function(data){
	    	if(data.state=="true"){
	    		alert("修改成功！");
	    		$("#save").hide();
	    		$("#update").show();
	    		$("#commit").show();
	    		$("#update_save").hide();
	    		if(pbillstatusname=="退单"){
	    			$("#back_commit").show();
	    		}
	    		$(".tt").attr("readonly","readonly");
	    	}else{
	    		
	    	}
	    }
	});
}
function update_onClick(){
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

								<div class="m-formbox">
									<div class="title">
										<span class="toggle_btn" onclick="clickToogle(this)"></span> 基本信息
									</div>
									<div class="cont clearfix">
										<div class="row">
											<div class="col-md-4 col-sm-6 col-xs-12">
												<label class="label"><span class="red">*</span>日期:</label>
												<div class="inputbox">
													<input type="text" class="text_date_half" name="billdate" readonly
														id="billdate" value="${bean.billdate}" />
												</div>
											</div>
											<div class="col-md-4 col-sm-6 col-xs-12">
												<label class="label">经办人名称</label>
												<div class="inputbox">
													<input type="text" name="psnname" id="psnname"
														value="${bean.psnname}" readonly="readonly"/> 
														<input
														type="hidden" name="pk_psn" id="pk_psn"
														value="${bean.pk_psn}" />
												</div>
											</div>
											<div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label">电子邮箱:</label>
	                          <div class="inputbox">
	                            <input type="text" name="email" readonly value="${bean.email}"  />
	                          </div>
	                        </div>
										</div>
										<div class="row hide_div">
											<div class="col-md-4 col-sm-6 col-xs-12">
												<label class="label">报账单编号:</label>
												<div class="inputbox">
													<input type="text" id="vbillno" name="vbillno"
														value="${bean.vbillno}" readonly />
												</div>
											</div>

											
											<div class="col-md-4 col-sm-6 col-xs-12">
												<label class="label">部门:</label>
												<div class="inputbox">
													<input type="text" name="deptname" id="deptname"
														value="${bean.deptname}" readonly /> <input type="hidden"
														name="deptid" id="deptid" value="${bean.deptid}" />
												</div>
											</div>
											
											<div class="col-md-4 col-sm-6 col-xs-12">
												<label class="label">手机号码:</label>
												<div class="inputbox">
													<input type="text" name="mobile" id="mobile"
														value="${bean.mobile}" readonly />
												</div>
											</div>
										</div>
									</div>
								</div>

								<!-- 借款信息  -->

								<div class="m-formbox" style="height:auto;">
									<div class="title">
										<span class="toggle_btn" style='visibility:hidden'></span> 借款信息
									</div>

									<div class="cont clearfix">
										<div class="row">
										 <div class="col-md-4 col-sm-6 col-xs-12">
												<label class="label"><span class="red">*</span>借款原因:</label>
												<div class="inputbox">
													<input type="text" name="appreason" class="tt" id="appreason"
														class="money_field_location_left" value="${bean.appreason }" onchange='getFloatStrByInput($(this),-1);' />
												</div>
											</div>
											<div class="col-md-4 col-sm-6 col-xs-12">
												<label class="label"><span class="red">*</span>借款金额:</label>
												<div class="inputbox">
													<input type="text" name="lzje" id="lzje" 
														class="money_field_location_left tt" value="${bean.lzje }" onchange='getFloatStrByInput($(this),-1);' />
												</div>
											</div>
											<div class="col-md-4 col-sm-6 col-xs-12">
												<label class="label"><span class="red">*</span>支付方式:</label>
													<div class="inputbox">
														<select name="zffs" id="zffs" class="tt" >
                              			<option value="1" id="1">现金</option>
                              			<option value="2" id="2">银行转账</option>
                              			<option value="3" id="3">转账支票</option>
                              		</select>
													</div>
											</div>
											<div class="col-md-4 col-sm-6 col-xs-12">
												<label class="label"><span class="red">*</span>账户:</label>
												<div class="inputbox">
													<input name="account" id="account" class="tt" value="${bean.account }"
														 />
												</div>
											</div>
										</div>
									</div>
								</div>

								<!-- 其他信息  -->

								<div class="m-formbox">
									<div class="title">
										<span class="toggle_btn" style='visibility:hidden'></span> 其他信息
									</div>
									<div class="cont clearfix">
										<div class="row">
											<div class="col-md-4 col-sm-6 col-xs-12" style='heigt:24px;'>
												<label class="label"><span class="red">*</span>摘要:</label>
												<div class="inputbox">
													<input type="text" id="digest" class="tt" name="digest"  maxlength="30"
														value="${bean.digest}"
														onkeyup='setdg_tip()' onchange="javascript:digestControll();"
														onfocus="javascript:saveDigest();">
													<p class="digest_tip" id="digest_tip">30字以内</p>
												</div>
											</div>
											
										
								<div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label">原始单据状态:</label>
	                          <div class="inputbox">
	                            <input type="text" name="pbillstatusname" id="pbillstatusname"  value="${bean.pbillstatusname}"   readonly />
	                             <input type="hidden" name="pbillstatus" readonly id="pbillstatus" value="${bean.pbillstatus}" />
	                          </div>
	                        </div>
										</div>
									</div>
								</div>

								<div class="next">
								 <%@ include file="/jsp/button.jsp"%>
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
      <input name="billtypecode" id="billtypecode" type="hidden" value="JK"/>
      <input name="pk_loanbill" id="pk_loanbill" type="hidden" value="${bean.pk_loanbill}"/>
  	 <input name="year" id="year" type="hidden" value="${bean.year}"/>
  	 <input name="month" id="month" type="hidden" value="${bean.month}"/>
</div>
</form>
</body>
</html>
<script type="text/javascript">

</script>
