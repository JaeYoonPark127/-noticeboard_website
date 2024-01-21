<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
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
	String pageNum = request.getParameter("pageNum"); 

	Connection conn = DBConn.getConnection();
	MemberDAO dao = new MemberDAO(conn);
	
	dao.updateData(dto);
	
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");
	
	if(searchValue != null) {
			
		if(request.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
			
	}else {
		searchKey = "subject";
		searchValue = "";
	}
	
	
	String param = "";

	if(!searchValue.equals("")) {
		
	
		param = "&searchKey=" + searchKey;
		param+= "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		
	}
	
	DBConn.close();
	
	response.sendRedirect("member_list.jsp?pageNum=" + pageNum + param);

%>