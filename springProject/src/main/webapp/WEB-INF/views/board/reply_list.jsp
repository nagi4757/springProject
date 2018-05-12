<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@ include file="../include/header.jsp" %>
		<script>
			// 댓글 삭제
	    	function replyDelete(rno, rgrpord, rgrpno){
	    		if(confirm("삭제하시겠습니까?")){
	    			$.ajax({
	    				type:"get",
	    				url:"${path}/reply/delete.do?rno="+rno+"&rgrpord="+rgrpord+"&rgrpno="+rgrpno,
	    				success:function(result){
	    					if(result=="success"){
	    						alert("댓글이 삭제되었습니다.");
	    						listReply(1);
	    					}else if(result=="fail"){
	    						alert("대댓글이 있는 댓글은 삭제가 불가능합니다.");
	    					}
	    				}
	    			});	
	    		}
			}
			
			function replyUpdate(rno){
				var replytext=$("#replytext-"+rno).val();
				var param="rno="+rno+"&replytext="+replytext;
				
				$.ajax({
					type:"post",
					url:"${path}/reply/update.do",
					data:param,
					success:function(result){
						alert("댓글이 수정되었습니다.");
						listReply(1);
					}
				});
			}
			
			function reReplyInsert(rno, bno, rgrpno, rgrpord, rdepth){
				var replytext=$("#re-replytext-"+rno).val();
	    		var bno = bno;
	    		var rprtno = rno;
	    		if(rdepth>=2){
	    			rno = rgrpno;
	    		}
	    		var rgrpord = rgrpord+1;
	    		var rdepth = rdepth+1;
	    		var param="replytext="+replytext+"&bno="+bno+"&rgrpno="+rno+"&rgrpord="+rgrpord+"&rdepth="+rdepth+"&rprtno="+rprtno;
				$.ajax({
	    			type:"post",
	    			url:"${path}/reply/insert.do",
	    			data:param,
	    			success:function(){
	    				alert("대댓글이 등록되었습니다.");
		    			listReply(1);	
	    			}
	    		});		
			}
			
			function showReplyModify(rno, replytext){
				cancelReReply(rno);
				var output = "<div class='form-group'><textarea rows='2' class='form-control' id='replytext-"+rno+"' placeholder='댓글을 작성해주세요'>"+replytext+"</textarea></div>";
				output += "<div class='form-group'><button type='button' onclick='replyUpdate("+rno+")' class='btn btn-primary btn-sm'>수정</button>&nbsp;";
				output += "<button type='button' onclick='cancelModify("+rno+")' class='btn btn-secondary btn-sm'>취소</button></div>";
				output += "<input type='hidden' id='hreply-"+rno+"' value='"+replytext+"'>";
				$("#reply-"+rno).html(output);
			}
			
			function showReReply(rno, bno, rgrpno, rgrpord, rdepth){
				cancelModify(rno);
				var output = "<div class='form-group'><textarea rows='2' class='form-control' id='re-replytext-"+rno+"' placeholder='댓글을 작성해주세요'></textarea></div>";
				output += "<div class='form-group'><button type='button' onclick='reReplyInsert("+rno+","+bno+","+rgrpno+","+rgrpord+","+rdepth+")' class='btn btn-primary btn-sm'>댓글작성</button>&nbsp;";
				output += "<button type='button' onclick='cancelReReply("+rno+")' class='btn btn-secondary btn-sm'>취소</button></div>";
				$("#re-reply-"+rno).html(output);
			}
			
			function cancelReReply(rno){
				$("#re-reply-"+rno).html("");
			}
			
			function cancelModify(rno){
				var replytext = $("#hreply-"+rno).val();
				$("#reply-"+rno).html(replytext);
			}
		</script>
	</head>
	<body>
		<c:forEach var="row" items="${list}">
			<div class="media mb-4">
				<c:forEach var="num" begin="2" end="${row.rdepth}">
					&nbsp;&nbsp;&nbsp;&nbsp;<c:if test="${ num == row.rdepth }">ㄴ&nbsp;&nbsp;</c:if>
				</c:forEach>
				<img class="d-flex mr-3 rounded-circle" src="http://placehold.it/50x50" alt="">
		    	<div class="media-body">
		        	<h5 class="mt-0">
		        		${row.userName}
		        		<small>
		        			(<fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/>)
		        		</small>
		        	</h5>
		        	<div id="reply-${row.rno}">
			        	<h5 class="mt-0">
			        		<small>
			        			${row.replytext}
			        		</small>
			        	</h5>
		        	</div>
		        	<small>
		        		<c:if test="${sessionScope.userId != null}">
		                	<a href="javascript:showReReply(${row.rno},${row.bno},${row.rgrpno},${row.rgrpord},${row.rdepth})" >댓글</a>
		                </c:if>
		                <c:if test="${sessionScope.userId == row.replyer}">
		                	<a href="javascript:showReplyModify(${row.rno},'${row.replytext}')" >수정</a>
		                	<a href="javascript:replyDelete(${row.rno},${row.rgrpord},${row.rgrpno})" >삭제</a>
		                </c:if>
		        	</small>
		        	<div id="re-reply-${row.rno}"></div>
		    	</div>
			</div>
		</c:forEach>
		
	    <!-- 페이징 처리 -->
	    <ul class="pagination justify-content-center">
	      			
	    	<!-- 이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 <<하이퍼링크를 화면에 출력 -->
	      	<c:if test="${replyPager.curBlock > 1}">
				<li class="page-item">
					<a class="page-link" href="javascript:list('${replyPager.prevPage}')" aria-label="Previous">
				    	<span aria-hidden="true">&laquo;</span>
				        <span class="sr-only">Previous</span>
				    </a>
				</li>
			</c:if>
			        	
			<!-- 하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
			<c:forEach var="num" begin="${replyPager.blockBegin}" end="${replyPager.blockEnd}">
				<!-- 현재페이지이면 하이퍼링크 제거 -->
			    <c:choose>
			    	<c:when test="${num == replyPager.curPage}">
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
			<c:if test="${replyPager.curBlock <= replyPager.totBlock}">
				<li class="page-item">
					<a class="page-link" href="javascript:list('${replyPager.nextPage}')" aria-label="Next">
						<span aria-hidden="true">&raquo;</span>
					    <span class="sr-only">Next</span>
					</a>
				</li>
			</c:if>
		</ul>	
	</body>
</html>