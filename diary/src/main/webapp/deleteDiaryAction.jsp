<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
    System.out.println("==========deleteDiaryAction.jsp==========");

    String loginMember = (String)(session.getAttribute("loginMember"));
    if(loginMember == null){ // 즉, 로그오프 상태면.
        response.sendRedirect("/diary/diary.jsp");
        return; 
    // 밑으로 원래 DB방식의 로그인 방식을 쓸 때 쓰던 인증우회문이 있으나 return;을 통해 끝내버림.
    }
    // 인증 우회 처리
    Class.forName("org.mariadb.jdbc.Driver");
    Connection conn = null;
    PreparedStatement stmt1 = null;
    conn = DriverManager.getConnection(
    		"jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
    // 인코딩(utf-8)
    request.setCharacterEncoding("UTF-8");

    //  diaryDate 불러오기
    String diaryDate = request.getParameter("diaryDate");
    System.out.println("diaryDate : " + diaryDate);
    
    // 삭제를 위한 sql
    String sql2 = "DELETE FROM diary WHERE diary_date = ?";
    PreparedStatement stmt2 = null;
    stmt2 = conn.prepareStatement(sql2);
    stmt2.setString(1, diaryDate);
	
    // 쿼리에 잘 들어갔나 디버깅
	System.out.println("stmt2 : " + stmt2);
    
	// 업데이트 됐나 확인. row2 경우는  됐으면 1, 아니면 0     row1는 됐으면 1<=   아니면 0
	int row = stmt2.executeUpdate();
    
	// 분기문
	if(row >= 1){
		System.out.println("글삭제 성공");
	} else{
		System.out.println("글삭제 실패");
	%>
	 	글삭제를 실패했습니다. 
	<%
	}
	
	// 리스폰
	response.sendRedirect("/diary/diary.jsp");
	
	// 자원반납
	conn.close();
%>
