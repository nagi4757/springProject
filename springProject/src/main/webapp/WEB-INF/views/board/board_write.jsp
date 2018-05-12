<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>게시글 작성</title>
		
		<!-- jstl 코어 태그 -->
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		        $("#btnSave").click(function(){
		            //var title = document.form1.title.value; ==> name속성으로 처리할 경우
		            //var content = document.form1.content.value;
		            //var writer = document.form1.writer.value;
		            var title = $("#title").val();
		            var content = $("#content").val();
		            //var writer = $("#writer").val();
		            if(title == ""){
		                alert("제목을 입력하세요");
		                document.form1.title.focus();
		                return;
		            }
		            if(content == ""){
		                alert("내용을 입력하세요");
		                document.form1.content.focus();
		                return;
		            }
		            /*if(writer == ""){
		                alert("이름을 입력하세요");
		                document.form1.writer.focus();
		                return;
		            }*/
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
			<h2>게시글 작성</h2>
			<form name="form1" method="post" action="${path}/board/insert.do">
			    <div>
			    	제목 : <input name="title" id="title" size="80" placeholder="제목을 입력해주세요">
			    </div>
			    <br />
			    <div>
			    	<textarea name="content" id="summernote" rows="4" cols="80" placeholder="내용을 입력해주세요"></textarea>
			    	<input type="hidden" name="bgroup" value="${bgroup}">
			    </div>
			    <!-- <div>
			    	이름 <input name="writer" id="writer" placeholder="이름을 입력해주세요">
			    </div> -->
			    
			    <div style="text-align: center;">
			        <button type="button" id="btnSave">확인</button>
			        <button type="button" onclick="javascript_:history.go(-1);">취소</button>
			    </div>
			</form>
		</div>
	</body>
</html>