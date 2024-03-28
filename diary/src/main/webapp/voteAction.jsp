<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<% 
    System.out.println("==========voteAction.jsp==========");

    // post방식으로 받은 값 UTF-8로 인코딩 설정
    request.setCharacterEncoding("UTF-8");
    
    String diaryDate = request.getParameter("diaryDate");
    String lunchPick = request.getParameter("lunchPick");
    
    System.out.println("diaryDate : " + diaryDate);
    System.out.println("lunchPick : " + lunchPick);
    
	String sql1 = "select my_session mySession from login"; // 알리어스 (별칭) 사용
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
	if(mySession.equals("OFF")) { // off일시 로그인 하라고 loginForm으로 보내기.
		response.sendRedirect("/diary/diary.jsp");
		return;
	}
    
	String sql2 = "INSERT INTO lunch(lunch_date, menu, update_date, create_date) VALUES(?, ?, NOW(), NOW())";
	PreparedStatement stmt2 = null;
	stmt2 = conn.prepareStatement(sql2);
    
    stmt2.setString(1, diaryDate);
    stmt2.setString(2, lunchPick);
    
    System.out.println("stmt2 : " + stmt2);
    
    int row = stmt2.executeUpdate();
    
    if(row == 1){
		System.out.println("투표 성공");
		response.sendRedirect("/diary/voteForm.jsp?cDate="+diaryDate+"&ck=F");
	} else{
		System.out.println("투표 실패");
	}
%>


















