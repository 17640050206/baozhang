<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.erp.bean.Workflow"%>
<!DOCTYPE html>
<html>
<head>
<!--头部-->
<%@ include file="/jsp/head.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>补退单消息</title>
<meta http-equiv="X-UA-Compatible" content="IE=8,11,chrome=1">
  <style type="text/css">
    .one:hover{
        color:red;
        cursor:hand;
        text-decoration:underline;
    }
  </style>
<script type="text/javascript">

$(document).ready(function(){
	$("li[name='message']").addClass('active');
	$("#baozhangren").attr("style","background-color: green;");
	loadProperties();
});
function openPubMessageinfo(messageid){
	$.ajax({ 
	    type : "POST",  
	    url : "<%=request.getContextPath()%>/common/getPubMessageinfo?pk="+messageid,
        contentType : 'application/json',  
	    dataType: "json",
	    error:function(data){
		//alert("系统通知查询失败，请联系管理员。");
	    },
	    success : function(data){
	    	for(var i=0;i<data.length;i++){
		    	$("div[name=gonggao1] pre[name=gonggaot]").text(data[i].billno+"\n\n");
		    	$("div[name=gonggao1] pre[name=gonggao]").text(data[i].content+"\n\n");
		    	$("div[name=gonggao1] pre[name=gonggaow]").text("\n发布时间："+data[i].senddate+"\n");
				$('#xttzModal').modal('toggle');
	    	}
	    }
	});
};

function btdxx_onClick(){  //补退单信息
	this.location.href="<%=request.getContextPath()%>/workflow/getBtdList.do";
}

function xxgl_onClick() {  //消息管理
	this.location.href="<%=request.getContextPath()%>/pubmessage/getallmessage.do";
}

//已上线的单据可以在领导审批界面查看单据详情
function detailBill(){
	var billid = $("input[name='billid']").val();
	var pk_billtype = $("input[name='pk_billtype']").val();
	if(pk_billtype=="CL" || pk_billtype=="23AE" || pk_billtype=="DTBZ" || pk_billtype=="23A0" || 
	   pk_billtype=="23A2" || pk_billtype=="RCBZ" || pk_billtype=="SJ" || pk_billtype=="23AK" || 
	   pk_billtype=="CEZF" || pk_billtype=="23A3" || pk_billtype=="CGYX" || pk_billtype=="23A4" || 
	   pk_billtype=="23A5" || pk_billtype=="23A1" || pk_billtype=="JK" || pk_billtype=="23A7" || 
	   pk_billtype=="QDCJ" || pk_billtype=="ZFSQ"){
		viewBill_onClick(billid,pk_billtype);
	}else{
		alert("此单据类型未上线！");
	}
}

//与首页补退单信息栏单据预览界面按钮一致
function viewBill_onClick(id,billtype){
	 window.location="<%=request.getContextPath()%>/loanbill/viewBill.do?pk_loanbill="+id+"&billtype="+billtype+"&action=backBillView"; 
  }

</script>
</head>
  <body>
    <div class="container-fluid">
			
      <div class="row m-content message">
        <div class="col-md-12">
              <div class="m-column" style="margin-bottom: 0;">
                <div class="header tabheader">
                  <div class="title " onclick="xxgl_onClick()">消息管理</div>
                  <div class="title act" onclick="btdxx_onClick()">补退单消息</div>
                </div>
                <div id="list" class="body clearfix">
		                <form name="form" method="post" id="form">
		                  <div class="cont" style="height:530px;">
		                    <table class="table table-bordered table-hover table-striped">
		                      <thead>
		                        <tr>
		                        	<th>单据号</th>
		                        	<th>补退单原因</th>
		                        	<th>发送日期</th>
		                        	<th>发送人</th>
		                        </tr>
		                      </thead>
		                      <tbody>
										<%
											List<Workflow> lResult = null; //定义结果列表的List变量
											if (request.getAttribute("beans") != null) { //如果request中的beans不为空
											lResult = (List) request.getAttribute("beans"); //赋值给resultList
											for (int i = 0; i < lResult.size(); i++) {
												Workflow vo = lResult.get(i);
										%>
										<tr >
											<td class="one" style=" width: 10%;" onclick="javascript:viewBill_onClick('<%=vo.getBillid()%>','<%=vo.getBilltypecode()%>');">
											<%=vo.getBillno()%>
											<input type="hidden" name="billid" value="<%=vo.getBillid()%>"/>
											<input type="hidden" name="pk_billtype" value="<%=vo.getBilltypecode()%>"/>
											</td>
											<td style=" width: 30%;"><%=vo.getChecknote()%></td>
											<td style=" width: 6%;"><%=vo.getSenddate()==null||"".equals(vo.getSenddate())?"":vo.getSenddate().substring(2, 10)%></td>
											<td style=" width: 6%;"><%=vo.getCheckmanname()%></td>
										</tr>
										<%}
											} %>
		                      </tbody>
		                    </table>
		                  </div>
		                </form>
		                </div>
              </div>
        </div>
      </div>
	 </div>


    <script>
    	$('#list').on('click','tbody tr',function(){
    		$('#messageModal').modal('toggle');
    	})
    	document.getElementById("bs-example-navbar-collapse-1").style.display="block";
    </script>
  </body>
</html>