<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	System.out.println("==========voteCheckAction.jsp==========");
	// 0. 로그인(인증) 분기
	// db이름.테이블이름.컬럼이름
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")

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
	
	// 값을 체크하는 코드
	String checkDate = request.getParameter("checkDate");
	String sql2 = "select lunch_date lunchDate from lunch where lunch_date=?";
	// 결과가 있으면 이미 이날짜에 일기가 있다 -> 이날짜로는 입력X
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, checkDate);
	rs2 = stmt2.executeQuery();
	if(rs2.next()) {
	//  이날짜 일기 기록 불가능 (이미 존재하니까)
		response.sendRedirect("/diary/voteForm.jsp?checkDate="+checkDate+"&ck=F");
	} else {
		//  이날짜 일기 기록 가능
		response.sendRedirect("/diary/voteForm.jsp?checkDate="+checkDate+"&ck=T");
	}
%>