<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
    System.out.println("==========updateDiaryAction.jsp==========");
    
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
    

	// 인증 우회 쿼리
	String sql1 = "select my_session mySession from login"; // 알리어스 별칭 사용
	
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
	if(rs1.next()){
		mySession = rs1.getString("mySession");
	}
    
	//로그인 인증 우회 처리 실행
	if(mySession.equals("OFF")) {
		response.sendRedirect("/diary/diary.jsp");
		return;
	}
%>
<%
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
%>