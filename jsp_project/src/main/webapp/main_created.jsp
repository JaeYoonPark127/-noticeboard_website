<%@page import="unit02.MemberDAO"%>
<%@page import="unit02.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<jsp:useBean id="dto" class="unit02.MemberDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>

<%
	Connection conn =DBConn.getConnection();
	MemberDAO dao = new MemberDAO(conn);
	
	
	int maxNum = dao.getMaxNum();
	
	dto.setNum(maxNum + 1); 
	
	dao.insertData(dto);
	
	DBConn.close();
	

	response.sendRedirect("main.jsp"); 


%>