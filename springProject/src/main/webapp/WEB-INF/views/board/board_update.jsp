<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 작성</title>
<%@ include file="../include/header.jsp" %>
<script>
    $(document).ready(function(){
    	// ** 목록 버튼 클릭 이벤트 : 버튼 클릭시 상세보기화면에 있던 페이지, 검색옵션, 키워드 값을 가지로 목록으로 이동
    	$("#btnList").click(function(){
            location.href="${path}/board/list.do?curPage=${curPage}&searchOption=${searchOption}&keyword=${keyword}";
        });
        $("#btnUpdete").click(function(){
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
            document.form1.action="${path}/board/update.do"
            // 폼에 입력한 데이터를 서버로 전송
            document.form1.submit();
        });
    });
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2>게시글 보기</h2>
<form name="form1" method="post">
	<!-- 원하는 날짜형식으로 출력하기 위해 fmt태그 사용 -->
    <div>        
    	작성일자 : <fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd a HH:mm:ss"/>
        <!-- 날짜 형식 => yyyy 4자리연도, MM 월, dd 일, a 오전/오후, HH 24시간제, hh 12시간제, mm 분, ss 초 -->
    </div>
    <div>
    	조회수 : ${dto.viewcnt}
    </div>
    <div>
		제목 <input name="title" id="title" size="80" value="${dto.title}" placeholder="제목을 입력해주세요">
    </div>
    <div>
    	내용 <textarea name="content" id="content" rows="4" cols="80" placeholder="내용을 입력해주세요">${dto.content}</textarea>
    </div>
    <div>
    	작성자 ${dto.userName}
    </div>
    <div style="width:650px; text-align: center;">
        <!-- 게시물번호를 hidden으로 처리 -->
        <input type="hidden" name="bno" value="${dto.bno}">
    <!-- 본인이 쓴 게시물만 수정, 삭제가 가능하도록 처리 -->
    <c:if test="${sessionScope.userId == dto.writer}">
        <button type="button" id="btnUpdete">확인</button>
    </c:if>
    	<!-- **상세보기 화면에서 게시글 목록화면으로 이동 -->
        <button type="button" id="btnList">목록</button>
    </div>
</form>
</body>
</html>