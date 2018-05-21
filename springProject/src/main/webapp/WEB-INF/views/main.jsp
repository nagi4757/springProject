<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>나기의 세상 - Nagi's World</title>
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
              				<h3>자유게시판</h3>
              				<p>자유롭게 IT정보를 공유합시다.</p>
            			</div>
          			</div>
          			<!-- Slide Two - Set the background image for this slide in the line below -->
          			<div class="carousel-item" style="background-image: url('/resources/images/pexels-photo-248515.png')">
            			<div class="carousel-caption d-none d-md-block">
              				<h3>IT강의실</h3>
              				<p>주인장이 IT지식을 공유합니다.</p>
            			</div>
          			</div>
          			<!-- Slide Three - Set the background image for this slide in the line below -->
          			<div class="carousel-item" style="background-image: url('/resources/images/pexels-photo-839465.jpeg')">
            			<div class="carousel-caption d-none d-md-block">
              				<h3>한국어/일본어</h3>
              				<p>이 홈페이지는 한국인과 일본인이 자유롭게 사용할 수 있도록 제작되어있습니다.</p>
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
    			${msg}
    		</h1>
    		
    		<!-- Portfolio Section -->
    		<c:if test="${freeBoardList.size() > 0}">
      			<h2>자유게시판</h2>
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
      			<h2>강의 게시판</h2>
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
          			<h2>주인장 소개</h2>
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
              				<strong>한남대학교</strong>
              				<br />- 컴퓨터공학과 전공 / 2017. 02(졸업)
              				<br />- C, JAVA, PHP, DB(Mysql), Android, Linux
            			</li>
            			<li>
            				<strong>JSL인재개발원</strong>
            				<br />- ICT소프트웨어 전문과정 24기 / 2016. 08 ~ 2017. 04
            				<br />- JAVA, DB(Oracle, MySQL), JavaScript, Jquery, HTML, CSS, Structs2
            			</li>
          			</ul>
          			<h4><strong>Experiences</strong></h4>
          			<ul>
            			<li>
            				<strong>프로그래머 (일본)</strong>
            				<br />- 사원관리, 근무표 제작(Spring + Structs) / 2017. 07 ~ 2017. 09
            				<br />- 국세청 공매사이트 유지보수(PHP) / 2017. 10 ~ 2018. 01
            				<br />- (사진사, 교회)홈페이지 제작(PHP) / 2018. 03 ~ 2018. 05
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
          					<strong>한국어</strong>
          				</li>
          				<li>
          					<strong>일본어</strong>
          				</li>
          			</ul>
        			<p>
        				일본에서 프로그래밍을 하고 있는 개발자 윤나기입니다. <br><br>
        				<strong>나기</strong>라는 닉네임은 중학교 시절에 좋아하던 만화 캐릭터를 따와서 지금까지 사용하고 있는 닉네임입니다. 앞으로 잘 부탁드리겠습니다.<br><br>
        				이 홈페이지를 만들게 된 계기는 개인적인 개발공부와 한국과 일본 개발자 사람들과 자유롭게 IT정보를 주고 받기 위해서 만들게 되었습니다.<br><br>
        				제가 비록 IT지식이 많이 부족하지만, 잘 부탁드립니다.<br><br>
        			</p>
        		</div>
      		</div>
      		<!-- /.row -->

      		<hr>

      		<!-- Call to Action Section -->
      		<div class="row mb-4">
        		<div class="col-md-8">
          			<p>궁금한 것이 있거나 따로 물어보고 싶은게 있다면 메일을 보내주세요.</p>
        		</div>
        		<div class="col-md-4">
          			<a class="btn btn-lg btn-secondary btn-block" href="#">주인장에게 메일 보내기</a>
        		</div>
      		</div>
      		
    	</div>
    	<!-- /.container -->
		
		<%@ include file="include/footer.jsp" %>
	</body>
</html>