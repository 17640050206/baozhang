<%@page contentType="text/html; charset=UTF-8" language="java"%>

<%@page import="java.util.List"%>
<%@page import="com.erp.bean.Loanbill"%>
<%
    String year = null; 
    String month = null; 
    String pbillstatus = null; 
        if(request.getAttribute("year") != null) {  //如果request中取出的bean不为空
            year = (String)request.getAttribute("year");  //从request中取出vo, 赋值给resultVo
        }
        if(request.getAttribute("month") != null) {  //如果request中取出的bean不为空
        	month = (String)request.getAttribute("month");  //从request中取出vo, 赋值给resultVo
        }
        if(request.getAttribute("pbillstatus") != null) {  //如果request中取出的bean不为空
        	pbillstatus = (String)request.getAttribute("pbillstatus");  //从request中取出vo, 赋值给resultVo
        }
%>
<!DOCTYPE html>
<html>
<head>
<!--头部-->
<%@ include file="head.jsp"%>
<title>已报账单据</title>

<meta http-equiv="X-UA-Compatible" content="IE=8,11,chrome=1">
<script>
$(document).ready(function(){
	$("li[name='listCmerSavedBills']").addClass('active');
	$("#baozhangren").attr("style","background-color: green;");
	if('<%=year%>'!=null){
		$("#year").find("option[value = '"+<%=year%>+"']").attr("selected","selected");
	}
	if('<%=month%>'!=null){
		$("#month").find("option[value = '"+<%=month%>+"']").attr("selected","selected");
	}
	if('<%=pbillstatus%>'!=null){
		$("#pbillstatus").find("option[value = '"+<%=pbillstatus%>+"']").attr("selected","selected");
	}
});

   function viewBill_onClick(id,billtype){
	   window.location="<%=request.getContextPath()%>/loanbill/viewBill.do?pk_loanbill="+id+"&billtype="+billtype+"&action=savedView"; 
	  }
   function scrollLid(that){
		 var scroll = $(that).scrollLeft();
		 scroll = "-" + scroll;
		 $(".modal-body .t-head").css("margin-left", scroll + "px");
	 }
	
 	function list_onClick(){  
 		 var year =  $("#year").val();
 		 var month =  $("#month").val();
 		 var selectstatus =  $("select[name='selectstatus']").val().trim();
 		 var billno = $("#allcondition").val();
 		window.location="<%=request.getContextPath()%>/loanbill/toSavedBillPage.do?pbillstatus="+selectstatus+"&year="+year+"&month="+month+"&billno="+billno;
    }
 

//锁定屏幕
function zhezhao(){
	document.getElementById('zhezhao').style.display = "block";
}
//解锁屏幕
function zhezhaofinish(){
	document.getElementById('zhezhao').style.display = "none";
}
 
 function changeSelectStatus(){
	 var year =  $("#year").val();
	 var month =  $("#month").val();
	 var selectstatus =  $("select[name='selectstatus']").val().trim();
	
	 if("1"==selectstatus){
			window.location="<%=request.getContextPath()%>/loanbill/toSavedBillPage.do?pbillstatus=1&year="+year+"&month="+month;
		}
	if("2"==selectstatus){
		window.location="<%=request.getContextPath()%>/loanbill/toSavedBillPage.do?pbillstatus=2&year="+year+"&month="+month;
	}
	if("3"==selectstatus){
		window.location="<%=request.getContextPath()%>/loanbill/toSavedBillPage.do?pbillstatus=3&year="+year+"&month="+month;
	}if("4"==selectstatus){
		window.location="<%=request.getContextPath()%>/loanbill/toSavedBillPage.do?pbillstatus=4&year="+year+"&month="+month;
	}if("5"==selectstatus){
		window.location="<%=request.getContextPath()%>/loanbill/toSavedBillPage.do?pbillstatus=5&year="+year+"&month="+month;
	}if("6"==selectstatus){
		window.location="<%=request.getContextPath()%>/loanbill/toSavedBillPage.do?pbillstatus=6&year="+year+"&month="+month;
	}
	
}
 function pub_onMouseOver(billno){//追踪
	 zhezhao();
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
		    	appendHtml="<tr ><td style='min-width:60px!important;'>"+data.list[i].sendermanname+"</td><td>"+data.list[i].senddate+"</td><td style='min-width:60px!important;'>"+data.list[i].psnname+"</td><td>"+data.list[i].checkdate+"</td><td style='min-width:80px!important;'>"+data.list[i].checkresult+"</td><td>"+data.list[i].checknote+"</td></tr>";
   		    	$("#spyjtr").append(appendHtml);
		    		}
		    	zhezhaofinish();
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
 function close1(){
	 $("#trackModal").hide();
 }
 $(function(){
		$('input').placeholder();
	})
