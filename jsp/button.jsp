<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<script type="text/javascript">
$(document).ready(function(){
	$("#update_save").hide();
})
	function pub_onMouseOver(){//追踪
	var billid = $("#pk_loanbill").val();
		 $("#spyjtr tr").remove();
			$.ajax({
				type : "POST",
				url : "<%=request.getContextPath()%>/workflow/approvresult.do?billid="+billid,
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
</script>
	<body>
		  <a class="btn btn-mini btn-success" href="javascript:void(0);" id="update_save" onclick="update_save()" >保存</a>
		      <a class="btn btn-mini btn-success" href="javascript:void(0);" id="back_commit" onclick="commit_onClick()" >提交</a>
     <%  if(request.getAttribute("action")==null||request.getAttribute("action").equals("")){%>
									<a class="btn btn-mini btn-success" href="javascript:void(0);" id="save" onclick="save_onclick()" >保存</a>
									<a class="btn btn-mini  btn-gray" href="<%=request.getContextPath()%>/jsp/baozhangren.jsp" id="cancel">取消</a>
								<%}else if(request.getAttribute("action").equals("leadView")){ %> 
								<a class="btn btn-mini  btn-success" onclick="pub_onMouseOver()" style="width:110px;" >联查审批情况</a>
									<a class="btn btn-mini btn-success" href="javascript:void(0);" id="pass" onclick="pass_onclick()" >通过</a>
									<a class="btn btn-mini btn-success" href="javascript:void(0);" id="stop" onclick="stop_onclick()" >不批准</a>
									<a class="btn btn-mini  btn-gray" href="<%=request.getContextPath()%>/workflow/toApprovePage.do" id="cancel">取消</a>
								<%} else if(request.getAttribute("action").equals("savedView1")){ %> 
									<a class="btn btn-mini btn-success" href="javascript:void(0);" id="commit" onclick="commit_onClick()" >提交</a>
								    <a class="btn btn-mini btn-success" href="javascript:void(0);" id="update" onclick="update_onClick()" >修改</a>
								    <a class="btn btn-mini btn-success" href="javascript:void(0);" id="delete" onclick="delete_onclick()" >删除</a>
								    <a class="btn btn-mini  btn-gray" href="<%=request.getContextPath()%>/loanbill/toSavedBillPage.do" id="cancel">取消</a>
								<%} else if(request.getAttribute("action").equals("savedView2")){%>
								    <a class="btn btn-mini  btn-success" onclick="pub_onMouseOver()"  style="width:110px;">联查审批情况</a>
									<a class="btn btn-mini  btn-gray" href="<%=request.getContextPath()%>/loanbill/toSavedBillPage.do" id="cancel">取消</a>
								<%} else if(request.getAttribute("action").equals("backBillView")){%>
								    <a class="btn btn-mini  btn-success" onclick="pub_onMouseOver()" style="width:110px;" >联查审批情况</a>
									<a class="btn btn-mini btn-success" href="javascript:void(0);" id="update" onclick="update_onClick()" >修改</a>
								    <a class="btn btn-mini btn-success" href="javascript:void(0);" id="delete" onclick="delete_onclick()" >删除</a>
								    <a class="btn btn-mini  btn-gray" href="<%=request.getContextPath()%>/workflow/getBtdList.do" id="cancel">取消</a>
								<%} else if(request.getAttribute("action").equals("savedView3")){%>
								    <a class="btn btn-mini  btn-success" onclick="pub_onMouseOver()"  style="width:110px;">联查审批情况</a>
									<a class="btn btn-mini btn-success" href="javascript:void(0);" id="update" onclick="update_onClick()" >修改</a>
								    <a class="btn btn-mini btn-success" href="javascript:void(0);" id="delete" onclick="delete_onclick()" >删除</a>
								    <a class="btn btn-mini  btn-gray" href="<%=request.getContextPath()%>/workflow/getBtdList.do" id="cancel">取消</a>
								<%} else if(request.getAttribute("action").equals("detail")){ %>
										<a class="btn btn-mini btn-success" href="javascript:void(0);" id="commit" onclick="commit_onClick()" >提交</a>
								    <a class="btn btn-mini btn-success" href="javascript:void(0);" id="update" onclick="update_onClick()" >修改</a>
								    <a class="btn btn-mini  btn-gray" href="<%=request.getContextPath()%>/loanbill/toSavedBillPage.do" id="cancel">取消</a>
								<%} %>
	</body>
</html>
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
