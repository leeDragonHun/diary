<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
    System.out.println("==========diaryOne.jsp==========");

    //  diaryDate 불러오기
    String diaryDate = request.getParameter("diaryDate");
	System.out.println("diaryDate : " + diaryDate);

	// DB 연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");

	// DB로 사용할 것 선언
	String sql1 = "select my_session mySession from login"; // 로그인 on/off 확인, 별칭사용
	String sql2 = "SELECT * FROM diary WHERE diary_date = ?"; // diaryDate 의 일기 불러오기
	PreparedStatement stmt1 = null;
	PreparedStatement stmt2 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
    
	// SQL에 값 넣을 준비
	stmt1 = conn.prepareStatement(sql1);
	stmt2 = conn.prepareStatement(sql2);
    
	//로그인 인증 우회 처리 준비
	rs1 = stmt1.executeQuery(); // ResultSet의 결과 불러오기
	String mySession = null; // rs1 실행문에 들어갈 변수 선언
	if(rs1.next()){ // rs1실행, 즉 로그인분기문 쿼리 실행(실행되면의 조건을 아래 기입)
		mySession = rs1.getString("mySession"); // String mySession에 db에서 불러온 my_session 값 넣기
	}
	
	//로그인 인증 우회 처리 실행
	if(mySession.equals("OFF")) {
		response.sendRedirect("/diary/diary.jsp");
		return; // 인증 우회로 접속하였기 때문에 코드 진행을 더이상 못 하게 해준 것이다.
	}
	
	// SQL2에 값 넣기
	stmt2.setString(1, diaryDate);
    
	// Form에서 입력한 값 디버깅
	System.out.println("stmt2 : " + stmt2);
    
    // 선택한 날짜의 일기 값 나열
    rs2 = stmt2.executeQuery();


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
    .re1{
        background: url("./img/re1.png") no-repeat center;
        background-size: contain;
        background-position: center;
        background-color: transparent;
        border: none;
        width: 130px;
        height: 100px;
        cursor: pointer;
    }
    .re1:hover{
        background: url("./img/re2.png") no-repeat center;
        background-size: contain;
        background-position: center;
        background-color: transparent;
        border: none;
        width: 130px;
        height: 100px;
        cursor: pointer;
    }
    .del1{
        background: url("./img/closermv.png");
        background-size: contain;
        background-position: center;
        background-color: transparent;
        border: none;
        width: 70px;
        height: 100px;
        cursor: pointer;
    }
    .del1:hover{
        background: url("./img/openrmv.png");
        background-size: contain;
        background-position: center;
        background-color: transparent;
        border: none;
        width: 70px;
        height: 100px;
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
            
        <div class="fs-1">버린 감정</div>
        <br>
        <form method="post" action="/diary/updateDiaryForm.jsp">
            <span>
                날짜 : 
                        <input value="<%=diaryDate%>" type="text" name="diaryDate" readonly="readonly" style="background-color: transparent; border: none;">
            </span>
            <%
                if(rs2.next()){
                	String diary_date = rs2.getString("diary_date");
                    String title = rs2.getString("title");
                    String weather = rs2.getString("weather");
                    String content = rs2.getString("content");
                    String update_date = rs2.getString("update_date");
                    String create_date = rs2.getString("create_date");
                    
                    // 디버깅
                    System.out.println("날짜 : " + diary_date);
                    System.out.println("제목 : " + title);
                    System.out.println("기분 : " + weather);
                    System.out.println("내용 : " + content);
                    System.out.println("수정날짜 : " + update_date);
                    System.out.println("작성날짜 : " + create_date);
             %>
            <span>
                제목 : <input type="text" value="<%=title%>" name="title" style="background-color: transparent; border: none;" placeholder="제목을 입력하세요." readonly="readonly">
            </span>
            <span>
                <select name="weather" style="background-color: transparent; border: none; ">
                    <option value="희" <% if(weather.equals("희")) { %>selected<% } %>>희&#128513;</option>
                    <option value="노" <% if(weather.equals("노")) { %>selected   <% } %>>노&#128545;</option>
                    <option value="애" <% if(weather.equals("애")) { %>selected<% } %>>애&#128557;</option>
                    <option value="락" <% if(weather.equals("락")) { %>selected<% } %>>락&#128526;</option>
                </select>
            </span>
            
            <br><br>
                        
            <span>
                 <textarea style="width:100%; background-color: transparent; border: none;" rows="10" cols="20" name="content" readonly="readonly"><%=content%></textarea>
            </span>
            <%
                }
            %>            
            <br>
            <span style="display: flex; justify-content: center;">
                <button class="re1" type="submit"></button>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <button class="del1" type="button" onclick="location.href='/diary/deleteDiaryAction.jsp?diaryDate=<%=diaryDate%>'"></button>
            </span>
        </form>
        
    <!-- 메인 끝 -->   
    
    <br>
    </div>
</body>
</html>