<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
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
		//로그인상태 확인
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID=(String)session.getAttribute("userID");
		}
		
		if(userID == null){
			script.println("<script>");
			script.println("alert('로그인후 이용 가능합니다.')");
			script.println("location.href='./login.jsp'");
			script.println("</script>");
		}
		
		
		//bbs인스턴스 생성
		User user = new UserDAO().getUser(userID);
		
		
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
							<%
							if(userID == null){
							%>	
							<ul class="dropdown-menu">
								<li class="active"><a href="./login.jsp">로그인</a></li>
								<li><a href="./join.jsp">회원가입</a></li>
							</ul>
							<%}else{ %>
							<ul class="dropdown-menu">
								<li class="active"><a href="./logoutAction.jsp">로그아웃</a></li>								
							</ul>
							<%} %>
						</li>
					</ul>
				</div>
			</nav>
		</header>
	
	
		<!-- 페이지별 컨텐츠 영역 시작 -->
		<section>
			<!-- 글읽기 양식 -->
			<div class="container">
				<div class="col-lg-12">
					<div class="jumbotron" style="margin-top:20px;padding-top:30px">
						<h2 style="text-align:center">마이페이지</h2>		
						<div>
							<span>사용자명</span>
							<span><%= user.getUserName() %></span>
							<br>
							<span>아이디</span>
							<span><%=  user.getUserID() %></span>
							<br>
							<span>패스워드</span>
							<span>***************</span>
							<br>
							<span>성별</span>
							<span><%= user.getUserGender() %></span>
							<br>
							<span>이메일</span>
							<span><%= user.getUserEmail() %></span>
							<br>
						</div>
					</div>
					<div class="button-group">
						<a href="./changePassword.jsp" class="btn btn-success">패스워드 변경</a>
						<a href="./signOut.jsp" class="btn btn-success">회원탈퇴</a>
						<a href="./main.jsp" class="btn btn-success">확인</a>
					</div>
				</div>
			</div>
		</section>
		
	</section>
	
	
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js"></script>
</body>
</html>