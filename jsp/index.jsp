<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>财务报账管理</title>
<script src="../js/jquery.js" type="text/javascript"></script>
	<link href="../css/bootstrap.min.css" rel="stylesheet" >
</head>
<body>
<br><br><br><br><br><br><br>
	<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
		<div class="row clearfix">
			<div class="col-md-12 column">
					<img alt="" width="100%" height="100" src="${pageContext.request.contextPath }/img/1.jpg"  />
				</div>
		</div>
		<br><br>
			<div class="row clearfix">
				<div class="col-md-9 column">
					<img alt="" width="840" height="440" src="${pageContext.request.contextPath }/img/loginm.png"  />
				</div>
				<div class="col-md-3 column" >
					<br><br><br><br><br>
					<center>
						<div class="form-group">
							 <center><label >用户名:</label><input type="text" class="form-control" id="exampleInputEmail1" /></center>
						</div>
						<div class="form-group">
							 <center><label >密码:</label><input type="password" class="form-control" id="exampleInputPassword1" /></center>
						</div>
						<center><button type="submit" onclick="login()" class="btn btn-default">登录</button></center>
						<br><br>
						<!-- <center><button type="button" onclick="regist()" class="btn btn-default">注册</button></center> -->
					</center>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
<script type="text/javascript">
	
	function login(){
		var usercode = $("#exampleInputEmail1").val();
		var password = $("#exampleInputPassword1").val();
		$.ajax({
			type:"POST",
			dataType:"json",
			data:{
				"usercode":usercode,
				"password":password
			},
			url:"<%=request.getContextPath()%>/user/login.do",
			success:function(r){
				if(r.state=="true"){
					if(r.user.default_role=="C"){
						window.location.href="<%=request.getContextPath()%>/jsp/baozhangren.jsp";
					}else if(r.user.default_role=="A"){
						window.location.href="<%=request.getContextPath()%>/workflow/toApprovePage.do";
					}
					
				}else{
					alert(r.error);
				}
				
			}
		});
	}
	function regist(){
		window.location.href="http://localhost:8080/baozhang/jsp/regist.jsp";
	}
</script>