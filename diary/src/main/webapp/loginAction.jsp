<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
    System.out.println("==========loginAction.jsp==========");
    // 인증 우회 처리
    String loginMember = (String)(session.getAttribute("loginMember"));
    System.out.println("loginMember : " + loginMember);
    if(loginMember != null) {
        response.sendRedirect("/diary/diary.jsp");
        return;
    }

    // 1. 요청값 분석 -> 로그인 성공 -> session에 loginMember변수를 생성
    // diary.jsp에서 입력한 id,pw 요청
    String memberId = request.getParameter("memberId");
    String memberPw = request.getParameter("memberPw");
    
    Class.forName("org.mariadb.jdbc.Driver");
    Connection conn = null;
    PreparedStatement stmt1 = null;
    ResultSet rs1 = null;
    conn = DriverManager.getConnection(
            "jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
    
    String sql2 = "select member_id memberId from member where member_id=? and member_pw=?";
    PreparedStatement stmt2 = null;
    ResultSet rs2 = null;
    stmt2 = conn.prepareStatement(sql2);
    stmt2.setString(1, memberId);
    stmt2.setString(2, memberPw);
    rs2 = stmt2.executeQuery();
    
    if(rs2.next()) {
        // 로그인 성공
        System.out.println("로그인 성공");
        // 세션키 부여되는 부분, 
        // rs2.getString("memberId")여기에 부여 되는데 그걸 "loginMember" 여기에 넣어주겠다.
        session.setAttribute("loginMember", rs2.getString("memberId"));
        response.sendRedirect("/diary/diary.jsp");
    } else {
        // 로그인 실패 세션키 값을 못 받은 채로 다시 diary로 이동.
        System.out.println("로그인 실패");
        response.sendRedirect("/diary/diary.jsp");
    }
    
    // 자원반납
    conn.close();
%>