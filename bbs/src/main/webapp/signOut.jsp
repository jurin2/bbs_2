<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css">
<title>JSP를 이용한 게시판 만들기</title>

</head>
<body>
	<% 
		PrintWriter script=response.getWriter();
		
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID == null){
			script.println("<script>");
			script.println("alert('회원전용 페이지입니다.')");
			script.println("location.href='./main.jsp'");
			script.println("</script>");
		}
		
		User user=new UserDAO().getUser(userID);
	
	%>
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
						<form method="post" action="./signOutAction.jsp">
							<h2 style="text-align:center">회원 탈퇴</h2>		
							<div class="form-group">
								<label>사용자명
									<input type="text" class="form-control" name="userName" value="<%= user.getUserName() %>" disabled>
								</label>
							</div>
							<div class="form-group">
								<label>아이디
									<input type="text" class="form-control" name="userID" value="<%= user.getUserID() %>" disabled>
								</label>
							</div>
							<div class="form-group">
								<label>패스워드
									<input type="password" class="form-control" name="userPassword">
								</label>
							</div>
							<div class="form-group">
								<label>패스워드확인
									<input type="password" class="form-control" name="userPassword1">
								</label>
							</div>
							
							<input type="submit" value="회원탈퇴" class="btn btn-danger form-control">
							<input type="button" value="취소" class="btn btn-success form-control" onClick="location.href='./main.jsp'">
							
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