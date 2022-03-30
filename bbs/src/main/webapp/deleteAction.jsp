<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %><!-- 사용자 라이브러리 -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바에서 자바스크립트 사용 -->
<% request.setCharacterEncoding("utf-8"); %><!-- 넘어온 한글자료 깨지지 않도록 -->



    
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
		
		//넘어온 bbsID를 초기화하고 request가 존재한다면 bbsID로 셋팅
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		
		//존재하지않는 또는 잘못된 접근처리
		if(bbsID == 0 ){
			script.println("<script>");
			script.println("alert('잘못된 접근입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		
		//로그인중일때 로그인방지
		if(userID == null){
			script.println("<script>");
			script.println("alert('로그인후 작성 가능합니다. 로그인페이지로 이동합니다.')");
			script.println("location.href='./login.jsp'");
			script.println("</script>");
		}else{	
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.delete2(userID,bbsID);
			//삭제오류
			if(result == 1){
				script.println("<script>");
				script.println("alert('글 삭제에 성공')");
				script.println("location.href='./bbs.jsp'");
				script.println("</script>");
			}else{
				script.println("<script>");
				script.println("alert('사용자를 확인하세요')");
				script.println("location.href='./bbs.jsp'");
				script.println("</script>");
			}
			
		}
			
	%>
</body>
</html>