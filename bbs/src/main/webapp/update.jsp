<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>웹게시판</title>
    <link rel="stylesheet" href="./css/update.css">

</head>
<body>
  <%
		String userID = null;
		if(session.getAttribute("userID") != null){
			// 로그인 중
			userID = (String)session.getAttribute("userID");
		}
	%>

    <div class="wrap">
        <header class="header">
            <div class="container">
                <nav class="nav">
                    <ul class="gbl-nav">                        
                        <li class="nav-left">
                            <ul>
                                <li class="logo"><a href="./main.jsp">게시판 만들기</a></li>
                                <li><a href="./main.jsp" class="active">메인</a></li>
                                <%
                                	if(userID !=null){
                                %>		
                                <li><a href="./notice.jsp">게시판</a></li>
                                <%	
                                	}
                                %>
                                
                                
                            </ul>    
                        </li>
                        <li class="nav-right">
                            <ul>
                            	<%
                            		if(userID == null){                      			
                            	%>
	                            	<!-- 로그인 아님 -->
	                            	<li><a href="./login.jsp">로그인</a></li>
	                                <li><a href="./join.jsp">회원가입</a></li>
                            	<%
                            		}else{
                            	%>
                            		<!-- 로그인 중 -->
                            		<li><a href="./logoutAction.jsp">로그아웃</a></li>
                            	<%
                            		}
                            	%>

                            </ul>
                        </li>
                    </ul>
                </nav>
            </div>
        </header>
        <section class="sec main-sec">
            <div class="container">
                <div class="contents clearfix">
                    <div class="sec-tit">글수정</div>
                    <form action="#" method="post">
                        <div class="table">
                            <div class="n-tit">
                                제목
                                <br>
                                <input type="text" name="noticeTit" id="noticeTit" value="문의드립니다.">
                            </div>
                            <div class="n-content">
                                내용
                                <br>
                                <textarea name="noticeContent" id="noticeContent">Lorem ipsum dolor sit amet consectetur, adipisicing elit. Vel iusto nihil iure molestias labore laborum, deserunt rem illo veniam vitae velit, illum id cupiditate quas libero, reprehenderit earum autem corrupti.
                                </textarea>
                            </div>
                        </div>
                        <div class="g-btn">
                            <input type="submit" value="수정완료">
                        </div>
                    </form>      
                </div>       
            </div>
        </section>
        <footer class="footer">
            <div class="container">
                <address>
                    Copyright CHO
                </address>
            </div>
        </footer>
    </div>
</body>
</html>