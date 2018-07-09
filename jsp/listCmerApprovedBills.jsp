<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%@page import="java.util.List"%>
<%@page import="com.erp.bean.Workflow"%>
<%
    String range = null; 
        if(request.getAttribute("range") != null) {  //如果request中取出的bean不为空
        	range = (String)request.getAttribute("range");  //从request中取出vo, 赋值给resultVo
        }
%>
<!DOCTYPE html>
<html>
<head>
<!--头部-->
<%@ include file="head.jsp" %>
<title>单据审批</title>
<meta http-equiv="X-UA-Compatible" content="IE=8,11,chrome=1">
<script>
$(document).ready(function(){
	$("li[name='leaderApprove']").addClass('active');
	$("#leader").attr("style","background-color: green;");
	if('<%=range%>'!=null){
		$("#range").find("option[value = '"+<%=range%>+"']").attr("selected","selected");
	}
});

function list_onClick(){
	var billno = $("#allcondition").val();
	var range = $("#range").val();
	window.location="<%=request.getContextPath()%>/workflow/toApprovePage.do?billno="+billno+"&range="+range;
}
function close1(){
	 $("#trackModal").hide();
}
function viewBill_onClick(id,billtype,pk_pubwork){
	   window.location="<%=request.getContextPath()%>/loanbill/viewBill.do?pk_loanbill="+id+"&billtype="+billtype+"&action=leadView&pk_pubwork="+pk_pubwork; 
	  }
function pub_onMouseOver(billno){//追踪
	 $("#spyjtr tr").remove();
		$.ajax({
			type : "POST",
			url : "<%=request.getContextPath()%>/workflow/approvresult.do?billid="+billno,
			async : false,  //同步请求
			dataType: "json",
			success:function(data){
				var appendHtml="";
		    	for (var i=0;i<data.list.length;i++){
		    		if(data.list[i].checkresult == '0'){
		    			data.list[i].checkresult = '未审批';
		    		}else if(data.list[i].checkresult == '1'){
		    			data.list[i].checkresult = '通过'
		    		}
		    		else if(data.list[i].checkresult == '2'){
		    			data.list[i].checkresult = '不批准'
		    		}
		    		else if(data.list[i].checkresult == '3'){
		    			data.list[i].checkresult = '驳回'
		    		}
		    	appendHtml="<tr ><td style='min-width:60px!important;'>"+data.list[i].sendermanname+"</td><td>"+data.list[i].senddate+"</td><td style='min-width:60px!important;'>"+data.list[i].psnname+"</td><td>"+data.list[i].checkdate+"</td><td style='min-width:80px!important;'>"+data.list[i].checkresult+"</td><td>"+data.list[i].checknote+"</td></tr>";
  		    	$("#spyjtr").append(appendHtml);
		    		}
		   	 $('#trackModal').show();
				var thead = $('#trackModal .table:first').find('th');
		 	    var tbody = $('#spyjtr tr:first').find('td');
		 	    if(tbody.length>0){
		 		   for(var j = 0;j<thead.length;j++){
		 			  thead.eq(j).css("width",tbody.eq(j).css("width"));
		 		   }
		 	   }
				
		  }, 
			error: function() {
	        alert("搜索失败，请稍后再试！");
	        }
		});
}
function allPass(){
	var flag = false;
	$('#flowBody tr').each(function() {
		if($(this).find("input[name='check2']").prop('checked')){
			flag=true;
		}
	})
	if(flag==false){
		alert("请勾选需要批量通过的单据！");
		return;
	}
	$('#flowBody tr').each(function() {
		if($(this).find("input[name='check2']").prop('checked')){
			var pk_loanbill = $(this).find("input[name='pk_loanbill']").val();
			var pk_pubwork = $(this).find("input[name='pk_pubwork']").val();
			$.ajax({ 
			    type : "POST",  
			    url : "<%=request.getContextPath()%>/workflow/checkBill.do?flag=1&pk_loanbill="+pk_loanbill+"&pk_pubwork="+pk_pubwork,
		        contentType : 'application/json',  
			    dataType: "json",
			    error:function(data){
			    },
			    success : function(data){
			    	if(data.state=="true"){
			    		
			    	}else{
			    		alert(data.error);
			    	}
			    }
			});
		}
	});
	location.href="<%=request.getContextPath()%>/workflow/toApprovePage.do";
}
function allcheck1(){
	var isChecked = $("#checkTotal").is(":checked");
    if(isChecked==true){
    	$("input[name='check2']").each(function() {  
    		  this.checked = true;  
        });  
    }
    if(isChecked==false){
    	$("input[name='check2']").each(function() {  
            this.checked = false;  
        });  
    }
}
function allSendback(){
	var flag = false;
	$('#flowBody tr').each(function() {
		if($(this).find("input[name='check2']").prop('checked')){
			flag=true;
		}
	})
	if(flag==false){
		alert("请勾选需要批量驳回的单据！");
		return;
	}
	$('#askModal2').show();
}
function closeMod(){
	$('#askModal2').hide();
}
function approve1(){
	var checknote = $("#checknote1").val();
	$('#flowBody tr').each(function() {
		if($(this).find("input[name='check2']").prop('checked')){
			var pk_loanbill = $(this).find("input[name='pk_loanbill']").val();
			var pk_pubwork = $(this).find("input[name='pk_pubwork']").val();
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
	});
	
}
</script>
<style type="text/css">
a {
	text-decoration: none;
}
</style>
<style>
        #header
        {
     /*        width: 1000px; */
            margin-left: auto;
            margin-right: auto;
        }
        /*  #tblGrid
        {
            border: 0;
            cellpadding: 0;
            margin-left: auto;
            margin-right: auto;
        }  */
  #tblGrid thead tr td
        {
            color: #666;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
            background:#def3fc ;
        }
        #tblGrid thead tr td[name*="paixu"]{
        	background:#def3fc url('<%=request.getContextPath()%>/static/img/sort_default.png') no-repeat right center;
        }
   #tblGrid thead tr td.tolow{
   	background:#def3fc url('<%=request.getContextPath()%>/static/img/sort_tolow.png') no-repeat right center;
   }
   #tblGrid thead tr td.tohigh{
   	background:#def3fc url('<%=request.getContextPath()%>/static/img/sort_tohigh.png') no-repeat right center;
   }
   /*      #tblGrid th, #tblGrid td
        {
            border: 1px solid #E1E1E1;
            text-align: center;
        }  */
        .hover
        {
            background-color: #5dd354;
            cursor: pointer;
        }
        .sorted
        {
            background-color: rgba(228, 242, 252, 0.39);
        }
        .clickable
        {
            text-decoration: underline;
        }
    </style>
