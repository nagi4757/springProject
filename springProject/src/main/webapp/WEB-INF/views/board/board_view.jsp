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
		    				alert("<spring:message code="boardView.alert1"/>");
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
		            if(confirm("<spring:message code="boardView.alert2"/>")){
		                document.form1.action = "${path}/board/delete.do?bno=${dto.bno}";
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
			<h2>${dto.title}</h2>
			<!-- 원하는 날짜형식으로 출력하기 위해 fmt태그 사용 -->
			<div>        
				<spring:message code="boardView.number1"/> <fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd a HH:mm:ss"/>
			    <!-- 날짜 형식 => yyyy 4자리연도, MM 월, dd 일, a 오전/오후, HH 24시간제, hh 12시간제, mm 분, ss 초 -->
			</div>
			<div>
				<spring:message code="boardView.number2"/> ${dto.viewcnt}
			</div>
			<div>
			 	<spring:message code="boardView.number3"/> ${dto.userName}
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
					<button type="button" id="btnUpdete"><spring:message code="boardView.number4"/></button>
				    <button type="button" id="btnDelete"><spring:message code="boardView.number5"/></button>
				</c:if>
				<!-- **상세보기 화면에서 게시글 목록화면으로 이동 -->
				<button type="button" id="btnList"><spring:message code="boardView.number6"/></button>
			</div>
			
			<div>		
				<br /><br />
				<!-- 댓글 목록 출력할 위치 -->
    			<div id="listReply"></div>
    			
    			<!-- Comments Form -->
		        <c:if test="${sessionScope.userId != null}">
			    	<div class="card my-4">
			        	<h5 class="card-header"><spring:message code="boardView.number7"/></h5>
			            <div class="card-body">
				        	<div class="form-group">
				            	<textarea class="form-control" rows="3" id="replytext"></textarea>
				            </div>
				            <button type="button" class="btn btn-primary" id="btnReply"><spring:message code="boardView.number8"/></button>
				        </div>
			        </div>
		       	</c:if>
		   	</div>  
			
		</div>
		<br />
		<%@ include file="../include/footer.jsp" %>
	</body>
</html>