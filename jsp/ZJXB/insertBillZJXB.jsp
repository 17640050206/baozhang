<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.erp.bean.Loanbill" %>
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
<title>下拨资金申请报账单</title>
<script type="text/javascript">

function save_onclick(){
	var digest = $("#digest").val();
	var lzje = $("#lzje").val();
	var appreason = $("#appreason").val();
	var account = $("#account").val();
	var transferdate = $("#transferdate").val();
	if(lzje==""||lzje==null){
		alert("申请金额不能为空!");
		return;
	}
	if(appreason==""||appreason==null){
		alert("申请原因不能为空!");
		return;
	}
	if(account==""||account==null){
		alert("账户不能为空!");
		return;
	}
	if(transferdate==""||transferdate==null){
		alert("申请划款日期不能为空!");
		return;
	}
	if(digest==""||digest==null){
		alert("摘要不能为空!");
		return;
	}
	form.action="<%=request.getContextPath()%>/loanbill/saveZJXB.do";
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
	var digest = $("#digest").val();
	var lzje = $("#lzje").val();
	var appreason = $("#appreason").val();
	var account = $("#account").val();
	var transferdate = $("#transferdate").val();
	if(lzje==""||lzje==null){
		alert("申请金额不能为空!");
		return;
	}
	if(appreason==""||appreason==null){
		alert("申请原因不能为空!");
		return;
	}
	if(account==""||account==null){
		alert("账户不能为空!");
		return;
	}
	if(transferdate==""||transferdate==null){
		alert("申请划款日期不能为空!");
		return;
	}
	if(digest==""||digest==null){
		alert("摘要不能为空!");
		return;
	}
	var loanbill = {};  
	loanbill.digest  = $("#digest").val();
	loanbill.lzje  = $("#lzje").val();
	loanbill.account  = $("#account").val();
	loanbill.appreason =  $("#appreason").val();
	loanbill.transferdate =  $("#transferdate").val();
	loanbill.billtypecode =  $("#billtypecode").val();
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
	    		if(pbillstatusname=="退单"){
	    			$("#back_commit").show();
	    		}
	    		$("#update_save").hide();
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
									<input type="text" class="text_date_half" name="billdate" id="billdate" readonly  value="${bean.billdate}"/>
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
                                                                                                                        
                                                                                                    
<!-- 资金信息  -->       
             
                    <div id="htdiv" class="m-formbox mainlist clear" style="height:auto">
                      <div class="title">
						<span class="toggle_btn" style='visibility:hidden'></span>
						资金信息
					  </div>
                      <div class="cont clearfix">
                          <div class="row">
                          
	                        <div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label"><span class="red">*</span>申请金额:</label>
	                          <div class="inputbox">
	                            <input  class="tt" type="text" id="lzje"  name="lzje" value="${bean.lzje}" />
	                          </div>
	                        </div>
	                        <div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label"><span class="red">*</span>申请原因:</label>
	                          <div class="inputbox">
	                            <input type="text" id="appreason"  name="appreason" class="tt" value="${bean.appreason }" />
	                          </div>
	                        </div>
	                        <div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label"><span class="red">*</span>账户:</label>
	                          <div class="inputbox">
	                            <input type="text" id="account"  name="account" class="tt" value="${bean.account }" />
	                          </div>
	                        </div>
	                         <div class="col-md-4 col-sm-6 col-xs-12">
	                          <label class="label"><span class="red">*</span>申请划款日期:</label>
	                          	<div class="inputbox">
									<input type="text" class="tt"  name="transferdate" id="transferdate"  onclick="SelectDate(this,'yyyy\-MM\-dd')"   value="${bean.transferdate}"/>
								</div>
	                        </div>
	                         <div class="col-md-6 col-sm-5 col-xs-12">
								<label class="label"><span class="red">*</span>摘要:</label>
								<div class="inputbox">
									<input type="text" id="digest" name="digest" class="tt"  maxlength="30" value="${bean.digest}"  />
								<p class="digest_tip" id="digest_tip" >30字以内</p>
								</div>
							</div>
	                      </div>
                      </div>
                    </div>
<!-- 其他信息  -->       
             
                    <div class="m-formbox mainlist clear">
                      <div class="title">
						<span class="toggle_btn" style='visibility:hidden'></span>
						其他信息
					  </div>
                      <div class="cont clearfix">
                          <div class="row">
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
      <input name="billtypecode" id="billtypecode" type="hidden" value="ZJXB"/>
      <input name="pk_loanbill" id="pk_loanbill" type="hidden" value="${bean.pk_loanbill}"/>
  <input name="year" id="year" type="hidden" value="${bean.year}"/>
  	 <input name="month" id="month" type="hidden" value="${bean.month}"/>
        

</form>
 			
 			
</body>
</html>