</head>

  <body>
    <div class="container-fluid">
		<!--头部结束-->
	<form name="form" method="post" id="form">
      <div class="row m-content approveCenter">
        <div class="col-md-12">
              <div class="m-column" style="overflow:hidden;min-height:500px;">
                <div class="header">
                  <div class="title">财务审核</div>
                  <div class='spstatus_div'>
                  </div>
                </div>
                <div class="body clearfix">
                  <div class="cont">
                    <div class="top clearfix">
                        <div class="navbar-form navbar-left" role="search" style="top: 1px;padding-right:5px">
                          <div class="form-group">
                            <input type="text" class="form-control" placeholder='请输入单据号'   style='width:180px;font-size:12px;color:#555'id="allcondition" name="allcondition" value="<%=request.getAttribute("allcondition")==null?"":request.getAttribute("allcondition")%>"/>
                          </div>
                      
                        </div>

			&nbsp&nbsp&nbsp&nbsp
							查询范围： <select
											name="selectstatus" class="form-control"  id="range"
											onchange="javascript:changeSelectStatus();">
											<option value="6" selected>-未选择-</option>
											<option value="1">一周内未审核</option>
											<option value="2">一月内未审核</option>
											<option value="3">三月内未审核</option>
											<option value="4">六月内未审核</option>
											<option value="5">一年内未审核</option>
										</select>
