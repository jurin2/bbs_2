<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %><!-- 사용자 라이브러리 -->
<%@ page import="bbs.Bbs" %><!-- 사용자 라이브러리 -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바에서 자바스크립트 사용 -->
<%@ page import="java.util.ArrayList" %>

<% request.setCharacterEncoding("utf-8"); %><!-- 넘어온 한글자료 깨지지 않도록 -->    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css">
<title>JSP를 이용한 게시판 만들기</title>

</head>
<body>

	<%
		//로그인상태 확인
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID=(String)session.getAttribute("userID");
		}
		
		int pageNumber=1;
		// 페이지 번호
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
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
			<div class="container">
				<table>
					<thead>
						<tr>
							<th style="width:10%;background-color:#aaa;text-align:center;font-size:18px;">문서번호</th>
							<th style="width:60%;background-color:#aaa;text-align:center;font-size:18px;">제목</th>
							<th style="width:15%;background-color:#aaa;text-align:center;font-size:18px;">작성자</th>
							<th style="width:15%;background-color:#aaa;text-align:center;font-size:18px;">작성일</th>							
						</tr>	
					</thead>
					<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for(int idx=0; idx<list.size(); idx++){
					%>
						<tr>
							<td><%= list.get(idx).getBbsID() %></td>
							<td><%= list.get(idx).getBbsTitle() %></td>
							<td><%= list.get(idx).getUserID() %></td>
							<td><%= list.get(idx).getBbsDate() %></td>							
						</tr>
					<%
						}
					%>
					</tbody>					
				</table>
				<%
					if(pageNumber>1){
				%>
				<a href="bbs.jsp?pageNumber=<%= pageNumber - 1 %>" class="btn btn-success">이전</a>
				<%} %>
				<%
					if(bbsDAO.nextPage(pageNumber+1)){
				%>
				<a href="bbs.jsp?pageNumber=<%= pageNumber + 1 %>" class="btn btn-success">다음</a>
				<%} %>
				<a href="./write.jsp" class="btn btn-success">글쓰기</a>
			</div>
			
		</section>
		
	</section>
	
	
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js"></script>
</body>
</html>