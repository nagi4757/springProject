<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- jstl 코어 태그 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- context 경로 -->
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="allPath" value="${requestScope['javax.servlet.forward.servlet_path']}" /> 
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- Navigation -->
<nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark fixed-top">
	<div class="container">
		<a class="navbar-brand" href="/springProject">Nagi's World</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        	<span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
        	<ul class="navbar-nav ml-auto">
            	<li class="nav-item">
              		<a class="nav-link" href="/springProject">
              			<spring:message code="menu.number1"/>
              		</a>
            	</li>
            	<li class="nav-item">
              		<a class="nav-link" href="${path}/board/list.do">
              			<spring:message code="menu.number2"/>
              		</a>
            	</li>
            	<li class="nav-item dropdown">
              		<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownPortfolio" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                		<spring:message code="menu.number3"/>
              		</a>
              		<div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownPortfolio">
                		<a class="dropdown-item" href="javascript:lectureList(2)">Spring</a>
                		<a class="dropdown-item" href="javascript:lectureList(3)">JavaScript</a>
              		</div>
              		<form name="lectureList" method="post" action="${path}/lecture/list.do">
              			<input type="hidden" id="lectureListBgroup" name="bgroup" value="${map.bgroup}">
              		</form>
            	</li>
            	<c:choose>
	            	<c:when test="${sessionScope.userId == null}">
	            		<li class="nav-item">
	              			<a class="nav-link" href="${path}/member/login.do">
	              				<spring:message code="menu.number4"/>
	              			</a>
	            		</li>
	            		<li class="nav-item">
	              			<a class="nav-link" href="${path}/member/write.do">
	              				<spring:message code="menu.number5"/>
	              			</a>
	            		</li>
	            	</c:when>
	            	<c:otherwise>
	            		<li class="nav-item">
	            			<c:if test="${sessionScope.userIsAdmin == 'Y'}">
	              				<a class="nav-link" href="${path}/member/list.do">
	              					<spring:message code="menu.number6"/>
	              				</a>
	              			</c:if>
	              			<c:if test="${sessionScope.userIsAdmin == 'N'}">
	              				<a class="nav-link" href="${path}">
	              					<spring:message code="menu.number6"/>
	              				</a>
	              			</c:if>
	            		</li>
	            		<li class="nav-item">
	              			<a class="nav-link" href="${path}/member/logout.do">
	              				<spring:message code="menu.number7"/>
	              			</a>
	            		</li>
	            	</c:otherwise>
            	</c:choose>
            	<li class="nav-item dropdown">
              		<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownLanguage" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                		<spring:message code="menu.number8"/>
              		</a>
              		<div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownLanguage">
                		<a class="dropdown-item" href="javascript:langChange('ko')">한국어</a>
                		<a class="dropdown-item" href="javascript:langChange('ja')">日本語</a>
              		</div>
              		<form name="langChange" method="post" action="${path}${allPath}">
              			<input type="hidden" id="langChangeBgroup" name="bgroup" value="${map.bgroup}">
              			<input type="hidden" id="langChangeLang" name="lang" value="ko">
              			<c:if test="${dto.bno != null}">
              				<input type="hidden" name="bno" value="${dto.bno}">
              			</c:if>
              		</form>
            	</li>
        	</ul>
    	</div>
	</div>
</nav>