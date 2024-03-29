<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%
    String loginMember = (String)(session.getAttribute("loginMember"));
    System.out.println("loginMember : "+ loginMember);
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
<%
	if(loginMember != null){ // on 상태일 때의 html
%>
            <div class="ab">
                <button type="button" class="homeBtn" onclick="location.href='/diary/diary.jsp'"></button>
                <button type="button" class="calBtn" onclick="location.href='/diary/diaryCalendar.jsp'"></button>
                <button type="button" class="listBtn" onclick="location.href='/diary/diaryList.jsp'"></button>
                <button type="button" class="voteBtn" onclick="location.href='/diary/voteForm.jsp'"></button>
            </div>
            <div class="ab-r">
                <button type="button" class="outBtn" onclick="location.href='/diary/logout.jsp'"></button>
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
<%		
		return;
	} 	else { // off 상태나 그밖의 모든 상황 시...
%>
            
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
		 			<h4>안 좋은 감정을 오늘, 이곳에 버리고 가세요.</h4>	
		 		</div>
		 		
		 		<br>
		 		
		 		<div class="d-flex justify-content-center">
					<form method="post" action="/diary/loginAction.jsp">
						<table>
                            <tr>    
                                <td colspan='2' style="text-align: center;">먼저 로그인을 하세요.</td>
                            </tr>
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
<%
	}
%>
</body>
</html>
