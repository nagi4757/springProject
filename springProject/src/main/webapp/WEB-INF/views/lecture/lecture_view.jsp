<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>나기의 세상 - Nagi's World</title>
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
			});
			
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
		
		<!-- Page Content -->
    	<div class="container">
    	
    		<!-- Page Heading/Breadcrumbs -->
      		<h1 class="mt-4 mb-3">${dto.title}</h1>
      		
      		<div class="row">
      		
      			<!-- Post Content Column -->
		        <div class="col-lg-12">
		        	<hr>
		          	<!-- Date/Time -->
		          	<p>작성일자 : <fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd a HH:mm:ss"/></p>
		          	<hr>
					
				  	${dto.content}
		
		          	<hr>
		
		          	<!-- Single Comment -->
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
      		<!-- /.row -->	
		</div>
		<!-- /.container -->
    	
		<br />
		<%@ include file="../include/footer.jsp" %>
	</body>
</html>