</script>
<style type="text/css">
a {
	text-decoration: none;
}
</style>
<style>
#tblGrid thead tr td {
	color: #666;
	font-weight: bold;
	text-align: center;
	text-decoration: none;
	background: #def3fc;
}

.hover {
	background-color: #5dd354;
	cursor: pointer;
}

.sorted {
	background-color: rgba(228, 242, 252, 0.39);
}

.clickable {
	text-decoration: underline;
}
</style>
</head>
<body>
	<!-- ajax异步请求时锁定屏幕用，半透明div -->
	<div id="zhezhao"
		style="background-color: #000; filter: alpha(opacity : 30); opacity: 0.3; position: fixed; left: 0; top: 0; width: 100%; height: 100%; z-index: 99999; display: none">
		<table style="width: 100%; height: 100%;">
			<tr valign=middle align=center>
				<td><img
					src="<%=request.getContextPath()%>/qh/resources/images/please-wait.gif"></img></td>
			</tr>
		</table>
	</div>
	<div class="container-fluid">
		<!--头部结束-->
		<form name="form" method="post" id="form">
			<div class="row m-content billsList">
				<div class="col-md-12">
					<div class="m-column">
						<div class="header">
							<div class="title">已填制单据</div>
						</div>
						<div class="body clearfix">
							<div class="cont">
								<div class="top clearfix">
									<div class="pull-left" style="margin-right: 20px;">
										<div class="navbar-form navbar-left" role="search"
											style="top: 1px;">
											<div class="form-group">
												<input type="text" id="allcondition" name="allcondition"
													class="form-control" placeholder="搜索单据号" />
											</div>
										</div>
										<span>年份</span> <select id="year"
											name="month" class="form-control" 
											onchange="javascript:changeyear();">
											<option value=""  selected>--</option>
											<option value="1996" >1996</option>
											<option value="1997" >1997</option>
											<option value="1998" >1998</option>
											<option value="1999" >1999</option>
											<option value="2000" >2000</option>
											<option value="2001" >2001</option>
											<option value="2002" >2002</option>
											<option value="2003" >2003</option>
											<option value="2004" >2004</option>
											<option value="2005" >2005</option>
											<option value="2006" >2006</option>
											<option value="2007" >2007</option>
											<option value="2008" >2008</option>
											<option value="2009" >2009</option>
											<option value="2010" >2010</option>
											<option value="2011" >2011</option>
											<option value="2012" >2012</option>
											<option value="2013" >2013</option>
											<option value="2014" >2014</option>
											<option value="2015" >2015</option>
											<option value="2016" >2016</option>
											<option value="2017" >2017</option>
											<option value="2018" id="2018">2018</option>
										</select>
                                        <span>月份</span> <select id="month"
											name="month" class="form-control" 
											onchange="javascript:changemonth();">
											<option value=""  selected>--</option>
											<option value="1" >1</option>
											<option value="2" >2</option>
											<option value="3" >3</option>
											<option value="4" >4</option>
											<option value="5" >5</option>
											<option value="6" >6</option>
											<option value="7" >7</option>
											<option value="8" >8</option>
											<option value="9" >9</option>
											<option value="10" >10</option>
											<option value="11" >11</option>
											<option value="12" >12</option>
										</select>
											<span
											style="margin-left: 20px;">单据状态</span> 
											 <select 
											name="selectstatus" id="pbillstatus" class="form-control" 
											onchange="javascript:changeSelectStatus();">
											<option value="1"  selected>全部状态</option>
											<option value="2">自由态</option>
											<option value="3">提交态</option>
											<option value="4">审批进行中</option>
											<option value="5">审批通过</option>
											<option value="6">退单</option>
										</select> <span><a class="btn btn-primary"
											style="padding-left: 35px;" href="javascript:void(0)" onclick="javascript:list_onClick()">查询</a></span>
									</div>
								</div>
								<div style="min-height: 500px; max-height: 700px" id="mypage">
									<table class="table table-bordered table-striped" id="tblGrid">
										<thead>
											<tr>
												<td name="paixu_num">序号</td>
												<td name="paixu">单据类型</td>
												<td name="paixu">单据编号</td>
												<td name="paixu">报账人</td>
												<td name="paixu_num">金额</td>
												<td name="paixu">单据日期</td>
												<td name="paixu">单据状态</td>
												<td>操作</td>
											</tr>
										</thead>
										<tbody id="TbList">
											<%
											List<Loanbill> lResult = null; //定义结果列表的List变量
											if (request.getAttribute("beans") != null) { //如果request中的beans不为空
											lResult = (List) request.getAttribute("beans"); //赋值给resultList
											for (int i = 0; i < lResult.size(); i++) {
												Loanbill vo = lResult.get(i);
										%>
												<tr
													>
													<td name="xuhao"><%=i+1 %></td>
													<td><%=vo.getBilltypename() %></td>
													<td><%=vo.getVbillno() %></td>
													<td><%=vo.getPsnname() %></td>
													<td><%=vo.getLzje() %></td>
													<td><%=vo.getBilldate() %></td>
													<td>
													<%if("退单".equals(vo.getPbillstatusname())){%>
													 <font color="red"><%=vo.getPbillstatusname() %>！</font>
													<%}else if("审批已完成".equals(vo.getPbillstatusname())){ %>
													 <font color="green"><%=vo.getPbillstatusname() %></font>
													<%} else if("审批进行中".equals(vo.getPbillstatusname())){ %>
													<font color="orange"><%=vo.getPbillstatusname() %></font>
													<%}else{ %>
													<%=vo.getPbillstatusname() %>
													<%} %>
													</td>
													
													<td style="text-align: left;"><input type="hidden"
														name="billtype" value="<%=vo.getBilltypecode() %>" /> <input
														type="hidden" name="pk_loanbill"
														value="<%=vo.getPk_loanbill()%>" /> <center><a class="operateBtn text-orange"
																href="javascript:viewBill_onClick('<%=vo.getPk_loanbill()%>','<%=vo.getBilltypecode() %>')"><i
																class="glyphicon glyphicon-eye-open" title="查看"></i></a>
														<%if(!"自由态".equals(vo.getPbillstatusname())){%>		
														<a class="operateBtn text-success"
																onclick="pub_onMouseOver('<%=vo.getPk_loanbill()%>')"><i
																class="glyphicon glyphicon-info-sign" title="审批跟踪"></i></a>
															<%} %>	
																</center>
														 </td>
												</tr>
											<%}} %>
										</tbody>
									</table>
								</div>
								<div>
									<center>
									
										<a class="btn btn-mini btn-success" href="<%=request.getContextPath()%>/loanbill/toSavedBillPage.do?currentPage=${currentPage-1}&year=${year}&month=${month}&pbillstatus=${pbillstatus}">上一页</a>
										<font size="4" color="green"><%=request.getAttribute("currentPage") %></font><font size="3">(共</font><font size="4" color="red"><%=request.getAttribute("totalPage") %></font><font size="3">页)</font>
										<a class="btn btn-mini btn-success" href="<%=request.getContextPath()%>/loanbill/toSavedBillPage.do?currentPage=${currentPage+1}&year=${year}&month=${month}&pbillstatus=${pbillstatus}">下一页</a>
									</center>
								</div>
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
							</div>
							<a id="temHref" style="display:none"></a>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
<script >
document.getElementById("bs-example-navbar-collapse-1").style.display="block";
</script>

</html>


