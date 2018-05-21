<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
		<title><spring:message code="title.number1"/> - Nagi's World</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<%@ include file="include/header.jsp" %>
	</head>
	
	<body>
		<%@ include file="include/menu.jsp" %>
		<header>
      		<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
        		<ol class="carousel-indicators">
          			<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
          			<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
          			<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
        		</ol>
        		<div class="carousel-inner" role="listbox">
          			<!-- Slide One - Set the background image for this slide in the line below -->
          			<div class="carousel-item active" style="background-image: url('/resources/images/pexels-photo-374074.jpeg')">
            			<div class="carousel-caption d-none d-md-block">
              				<h3><spring:message code="main.number1"/></h3>
              				<p><spring:message code="main.number2"/></p>
            			</div>
          			</div>
          			<!-- Slide Two - Set the background image for this slide in the line below -->
          			<div class="carousel-item" style="background-image: url('/resources/images/pexels-photo-248515.png')">
            			<div class="carousel-caption d-none d-md-block">
              				<h3><spring:message code="main.number3"/></h3>
              				<p><spring:message code="main.number4"/></p>
            			</div>
          			</div>
          			<!-- Slide Three - Set the background image for this slide in the line below -->
          			<div class="carousel-item" style="background-image: url('/resources/images/pexels-photo-839465.jpeg')">
            			<div class="carousel-caption d-none d-md-block">
              				<h3><spring:message code="main.number5"/></h3>
              				<p><spring:message code="main.number6"/></p>
            			</div>
          			</div>
        		</div>
        		<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
          			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
          			<span class="sr-only">Previous</span>
        		</a>
        		<a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
          			<span class="carousel-control-next-icon" aria-hidden="true"></span>
          			<span class="sr-only">Next</span>
        		</a>
      		</div>
    	</header>

    	<!-- Page Content -->
    	<div class="container">
    		<h1 class="my-4">
    			<spring:message code="main.number7"/>
    		</h1>
    		
    		<!-- Portfolio Section -->
    		<c:if test="${freeBoardList.size() > 0}">
      			<h2><spring:message code="main.number8"/></h2>
      		</c:if>

      		<!-- Marketing Icons Section -->
      		<div class="row">
      			<c:forEach var="row" items="${freeBoardList}">
      				<div class="col-lg-4 col-sm-6 portfolio-item">
	          			<div class="card h-100">
	          				<a href="${path}/board/view.do?bno=${row.bno}">
	            				<img class="card-img-top" src="${row.firstImageSrc}" alt="" width="700px" height="250px">
	            			</a>
	            			<div class="card-body">
	              				<h5 class="card-title">
	              					<a href="${path}/board/view.do?bno=${row.bno}">${row.title}</a>
	              				</h5>
	            			</div>
	          			</div>
        			</div>
      			</c:forEach>
      		</div>
      		<!-- /.row -->

      		<!-- Portfolio Section -->
      		<c:if test="${LectureBoardList.size() > 0}">
      			<h2><spring:message code="main.number9"/></h2>
      		</c:if>
      		
      		<div class="row">
      			<c:forEach var="row" items="${LectureBoardList}">
	        		<div class="col-lg-4 col-sm-6 portfolio-item">
	          			<div class="card h-100">
	            			<a href="${path}/lecture/view.do?bno=${row.bno}">
	            				<img class="card-img-top" src="${row.firstImageSrc}" alt="" width="700px" height="250px">
	            			</a>
	            			<div class="card-body">
	              				<h5 class="card-title">
	                				<a href="${path}/lecture/view.do?bno=${row.bno}">${row.title}</a>
	              				</h5>
	            			</div>
	          			</div>
	        		</div>
        		</c:forEach>
      		</div>
      		<!-- /.row -->

      		<!-- Features Section -->
      		<div class="row">
        		<div class="col-lg-6">
          			<h2><spring:message code="main.number10"/></h2>
          			<h5><strong>Yoon Nagi</strong></h5>
          			<p>
          				Front-end Web / dbsqhd4757@naver.com<br/>
          				<a class="fa fa-github-square" style="font-size:50px" href="https://github.com/nagi4757" target="_blank"></a>
          				<a class="fa fa-facebook-square" style="font-size:50px" href="" target="_blank"></a>
          				<a class="fa fa-twitter-square" style="font-size:50px" href="https://twitter.com/dbsqhd4757" target="_blank"></a>
          			</p>
          			
          			<h4><strong>Educations</strong></h4>
          			<ul>
            			<li>
              				<strong><spring:message code="main.number11"/></strong>
              				<br /><spring:message code="main.number12"/>
              				<br />- C, JAVA, PHP, DB(Mysql), Android, Linux
            			</li>
            			<li>
            				<strong><spring:message code="main.number13"/></strong>
            				<br /><spring:message code="main.number14"/>
            				<br />- JAVA, DB(Oracle, MySQL), JavaScript, Jquery, HTML, CSS, Structs2
            			</li>
          			</ul>
          			<h4><strong>Experiences</strong></h4>
          			<ul>
            			<li>
            				<strong><spring:message code="main.number15"/></strong>
            				<br /><spring:message code="main.number16"/>
            				<br /><spring:message code="main.number17"/>
            				<br /><spring:message code="main.number18"/>
            			</li>
          			</ul>
          			<h4><strong>Skills</strong></h4>
          			<ul>
          				<li>
          					<strong>Operating System</strong>
          					<br />- Windows
          					<br />- Linux(CentOS, Ubuntu)
          				</li>
          				<li>
          					<strong>JAVA(WEB)</strong>
          					<br />- JSP
          					<br />- Servlet
          					<br />- Struts2 Framework
          					<br />- Spring Framework 
          				</li>
          				<li>
          					<strong>JavaScript</strong>
          					<br />- jQuery
          					<br />- AJAX
          				</li>
          				<li>
          					<strong>Databases</strong>
          					<br />- MySQL
          					<br />- Oracle
          				</li>
          				<li>
          					<strong>Collaboration Tools</strong>
          					<br />- Github
          					<br />- SVN
          				</li>
          				<li>
          					<strong>ETC</strong>
          					<br />- PHP
          					<br />- C
          					<br />- HTML5
          					<br />- CSS3
          					<br />- Bootstrap3
          				</li>
          			</ul>
          			
        		</div>
        		<div class="col-lg-6">
          			<img class="img-fluid rounded" src="/resources/images/20180515_111037931.jpg" width="700px" height="450px">
        			<br><br>
        			<h4><strong>Languages</strong></h4>
          			<ul>
          				<li>
          					<strong><spring:message code="main.number19"/></strong>
          				</li>
          				<li>
          					<strong><spring:message code="main.number20"/></strong>
          				</li>
          			</ul>
        			<p>
        				<spring:message code="main.number21"/><br><br>
        				<strong><spring:message code="main.number22"/></strong><spring:message code="main.number23"/><br><br>
        				<spring:message code="main.number24"/><br><br>
        				<spring:message code="main.number25"/><br><br>
        			</p>
        		</div>
      		</div>
      		<!-- /.row -->

      		<hr>

      		<!-- Call to Action Section -->
      		<div class="row mb-4">
        		<div class="col-md-8">
          			<p><spring:message code="main.number26"/></p>
        		</div>
        		<div class="col-md-4">
          			<a class="btn btn-lg btn-secondary btn-block" href="#"><spring:message code="main.number27"/></a>
        		</div>
      		</div>
      		
    	</div>
    	<!-- /.container -->
		
		<%@ include file="include/footer.jsp" %>
	</body>
</html>