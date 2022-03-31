<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<% request.setCharacterEncoding("utf-8"); %><!-- 넘어온 한글자료 깨지지 않도록 -->
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 패스워드 변경</title>
</head>
<body>

	<%
	PrintWriter script = response.getWriter();
	
	//로그인상태 확인
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID=(String)session.getAttribute("userID");
	}
	
	// 현재 패스워드
	String oldPassword = null;
	if(request.getParameter("oldPassword") != null){
		oldPassword = request.getParameter("oldPassword");
	}
	// 새로운 패스워드
	String newPassword1 = null;
	if(request.getParameter("newPassword1") != null){
		newPassword1 = request.getParameter("newPassword1");
	}
	// 새로운 패스워드2
	String newPassword2 = null;
	if(request.getParameter("newPassword2") != null){
		newPassword2 = request.getParameter("newPassword2");
	}
	
	
	//로그인중일때 로그인방지
	if(userID == null){
		script.println("<script>");
		script.println("alert('회원전용 기능입니다.')");
		script.println("location.href='./main.jsp'");
		script.println("</script>");
	}else if(newPassword1.equals(newPassword2)){	
		// 로그인 상태, 새로운 패스워드 일치
		UserDAO userDAO = new UserDAO();
		int result = userDAO.updateUser(userID, oldPassword, newPassword1);
		
		if(result == 1){
			// 변경성공(1)
			script.println("<script>");
			script.println("alert('회원정보 변경 완료')");
			script.println("location.href='./main.jsp'");
			script.println("</script>");
		}else if(result == -1){
			// 현재패스워드 다를때(-1)
			script.println("<script>");
			script.println("alert('현재 패스워드를 확인하세요')");
			script.println("history.back()");
			script.println("</script>");
		}else if(result == -2){
			// 변경패스워드 현재패스워드 같을때(-2)
			script.println("<script>");
			script.println("alert('새로운 패스워드는 이전 패스워드와 달라야 합니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			// 데이터베이스 오류(-3)
			script.println("<script>");
			script.println("alert('알수없는 오류가 발생했습니다. 관리자에게 문의하세요.')");
			script.println("location.href='./main.jsp'");
			script.println("</script>");
		}

		
	}else{
		script.println("<script>");
		script.println("alert('새로운 패스워드가 일치하지 않습니다')");
		script.println("history.back()");
		script.println("</script>");	
	}
	

	%>

</body>
</html>
