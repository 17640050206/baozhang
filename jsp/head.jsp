
<%@page import="com.sun.org.apache.xalan.internal.xsltc.compiler.sym"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.erp.bean.User" %>
<%@page import="java.net.InetAddress"%>
<%
       if(session.getAttribute("loginUser")==null){
         response.sendRedirect(request.getContextPath()+"/jsp/index.jsp");
         return;
      }%>
<!-- 获取系统日期，导航部分显示时间 -->
<link href="<%=request.getContextPath()%>/vendor/bootstrap-3.3.0/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/vendor/bootstrap-3.3.0/css/index.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/vendor/jquery/jquery-1.11.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.form.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/vendor/bootstrap-3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/js/date.js"></script>


 <%
  Date date = new Date();
  Calendar cal=Calendar.getInstance();
  String dayOfWeekTime="";
  String ip = InetAddress.getLocalHost().getHostAddress();
  int dayOfWeek=cal.get(Calendar.DAY_OF_WEEK);
  switch(dayOfWeek){
   case 1:dayOfWeekTime="星期天";break;
   case 2:dayOfWeekTime="星期一";break;
   case 3:dayOfWeekTime="星期二";break;
   case 4:dayOfWeekTime="星期三";break;
   case 5:dayOfWeekTime="星期四";break;
   case 6:dayOfWeekTime="星期五";break;
   case 7:dayOfWeekTime="星期六";break;
  }
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  String timeString = sdf.format(date);
  String default_role=session.getAttribute("default_role")+"";
  System.out.print(default_role);
 %>
<script type='text/javascript'>

function hideDhDiv(){
	document.getElementById("bs-example-navbar-collapse-1").style.display="none";
	document.getElementById("bs-example-navbar-collapse-2").style.display="none";
}

function hideDiv(){
	$("#index_C").hide();
	$("#index_A").hide();
}



