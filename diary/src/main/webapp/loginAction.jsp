<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%
	System.out.println("==========loginAction.jsp==========");
	// 0. 로그인분기(인정분기)
	// db이름.테이블이름.컬럼이름
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	String sql1 = "select my_session mySession from login"; // 알리어스 별칭 사용
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	String mySession = null;
	if(rs1.next()){
		mySession = rs1.getString("mySession");
	}
	if(mySession.equals("ON")){
		response.sendRedirect("/diary/loginForm.jsp"); // 클라이언트한테 loginForm.jsp를 요청해라.
		return; // 코드 진행을 끝내는 것. ex) 메서드 끝낼때 return사용. 지금은 로그인 off 상태일 때 끝내기 위해 사용
	}
	
	// 1. 요청값 분석
	String memberId = request.getParameter("memberId"); 	
	String memberPw = request.getParameter("memberPw");
	
	String sql2 = "select member_id memberId from member where member_id = ? and member_pw = ?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, memberId);
	stmt2.setString(2, memberPw);
	rs2 = stmt2.executeQuery();

	if(rs2.next()){
		// 로그인 성공
		System.out.println("로그인 성공");
		// diary.login.my_session -> "ON" 변경
		String sql3 = "update login set my_session = 'ON', on_date = NOW() where my_session = 'OFF'";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		int row = stmt3.executeUpdate();
		System.out.println("로그인 성공 횟수 : " + row);
		response.sendRedirect("/diary/diary.jsp");
		
	} else { // else 결과가 없다. 이건 로그인 실패다. 왜냐하면 rs2에 id와 pw가 들어가있기 때문에.
		// 	로그인 실패
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("잘못된 접근 입니다. 아이디와 비밀번호를 확인해주세요", "utf-8");
		response.sendRedirect("/diary/diary.jsp?errMsg="+errMsg);
	}
%>
