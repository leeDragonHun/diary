<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	System.out.println("==========updateDiaryForm.jsp==========");


    String loginMember = (String)(session.getAttribute("loginMember"));
    if(loginMember == null){ // 즉, 로그오프 상태면.
        response.sendRedirect("/diary/diary.jsp");
        return; 
    }

	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");

	String diaryDate = request.getParameter("diaryDate");
	String title = request.getParameter("title");
	String weather = request.getParameter("weather");
	String content = request.getParameter("content");
    System.out.println("diaryDate : " + diaryDate);
    System.out.println("title : " + title);
    System.out.println("weather : " + weather);
    System.out.println("content : " + content);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>updateDiaryForm</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Nanum+Myeongjo&display=swap" rel="stylesheet">
</head>
<style>
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
		
	.addDiaryBtn{
		background: url("./img/book2.png") no-repeat center;
		background-size: 100%;
		background-color: transparent;
        border: none;
        width: 100px;
        height: 75px;
        cursor: pointer;
	}
    
    a{ text-decoration: none; color: black; }
	
	.addDiaryBtn:hover{
		background: url("./img/book1.png") no-repeat center;
		background-size: 100%;
		background-color: transparent;
        border: none;
        width: 100px;
        height: 75px;a
        cursor: pointer;
	}

    .ab{
        position: absolute;
        top: 5px;
        left : 5px;
    }
    
    .ab-r{
        position: absolute;
        top: 5px;
        right : 5px;
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
    .voteBtn{
        background: url("./img/vote1.png") no-repeat center;
        background-size: 100%;
        background-color: transparent;
        border: none;
        width: 50px;
        height: 50px;
        cursor: pointer;
    }
    .voteBtn:hover{
        background: url("./img/vote2.png") no-repeat center;
        background-size: 100%;
        background-color: transparent;
        border: none;
        width: 50px;
        height: 50px;
        cursor: pointer;
    }
</style>
<body class="nanum-myeongjo-regular">

    <div class="ab">
        <button type="button" class="homeBtn" onclick="location.href='/diary/diary.jsp'"></button>
        <button type="button" class="calBtn" onclick="location.href='/diary/diaryCalendar.jsp'"></button>
        <button type="button" class="listBtn" onclick="location.href='/diary/diaryList.jsp'"></button>
        <button type="button" class="voteBtn" onclick="location.href='/diary/voteForm.jsp'"></button>
    </div>
    <div class="ab-r">
        <button type="button" class="outBtn" onclick="location.href='/diary/logout.jsp'"></button>
    </div>
    
	<div class="diaryBg px-5 ">
	<!-- 메인 시작 -->	
			
		<div class="fs-1">다시 생각하기</div>
		<br>
		<!-- 날짜가능확인을 통해 그 날짜에 일기가 있는지 없는지 확인해서 오늘 일기 작성할 수 있는지 없는지. -->

		
		<form method="post" action="/diary/updateDiaryAction.jsp">
			<span>
				날짜 :
                <input value="<%=diaryDate %>" type="text" name="diaryDate" readonly="readonly" style="background-color: transparent; border: none;">
			</span>
			<span>
				제목 : <input value="<%=title %>" type="text" name="title" style="background-color: transparent; border: none;">
			</span>
			<span>
                <select name="weather" style="background-color: transparent; border: none;">
				    <option value="희">희&#128513;</option>
				    <option value="노">노&#128545;</option>
				    <option value="애">애&#128557;</option>
				    <option value="락">락&#128526;</option>
				</select>
			</span>
			
			<br><br>
						
			<span>
				 <textarea style="width:100%; background-color: transparent; border: none;" rows="10" cols="20" name="content"><%=content %></textarea>
			</span>
			<br>
			<span style="display: flex; justify-content: center;">
				<button type="submit" class="addDiaryBtn"></button>
			</span>
		</form>
		
	<!-- 메인 끝 -->	
	
	<br>
	</div>
</body>
</html>
<%
    // 자원반납
    conn.close();
%>