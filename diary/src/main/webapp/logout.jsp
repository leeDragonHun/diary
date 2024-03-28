<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%
	System.out.println("==========logout.jsp==========");
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
	
	if(mySession.equals("OFF")){ // off일시 로그인 하라고 loginForm으로 보내기.
		String errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/diary/diary.jsp?errMsg="+errMsg); // 클라이언트한테 loginForm.jsp를 요청해라.
		return; // 코드 진행을 끝내는 것. ex) 메서드 끝낼때 return사용. 지금은 로그인 off 상태일 때 끝내기 위해 사용
	}
	// if문에 걸리지 않았다는 건 현재값이 OFF가 아니고 ON이다.(바로이 위에 있는 if문이 통과 됐을것이다.)
	// OFF로 변경후 loginForm으로 리다이렉트하는 코드를 아래에 작성.
	String sql2 = "UPDATE login set my_session = 'OFF', off_date = now() where my_session = 'ON'";
	PreparedStatement stmt2 = null;
	stmt2 = conn.prepareStatement(sql2);
	int row = stmt2.executeUpdate();
	System.out.println("로그아웃 성공 횟수 : " + row);
	
	response.sendRedirect("/diary/diary.jsp");
%>