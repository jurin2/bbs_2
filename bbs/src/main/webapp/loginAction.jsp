<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %> <!-- 사용자 라이브러리 -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바에서 자바스크립트 사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 넘어온 한글자료 깨지지 않도록 하기위함 -->

<jsp:useBean id="user" class="user.User" scope="page"/> <!-- class를 자바빈즈로 사용함 / 이름은 id에서 설정한 이름으로 -->
<jsp:setProperty name="user" property="userID"/> <!-- 로그인 페이지에서 받아온 userID를 User.userID에 저장 -->
<jsp:setProperty name="user" property="userPassword"/> <!-- 로그인 페이지에서 받아온 userPassword를 User.userPassword에 저장 -->


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<%
		PrintWriter script = response.getWriter();
		
		//로그인상태 확인
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID=(String)session.getAttribute("userID");
		}
		
		//로그인중일때 로그인방지
		if(userID != null){
			script.println("<script>");
			script.println("alert('로그인 상태 입니다.')");
			script.println("location.href='./main.jsp'");
			script.println("</script>");
		}
	
	
		/* 자료입력 확인 */
		if(user.getUserID() == null || user.getUserPassword() == null){
			script.println("<script>");
			script.println("alert('아이디와 패스워드를 확인하세요')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			UserDAO userDAO = new UserDAO();
			
			int result = userDAO.login(user.getUserID(),user.getUserPassword());
			script.println("<script>");
			
			if(result == 1){
				//세션을 생성
				session.setAttribute("userID",user.getUserID());
				
				script.println("alert('로그인 성공')");
				script.println("location.href='./main.jsp'");
			}else if(result == -1) {
				script.println("alert('패스워드를 확인하세요')");
				script.println("history.back()");
			}else if(result == -2){	
				script.println("alert('아이디를 확인하세요')");
				script.println("history.back()");
			}else if(result == -3){	
				script.println("alert('데이터베이스 오류')");
				script.println("history.back()");
			}
			
			script.println("</script>");
		}
	%>

</body>
</html>