function role_Change(obj){
	hideDiv();
	hideDhDiv();
	var role = $(obj).attr('selectid'); 
	if("C"==role){
		$("#index_C").show();
		document.getElementById("bs-example-navbar-collapse-1").style.display="block";
	}
	if("A"==role){
		document.getElementById("bs-example-navbar-collapse-2").style.display="block";
		//leaderCensor_onClick();
	}

	changeRole(role);
}
	
	//退出系统
	function logout_onClick() {
		if(window.confirm("您确定要退出系统吗?")) {
			parent.location.href = "<%=request.getContextPath()%>/user/rmLoginAction.do";
		}
	}
	function toSavedBills_onClick() {  //转到已申请单据页面
		 window.location="<%=request.getContextPath()%>/loanbill/toSavedBillPage.do";
	}

	 //修改密码
	function passwordupdate(){
		
		var old_password=$("input[name='old_password']").val();
		var new_password=$("input[name='new_password']").val();
		var confirm_password=$("input[name='confirm_password']").val();
		var flag=true;
		if(old_password == null||""==old_password ) {
	        alert("原密码不能为空");
	        flag=false;
	    }	
		if((new_password == null||""==new_password)&&flag==true ) {
	        alert("新密码不能为空");
	        flag=false;
	    }
		if((confirm_password == null||""==confirm_password)&&flag==true ) {
	        alert("确认密码不能为空");
	        flag=false;
	    }	
		/* if((new_password.length<6)&&flag==true){
			alert("密码长度必须大于6位！");
			flag=false;
			} */
		if((new_password.length>20)&&flag==true){
			alert("密码长度必须不能大于20位！");
			flag=false;
			}
		if((confirm_password !=new_password )&&flag==true) {
	        alert("新密码与确认密码不一致");
	        flag=false;
	    }	
		if(flag==true){
			$.ajax({
				type : 'post',
				url : '<%=request.getContextPath()%>/user/updatepassword.do',
				data : {
					"old_password":old_password,
					"confirm_password":confirm_password,
					"new_password":new_password
				},
				datatype : 'json',
				success : function(data) {
					if(data.state=="true"){
						alert(data.msg);
						parent.location.href = "<%=request.getContextPath()%>/jsp/index.jsp";
					}else{
						alert(data.error)
					}
				}
			});
		}
		
	} 
	
	//取消修改密码
	function passwordModifyHide(){
		$("input[name='old_password']").val('');
		$("input[name='new_password']").val('');
		$("input[name='confirm_password']").val('');
	}
	
    function moreNotice_onClick() {  //消息管理分页一
    	this.location.href="<%=request.getContextPath()%>/pubmessage/getallmessage.do";
    }
    function moreNotice_onClick_2() {  //消息管理分页二
    	this.location.href="<%=request.getContextPath()%>/workflow/getBtdList.do";
    }
    function questionCore_onClick(){  //帮助中心
    	this.location.href="<%=request.getContextPath()%>/pubmessageh";
    }

    $(function(){
    	if("<%=request.getAttribute("flogin")%>"=="Y"){
  	  	 	  $.ajax({
  	 		   type:"GET",
  	 		   url :"<%=request.getContextPath()%>/smoperatelog/operatelogin",

  	 		    error:function(data){
  	 		    },
  	 		    success:function(data){
  	 		    	
  	 		    }
  	  	 	  });
    	}
    	var divselect = function(a,b){
            var ishide= true;
            $(a).find('cite').text($(a).find('li:first').text());
            $(".m-logo a").each(function(){
            	if($(this).attr("gname")==$(a).find('li:first').text()){
                    $(this).addClass("act");
                	$(this).siblings("a").removeClass("act");
            	}
            })
            $(b).focus().val($(a).find('a').attr('selectid')).blur();
            $(a).on('click',function(e){
              e.stopPropagation();
              if(ishide==true){
                $(this).css({
                  'box-shadow':'inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6)',
                  'border-color':'#66afe9'
                });
                $(this).find('ul').stop().show();
                ishide=false;
              }else{
                $(this).css({
                  'box-shadow':'none',
                  'border-color':'#ccc'
                });
                $(this).find('ul').stop().hide();
                ishide=true;
              }
            });
            $(document).on('click',function(){
              $(a).find('ul').stop().hide();
              $(a).css({
                  'box-shadow':'none',
                  'border-color':'#ccc'
                });
              ishide=true;
            });
            $(a).find('li').on('click',function(){
              $(a).find('cite').text($(this).text());
              $(b).val($(this).find('a').attr('selectid'));
            });
          }
          divselect('.divselect2','.inputselect2');
          
    });
    function psnmessage(){
     	  	$('#setting_content .clearfix').find('input[type="text"]').attr("readOnly",true);
    	getGrantList();
    	getBilltypeList();
    	$('#billtype1').attr('disabled', true);
    	$('#grantdept1').attr('disabled', true);
    	$('#grantpsn1').attr('disabled', true);
    	 $("#saveButton").hide();
   	  $("#cancelButton").hide();
    	
    }
    function getBilltypeList(){
    	$.ajax({
    		type:"POST",
    		 url : "<%=request.getContextPath()%>/grant/getBilltypeList.do",
             contentType : 'application/json',
     	    dataType: "json",
     	    success : function(data){
     	    	if(data.state=="true"){
     	    		var context="";
     	    		context=context+"<option value=''>--请选择--</option>";
     	    		for(var i=0;i<data.typelist.length;i++){
     	    			context=context+"<option value="+data.typelist[i].billtypecode+">"+data.typelist[i].billtypename+"</option>";
     	    		}
     	    		$("#billtype1").html(context);
     	    	}else{
     	    		
     	    	}
     	    	}
    	});
    }
    function getGrantList(){
    	$.ajax({
    		type:"POST",
    		 url : "<%=request.getContextPath()%>/grant/getGrantList.do",
             contentType : 'application/json',
     	    dataType: "json",
     	    success : function(data){
     	    	if(data.state=="true"){
     	    		$("#grantlist").children('tr').remove();
          	    	for(var i =0;i < data.grantlist.length;i++){
         	    	$("#grantlist").append("<tr><td><center><input type='checkbox' class='checkA'; name='check' value="+data.grantlist[i].pk_grant+"></center></td><td><center>"+data.grantlist[i].datefrom+"</center></td><td><center>"+data.grantlist[i].dateto+"</center></td><td><center><font title="+data.grantlist[i].billtypename+" style='display:block;width: 240px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;'>"+data.grantlist[i].billtypename+"</font></center></td><td><center>"+data.grantlist[i].psnname+"</center></td><td><center>"+data.grantlist[i].psndeptname+"</center></td><td><center>"+data.grantlist[i].grantpsnname+"</center></td><td><center>"+data.grantlist[i].grantdeptname+"</center></td></tr>");
         	        }
     	    	}else{
     	    		$("#grantlist").html("<tr><td colspan='8' width='100%'><center>"+data.error+"</center></td></tr>");
     	    	}
     	    	}
    	});
    }
    
    function deleteGrant(){
    	var id="";
        $("input[name='check']:checked").each(function() { // 遍历选中的checkbox
             id=id+$(this).val();
        });
        if(id==""){
        	alert("请选择授权数据！");
        	return;
        }
    	
    			var ids="";
    	        $("input[name='check']:checked").each(function() { // 遍历选中的checkbox
    	            n = $(this).parents("tr").index();  // 获取checkbox所在行的顺序
    	            if(ids==""){
    	            	ids=ids+$(this).val();
    	            }else{
    	            	ids=ids+","+$(this).val();
    	            }
    	            $("#grantlist").find("tr:eq("+n+")").remove();
    	        });
    	        if(ids==""){
    	        	alert("请勾选一条授权数据！");
    	        	return;
    	        }
    	        $.ajax({
    	    		type:"POST",
    	    		 url : "<%=request.getContextPath()%>/grant/deleteGrant.do",
    	     	    dataType: "json",
    	     	    data:{
    	     	    	"pk_grant":ids
    	     	    },
    	     	    success : function(data){
    	     	    	alert("删除成功");
    	     	    	getGrantList();
    	     	    }
    	    	});
    	        
    }
    function allcheck(){
    	var isChecked = $("#allcheck").is(":checked");
        if(isChecked==true){
        	$("input[class='checkA']").each(function() {  
        		  this.checked = true;  
            });  
        }
        if(isChecked==false){
        	$("input[class='checkA']").each(function() {  
                this.checked = false;  
            });  
        }
    }
   
	function showDhDiv(){
		<%
	String default_door =  session.getAttribute("default_role")+"";
		if(null!=default_door || !"".equals(default_door)){%>
		<%if(default_door.indexOf("A")>=0){%>
				document.getElementById("bs-example-navbar-collapse-2").style.display="block";
			<%}%>
		<% if(default_door.indexOf("C")>=0){%>
		System.out.print("C");
			document.getElementById("bs-example-navbar-collapse-1").style.display="block";
		<%}}%>
	}
    function saveGrant(){
    	var billtype=$("#billtype1").val();
    	var startdate=$("#start_time").val();
    	var enddate=$("#end_time").val();
    	var grantedman=$("#grantpsn1").val();
    	var granddept=$("#grantdept1").val();
   
    	if(billtype==""){
    		alert("单据类型不能为空");
    		return;
    	}
     	if(checkInputDate(startdate,enddate)==false){
     		return false;
     	}
    	if(grantedman==""){
    		alert("被授权人不能为空");
    		return;
    	}
  /*   	zhezhao(); */
    	$.ajax({
    		type:"POST",
    		 url : "<%=request.getContextPath()%>/grant/insertGrant.do",
     	    dataType: "json",
     	    data:{
     	    	"billtype":billtype,
     	    	"startdate":startdate,
     	    	"enddate":enddate,
     	    	"grantedman":grantedman,
     	    	"granddept":granddept
     	    },
     	    success : function(data){
     	    /* 	zhezhaofinish(); */
     	    if(data.state=="false"){
     	    	alert(data.error);
     	    	cancel();
     	    }else{
     	    	 getGrantList();
     	    	getBilltypeList();
     	     	alert(data.message);
     	     	$("#insertButton").show();
     		  	 $("#saveButton").hide();
     		  	 $("#cancelButton").hide();
     		  	$("#start_time").val("");
     		  	$("#end_time").val("");
     		  	$("#start_time").attr("disabled",true);
     	    	$("#end_time").attr("disabled",true);
     	    	$('#billtype1').attr('disabled', true);
     	    	$('#grantdept1').attr('disabled', true);
     	    	$('#grantpsn1').attr('disabled', true);
     		  	 
     	    }
     	    /* $('#setting_content').modal(); */
     	    }
    	});
    }
    
    function todagl_onClick() {  //消息管理
  	   this.location.href="<%=request.getContextPath()%>/common/todaglPage";
  	}
    function listAnalysis_onClick(){
    	this.location.href="<%=request.getContextPath()%>/common/listAnalysis";
    }
    //发送请求,改变门户角色session
    function changeRole(role){
    	    	if(role=='A'){
    	    		 window.location.href="<%=request.getContextPath()%>/workflow/toApprovePage.do";
    	    	}if(role=='C'){
    	    		window.location.href="<%=request.getContextPath()%>/jsp/baozhangren.jsp";
    	    	}
    }
    function changeDefRole(id){
    	$.ajax({
    	    type : "POST",  
    	    url : "<%=request.getContextPath()%>/user/changeDefRole.do?role="+id,
            contentType : 'application/json',
    	    dataType: "json",
    	    success : function(data){
    	    	alert(data.msg);
    	    }
    	});
    }
    function act_onclick(role){
    
    	$("#"+role).prop("checked",true);
    }
    function changeR(id){
    	var check = $("#"+id).is(":checked");
    	if(check==true){
    		changeRole(id);
    		changeDefRole(id);
    		act_onclick(id);
    	}
    }
  //人员参照选择
    function psn_onclick1(){
    	getReference(new Array($("#bsq_pk_psns"), $("#bsq_disp_psns"),$("#bsq_pk_dept"),$("#bsq_deptname")), '<%=request.getContextPath()%>/', '<%=request.getContextPath()%>/customc/referenceApprove1.do', '1000','750');
  }
  //单据类型参照
    function billType_onclick1(){
	  var sqlx = $('#bsq_pk_billtypes').val().trim();
    	getReference(new Array($("#bsq_pk_billtypes"), $("#bsq_billtypes")), '<%=request.getContextPath()%>/', '<%=request.getContextPath()%>/bdbilltype/referenceApprove1?sqlx='+sqlx, '800','750');
    }
  function check_act(){
	  <%
	   String user_defrole =  session.getAttribute("default_role")+"";
	   if("C".equals(user_defrole)){%>
	   		$("#C").attr("checked","true");
	   <%}%>
	   <%if("A".equals(user_defrole)){%>
		$("#A").attr("checked","true");
	   <%}%>
	   <%if("F".equals(user_defrole)){%>
		$("#F").attr("checked","true");
	   <%}%>
  }
  function cancel(){
   	$("#start_time").val("");
   	$("#end_time").val("");
	  $('#setting_content .clearfix').find('input[type="text"]').attr("readOnly",true);
	  $("#saveButton").css({ "display": "none" });
	  $("#insertButton").show();
	  $("#cancelButton").hide();
	  $('#billtype1').attr('disabled', true);
	   	$('#grantdept1').attr('disabled', true);
	   	$('#grantpsn1').attr('disabled', true);
	  
  }
  function insertGrant(){

	   	$("#start_time").attr('disabled', false);
	   	$("#end_time").attr('disabled', false);
	   	$("#start_time").attr('readonly', false);
	   	$("#end_time").attr('readonly', false);
	    $("#saveButton").show();
		  $("#cancelButton").show();
		  $("#insertButton").hide();
		  $('#billtype1').attr('disabled', false);
	   	$('#grantdept1').attr('disabled', false);
	   	$('#grantpsn1').attr('disabled', false);
	  $("#saveButton").show();
	  $("#cancelButton").show();
	  $("#insertButton").hide();
	  $("#updateButton").hide();
	  
	  
  }
  function exitCont(){
	  $('#setting_content .clearfix').find('input[type="text"]').val("");
	  $("#insertButton").show();
  }
  function checkInputDate(inputStartMonth,inputEndMonth){ 
	//1. 两个文本框都不能为空
	if( inputStartMonth ==null  || inputStartMonth==""){ 
		alert("开始日期不能为空"); 
		return false; 
	} 
	if( inputEndMonth ==null  || inputEndMonth==""){ 
		alert("结束日期不能为空"); 
		return false; 
	} 

	//2. 开始时间不能大于结束时间
	var arrStart = inputStartMonth.split("-"); 
	var tmpIntStartYear = parseInt(arrStart[0],10); 
	var tmpIntStartMonth = parseInt(arrStart[1],10);
	var tmpIntStartDay = parseInt(arrStart[2],10);

	var arrEnd = inputEndMonth.split("-"); 
	var tmpIntEndYear = parseInt(arrEnd[0],10); 
	var tmpIntEndMonth = parseInt(arrEnd[1],10); 
	var tmpIntEndDay = parseInt(arrEnd[2],10);
	
	if( tmpIntStartYear < tmpIntEndYear ){ 
	}else if(tmpIntStartYear == tmpIntStartYear ){ 
		if( tmpIntStartMonth < tmpIntEndMonth ){ 
		} else if(tmpIntStartMonth == tmpIntEndMonth){
			if(tmpIntStartDay < tmpIntEndDay){
			}else if(tmpIntStartDay == tmpIntEndDay){
			}else{
				alert("开始日期不能晚于结束日期"); 
				return false; 
			}
		}else{ 
			alert("开始日期不能晚于结束日期"); 
			return false; 
		} 
	
	}else{ 
		alert("开始日期不能晚于结束日期"); 
		return false; 
	} 
	}
  function getPeople(){
	  var deptid=$("#grantdept1").val();
	    	$.ajax({
	    		type:"POST",
	    		 url : "<%=request.getContextPath()%>/user/getPeopleList.do?deptid="+deptid,
	             contentType : 'application/json',
	     	    dataType: "json",
	     	    success : function(data){
	     	    	if(data.state=="true"){
	     	    		var context="";
	     	    		for(var i=0;i<data.peoplelist.length;i++){
	     	    			context=context+"<option value="+data.peoplelist[i].userid+">"+data.peoplelist[i].user_name+"</option>";
	     	    		}
	     	    		$("#grantpsn1").html(context);
	     	    	}else{
	     	    		
	     	    	}
	     	    	}
	    	});
  }
  function xxgl_onClick1() {  //消息管理
		this.location.href="<%=request.getContextPath()%>/pubmessage/getallmessage1.do";
	}
