<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	System.out.println("==========vote.jsp==========");

    // 인증 우회 처리
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
	// 로그인 off 시 diary.jsp로 가기
	if(mySession.equals("OFF")) {
		response.sendRedirect("/diary/diary.jsp");
		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
	}
%>
<%
    String checkDate = request.getParameter("checkDate");
    if(checkDate == null) {
        checkDate = ""; // 날짜에 null이 아니고 공백넣기위함
    }
    String ck = request.getParameter("ck");
    if(ck == null) {
        ck = "";
    }
    
    String msg = "";
    if(ck.equals("T")) {
        msg = "오늘 메뉴가 없어요!";
    } else if(ck.equals("F")){
        msg = "오늘 메뉴가 있어요!";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>vote</title>
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

    a{ text-decoration: none; color: black; }

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
    .stBtn{
        background: url("./img/st1.png") no-repeat center;
        background-size: 100%;
        background-color: transparent;
        border: none;
        width: 50px;
        height: 50px;
        cursor: pointer;
    }
    .stBtn:hover{
        background: url("./img/st2.png") no-repeat center;
        background-size: 100%;
        background-color: transparent;
        border: none;
        width: 50px;
        height: 50px;
        cursor: pointer;
    }
    .hamBtn{
        background: url("./img/ham1.png") no-repeat center;
        background-size: 100%;
        background-color: transparent;
        border: none;
        width: 50px;
        height: 50px;
        cursor: pointer;
    }
    .hamBtn:hover{
        background: url("./img/ham2.png") no-repeat center;
        background-size: 100%;
        background-color: transparent;
        border: none;
        width: 50px;
        height: 50px;
        cursor: pointer;
    }
    .hamBtnX{
        background: url("./img/ham1.png") no-repeat center;
        background-size: 100%;
        background-color: transparent;
        border: none;
        width: 50px;
        height: 50px;
        cursor: pointer;
    }
    .hamBtnX:hover{
        background: url("./img/hamX.png") no-repeat center;
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
    <button type="button" class="voteBtn" onclick="location.href='/diary/vote.jsp'"></button>
    <button type="button" class="outBtn" onclick="location.href='/diary/logout.jsp'"></button>
</div>
    
    <div class="diaryBg px-5 ">
    <!-- 메인 시작 -->  
            
        <div class="fs-1">오늘의 식사는?</div>
        <br>

        
        <hr>
        
        
            <span>
                <%
                    // 아직 오늘 메뉴 선정 안 했을 때
                    if(ck.equals("T")) {
                %>
                            <form method="post" action="/diary/voteCheckAction.jsp">    
                                <div>
                                    고른날짜 : <input type="date" name="checkDate" value="<%=checkDate%>" style="background-color: transparent; border: none;">
                                    <button type="submit" style="background-color: transparent; border: none;">날짜가능확인</button>
                                    <br><br>
                                    <div><%=msg%></div>
                                </div>
                            </form>
                
                            날짜 : 
                            <input value="<%=checkDate%>" type="text" name="diaryDate" readonly="readonly" style="background-color: transparent; border: none;">
                            
                            <br><br>
                            
                            <span>
                                <h4>오늘 식사 정하기</h4>
                            </span>
                            <form method="post" action="/diary/voteAction.jsp?diaryDate=<%=checkDate%>">    
                                <span>
                                    <input type="radio" name="lunchPick" value="한식" checked="checked"> 한식 <br>
                                    <input type="radio" name="lunchPick" value="중식"> 중식 <br>
                                    <input type="radio" name="lunchPick" value="일식"> 일식 <br>
                                    <input type="radio" name="lunchPick" value="양식"> 양식 <br>
                                    <input type="radio" name="lunchPick" value="기타"> 기타
                                </span>
                                <div>
                                    <table>
                                        <tr>
                                            <td><button type="submit" class="hamBtn"></button></td>
                                            <td><button type="button" class="stBtn" onclick="location.href='/diary/statsLunch.jsp'"></button></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td>투표</td>
                                            <td>통계</td>
                                        </tr>
                                    </table>
                                </div>
                            </form>
                        </span>
                <%      
                    // 이미 오늘 메뉴 선정을 했을 때
                    } else if(ck.equals("F")) {
                %>
                    <form method="post" action="/diary/voteCheckAction.jsp">    
                        <div>
                            고른날짜 : <input type="date" name="checkDate" value="<%=checkDate%>" style="background-color: transparent; border: none;">
                            <button type="submit" style="background-color: transparent; border: none;">날짜가능확인</button>
                            <br><br>
                            <div><%=msg%></div>
                        </div>
                    </form>                
                            날짜 : 
                            <input value="<%=checkDate%>" type="text" name="diaryDate" readonly="readonly" style="background-color: transparent; border: none;">
                            
                            <br><br>
                            
                            <span>
                                <h4>오늘 정한 식사</h4>
                            </span>
                <%
                    // 투표 후 당일 투표 결과를 이 폼에 표시하기 
                    String sql2 = "SELECT * FROM lunch WHERE lunch_date = ?";
                    PreparedStatement stmt2 = null;
                    ResultSet rs2 = null;
                    stmt2 = conn.prepareStatement(sql2);
                    stmt2.setString(1, checkDate);
                    System.out.println("stmt2 : " + stmt2);
                    rs2 = stmt2.executeQuery();
                    if(rs2.next()){
                    	String cDate = rs2.getString("lunch_date");
                    	String menu = rs2.getString("menu");
                    	System.out.println("cDate : " + cDate);
                    	System.out.println("menu : " + menu);
                %>
                                <!-- rs2를 통해 불러온 menu를 .equals를 통해 같은 값일 때 check되게 했음  -->
                                <span>
                                    <input type="radio" name="lunchPick" value="한식" <% if(menu.equals("한식")){%> checked<%} %>> 한식 <br>
                                    <input type="radio" name="lunchPick" value="중식" <% if(menu.equals("중식")){%> checked<%} %>> 중식 <br>
                                    <input type="radio" name="lunchPick" value="일식" <% if(menu.equals("일식")){%> checked<%} %>> 일식 <br>
                                    <input type="radio" name="lunchPick" value="양식" <% if(menu.equals("양식")){%> checked<%} %>> 양식 <br>
                                    <input type="radio" name="lunchPick" value="기타" <% if(menu.equals("기타")){%> checked<%} %>> 기타
                                </span>
                    <%
                        }
                    %>
                                <div>
                                    <table>
                                        <tr>
                                            <td><button type="button" class="hamBtnX"></button></td>
                                            <td><button type="button" class="stBtn" onclick="location.href='/diary/statsLunch.jsp'"></button></td>
                                        </tr>
                                        <tr style="text-align: center;">
                                            <td>투표</td>
                                            <td>통계</td>
                                        </tr>
                                    </table>
                                </div>
                        </span>                       
                <%      
                    // 첫 화면
                    } else {
                %>
                        <form method="post" action="/diary/voteCheckAction.jsp">    
                            <div>
                                고른날짜 : <input type="date" name="checkDate" value="<%=checkDate%>" style="background-color: transparent; border: none;">
                                <button type="submit" style="background-color: transparent; border: none;">날짜가능확인</button>
                                <br><br>
                                <div><%=msg%></div>
                            </div>
                        </form>
                        </span>
                        <span>
                            먼저 날짜를 선택하세요.
                        </span>
                        <br>
                            <table>
                                <tr>
                                    <td><button type="button" class="stBtn" onclick="location.href='/diary/statsLunch.jsp'"></button></td>
                                </tr>
                                <tr style="text-align: center;">
                                    <td>통계</td>
                                </tr>
                            </table>
                <%   
                    }
                %>
        

        
    <!-- 메인 끝 -->   
    
    <br>
    </div>
</body>
</html>