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
		        $("#btnWrite").click(function(){
		            // 페이지 주소 변경(이동)
		            location.href = "${path}/board/write.do";
		        });
		    });
		 	// **원하는 페이지로 이동시 검색조건, 키워드 값을 유지하기 위해
		 	function list(page){
		        location.href="${path}/board/list.do?curPage="+page+"&searchOption-${map.searchOption}"+"&keyword=${map.keyword}";
		    }
		</script>
	</head>
	<body>
		<%@ include file="../include/menu.jsp" %>
		<div class="container">
			<div class="row">
		    
			    <div class="col-lg-12">
			    	<h2 class="my-4">자유게시판</h2>
				    <form name="form1" method="post" action="${path}/board/list.do">
				        <select name="searchOption">
				            <!-- 검색조건을 검색처리후 결과화면에 보여주기위해  c:out 출력태그 사용, 삼항연산자 -->
				            <option value="all" <c:out value="${map.searchOption == 'all'?'selected':''}"/> >제목+내용+이름</option>
				            <option value="writer" <c:out value="${map.searchOption == 'writer'?'selected':''}"/> >이름</option>
				            <option value="content" <c:out value="${map.searchOption == 'content'?'selected':''}"/> >내용</option>
				            <option value="title" <c:out value="${map.searchOption == 'title'?'selected':''}"/> >제목</option>
				        </select>
				        <input name="keyword" value="${map.keyword}">
				        <input type="submit" value="조회">
				    <!-- 로그인한 사용자만 글쓰기 버튼을 활성화 -->
				    <c:if test="${sessionScope.userId != null}">
				    	<button type="button" id="btnWrite">글쓰기</button>
				    </c:if> 
				    </form>
				    <!-- 레코드의 갯수를 출력 -->
				    ${map.count}개의 게시물이 있습니다.
			    	
			    	<div class="card card-outline-secondary my-4">
	    				<div class="table-responsive">
	    					<table class="table table-striped custab">
	    						<thead>
	    							<tr>
	    								<th>번호</th>
	    								<th>제목</th>
	    								<th>이름</th>
	    								<th>작성일</th>
	    								<th>조회수</th>
	    							</tr>
	    						</thead>
	    						<c:forEach var="row" items="${map.list}">
		    						<tr>
		    							<td>${row.bno}</td>
		    							<!-- 게시글 상세보기 페이지로 이동시 게시글 목록페이지에 있는 검색조건, 키워드, 현재페이지 값을 유지하기 위해 -->
			            				<td>
			            					<a href="${path}/board/view.do?bno=${row.bno}&curPage=${map.boardPager.curPage}&searchOption=${map.searchOption}&keyword=${map.keyword}">${row.title}</a>
			            					<c:if test="${row.recnt > 0}">
	                    						<span style="color: red;">(${row.recnt})</span>
	                    					</c:if>
			            				</td>
			            				<td>${row.userName}</td>
		    							<td>
		    								<!-- 원하는 날짜형식으로 출력하기 위해 fmt태그 사용 -->
		    								<fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
		    							</td>
		    							<td>${row.viewcnt}</td>
		    						</tr>
	    						</c:forEach>
	    					</table>
	    					<c:if test="${map.list.size() < 1}">
	    						<div class="text-center">게시물이 없습니다.</div><br />
	    					</c:if>
	    				</div>
	    			</div>
	    			
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
		    </div>
		    
		</div>
		<br />
		<%@ include file="../include/footer.jsp" %>
	</body>
</html>