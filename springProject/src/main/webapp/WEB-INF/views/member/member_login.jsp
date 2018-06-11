<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
		<title><spring:message code="title.number1"/> - Nagi's World</title>
		<%@ include file="../include/header.jsp" %>
		<script>
		    $(document).ready(function(){
		        $("#btnLogin").click(function(){
		            // 태크.val() : 태그에 입력된 값
		            // 태크.val("값") : 태그의 값을 변경 
		            var userId = $("#userId").val();
		            var userPw = $("#userPw").val();
		            if(userId == ""){
		                alert("<spring:message code="login.alert1"/>");
		                $("#userId").focus(); // 입력포커스 이동
		                return; // 함수 종료
		            }
		            if(userPw == ""){
		                alert("<spring:message code="login.alert2"/>");
		                $("#userPw").focus();
		                return;
		            }
		            // 폼 내부의 데이터를 전송할 주소
		            document.form1.action="${path}/member/loginCheck.do"
		            // 제출
		            document.form1.submit();
		        });
		    });
		</script>
	</head>
	<body>
		<%@ include file="../include/menu.jsp" %>
		<div class="container">
			<form name="form1" method="post">
				<div class="modal-dialog modal-lg" role="document">
	          		<div class="modal-content">
	            		<div class="modal-header">
	              			<h5 class="modal-title" id="exampleModalLongTitle">Login</h5>
	            		</div>
	            		<div class="modal-body">
	              			<div class="form-group">
	                			<label for="ID"><spring:message code="login.number1"/></label>
	                 			<input type="text" class="form-control form-control-lg rounded-0" name="userId" id="userId">
	              			</div>
	              			<div class="form-group">
	                			<label><spring:message code="login.number2"/></label>
	                			<input type="password" class="form-control form-control-lg rounded-0" id="userPw" name="userPw">
	              			</div>
	              			<label style="color:red">
	              				<c:if test="${msg == 'failure'}">
				                    <div style="color: red">
				                    	<spring:message code="login.number3"/>
				                    </div>
				                </c:if>
				                <c:if test="${msg == 'logout'}">
				                    <div style="color: red">
				                    	<spring:message code="login.number4"/>
				                    </div>
				                </c:if>
				                <c:if test="${msg == 'EmailAuthFailure'}">
				                    <div style="color: red">
				                    	<spring:message code="login.number6"/>
				                    </div>
				                </c:if>
				                <c:if test="${msg == 'EmailAuthSuccess'}">
				                    <div style="color: red">
				                    	<spring:message code="login.number7"/>
				                    </div>
				                </c:if>
				                <c:if test="${msg == 'EmailAuthError'}">
				                    <div style="color: red">
				                    	<spring:message code="login.number8"/>
				                    </div>
				                </c:if>
				           	</label>
	            		</div>
	            		<div class="modal-footer">
	              			<button type="button" class="btn btn-secondary" id="btnLogin"><spring:message code="login.number5"/></button>
	            		</div>
					</div>
	         	</div>    
		    </form>
	    </div>
	    <br />
	    <%@ include file="../include/footer.jsp" %>
	</body>
</html>