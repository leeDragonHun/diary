<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%
	System.out.println("==========diary.jsp==========");

	// 인증 우회 쿼리
	String sql1 = "select my_session mySession, on_date onDate, off_date offDate from login"; // 알리어스 별칭 사용
	
	// DB 연동
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");

	// DB 사용 준비
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	
	String mySession = null;
	String onDate = null;
	String offDate = null;
	if(rs1.next()){
		mySession = rs1.getString("mySession");
		onDate = rs1.getString("onDate");
		offDate = rs1.getString("offDate");
	}
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>diary</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Nanum+Myeongjo&display=swap" rel="stylesheet">
</head>
<style>
    a{ text-decoration: none; color: black; }

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
        width: 100vw;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
	}
	
	.loginBtn{
		background: url("./img/closermv.png") no-repeat center;
		background-size: cover;
		background-color: transparent;
        border: none;
        width: 60px;
        height: 85px;
        cursor: pointer;
	}

	.loginBtn:hover{
		background: url("./img/openrmv.png") no-repeat center;
		background-size: cover;
		background-color: transparent;
        border: none;
        width: 60px;
        height: 85px;
        cursor: pointer;
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
	
	.addDiaryBtn:hover{
		background: url("./img/book1.png") no-repeat center;
		background-size: 100%;
		background-color: transparent;
        border: none;
        width: 100px;
        height: 75px;
        cursor: pointer;
	}
	
	.logoutBtn{
		background: url("./img/exit1.png") no-repeat center;
		background-size: 100%;
		background-color: transparent;
        border: none;
        width: 100px;
        height: 75px;
        cursor: pointer;
	}
	
	.logoutBtn:hover{
		background: url("./img/exit2.png") no-repeat center;
		background-size: 100%;
		background-color: transparent;
        border: none;
        width: 100px;
        height: 75px;
        cursor: pointer;
	}

    .ab{
        position: absolute;
        top: 5px;
        left : 5px;
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

</style>
<body class="nanum-myeongjo-regular">


<%
	if(mySession.equals("OFF")){ // off 상태일 때의 html
%>
            <div class="abc">
    		    <div class="ab">
                    <button type="button" class="homeBtn" onclick="location.href='/diary/diary.jsp'"></button>
                    <button type="button" class="calBtn" onclick="location.href='/diary/diaryCalendar.jsp'"></button>
                    <button type="button" class="listBtn" onclick="location.href='/diary/diaryList.jsp'"></button>
                    <button type="button" class="outBtn" onclick="location.href='/diary/logout.jsp'"></button>
                    로그인상태 : <%=mySession %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;최근접속 : <%=onDate %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;최근종료 : <%=offDate %>
                </div>
            </div>
		    <!-- 본문 시작  -->
		    <div class="diaryBg p-5">
                
				<center>
					<span class="fs-1">< 오늘, 이 곳에서 </span><span class="fs-5">;감정 쓰레기통</span><span class="fs-1"> ></span>
				</center>			
				<br>
                
				<div class="text-center w-50">
		  		&nbsp;타인에게 스트레스, 미움, 분노, 죄책감 등 온갖 무거운 짐을 쏟아부어 본 적 있나요? 생각보다 흔히 일어나는 일이에요. 혼자서 미쳐 해결하지 못한 감정은 가슴속에 남아 있고 사람은 이것을 현명하게 다루지 못하죠. 맞아요. 이건 원래 어려운 일이에요. 그래서 제가 도와드릴게요. 자신을 털어내고 개운해지세요. 
		        <br><br>                                                     
		 		&nbsp;“걱정을 해서, 걱정이 없어지면, 걱정이 없겠네.” 어차피 없어지지 않을 걱정, 이곳에 적으면서 생각을 정립해봐요. 나를 불안하게 하는 것은 무엇인지, 나의 상황은 어떠한지 정리해 봐요. 그리고...
		 		</div>
		 		<br><br>
		 		<div class="d-flex justify-content-center">
		 			<h4>안 좋은 감정을 오늘, 이곳에 버리고 가세요...</h4>	
		 		</div>
		 		
		 		<br>
		 		
		 		<div class="d-flex justify-content-center">
					<form method="post" action="/diary/loginAction.jsp">
						<table>
							<tr>
								<td>계정&nbsp;&nbsp;</td>
								<td><input type="text" name="memberId"></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td rowspan='2'><button class="loginBtn" type="submit"></button></td>
							</tr>
							<tr>
								<td>암호&nbsp;&nbsp;&nbsp;</td>
								<td><input type="password" name="memberPw"></td>
								<td>&nbsp;&nbsp;</td>
							</tr>
						</table>
					</form>
		 		<br><br><br><br>
			  </div>
			</div>
		    <!-- 본문 끝 -->
<%		
		return;
	} 	else if(mySession.equals("ON")){ // ON 상태일 때의 html
%>
		    <div class="ab">
                <button type="button" class="homeBtn" onclick="location.href='/diary/diary.jsp'"></button>
                <button type="button" class="calBtn" onclick="location.href='/diary/diaryCalendar.jsp'"></button>
                <button type="button" class="listBtn" onclick="location.href='/diary/diaryList.jsp'"></button>
                <button type="button" class="outBtn" onclick="location.href='/diary/logout.jsp'"></button>
                로그인상태 : <%=mySession %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;최근접속 : <%=onDate %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;최근종료 : <%=offDate %>
            </div>
			    <!-- 본문 시작  -->
			    <div class="diaryBg p-5">

			    	<br><br><br><br><br>
					<center>
						<span class="fs-1">< 오늘, 이 곳에 </span><span class="fs-5">;감정 쓰레기통</span><span class="fs-1"> ></span>
					</center>			
					<br>
					<div class="text-center w-50">
			  		&nbsp;타인에게 스트레스, 미움, 분노, 죄책감 등 온갖 무거운 짐을 쏟아부어 본 적 있나요? 생각보다 흔히 일어나는 일이에요. 혼자서 미쳐 해결하지 못한 감정은 가슴속에 남아 있고 사람은 이것을 현명하게 다루지 못하죠. 맞아요. 이건 원래 어려운 일이에요. 그래서 제가 도와드릴게요. 자신을 털어내고 개운해지세요. 
			        <br><br>                                                     
			 		&nbsp;“걱정을 해서, 걱정이 없어지면, 걱정이 없겠네.” 어차피 없어지지 않을 걱정, 이곳에 적으면서 생각을 정립해봐요. 나를 불안하게 하는 것은 무엇인지, 나의 상황은 어떠한지 정리해 봐요. 그리고...
			 		</div>
			 		<br><br>
			 		<div class="d-flex justify-content-center">
			 			<h4>안 좋은 감정을 오늘, 이곳에 버리고 가세요...</h4>	
			 		</div>
			 		
			 		<br>
			 		
			 		<div class="d-flex justify-content-center">
			 			<table>
			 				<tr>
			 					<td>	
		 							<button type="button" class="addDiaryBtn" onclick="location.href='/diary/addDiaryForm.jsp'"></button>
		 						</td>
		 						<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			 					<td>
			 						<button type="button" class="logoutBtn" onclick="location.href='/diary/logout.jsp'"></button>
			 					</td>
			 				</tr>
			 			</table>
			 		</div>
			 		<br><br><br><br>
			    </div>
			    <!-- 본문 끝 -->
			    
<%
	}
%>
</body>
</html>