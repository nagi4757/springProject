<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>로그인페이지</title>
		<%@ include file="../include/header.jsp" %>
		<script>
		    $(document).ready(function(){
		        $("#btnLogin").click(function(){
		            // 태크.val() : 태그에 입력된 값
		            // 태크.val("값") : 태그의 값을 변경 
		            var userId = $("#userId").val();
		            var userPw = $("#userPw").val();
		            if(userId == ""){
		                alert("아이디를 입력하세요.");
		                $("#userId").focus(); // 입력포커스 이동
		                return; // 함수 종료
		            }
		            if(userPw == ""){
		                alert("아이디를 입력하세요.");
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
	                			<label for="ID">아이디</label>
	                 			<input type="text" class="form-control form-control-lg rounded-0" name="userId" id="userId">
	              			</div>
	              			<div class="form-group">
	                			<label>비밀번호</label>
	                			<input type="password" class="form-control form-control-lg rounded-0" id="userPw" name="userPw" autocomplete="new-password">
	              			</div>
	              			<label style="color:red">
	              				<c:if test="${msg == 'failure'}">
				                    <div style="color: red">
				                    	아이디 또는 비밀번호가 일치하지 않습니다.
				                    </div>
				                </c:if>
				                <c:if test="${msg == 'logout'}">
				                    <div style="color: red">
				                    	로그아웃되었습니다.
				                    </div>
				                </c:if>
				           	</label>
	            		</div>
	            		<div class="modal-footer">
	              			<button type="button" class="btn btn-secondary" id="btnLogin">로그인</button>
	            		</div>
					</div>
	         	</div>    
		    </form>
	    </div>
	    <br />
	    <%@ include file="../include/footer.jsp" %>
	</body>
</html>