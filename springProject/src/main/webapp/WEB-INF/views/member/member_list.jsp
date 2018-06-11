<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
		<title><spring:message code="title.number1"/> - Nagi's World</title>
		
		<%@ include file="../include/adminCheck.jsp" %>
		<%@ include file="../include/header.jsp" %>
	
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
    				<h3 class="my-4">회원관리</h3>
    				<div class="card card-outline-secondary my-4">
    					<div class="table-responsive">
    						<table class="table table-striped custab">
    							<thead>
    								<tr>
    									<th>아이디</th>
    									<th>이름</th>
    									<th>이메일</th>
    									<th>회원가입일자</th>
    								</tr>
    							</thead>
    							<c:forEach var="row" items="${list}">
    							<tr>
    								<th>${row.userId}</th>
    								<th><a href="${path}/member/view.do?userId=${row.userId}">${row.userName}</a></th>
    								<th>${row.userEmail}</th>
    								<th>${row.userRegdate}</th>
    							</tr>
    							</c:forEach>
    						</table>
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