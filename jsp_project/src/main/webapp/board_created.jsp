<%@page import="unit01.BoardDAO"%>
<%@page import="unit01.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<jsp:useBean id="dto" class="unit01.BoardDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>

<%
	Connection conn =DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	
	int maxNum = dao.getMaxNum();
	
	dto.setNum(maxNum + 1); 
	
	
	dao.insertData(dto);
	
	DBConn.close();
	

	response.sendRedirect("board_list.jsp"); 


%>