&nbsp&nbsp
						<span style="margin-left:5px"><a class="btn btn-success" href="javascript:list_onClick()" style='height:25px;width:45px;padding:0!important;line-height:24px'>查询</a></span>
						<span style="margin-right:5px"><a  class="btn"  href="javascript:allPass()" style='height:25px;width:70px;padding:0!important;line-height:24px;border-color: green;border-width: 2px'>批量通过</a></span>
						<span style="margin-right:5px"><a  class="btn"  href="javascript:allSendback()" style='height:25px;width:70px;padding:0!important;line-height:24px;border-color: red;border-width: 2px'>批量驳回</a></span>
                    </div>
					</div>
                    <table class="table table-bordered table-striped" id="tblGrid">
                      <thead>
                        <tr>
                        		<td style='min-width:35px;'><input type="checkbox" id="checkTotal" onclick="allcheck1()"/></td>
                        		<td name="paixu">单据编号</td>
                        		<td style='width:350px;' name="paixu">摘要</td>
                        		<td name="paixu_num">列账金额</td>
                        		<td style='min-width:110px;' name="paixu">报账单类型</td>
                        		<td style='min-width:65px;' name="paixu">原始单据状态</td>
                        		<td style='min-width:85px;' name="paixu">发送时间</td>
                        		<td style='min-width:65px;' name="paixu">发送人</td>
                        		<td style='min-width:65px;' name="paixu">经办人</td>
                        		<td style='min-width:56px;'>操作</td>
                        </tr>
                      </thead>
                      <tbody id="flowBody">
                     	<%
							List<Workflow> lResult = null; //定义结果列表的List变量
							if (request.getAttribute("beans") != null) { //如果request中的beans不为空
							lResult = (List) request.getAttribute("beans"); //赋值给resultList
							for (int i = 0; i < lResult.size(); i++) {
							Workflow vo = lResult.get(i);
								if("grant".equals(vo.getBillno())){%>
                     		 <tr>
                     		 		<td colspan="10" style="text-align:left;"><font size="3" color="green"><%=vo.getChecknote()%></font></td>
                             </tr>
                      <%}else{ %>
                      	 <tr ondblclick="viewBill_onClick('<%=vo.getBillid() %>','<%=vo.getBilltypecode()%>','<%=vo.getPk_pubwork()%>')">
							<td><input type="checkbox" name="check2" onclick=""/>
								<input type="hidden" name="billtypecode" value="<%=vo.getBilltypecode()%>"/>
								<input type="hidden" name="pk_loanbill"  value="<%=vo.getBillid() %>"/>
								<input type="hidden" name="pk_pubwork"  value="<%=vo.getPk_pubwork() %>"/>
							</td>
                      		<td name="billnos"><%=vo.getBillno() %></td>

							<td style='font-size:12px'><%=vo.getDigest() %></td>
							<td><%=vo.getLzje() %></td>
							<td><%=vo.getBilltypename() %></td>
							<td><%=vo.getPbillstatusname() %></td>

                      		<td style='font-size:12px'><%=vo.getSenddate() %></td>
                      		<td><%=vo.getSendermanname() %></td>
                      		<td><%=vo.getPsnname() %></td>
                      		<td>
                      			<a  class="operateBtn text-orange" style='padding-right:0'  onclick="javascript:viewBill_onClick('<%=vo.getBillid() %>','<%=vo.getBilltypecode()%>','<%=vo.getPk_pubwork()%>')"><i class="glyphicon glyphicon-eye-open" title="查看"></i></a>
                      			<a class="operateBtn text-success"  style='padding-right:0' onclick="javascript:pub_onMouseOver('<%=vo.getBillid() %>')"><i class="glyphicon glyphicon-info-sign" title="审批跟踪"></i></a>
                      </tr>
                      <%}}} %>
                      </tbody>
                    </table>
                  
                    <!-- 跟踪Modal -->
								<div class="modal modal-1" id="trackModal" tabindex="-1"
									role="dialog" data-backdrop="static" data-keyboard="false">
									<div class="modal-dialog" style="width:1150px">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" onclick="$('#trackModal .clearfix').find(':input').val('');close1();" class="close" data-dismiss="modal">
													<span aria-hidden="true"  data-dismiss="modal">&times;</span><span
														class="sr-only">Close</span>
												</button>
												<h4 class="modal-title">审批详情</h4>
											</div>
											<div class="modal-body clearfix" style='overflow:hidden'>
												<div  class='t-head'
													style="min-height: auto; padding: 0 17px 0 0px; margin: 0;overflow:hidden;margin-right:17px">
													<table class="table table-bordered" style='table-layout:fixed;overflow:hidden'>
														<thead>
															<tr style="white-space: nowrap">
																<th>发送人</th>
																<th>发送日期</th>
																<th>审批人</th>
																<th>审批日期</th>
																<th>审批状况</th>
																<th>审批意见</th>
															</tr>
														</thead>
													</table>
												</div>
												<div class="table-responsive" onscroll="scrollLid(this)"
													style="height: 331px; margin-top: -1px; overflow-x: hidden; overflow: scroll;">
													<table class="table table-bordered">
														<tbody id="spyjtr" align="center">

														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>
								</div>
						 <!-- 改派 -->
                  </div>
                </div>
              </div>
        </div>
                              <center>
									
										<a class="btn btn-mini btn-success" href="<%=request.getContextPath()%>/workflow/toApprovePage.do?currentPage=${currentPage-1}&range=${range}">上一页</a>
										<font size="4" color="green"><%=request.getAttribute("currentPage") %></font><font size="3">(共</font><font size="4" color="red"><%=request.getAttribute("totalPage") %></font><font size="3">页)</font>
										<a class="btn btn-mini btn-success" href="<%=request.getContextPath()%>/workflow/toApprovePage.do?currentPage=${currentPage+1}&range=${range}">下一页</a>
									</center>
         </div>
      </form>
    </div>
  </body>
<script type="text/javascript">
	document.getElementById("bs-example-navbar-collapse-2").style.display="block";
</script>

</html>
<!-- 不批准Modal -->
                    <div class="modal modal-1" id="askModal2" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
                      <div class="modal-dialog">
                        <div class="modal-content">
                          <div class="modal-header">
                            <button type="button" onclick="$('#askModal2 .clearfix').find(':input').val('');" class="close" data-dismiss="modal"><span onclick="closeMod();" aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title">批量不批准原因</h4>
                          </div>
                          <div class="modal-body clearfix">
                            </div>
                            <div class="m-form-group" align="center"><textarea style="width:550px;"  class="form-control" rows="5"  name="checknote1" id="checknote1">不批准</textarea></div>
                            <div class="text-center"><a class="btn btn-primary"  onclick="approve1()">确定</a></div>
                          </div>
                        </div>
                      </div>
                    </div>
     
