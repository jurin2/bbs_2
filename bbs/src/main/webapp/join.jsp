<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css">
<title>JSP를 이용한 게시판 만들기</title>

</head>
<body>
	<section class="wrap">
		<!-- 공통 영역  -->
		<header>
			<nav class="navbar navbar-default">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
						aria-expanded="false">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="./main.jsp">JSP를 이용한 게시판 만들기</a>
				</div>
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
						<li><a href="./main.jsp">메인</a></li>
						<li><a href="./bbs.jsp">게시판</a></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle"
								data-toggle="dropdown" role="button" aria-haspopup="true"
								aria-expanded="false">접속하기<span class="caret"></span></a>
								
							<ul class="dropdown-menu">
								<li class="active"><a href="./login.jsp">로그인</a></li>
								<li><a href="./join.jsp">회원가입</a></li>
							</ul>
							
							<ul class="dropdown-menu" style="display:none">
								<li class="active"><a href="./logoutAction.jsp">로그아웃</a></li>								
							</ul>
						</li>
					</ul>
				</div>
			</nav>
		</header>
	
	
		<!-- 페이지별 컨텐츠 영역 시작 -->
		<section>
			<!-- 로그인 양식 -->
			<div class="container">
				<div class="col-lg-12">
					<div class="jumbotron" style="margin-top:20px;padding-top:30px">
						<form method="post" action="./joinAction.jsp">
							<h2 style="text-align:center">회원가입</h2>		
							<div class="form-group">
								<input type="text" placeholder="아이디" class="form-control" name="userID">
							</div>
							<div class="form-group">
								<input type="password" placeholder="패스워드" class="form-control" name="userPassword">
							</div>
							<div class="form-group">
								<input type="text" placeholder="성명" class="form-control" name="userName">
							</div>
							<div class="form-group" style="text-align:center">
								<label class="btn btn-primary">								
									<input type="radio" name="userGender" value="남" checked> 남자
								</label>
								<label class="btn btn-primary">
									<input type="radio" name="userGender" value="여"> 여자
								</label>
								
							</div>
							<div class="form-group">
								<input type="email" placeholder="이매일" class="form-control" name="userEmail">
							</div>
							<input type="submit" value="회원가입" class="btn btn-primary form-control">
						</form>
					</div>
				</div>
			</div>
		</section>
		
	</section>
	
	
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js"></script>
</body>
</html>
