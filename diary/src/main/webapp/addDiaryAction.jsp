<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	System.out.println("==========addDiaryAction.jsp==========");

	// post방식으로 받은 값 UTF-8로 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// addDiaryForm.jsp 에서 보낸 값 받기
	String diaryDate = request.getParameter("diaryDate");
	String title = request.getParameter("title");
	String weather = request.getParameter("weather");
	String content = request.getParameter("content");
	
	// 불러온 값 디버깅
	System.out.println("diaryDate : " + diaryDate);
	System.out.println("title : " + title);
	System.out.println("weather : " + weather);
	System.out.println("content : " + content);
	
	// DB 연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	// DB로 사용할 것 선언
	String sql1 = "select my_session mySession from login"; // 로그인 on/off 확인, 별칭사용
	String sql2 = "INSERT INTO diary VALUES (?, ?, ?, ?, NOW(), NOW())"; // diary 새글 작성
	PreparedStatement stmt1 = null;
	PreparedStatement stmt2 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	
	// SQL에 값 넣을 준비
	stmt1 = conn.prepareStatement(sql1);
	stmt2 = conn.prepareStatement(sql2);
	
	//로그인 인증 우회 처리 준비
	rs1 = stmt1.executeQuery(); // ResultSet의 결과 불러오기
	String mySession = null; // rs1 실행문에 들어갈 변수 선언
	if(rs1.next()){ // rs1실행, 즉 로그인분기문 쿼리 실행(실행되면의 조건을 아래 기입)
		mySession = rs1.getString("mySession"); // String mySession에 db에서 불러온 my_session 값 넣기
	}
	
	//로그인 인증 우회 처리 실행
	if(mySession.equals("OFF")) {
		response.sendRedirect("/diary/diary.jsp");
		return; // 인증 우회로 접속하였기 때문에 코드 진행을 더이상 못 하게 해준 것이다.
	}	
	
	// SQL2에 값 넣기
	stmt2.setString(1, diaryDate);
	stmt2.setString(2, title);
	stmt2.setString(3, weather);
	stmt2.setString(4, content);
	
	// Form에서 입력한 값 디버깅
	System.out.println("일기 작성 내용 : " + stmt2);
	
	// 업데이트 된 횟수만큼의 수
	int row = stmt2.executeUpdate();
	
	// 작성 성공하면->diary.jsp로 / 실패하면->addDiaryForm.jsp로 리스폰
	if(row == 1){
		System.out.println("일기입력 완료회수 : " + row + "장");
		response.sendRedirect("/diary/diary.jsp");
	} else {
		System.out.println("일기 입력 실패");
		response.sendRedirect("/diary/addDiaryForm.jsp");
	}
	
	// 자원반납
	conn.close();
%>