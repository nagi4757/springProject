<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
		<title><spring:message code="title.number1"/> - Nagi's World</title>
		<%@ include file="../include/header.jsp" %>
		<script type="text/javascript">
		var reCheck = true;

		$(document).ready(function(){
			
			$("#userName").blur(function(){
				var name = document.getElementById("userName").value;
				var form_data = new FormData();
		    	form_data.append('name', name);
				if(name == ""){
					document.getElementById("re-nameErr").innerHTML = "<spring:message code="memberWrite.error1"/>";
				}else{
					$.ajax({
						type : "POST",
						url : "${path}/member/checkName.do",
						data : form_data,
						cache: false,
			            contentType: false,
			            processData: false,
						success : function(data) {
							if(data == "success"){
								document.getElementById("re-nameErr").innerHTML = "";
								reCheck = true;
							}else if(data == "failure"){
								document.getElementById("re-nameErr").innerHTML = "<spring:message code="memberWrite.error2"/>";
								reCheck = false;
							}
						}
					});
				}  
			});
			
			$("#userId").focus(function(){
				var name = document.getElementById("userName").value;
				if(name == ""){
					document.getElementById("re-nameErr").innerHTML = "<spring:message code="memberWrite.error1"/>";
				}
			});
			
			$("#userId").blur(function(){
				var id = document.getElementById("userId").value;
				var RegexId = /^[a-z][a-z0-9_-]{3,11}$/;  
				var form_data = new FormData();
		    	form_data.append('id', id);
				if(id == ""){
					document.getElementById("re-idErr").innerHTML = "<spring:message code="memberWrite.error1"/>";
				}else if(!RegexId.test($.trim($("#userId").val()))){
					document.getElementById("re-idErr").innerHTML = "<spring:message code="memberWrite.error3"/>";
					reCheck = false;
				}else{
					$.ajax({
						type : "POST",
						url : "${path}/member/checkId.do",
						data : form_data,
						cache: false,
			            contentType: false,
			            processData: false,
						success : function(data) {
							if(data == "success"){
								document.getElementById("re-idErr").innerHTML = "";
								reCheck = true;
							}else if(data == "failure"){
								document.getElementById("re-idErr").innerHTML = "<spring:message code="memberWrite.error4"/>";
								reCheck = false;
							}
						}
					});
				}
			});

			$("#userPw").focus(function(){
				var name = document.getElementById("userName").value;
				var id = document.getElementById("userId").value;
				if(name == ""){
					document.getElementById("re-nameErr").innerHTML = "<spring:message code="memberWrite.error1"/>";
				}
				if(id == ""){
					document.getElementById("re-idErr").innerHTML = "<spring:message code="memberWrite.error1"/>";
				}
			});

			$("#userPw").blur(function(){
				var pw = document.getElementById("userPw").value;
				var RegexPw = /^[A-Za-z0-9_-]{6,18}$/;
				if(pw == ""){
					document.getElementById("re-pwErr").innerHTML = "<spring:message code="memberWrite.error1"/>";
				}else if(!RegexPw.test($.trim($("#userPw").val()))){
					document.getElementById("re-pwErr").innerHTML = "<spring:message code="memberWrite.error5"/>";
					reCheck = false;
				}else{
					document.getElementById("re-pwErr").innerHTML = "";
					reCheck = true;
				}
			});

			$("#userPw2").focus(function(){
				var name = document.getElementById("userName").value;
				var id = document.getElementById("userId").value;
				var pw = document.getElementById("userPw").value;
				if(name == ""){
					document.getElementById("re-nameErr").innerHTML = "<spring:message code="memberWrite.error1"/>";
				}
				if(id == ""){
					document.getElementById("re-idErr").innerHTML = "<spring:message code="memberWrite.error1"/>";
				}
				if(pw == ""){
					document.getElementById("re-pwErr").innerHTML = "<spring:message code="memberWrite.error1"/>";
				}
			});

			$("#userPw2").blur(function(){
				var pw = document.getElementById("userPw").value;
				var pw2 = document.getElementById("userPw2").value;
				if(pw2 == ""){
					document.getElementById("re-pwErr-cof").innerHTML = "<spring:message code="memberWrite.error1"/>";
				}else if(pw2 != pw){
					document.getElementById("re-pwErr-cof").innerHTML = "<spring:message code="memberWrite.error6"/>";
					reCheck = false;
				}else {
					document.getElementById("re-pwErr-cof").innerHTML = "";
					reCheck = true;
				}
			});

			$("#userEmail").focus(function(){
				var name = document.getElementById("userName").value;
				var id = document.getElementById("userId").value;
				var pw = document.getElementById("userPw").value;
				var pw2 = document.getElementById("userPw2").value;
				if(name == ""){
					document.getElementById("re-nameErr").innerHTML = "<spring:message code="memberWrite.error1"/>";
				}
				if(id == ""){
					document.getElementById("re-idErr").innerHTML = "<spring:message code="memberWrite.error1"/>";
				}
				if(pw == ""){
					document.getElementById("re-pwErr").innerHTML = "<spring:message code="memberWrite.error1"/>";
				}
				if(pw2 == ""){
					document.getElementById("re-pwErr-cof").innerHTML = "<spring:message code="memberWrite.error1"/>";
				}
			});

			$("#userEmail").blur(function(){
				var mail = document.getElementById("userEmail").value;
				var RegexMail = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
				var form_data = new FormData();
		    	form_data.append('email', mail);
				if(mail == ""){
					document.getElementById("re-mailErr").innerHTML = "<spring:message code="memberWrite.error1"/>";
				}else if(!RegexMail.test($.trim($("#userEmail").val()))){
					document.getElementById("re-mailErr").innerHTML = "<spring:message code="memberWrite.error7"/>";
					reCheck = false;
				}else{
					$.ajax({
						type : "POST",
						url : "${path}/member/checkEmail.do",
						data : form_data,
						cache: false,
			            contentType: false,
			            processData: false,
						success : function(data) {
							if(data == "success"){
								document.getElementById("re-mailErr").innerHTML = "";
								reCheck = true;
							}else if(data == "failure"){
								document.getElementById("re-mailErr").innerHTML = "<spring:message code="memberWrite.error8"/>";
								reCheck = false;
							}
						}
					});
				}
			});
		});


		function regCheck(){
			var id = document.getElementById("userId").value;
			var pw = document.getElementById("userPw").value;
			var pw2 = document.getElementById("userPw2").value;
			var mail = document.getElementById("userEmail").value;
			var name = document.getElementById("userName").value;

			if(id == ""){
			  document.getElementById("re-idErr").innerHTML = "<spring:message code="memberWrite.error1"/>";
			  reCheck = false
			}
			if(pw == ""){
			  document.getElementById("re-pwErr").innerHTML = "<spring:message code="memberWrite.error1"/>";
			  reCheck = false
			}
			if(pw2 == ""){
			  document.getElementById("re-pwErr-cof").innerHTML = "<spring:message code="memberWrite.error1"/>";
			  reCheck = false
			}
			if(mail == ""){
			  document.getElementById("re-mailErr").innerHTML = "<spring:message code="memberWrite.error1"/>";
			  reCheck = false
			}
			if(name == ""){
			  document.getElementById("re-nameErr").innerHTML = "<spring:message code="memberWrite.error1"/>";
			  reCheck = false
			}
			
			return reCheck;
			
		}
		
		</script>
	</head>
	<body>
		<%@ include file="../include/menu.jsp" %>
		<div class="container">
			<form name="form1" method="post" action="${path}/member/insert.do" onsubmit="return regCheck()">
				<div class="modal-dialog modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLongTitle"><spring:message code="memberWrite.number1"/></h5>
						</div>
						<div class="modal-body">
							<div class="form-group">
								<label for="Name" class="col-sm-3 control-label"><spring:message code="memberWrite.number2"/></label>
								<div class="col-sm-9">
									<input type="text" id="userName" name="userName" class="form-control" maxlength="20">
									<label id="re-nameErr" class="col-sm-9 control-label" style="color:red"></label>
								</div>
								<label for="ID" class="col-sm-3 control-label"><spring:message code="memberWrite.number3"/></label>
								<div class="col-sm-9">
									<input type="text" id="userId" name="userId" class="form-control">
									<label id="re-idErr" class="col-sm-9 control-label" style="color:red"></label>
								</div>
								<label for="Password" class="col-sm-3 control-label"><spring:message code="memberWrite.number4"/></label>
								<div class="col-sm-9">
									<input type="password" id="userPw" name="userPw" class="form-control">
									<label id="re-pwErr" class="col-sm-9 control-label" style="color:red"></label>
								</div>
								<label for="PasswordConfirm" class="col-sm-3 control-label"><spring:message code="memberWrite.number5"/></label>
								<div class="col-sm-9">
									<input type="password" id="userPw2" name="userPw2" class="form-control">
									<label id="re-pwErr-cof" class="col-sm-11 control-label" style="color:red"></label>
								</div>
								<label for="email" class="col-sm-3 control-label">E-Mail</label>
								<div class="col-sm-9">
									<input type="text" id="userEmail" name="userEmail" class="form-control">
									<label id="re-mailErr" class="col-sm-9 control-label" style="color:red"></label>
								</div>
							</div>
							<div class="modal-footer">
								<input type="submit" class="btn btn-secondary" value = "<spring:message code="memberWrite.number6"/>" />
								<input type="button" class="btn btn-secondary" value = "<spring:message code="memberWrite.number7"/>" onclick="javascript_:history.go(-1);" />
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
		<br />
		<%@ include file="../include/footer.jsp" %>
	</body>
</html>