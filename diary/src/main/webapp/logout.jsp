<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%
    System.out.println("==========logout.jsp==========");

    String loginMember = (String)(session.getAttribute("loginMember"));
    if(loginMember == null){ // 즉, 로그오프 상태면.
        response.sendRedirect("/diary/diary.jsp");
        return; 
    }

	session.invalidate(); // 세션 공간 초기화(포맷)
	response.sendRedirect("/diary/diary.jsp");
%>
