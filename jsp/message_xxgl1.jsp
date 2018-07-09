<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.erp.bean.Pubmessage"%>
<!DOCTYPE html>
<html>
<head>
<!--头部-->
<%@ include file="/jsp/head.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消息管理</title>
<meta http-equiv="X-UA-Compatible" content="IE=8,11,chrome=1">
<script type="text/javascript">

$(document).ready(function(){
	$("li[name='message']").addClass('active');
	$("#leader").attr("style","background-color: green;");
});


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


function xxgl_onClick() {  //消息管理
	this.location.href="<%=request.getContextPath()%>/pubmessage/getallmessage.do";
}
function closeMod(){
	$('#xttzModal').hide();
}
function quizMessage_Onclick(){
	var title=$("#messagetitle").val();
	var content = $("#messagecontent").val();
	$.ajax({ 
	    type : "POST",  
	    url : "<%=request.getContextPath()%>/pubmessage/insertMessage.do?title="+title+"&content="+content,
        contentType : 'application/json',  
	    dataType: "json",
	    error:function(data){
	    },
	    success : function(data){
	    	if(data.state="true"){
	    		alert("发布成功!");
	    		location.href="<%=request.getContextPath()%>/pubmessage/getallmessage1.do";
	    	}else{
	    		alert(data.error);
	    	}
	    	
	    }
	});
}
</script>
<style type="text/css">

#style1:hover {color:blue;text-decoration:underline;cursor:pointer;}

</style>
</head>
  <body>
    <div class="container-fluid">
      <div class="row m-content message">
        <div class="col-md-12">
              <div class="m-column" style="margin-bottom: 0;">
                <div class="header tabheader">
                  <div class="title  act" onclick="javascript:void(0)">消息管理</div>
                <button class="btn btn-primary" data-toggle="modal" data-target="#pubModal" data-backdrop="static" data-keyboard="false">发公告</button>
                </div>
                <div id="list" class="body clearfix">
                <form name="form" method="post" id="form">
                  <div class="cont" style="height:530px;">
                    <table class="table table-bordered table-hover table-striped">
                      <thead>
                        <tr>
                        	<th>主题</th>
                        	<th style="width:200px;">发送人</th>
                        	<th style="width:300px;">发送日期</th>
                        </tr>
                      </thead>
                      <tbody>
                      <%
									List<Pubmessage> lResult = null; //定义结果列表的List变量
									if (request.getAttribute("beans") != null) { //如果request中的beans不为空
									lResult = (List) request.getAttribute("beans"); //赋值给resultList
									for (int i = 0; i < lResult.size(); i++) {
										Pubmessage vo = lResult.get(i);
								%>
									<tr>
									<td class="theme" style="text-align: left;"><a href = 'javascript:void(0)' onclick = 'javascript:openPubMessageinfo("<%=vo.getPk_messageinfo()%>");'><center><font id='style1'><%=vo.getTitle()%></font></center></td>
									<td style=" width: 10%;"><%=vo.getPsnname()%></td>
									<td style=" width: 20%;"><%=vo.getSenddate().substring(2, 10)%></td>
									</tr>
									<%}} %>
                      </tbody>
                    </table>
                  </div>
                </form>
                </div>
                
                
                <!-- 弹窗 -->
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
								style="padding-left: 2%; word-wrap: break-word; white-space: pre-wrap; text-align: center; font-family: 'Microsoft YaHei'; font-size: 18px"></pre>
							<pre name='gonggao'
								style="padding-left: 2%; word-wrap: break-word; white-space: pre-wrap; text-align: left; font-family: 'Microsoft YaHei'; font-size: 15px"></pre>
							<pre name='gonggaow'
								style="padding-left: 2%; word-wrap: break-word; white-space: pre-wrap; text-align: right; font-family: 'Microsoft YaHei'; font-size: 15px"></pre>
						</div>
					</div>
				</div>
			</div>
		</div>
                  
              </div>
        </div>
      </div>
    

		    </div>
<!-- 发公告Modal -->
                    <div class="modal modal-1" id="pubModal" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
                      <div class="modal-dialog">
                        <div class="modal-content">
                          <div class="modal-header">
                            <button type="button" onclick="$('#pubModal .clearfix').find(':input').val('');" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title">公告</h4>
                          </div>
                          <div class="modal-body clearfix">
                            <div class="m-form-group"><span>主题</span><input style="width:530px;" type="text" class="form-control" maxlength="30" name="messagetitle" id="messagetitle">
                            <br> <font style="float:right;">公告主题允许填写最大字符数为30个字符！</font> 
                            </div>
                            <div class="m-form-group"><span>内容</span><textarea style="width:564px;" maxlength="300"  class="form-control" rows="5" placeholder="请尽量详细描述您的公告内容(三百字以内)" name="messagecontent" id="messagecontent"></textarea></div>
                            <div class="text-center"><a class="btn btn-primary"  onclick="quizMessage_Onclick()">发布</a></div>
                          </div>
                        </div>
                      </div>
                    </div>

  
    <script>
    	$('#list').on('click','tbody tr',function(){
    		$('#messageModal').modal('toggle');
    	})
    	document.getElementById("bs-example-navbar-collapse-2").style.display="block";
    </script>
  </body>
</html>