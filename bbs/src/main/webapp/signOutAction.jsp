<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<% request.setCharacterEncoding("utf-8"); %><!-- 넘어온 한글자료 깨지지 않도록 -->
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
</head>
<body>

	<%
	PrintWriter script = response.getWriter();
	
	//로그인상태 확인
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID=(String)session.getAttribute("userID");
	}
	
	// userPassword 초기화하고 request가 존재한다면 userPassword를 셋팅
	String userPassword = null;
	if(request.getParameter("userPassword") != null){
		userPassword = request.getParameter("userPassword");
	}	
	//존재하지않는 또는 잘못된 접근처리
		if(userID == null ){
			script.println("<script>");
			script.println("alert('잘못된 접근입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		
		//로그인중일때 로그인방지
		if(userID == null){
			script.println("<script>");
			script.println("alert('회원전용 기능입니다.')");
			script.println("location.href='./main.jsp'");
			script.println("</script>");
		}else{	
			UserDAO userDAO = new UserDAO();
			int result = userDAO.deleteUser(userID,userPassword);
			//탈퇴성공
			if(result == 1){
				script.println("<script>");
				script.println("alert('회원탈퇴 성공')");
				script.println("location.href='./logoutAction.jsp'");
				script.println("</script>");
			}else{
				script.println("<script>");
				script.println("alert('회원탈퇴 실패')");
				script.println("history.back()");
				script.println("</script>");
			}
			
		}
	
	
	%>

</body>
</html>