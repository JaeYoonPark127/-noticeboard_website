<%@page import="unit02.MemberDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="unit02.DBConn"%>
<%@page import="java.sql.Connection"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="dto" class="unit02.MemberDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>
<%

	String selectedIds = request.getParameter("selectedIds");
	if (selectedIds != null) {
		Connection conn = DBConn.getConnection();
		MemberDAO dao = new MemberDAO(conn);

		String[] idArray = selectedIds.split(",");
		for (String id : idArray) {
			int result = dao.deleteData_2(id); 
		
			if (result > 0) {
				System.out.println("레코드 삭제 성공");
			} else {
				System.out.println("레코드 삭제 실패");
			}
		}

		DBConn.close();
	}

	
	response.sendRedirect("member_list.jsp");
%>
