<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>회원정보 상세 페이지</title>
		<%@ include file="../include/header.jsp" %>
		<script>
			$(document).ready(function(){
				$("#btnUpdate").click(function(){
					// 확인 대화상자	
					if(confirm("수정하시겠습니까?")){
						document.form1.action = "${path}/member/update.do";
						document.form1.submit();
					}
				});
			});
			$(document).ready(function(){
				$("#btnDelete").click(function(){
					// 확인 대화상자 
					if(confirm("삭제하시겠습니까?")){
						document.form1.action = "${path}/member/delete.do";
						document.form1.submit();
					}
				});
			});
		</script>
	</head>
	
	<body>
		<%@ include file="../include/menu_mypage.jsp" %>
		<!-- Page Content -->
		<div class="container">
    		<div class="row">
    			<div class="col-lg-2">
    				<h2 class="my-4">MYPAGE</h2>
    				<div class="list-group">
    					<a href="${path}/member/list.do" class="list-group-item active">회원관리</a>
    					<a href="${path}/board/list.do?bgroup=2" class="list-group-item">게시판</a>
    				</div>
    			</div>
    			<!-- /.col-lg-2 -->
    			
    			<div class="col-lg-10">
    				<h3 class="my-4">회원정보 상세</h3>
    				<div class="card card-outline-secondary my-4">
    					<div class="table-responsive">
	    					<form name="form1" method="post">
	    						<table class="table">
	    							<tr>
										<td>아이디</td>
							 			<!-- id는 수정이 불가능하도록 readonly속성 추가 -->
										<td><input name="userId" value="${dto.userId}" readonly="readonly"></td>
									</tr>
									<tr>
										<td>비밀번호</td>
										<td><input type="password" name="userPw"></td>
									</tr>
									<tr>
										<td>이름</td>
										<td><input name="userName" value="${dto.userName}"></td>
									</tr>
									<tr>
										<td>이메일주소</td>
										<td><input name="userEmail" value="${dto.userEmail}"></td>
									</tr>
									<tr>
										<td>회원가입일자</td>
										<td>
											<fmt:formatDate value="${dto.userRegdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
									</tr>
									<tr>
										<td>회원정보 수정일자</td>
										<td>
											<fmt:formatDate value="${dto.userUpdatedate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
									</tr>
									<tr>
										<td colspan="2" align="center">
											<input type="button" value="수정" id="btnUpdate">
											<input type="button" value="삭제" id="btnDelete">
											<div style="color: red;">${message}</div>
										</td>
									</tr>
	    						</table>
	    					</form>
    					</div>
    				</div>
    			</div>
    			<!-- /.col-lg-10 -->
    		</div>
    		<!-- /.row -->	
    	</div>
    	<!-- /.container -->
    	
    	<br />					
    						
    	<%@ include file="../include/footer.jsp" %>
	</body>
</html>