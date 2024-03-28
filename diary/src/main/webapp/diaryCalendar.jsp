<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import = "java.util.*" %>
<%
	System.out.println("==========diaryCalendar.jsp==========");
	// DB 연동 관련
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");

	// DB 사용 준비
	String sql1 = "select my_session mySession from login";
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();	
	String mySession = null;
	if(rs1.next()){
		mySession = rs1.getString("mySession");
	}
	
	if(mySession.equals("OFF")) {
		response.sendRedirect("/diary/diary.jsp");
		return;
	}
%>
<%
	// 24년 3월 25일이 오늘인 것으로 설명된 주석임.
	
	// 타겟 년, 월
	String targetYear = request.getParameter("targetYear");
	String targetMonth = request.getParameter("targetMonth");
	
	Calendar target = Calendar.getInstance(); // 디폴드값으로 오늘 날짜가 들어간다.

	// 오늘 날짜 뽑는 코드
	// 밑에 tYear, tMonth는 제어문안에서 값이 바뀌기에
	// toYear 등의 변수를 만들어 오늘 날짜가 값이 안 바뀌어서 달력에 오늘이 적용되게 하기 위함.
	int toYear = target.get(Calendar.YEAR);
	int toMonth = target.get(Calendar.MONTH);
	int toDate = target.get(Calendar.DATE);
	
	
	if(targetYear != null || targetMonth != null){//타켓년, 타겟월이 null이 아닐때 출력
		target.set(Calendar.YEAR, Integer.parseInt(targetYear));//연도부터 해야함. 마이너스값이 들어오면 연도가 바뀜.
		target.set(Calendar.MONTH, Integer.parseInt(targetMonth));
	}
	
	// 달력 타이틀로 출력할 변수(달력제목행에 들어갈 몇년도 몇월달력인지.)
	int tYear = target.get(Calendar.YEAR);
	int tMonth = target.get(Calendar.MONTH);
	
	// 첫줄 공백의 개수는 그달 1일의 요일에서 -> 요일에 맵핑된 숫자 -> 타겟 날짜를 1일로 변경
	// 타겟의 날짜를 1일로 바꾸고 그 날짜의 요일값을 알아내기위함.
	target.set(Calendar.DATE, 1);
	//2024-03-01
	
	int yoNum = target.get(Calendar.DAY_OF_WEEK); // 일: 1 ~ 토: 7
	//6
	System.out.println(yoNum);
	
	// 시작공백의 개수 : 예를들어 수요일이면 수요일 값이 4니까 -1 하면 3. 일월화칸인 3칸이 공백임. 아래는 그 코드임.
	int startBlank = yoNum -1;
	//5
	int lastDate = target.getActualMaximum(Calendar.DATE); // target달의 마지막 날짜 반환
	//31
	
	//for문의 갯수(이달의 공백칸 + 이번달의 날짜 갯수)
	int countDiv = startBlank + lastDate;
	//5+31 = 36
%>	
<%
	// DB에서 tYear와 tMonth에 해당되는 diary목록 추출
	// 이번달만 하면 되지만 몇년도의 이번달인지가 필요하기에 tYear도 필요함.
	String sql2 = "select diary_date diaryDate, day(diary_date) day, left(title,3) title from diary where year(diary_date)=? and month(diary_date)=?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, tYear);
	stmt2.setInt(2, tMonth+1); // Month는 0부터 시작해서 1월. 까먹지 말기.
	System.out.println(stmt2);
	
	rs2 = stmt2.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>diaryCalendar</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Nanum+Myeongjo&display=swap" rel="stylesheet">
</head>
<style>
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
		
	.yo{
			float: left;
			width: 70px; height: 20px;
			background-color:transparent;
			border-radius: 5px;
			margin: 5px;
		}
		
	.sun {
			clear: both; /* float의 영향을 받지 않도록 설정  */
			color: #FF0000;
		}
		
	.sat{
			color: #0000FF;	
		}
		
			/* 각셀 */
	.cell {
			float:left;
			background-color:transparent;
			width: 70px; height: 70px;
			border-radius: 10px;
			margin: 5px;
			font-family: "Akaya Telivigala", system-ui;
		}
		

		
	a{ text-decoration: none; color: black;}
	
	.nanum-myeongjo-regular {
	 	font-family: "Nanum Myeongjo", serif;
		font-weight: 400;
		font-style: normal;
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

		<div class="diaryBg px-1">
			
			<!-- 메인 시작 -->
			<!-- 몇년 몇월 인지(Month는 0이 1월임 그래서 +1  -->
			<div class="center fs-1"><%=tYear%>&nbsp;&nbsp;<%=tMonth+1%></div>
			
			<!-- 전달 다음달 화살표 -->
			<container>
			<container class="d-flex justify-content-between">
				<item>
					<a href="./diaryCalendar.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth-1%>">&nbsp; &#129044;</a>
				</item>
				<item>
					<a href="./diaryCalendar.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth+1%>">&#129046;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
				</item>
			</container>
			<br>
			<div class="yo sun">Sun</div>
			<div class="yo">Mon</div>
			<div class="yo">Tue</div>
			<div class="yo">Wed</div>
			<div class="yo">Thu</div>
			<div class="yo">Fri</div>
			<div class="yo sat">Sat</div>
			</container>
			
			<container class="space">
						<!-- DATE값이 들어갈 DIV -->
			<%
				for(int i=1; i<=countDiv; i++){
					if(i%7 == 1){
			%>
						<div class="cell sun">
			<%			
					} else if(i%7 == 0){
			%>
						<div class="cell sat">
			<%			
					} else {
			%>
						<div class="cell">
			<%			
					}
				
					if(i-startBlank > 0) {
						%>
								<%=i-startBlank%><br>
						<%
								// 현재날짜(i-startBlank)의 일기가 rs2목록에 있는지 비교
								while(rs2.next()) {
									// 날짜에 일기가 존재한다
									if(rs2.getInt("day") == (i-startBlank)) {
						%>
										<div>
											<a href='/diary/diaryOne.jsp?diaryDate=<%=rs2.getString("diaryDate")%>'>
												<%=rs2.getString("title")%>...
											</a>
										</div>
						<%				
										break;
									}
								}
								rs2.beforeFirst(); // ResultSet의 커스 위치를 처음으로...
							} else {
						%>
								&nbsp;
						<%		
							}
						%>
					</div>
			<%		
				}//조상 for문 닫는 가로
			%>
							</div>	
						</div>
			</container>
			<!-- 메인 끝 -->
			
			
		</div>
</body>
</html>