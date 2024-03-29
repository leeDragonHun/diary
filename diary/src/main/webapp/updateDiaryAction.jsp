<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
    System.out.println("==========updateDiaryAction.jsp==========");


    String loginMember = (String)(session.getAttribute("loginMember"));
    if(loginMember == null){ // 즉, 로그오프 상태면.
        response.sendRedirect("/diary/diary.jsp");
        return; 
    }
    
    // 인코딩(utf-8)
    request.setCharacterEncoding("UTF-8");
    
    // Form에서 보낸 값 받기
	String diaryDate = request.getParameter("diaryDate");
	String title = request.getParameter("title");
	String weather = request.getParameter("weather");
	String content = request.getParameter("content");
    
    // 값 디버깅
	System.out.println("diaryDate : " + diaryDate);
	System.out.println("title : " + title);
	System.out.println("weather : " + weather);
	System.out.println("content : " + content);
    

	
	// DB 연동
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");

	String sql2 = "UPDATE diary SET title = ?, weather =?, content = ? WHERE diary_date = ?";
    PreparedStatement stmt2 = null;
    ResultSet rs2 = null;
    
	// DB 사용 준비
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, title);
	stmt2.setString(2, weather);
	stmt2.setString(3, content);
	stmt2.setString(4, diaryDate);
	System.out.println("stmt2 : " + stmt2);
    
	int row = stmt2.executeUpdate();
    
	if(row == 1) {
		System.out.println(row);
	response.sendRedirect("/diary/diaryOne.jsp?diaryDate="+diaryDate);
	} else {
        System.out.println("수정 실패");      
    }
    // 자원반납
    conn.close();
%>