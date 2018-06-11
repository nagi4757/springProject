<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
		<title><spring:message code="title.number1"/> - Nagi's World</title>
		
		<!-- jstl 코어 태그 -->
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<!-- jstl 시간 출력 태그 -->
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
		<!-- context 경로 -->
		<c:set var="path" value="${pageContext.request.contextPath}"/>
		
		<!-- jquery3.1.1 -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
		
		<!-- 세션확인 태그 -->
		<%@ include file="../include/sessionCheck.jsp" %>
		
		<!-- include libraries(jQuery, bootstrap) -->
		<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
		<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
		
		<!-- include summernote css/js-->
		<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.css" rel="stylesheet">
		<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.js"></script>
		
		<script>
		    $(document).ready(function(){
		    	// 목록 버튼 클릭 이벤트 : 버튼 클릭시 상세보기화면에 있던 페이지, 검색옵션, 키워드 값을 가지로 목록으로 이동
		    	/*
		    	$("#btnList").click(function(){
		            location.href="${path}/board/list.do?curPage=${curPage}&searchOption=${searchOption}&keyword=${keyword}";
		        });*/
		        $("#btnUpdete").click(function(){
		            //var title = document.form1.title.value; ==> name속성으로 처리할 경우
		            //var content = document.form1.content.value;
		            //var writer = document.form1.writer.value;
		            var title = $("#title").val();
		            var content = $("#summernote").val();
		            //var writer = $("#writer").val();
		            if(title == ""){
		                alert("<spring:message code="boardUpdate.alert1"/>");
		                document.form1.title.focus();
		                return;
		            }
		            if(content == ""){
		                alert("<spring:message code="boardUpdate.alert2"/>");
		                document.form1.content.focus();
		                return;
		            }
		            document.form1.action="${path}/board/update.do"
		            // 폼에 입력한 데이터를 서버로 전송
		            document.form1.submit();
		        });
		        
		        $('#summernote').summernote({
		            height: 600,
		            lang: 'ko-KR',
		            minHeight: null,
		            maxHeight: null,
		            focus: true,
		            callbacks: {
		            	onImageUpload: function(files, editor, welEditable){
		            		for (var i = files.length - 1; i >= 0; i--) {
		                        sendFile(files[i], this);
		                    }
		            	}          	
		            }
		        });
		    });
		    
		    function sendFile(file, el){
		    	var form_data = new FormData();
		    	form_data.append('file', file);
		    	
		    	$.ajax({
					data: form_data,
		            type: "POST",
		            url: "${path}/board/imageUpload.do",
		            cache: false,
		            contentType: false,
		            enctype: 'multipart/form-data',
		            processData: false,
		            success: function(url){
		            	var image = $('<img>').attr({'src' : url, 'width': "650px", 'class': "img-fluid"});
						$('#summernote').summernote('insertNode', image[0]);
		            }
		    	});    	
		    }
		</script>
	</head>
	<body>
		<div class="container">
			<h2><spring:message code="boardUpdate.number1"/></h2>
			<form name="form1" method="post">
				<!-- 원하는 날짜형식으로 출력하기 위해 fmt태그 사용 -->
			    <div>        
			    	<spring:message code="boardUpdate.number2"/> <fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd a HH:mm:ss"/>
			        <!-- 날짜 형식 => yyyy 4자리연도, MM 월, dd 일, a 오전/오후, HH 24시간제, hh 12시간제, mm 분, ss 초 -->
			    </div>
			    <div>
			    	<spring:message code="boardUpdate.number3"/> ${dto.viewcnt}
			    </div>
			    <div>
					<spring:message code="boardUpdate.number4"/> <input name="title" id="title" size="80" value="${dto.title}" placeholder="<spring:message code="boardUpdate.number5"/>">
			    </div>
			    <div>
			    	<spring:message code="boardUpdate.number6"/> ${dto.userName}
			    </div>
			    <div>
			   		<textarea name="content" id="summernote" rows="4" cols="80" placeholder="<spring:message code="boardUpdate.number7"/>">${dto.content}</textarea>
			    </div>
			    <div style="text-align: center;">
			        <!-- 게시물번호를 hidden으로 처리 -->
			        <input type="hidden" name="bno" value="${dto.bno}">
			    	<!-- 본인이 쓴 게시물만 수정, 삭제가 가능하도록 처리 -->
			    	<c:if test="${sessionScope.userId == dto.writer}">
			        	<button type="button" id="btnUpdete"><spring:message code="boardUpdate.number8"/></button>
			    	</c:if>
			    	<!-- **상세보기 화면에서 게시글 목록화면으로 이동 -->
			        <button type="button" onclick="javascript_:history.go(-1);"><spring:message code="boardUpdate.number9"/></button>
			    </div>
			</form>
		</div>
	</body>
</html>