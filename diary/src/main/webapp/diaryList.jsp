<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	// 0. 로그인(인증) 분기
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	
	String sql1 = "select my_session mySession from login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	String mySession = null;
	if(rs1.next()) {
		mySession = rs1.getString("mySession");
	}
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	if(mySession.equals("OFF")) {
		String errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
	}
%>	
<%
	// 출력 리스트 모듈
	int currentPage = 1;
    System.out.println("currentPage : " + currentPage);
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	/*
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	*/
	
	int startRow = (currentPage-1)*rowPerPage; // 1-0, 2-10, 3-20, 4-30,....
	
	String searchWord = "";
	if(request.getParameter("searchWord") != null) {
		searchWord = request.getParameter("searchWord");
	}
	/*
		select diary_date diaryDate, title
		from diary
		where title like ?
		order by diary_date desc
		limit ?, ?
	*/
	String sql2 = "select diary_date diaryDate, title from diary where title like ? order by diary_date desc limit ?, ?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, "%"+searchWord+"%");
	stmt2.setInt(2, startRow);
	stmt2.setInt(3, rowPerPage);
	rs2 = stmt2.executeQuery();
%>

<%
	// lastPage 모듈
	String sql3 = "select count(*) cnt from diary where title like ?";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	stmt3 = conn.prepareStatement(sql3);
	stmt3.setString(1, "%"+searchWord+"%");
	rs3 = stmt3.executeQuery();
	int totalRow = 0;
	if(rs3.next()) {
		totalRow = rs3.getInt("cnt");
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Nanum+Myeongjo&display=swap" rel="stylesheet">
</head>
<style>
    .ab{
        position: absolute;
        top: 5px;
        left : 5px;
    }
    
    .nanum-myeongjo-regular {
        font-family: "Nanum Myeongjo", serif; 
        font-weight: 400; 
        font-style: normal; 
    }
    
    .diaryBg {
        background: url("./img/bg4.jpg");
        background-size: cover;
        background-position: center;
        height: 100vh;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        }
    
    a{ text-decoration: none; color: black; }
    
    .bgNo{
        background-color:transparent;
    }

    .homeBtn{
		background: url("./img/home1.png") no-repeat center;
		background-size: 100%;
		background-color: transparent;
        border: none;
        width: 50px;
        height: 50px;
        cursor: pointer;
    }
    .homeBtn:hover{
		background: url("./img/home2.png") no-repeat center;
		background-size: 100%;
		background-color: transparent;
        border: none;
        width: 50px;
        height: 50px;
        cursor: pointer;
    }
    
    .calBtn{
		background: url("./img/cal1.png") no-repeat center;
		background-size: 100%;
		background-color: transparent;
        border: none;
        width: 50px;
        height: 50px;
        cursor: pointer;
    }
    .calBtn:hover{
		background: url("./img/cal2.png") no-repeat center;
		background-size: 100%;
		background-color: transparent;
        border: none;
        width: 50px;
        height: 50px;
        cursor: pointer;
    }
    
    .listBtn{
		background: url("./img/list1.png") no-repeat center;
		background-size: 100%;
		background-color: transparent;
        border: none;
        width: 50px;
        height: 50px;
        cursor: pointer;
    }
    .listBtn:hover{
		background: url("./img/list2.png") no-repeat center;
		background-size: 100%;
		background-color: transparent;
        border: none;
        width: 50px;
        height: 50px;
        cursor: pointer;
    }
    
    .outBtn{
		background: url("./img/out1.png") no-repeat center;
		background-size: 100%;
		background-color: transparent;
        border: none;
        width: 50px;
        height: 50px;
        cursor: pointer;
    }
    .outBtn:hover{
		background: url("./img/out2.png") no-repeat center;
		background-size: 100%;
		background-color: transparent;
        border: none;
        width: 50px;
        height: 50px;
        cursor: pointer;
    }
    .sear{
        background: url("./img/sear.png") no-repeat center;
        background-size: 100%;
        background-color: transparent;
        border: none;
        width: 30px;
        height: 25px;
        cursor: pointer;
    }
    .re1{
        background: url("./img/re1.png") no-repeat center;
        background-size: 100%;
        background-color: transparent;
        border: none;
        width: 30px;
        height: 25px;
        cursor: pointer;
    }
    
</style>
<body class="nanum-myeongjo-regular">

<div class="ab">
    <button type="button" class="homeBtn" onclick="location.href='/diary/diary.jsp'"></button>
    <button type="button" class="calBtn" onclick="location.href='/diary/diaryCalendar.jsp'"></button>
    <button type="button" class="listBtn" onclick="location.href='/diary/diaryList.jsp'"></button>
    <button type="button" class="outBtn" onclick="location.href='/diary/logout.jsp'"></button>
</div>

<div class="diaryBg px-5 ">
	<h1>버린 것들</h1>
    <hr>
	<table class="bgNo">
		<tr>
			<th style="width: 200px;">날짜</th>
			<th>제목</th>
		</tr>
		<%
			while(rs2.next()) {
		%>
				<tr>
					<td><a href="/diary/diaryOne.jsp?diaryDate=<%=rs2.getString("diaryDate") %>"><%=rs2.getString("diaryDate")%></a></td>
					<td><a href="/diary/diaryOne.jsp?diaryDate=<%=rs2.getString("diaryDate") %>"><%=rs2.getString("title")%></a></td>
				</tr>
		<%		
			}
		%>
	</table>
	
	<div>
    <br>
    <%
        if(currentPage == 1){
    %>        
		<a>이전</a>
		<a href="/diary/diaryList.jsp?currentPage=<%=currentPage+1%>">다음</a>
    <%
        } else if (currentPage == lastPage){
    %>
		<a href="/diary/diaryList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<a>다음</a>
    <%        
        }
    %>
	</div>
    <br>
	<form method="get" action="/diary/diaryList.jsp">
		<div>
            <input type="text" name="searchWord" style="background-color: transparent; border: none;" placeholder="제목을 검색하세요.">
			<button class="sear" type="submit"></button>
            <button class="re1" type="button" class="" onclick="location.href='/diary/diaryList.jsp'"></button>
		</div>
	</form>
</div>    
</body>
</html>