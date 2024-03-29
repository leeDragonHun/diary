<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	System.out.println("==========checkDateAction.jsp==========");
    
    String loginMember = (String)(session.getAttribute("loginMember"));
    if(loginMember == null){ // 즉, 로그오프 상태면.
        response.sendRedirect("/diary/diary.jsp");
        return; 
    // 밑으로 원래 DB방식의 로그인 방식을 쓸 때 쓰던 인증우회문이 있으나 return;을 통해 끝내버림.
    }

	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	// 값을 체크하는 코드
	String checkDate = request.getParameter("checkDate");
	String sql2 = "select diary_date diaryDate from diary where diary_date=?";
	// 결과가 있으면 이미 이날짜에 일기가 있다 -> 이날짜로는 입력X
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, checkDate);
	rs2 = stmt2.executeQuery();
	if(rs2.next()) {
	//  이날짜 일기 기록 불가능 (이미 존재하니까)
		response.sendRedirect("/diary/addDiaryForm.jsp?checkDate="+checkDate+"&ck=F");
	} else {
		//  이날짜 일기 기록 가능
		response.sendRedirect("/diary/addDiaryForm.jsp?checkDate="+checkDate+"&ck=T");
	}
    
	// 자원반납
	conn.close();
%>