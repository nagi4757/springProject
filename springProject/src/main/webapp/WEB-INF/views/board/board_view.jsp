<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>게시글 작성</title>
		<%@ include file="../include/header.jsp" %>
		<script>
		    $(document).ready(function(){
		    	
		    	listReply(1); 
		    	
		    	// 댓글 쓰기 버튼 클릭 이벤트 (ajax로 처리)
		    	$("#btnReply").click(function(){
		    		var replytext=$("#replytext").val();
		    		var bno = "${dto.bno}"
		    		var param="replytext="+replytext+"&bno="+bno;
		    		
		    		$.ajax({
		    			type:"post",
		    			url:"${path}/reply/insert.do",
		    			data:param,
		    			success:function(){
		    				alert("댓글이 등록되었습니다.");
		    				$("#replytext").val('');
			    			listReply(1);	
		    			}
		    		});
		    	});
		    	
		    	// 목록 버튼 클릭 이벤트 : 버튼 클릭시 상세보기화면에 있던 페이지, 검색옵션, 키워드 값을 가지로 목록으로 이동
		    	$("#btnList").click(function(){
		            location.href="${path}/board/list.do?curPage=${curPage}&searchOption=${searchOption}&keyword=${keyword}";
		        });
		    	
		    	// 게시글 삭제 버튼 클릭이벤트
		        $("#btnDelete").click(function(){
		            if(confirm("삭제하시겠습니까?")){
		                document.form1.action = "${path}/board/delete.do";
		                document.form1.submit();
		            }
		        });
		    	
		    	// 게시글 수정 버튼 클릭이벤트
		        $("#btnUpdete").click(function(){
		        	location.href="${path}/board/update.do?bno=${dto.bno}&curPage=${curPage}&searchOption=${searchOption}&keyword=${keyword}";
		        });
		    	
		    });
		    
		 	// RestController방식 (Json)
		 	// 댓글 목록2 (json)
		 	function listReply(num){
        		$.ajax({
            		type: "get",
            		url: "${path}/reply/list.do?bno=${dto.bno}&curPage="+num,
            		success: function(result){
                		$("#listReply").html(result);
            		}
        		});
    		}
		</script>
	</head>
	
	<body>
		<%@ include file="../include/menu.jsp" %>
		<div class="container">
			<br />
			<h2>게시글 보기</h2>
			<!-- 원하는 날짜형식으로 출력하기 위해 fmt태그 사용 -->
			<div>        
				작성일자 : <fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd a HH:mm:ss"/>
			    <!-- 날짜 형식 => yyyy 4자리연도, MM 월, dd 일, a 오전/오후, HH 24시간제, hh 12시간제, mm 분, ss 초 -->
			</div>
			<div>
				조회수 : ${dto.viewcnt}
			</div>
			<div>
				제목 : ${dto.title}
			</div>
			<div>
			 	작성자 : ${dto.userName}
			</div>
			<div style="text-align: center;">
				<div>
					${dto.content}
				</div>
				<br />
				<!-- 게시물번호를 hidden으로 처리 -->
				<input type="hidden" name="bno" value="${dto.bno}">
				<!-- 본인이 쓴 게시물만 수정, 삭제가 가능하도록 처리 -->
				<c:if test="${sessionScope.userId == dto.writer}">
					<button type="button" id="btnUpdete">수정</button>
				    <button type="button" id="btnDelete">삭제</button>
				</c:if>
				<!-- **상세보기 화면에서 게시글 목록화면으로 이동 -->
				<button type="button" id="btnList">목록</button>
			</div>
			
			<div>		
				<br /><br />
				<!-- 댓글 목록 출력할 위치 -->
    			<div id="listReply"></div>
    			
    			<!-- Comments Form -->
		        <c:if test="${sessionScope.userId != null}">
			    	<div class="card my-4">
			        	<h5 class="card-header">댓글쓰기</h5>
			            <div class="card-body">
				        	<div class="form-group">
				            	<textarea class="form-control" rows="3" id="replytext"></textarea>
				            </div>
				            <button type="button" class="btn btn-primary" id="btnReply">댓글등록</button>
				        </div>
			        </div>
		       	</c:if>
		   	</div>  
			
		</div>
		<br />
		<%@ include file="../include/footer.jsp" %>
	</body>
</html>