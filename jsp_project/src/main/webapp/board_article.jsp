<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="unit01.BoardDTO"%>
<%@page import="unit01.BoardDAO"%>
<%@page import="unit01.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	

	int num = Integer.parseInt(request.getParameter("num"));

	String pageNum = request.getParameter("pageNum");
	
	

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
	
	
	
	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	

	dao.updateHitCount(num);
	

	BoardDTO dto = dao.getReadData(num); 
	
	if(dto==null) {
		response.sendRedirect("board_lists.jsp");
	}
	

	int lineSu = dto.getContent().split("\n").length;
	

	dto.setContent(dto.getContent().replace("\n", "<br/>")); 
	
	
	String param = "";

	if(!searchValue.equals("")) {
		

		param = "&searchKey=" + searchKey;
		param+= "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		
	}
	
	
	
	DBConn.close();
		
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게 시 글</title>

<link rel="stylesheet" type="text/css" href="css/board_style.css"/>
<link rel="stylesheet" type="text/css" href="css/board_article.css"/>

</head>
<body>

<div id="bbs">
	
	<div id="bbs_title">
		게 시 글
	</div>
	<div id="bbsArticle">
		
		<div id="bbsArticle_header">
			<%=dto.getSubject() %>
		</div>
		
		<div class="bbsArticle_bottomLine">
			<dl>
				<dt>작성자</dt>
				<dd><%=dto.getName() %></dd>
				<dt>줄수</dt>
				<dd><%=lineSu %></dd>
			</dl>		
		</div>
		
		<div class="bbsArticle_bottomLine">
			<dl>
				<dt>등록일</dt>
				<dd><%=dto.getCreated() %></dd>
				<dt>조회수</dt>
				<dd><%=dto.getHitCount() %></dd>
			</dl>		
		</div>
		
		<div id="bbsArticle_content">
			<table width="600" border="0">
			<tr>
				<td style="padding-left: 20px 80px 20px 62px;" 
				valign="top" height="200">
				<%=dto.getContent() %>
				</td>
			</tr>			
			</table>
		</div>
		
	</div>
	
	
	<div id="bbsArticle_footer">
		<div id="leftFooter">
			<input type="button" value=" 수정 " class="btn2" 
			onclick="javascript:location.href='board_update.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%><%=param%>';"/>
			<input type="button" value=" 삭제 " class="btn2" 
			onclick="javascript:location.href='board_delete.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%><%=param%>';"/>
		</div>
		<div id="rightFooter">
			<input type="button" value=" 리스트 " class="btn2" 
			onclick="javascript:location.href='board_list.jsp?pageNum=<%=pageNum%><%=param%>';"/>
			
		</div>	
	</div>
	
</div>


</body>
</html>