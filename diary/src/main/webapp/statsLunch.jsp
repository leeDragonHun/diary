<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%
    System.out.println("==========statsLunch.jsp==========");


    String loginMember = (String)(session.getAttribute("loginMember"));
    if(loginMember == null){ // 즉, 로그오프 상태면.
        response.sendRedirect("/diary/diary.jsp");
        return; 
    }
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	String mySession = null;
	String sql2 = "select menu, count(*) cnt from lunch group by menu";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	rs2 = stmt2.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>식사 메뉴 통계</title>
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
	<h1>식사 메뉴 통계</h1>
	
	<%
				double maxHeight = 1000; // 차트의 최대 높이
				double totalCnt = 0; // 총투표 수 선언
				while(rs2.next()) { // sql2를 끝까지 반복
					totalCnt = totalCnt + rs2.getInt("cnt"); // 총투표수를 구하는 식
				}
				
				rs2.beforeFirst();
				// rs2.next를 한 번이라도 사용하면 ResultSet의 위치는 다음으로 넘어간다.
		        // rs2.next가 1~10이라면 2에서 구해지면 3으로 넘어가는데 그러지 않고 ResultSet의 처음위치로 돌아감.
		    %>
	<div class="fw-bold">
		전체 투표수 : <%=(int)totalCnt%>
	</div>
	<table  style="width: 500px;">
		<tr>
			<%	
			// c라는 배열을 만들고 색상값 넣기(나중에 menu 요소들의 색을 정해주기 위함 대신  i를 만들고 증가식 해주기)
				String[] c = {"#ABDEE6", "#CBAACB", "#FFFFB5", "#FFCCB6", "#F3B0C3"};
				int i = 0;
				while(rs2.next()) {
					// 요소 별 높이를 정하는 것임
                    // 내가정한 차트의 높이(maxHeight)에 그menu의 투표수 / 총 투표수 를 하면 전체대비 % 높이값으로 된다.
					int h = (int)(maxHeight * (rs2.getInt("cnt")/totalCnt));
			%>
					<td style="vertical-align: bottom;"><!-- 자식 div를 아래정렬로 -->
						<div style="height: <%=h%>px; 
									background-color:<%=c[i]%>;
									text-align: center"
                                    class="fw-bold m-3"
                                    ><!-- menu요소의 차트의 높이를 h로, 색상은 c배열의 값순서대로, 텍스트의 정렬은 가운데정렬  -->
							<%=rs2.getInt("cnt")%>
						</div>
					</td>
			<%		
					i = i+1; // 요소별로 배열에 있는 색상값 다르게 주기 위함.
				}
			%>
		</tr>
		<tr style="text-align: center" class="fw-bold">
			<%
				// 커스의 위치를 다시 처음으로
				rs2.beforeFirst();
							
				while(rs2.next()) {
			%>
					<td><%=rs2.getString("menu")%></td>
			<%		
				}
			%>
		</tr>
	</table>
</div>
</body>
</html>
<%
    // 자원반납
    conn.close();
%>