</script>
      <div class="row m-top">
        <div class="pull-right">
<%--           <i class="icon icon-date"></i> --%>
          今天是<span class="todaydate">
				<%=timeString%> <%=dayOfWeekTime %>
				<input type="hidden" name="toDay" value="<%=timeString%>"/>
          </span>
          <span onclick="passwordModifyShow()" title="修改密码" class="icon icon-password" data-toggle="modal" data-target="#pwModal"></span>
           <span class="icon icon-setting" title="设置中心" data-toggle="modal" data-target="#setModal"></span> 
          <span onclick="logout_onClick()" title="退出登录" class="icon icon-off"></span>
        </div>
        <%
        String username = "";
        	if(session.getAttribute("loginUser")!=null){
        		User user = (User)session.getAttribute("loginUser");
        		 username = user.getUser_name();
        	}
        %>
        <p class="hidden-xs">欢迎您的登录：<span><%=username %></span></p>
      </div>
      <!-- 报账Modal -->
	    <div class="modal" id="pwModal" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
	      <div class="modal-dialog" style="width: 358px;">
	        <div id="passwordModify" class="modal-content">
	          <div class="modal-header">
	            <button onclick = "javascript:passwordModifyHide()" type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	            <h4 class="modal-title">修改密码</h4>
	          </div>
	          <div class="modal-body clearfix">
	            <p><label>原密码：</label><input class="form-control" type="password"  name="old_password"></p>
	            <p><label>新密码：</label><input class="form-control" type="password" name="new_password"></p>
	            <p><label>密码确认：</label><input class="form-control" type="password" name="confirm_password"></p>
	            <div class="text-center">
	            	<a class="btn btn-primary"  onclick="javascript:passwordupdate()">保存</a>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	    
	     
	    <div class="modal" id="setModal" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
	      <div class="modal-dialog" style="width: 358px;">
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	            <h4 class="modal-title">设置中心</h4>
	          </div>
	          <div class="modal-body clearfix">
	            <ul class="setting_sel" style="padding:0">
					<li>
						<a class="modal_btn" data-toggle="modal" href="#set-1" data-dismiss="modal" onclick="check_act()">主门户设置</a>
					</li>
									 <%
        	String leaderR =  session.getAttribute("user_role")+"";
     		if(leaderR.indexOf("A")>=0){%>
					<li>
						<a class="modal_btn" data-toggle="modal" href="#set-2" data-dismiss="modal" onclick="psnmessage()">委托授权设置</a>
					</li>
					<%} %>
				</ul>
	          </div>
	        </div>
	      </div>
	    </div>
	  
	    <!-- 设置具体内容Modal -->
	    <div id="setting_content">
		    <div class="modal m-modal"  id="set-1">
				<div class="modal-dialog" style="width: 260px!important;margin: 5% auto;">
					<div class="modal-content">
						<div class="modal-header">
							<span class=" close" data-dismiss="modal">&times;</span>
							<h3 class="modal-title">主门户设置</h3>
						</div>
						<div class="modal-body">
							
							 <%
        	String role3 =  session.getAttribute("user_role")+"";
         
         
     		if(role3.indexOf("C")>=0){%>
        		<div class="m-form-group" id="mainseti-1">
        		                <div class="switch_div">
									<div class="row">
										<div class="col-md-8"><span>报账人工作台</span></div>
										<div class="col-md-4"><label><input class="mui-switch mui-switch-animbg" name="homeset" id="C" type="checkbox" onclick="changeR('C')" ></label></div>
									</div>
								</div>
				</div>
          	<%} %>
          	<% if(role3.indexOf("A")>=0){%>
          	<div class="m-form-group" style="hidden" id="mainseti-2">
								<div class="switch_div">
									<div class="row">
										<div class="col-md-8"><span>领导审批工作台</span></div>
										<div class="col-md-4"><label><input class="mui-switch mui-switch-animbg" name="homeset" id="A" type="checkbox" onclick="changeR('A')"></label></div>
									</div>
								</div>
							</div>
         		<% }%>
						</div>
					</div>
				</div>
			</div>
			<div class="modal m-modal laydate_body"  id="set-2">
				<div class="modal-dialog" style="width: 80%!important;margin: 5% auto;">
					<div class="modal-content">
						<div class="modal-header">
							<span class="close" onclick="exitCont()" data-dismiss="modal" >&times;</span>
							<h3 class="modal-title">委托授权设置</h3>
						</div>
						<div class="modal-body body1">
							<div class="m-formbox">
			                     <div class="cont clearfix" style="padding: 10px 20px 10px 0px;margin-left: -20px;">
			                        <div class="col-md-4 col-sm-6 col-xs-12">
			                          <label class="label"><span class="red">*</span>单据类型:</label>
			                          <div class="inputbox">
			                            <select id="billtype1"  disabled="disabled">
			                          		
			                          	</select>
			                          </div>
			                        </div>
			                        <div class="col-md-4 col-sm-6 col-xs-12">
			                          	<label class="label"><span class="red">*</span>开始时间:</label>
			                          	<div class="inputbox">
										    <input type="text" id="start_time" class="input_bor text_date_half" onclick="SelectDate(this,'yyyy\-MM\-dd')"  style="width:100%;">
										</div>
			                        </div>
			                        <div class="col-md-4 col-sm-6 col-xs-12">
			                          	<label class="label"><span class="red">*</span>结束时间:</label>
			                          	<div class="inputbox">
										    <input type="text" id="end_time" class=" input_bor text_date_half" onclick="SelectDate(this,'yyyy\-MM\-dd')" style="width:100%;">
										</div>
			                        </div>
			                         <div class="col-md-4 col-sm-6 col-xs-12">
			                          <label class="label"><span class="red">*</span>被授权人部门:</label>
			                          <div class="inputbox">
			                          	<select id="grantdept1" disabled="disabled" onchange="getPeople();">
			                          	    <option value="">--请选择--</option>
			                          		<option value="1">财务部</option>
			                          		<option value="2">信息技术部</option>
			                          		<option value="3">公关部</option>
			                          		<option value="4">业务部</option>
			                          	</select>
			                          </div>
			                        </div>
			                        <div class="col-md-4 col-sm-6 col-xs-12">
			                          <label class="label"><span class="red">*</span>被授权人:</label>
			                          <div class="inputbox">
			                            <select id="grantpsn1" value="" disabled="disabled">
			                          		<option value="">-请先选择被授权人部门-</option>
			                          	</select>
			                          </div>
			                        </div>
			                        
			                       
			                       <div class="text-right">
									<button  class="btn btn-primary" id="saveButton"  onclick="saveGrant()" >保存</button>
					            	<button id="cancelButton" class="btn btn-primary"  onclick="cancel();" >取消</button>
					            </div>
		                     </div>
		                   </div>
						</div>
						<div class="modal-body" class="body1">
							<div class="m-formbox m-formbox-nofloat">
			                     <div class="title" style="height:35px;">授权明细
			                       <div class="pull-right">
			                       <a  class="btn btn-primary"  href="javascript:void(0);" id="insertButton" onclick="insertGrant()">新增</a>
			                         <a class="btn btn-primary" href="javascript:void(0);" id="deleteButton" onclick="deleteGrant()">删除</a>
			                       </div>
			                     </div>
			                     <div class="cont clearfix">
			                       <div class="table-responsive">
			                         <table class="table table-bordered table-hover table-striped" namespace=""  name=  id="rowTable-CM_DEDUCTION111" >
			                           <thead>
			                             <tr>
			                               <th><input type="checkbox" id="allcheck" onclick="allcheck()"></th>
									       <th>开始日期</th>
									       <th>结束日期</th>
									       <th>单据类型</th>
									       <th>授权人</th>
									       <th>授权人部门</th>
									       <th>被授权人</th>
									       <th>被授权人部门</th>
			                             </tr>
			                           </thead>
			                           <tbody id="grantlist">
			                           </tbody>
			                         </table>
			                       </div>
			                     </div>
	                 		</div>
						</div>
					</div>
				</div>
			</div>
	    </div> 
      <div class="row m-logo">
        
        <div class="pull-right">
         <%
        	String role1 =  session.getAttribute("user_role")+"";
         System.out.print(role1);
         
     		if(role1.indexOf("C")>=0){%>
        	<a  selectid="C" gname="报账人工作台" id="baozhangren" name="gzt" onclick="role_Change(this);" >报账人工作台</a>
          	<%} %>
          	<% if(role1.indexOf("A")>=0){%>
          	<a selectid="A" class=""  name="gzt" id="leader" gname="领导审批工作台" onclick="role_Change(this);">领导审批工作台</a>
          	<% }%>
    
        	</div>
        	<img src="<%=request.getContextPath()%>/img/sitetitle.png" alt="财务集中管理报账平台" style="width: auto;border: none;color: #017fcc;font-size: 16px;font-weight: 700;">
        	<!-- <span>财务集中管理报账平台</span> -->
        	<input name="hostadd" value="<%=ip%>" id="hostadd" type="hidden" > 
      </div>
           <div class="row m-nav">
        <nav class="navbar" role="navigation">
		    <div id="bs-example-navbar-collapse-1" style='display:none'>
              <ul class="nav navbar-nav">
                <li name="index"><a href="<%=request.getContextPath()%>/jsp/baozhangren.jsp">首页</a></li>
                <li name="listCmerSavedBills"><a href="javascript:toSavedBills_onClick()">我的单据</a></li>
				<li name="message"><a href="javascript:moreNotice_onClick()">消息管理</a></li>
              </ul>
            </div>
		
		
		    <div  id="bs-example-navbar-collapse-2" style='display:none'>
              <ul class="nav navbar-nav">
                <li name="leaderApprove"><a href="javascript:changeRole('A')">单据审批</a></li>
                <li name="message"><a href="javascript:xxgl_onClick1()">消息管理</a></li>
              </ul>
            </div>

        </nav>
      </div>
<!-- 不批准Modal -->
                    <div class="modal modal-1" id="askModal" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
                      <div class="modal-dialog">
                        <div class="modal-content">
                          <div class="modal-header">
                            <button type="button" onclick="$('#askModal .clearfix').find(':input').val('');" class="close" data-dismiss="modal"><span onclick="closeMod();" aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title">不批准原因</h4>
                          </div>
                          <div class="modal-body clearfix">
                            </div>
                            <div class="m-form-group" align="center"><textarea style="width:550px;"  class="form-control" rows="5"  name="checknote" id="checknote">不批准</textarea></div>
                            <div class="text-center"><a class="btn btn-primary"  onclick="approve()">确定</a></div>
                          </div>
                        </div>
                      </div>
                    </div>
     