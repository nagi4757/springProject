<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@ include file="../include/header.jsp" %>
		<title>나기의 세상 - Nagi's World</title>
	</head>
	<body>
		<%@ include file="../include/menu.jsp" %>
		<!-- Page Content -->
	    <div class="container">
	
	      <!-- Page Heading/Breadcrumbs -->
	      <h1 class="mt-4 mb-3">
	      	<c:if test="${map.bgroup == 2}">
	      		Python
	      	</c:if>
	      	<c:if test="${map.bgroup == 3}">
	      		UML
	      	</c:if>
	        <small>강의실</small>
	      </h1>
	
	      <ol class="breadcrumb">
	        <li class="breadcrumb-item">
	          <a href="index.html">Home</a>
	        </li>
	        <li class="breadcrumb-item active">
	        	<c:if test="${map.bgroup == 2}">Python</c:if>
	        	<c:if test="${map.bgroup == 3}">UML</c:if> 강의실
	        </li>
	      </ol>
	
	      <div class="row">
	      
	      	<c:forEach var="row" items="${map.list}">
		        <div class="col-lg-6 portfolio-item">
		          <div class="card h-100">
		            <a href="${path}/lecture/view.do?bno=${row.bno}"><img class="card-img-top" src="${row.firstImageSrc}" width="700px"></a>
		            <div class="card-body">
		              <h4 class="card-title">
		                <a href="#">${row.title}</a>
		              </h4>
		            </div>
		          </div>
		        </div>
	        </c:forEach>
	        
	       
	      </div>
	      <!-- /.row -->
	
	      <!-- Pagination -->
	      <ul class="pagination justify-content-center">
	      			
		      <!-- 이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 <<하이퍼링크를 화면에 출력 -->
		      <c:if test="${map.boardPager.curBlock > 1}">
			  	<li class="page-item">
					<a class="page-link" href="javascript:list('${map.boardPager.prevPage}')" aria-label="Previous">
						<span aria-hidden="true">&laquo;</span>
					    <span class="sr-only">Previous</span>
					</a>
				</li>
			  </c:if>
				        	
			  <!-- 하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
			  <c:forEach var="num" begin="${map.boardPager.blockBegin}" end="${map.boardPager.blockEnd}">
				  <!-- 현재페이지이면 하이퍼링크 제거 -->
				  <c:choose>
					<c:when test="${num == map.boardPager.curPage}">
						<li class="page-item">
					    	<a class="page-link" style="color: red">${num}</a>
					    </li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
					    	<a class="page-link" href="javascript:list('${num}')">${num}</a>
					    </li>
					</c:otherwise>
				  </c:choose>
			  </c:forEach>
			  
			  <!-- 다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 >>하이퍼링크를 화면에 출력 -->
			  <c:if test="${map.boardPager.curBlock <= map.boardPager.totBlock}">
			  	<li class="page-item">
					<a class="page-link" href="javascript:list('${map.boardPager.nextPage}')" aria-label="Next">
						<span aria-hidden="true">&raquo;</span>
						<span class="sr-only">Next</span>
					</a>
				</li>
			  </c:if>
	      </ul>
	
	    </div>
	    <!-- /.container -->
	    
	    <%@ include file="../include/footer.jsp" %>
	</body>
</html>