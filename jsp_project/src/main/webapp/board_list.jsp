<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="unit01.MyUtil"%>
<%@page import="unit01.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="unit01.BoardDAO"%>
<%@page import="unit01.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	

	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	
	MyUtil myUtil = new MyUtil();
	

	String pageNum = request.getParameter("pageNum"); //겟파라미터로 받는다
	

	int currentPage = 1;
	

	if(pageNum != null) {
		
		currentPage = Integer.parseInt(pageNum);
	}
	

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
	
	

	int dataCount = dao.getDataCount(searchKey,searchValue);
	

	int numPerPage = 5;

	
	int totalPage = myUtil.getPageCount(numPerPage, dataCount);
	

	if(currentPage > totalPage) {
		currentPage = totalPage;
	}
	

	int start = (currentPage-1) * numPerPage+1;
	int end = currentPage * numPerPage;
	

	List<BoardDTO> lists = dao.getLists(start, end,searchKey,searchValue); 
	
	

	String param = "";

	if(!searchValue.equals("")) {
		

		param = "?searchKey=" + searchKey;
		param+= "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		
	}


	String listUrl = "board_list.jsp" + param; 
	
	
	String pageIndexList = 
			myUtil.pageIndexList(currentPage, totalPage, listUrl);
	

	
	String articleUrl = "board_article.jsp";
	
	if(param.equals("")) { 
		articleUrl += "?pageNum=" + currentPage;
	} else { 
		articleUrl += param + "&pageNum=" + currentPage;
	}
	
	
	DBConn.close();
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게 시 판</title>

<link rel="stylesheet" type="text/css" href="css/board_style.css"/>
<link rel="stylesheet" type="text/css" href="css/board_list.css"/>



<script type="text/javascript">

	function sendIt() {
		var f = document.searchForm;
		f.action = "board_list.jsp";
		f.submit();
	}

</script>


</head>
<body>

<div id="bbsList">

	<div id="bbsList_title">
		게 시 판
	</div>
	<div id="bbsList_header">
		<div id="leftHeader">
			<form action="" method="post" name="searchForm">
				<select name="searchKey" class="selectField">
					<option value="subject">제목</option>
					<option value="name">작성자</option>
					<option value="content">내용</option>
				</select>
				<input type="text" name="searchValue" class="textField"/>
				<input type="button" value=" 검 색 " class="btn2" onclick="sendIt();"/>		
			</form>				
		</div>
		<div id="rightHeader">
			<input type="button" value=" 글쓰기 " class="btn2" onclick="javascript:location.href='board_create.jsp';"/>
			<input type="button" value=" 메인이동 " class="btn2" onclick="javascript:location.href='main.jsp';"/>			
		</div>	
	</div>
	<div id="bbsList_list">
		<div id="title">
			<dl>
				<dt class="num">번호</dt>
				<dt class="subject">제목</dt>
				<dt class="email">이메일</dt>
				<dt class="name">작성자</dt>
				<dt class="created">작성일</dt>
				<dt class="hitCount">조회수</dt>
			</dl>
		</div>
		
		<div id="lists">
			<% for (BoardDTO dto : lists) { %>
				<dl>
					<dd class="num"><%= dto.getNum() %></dd>
					<dd class="subject">
						<a href="<%= articleUrl %>&num=<%= dto.getNum() %>"><%= dto.getSubject() %></a>
					</dd>
					<dd class="email"><%= dto.getEmail() %></dd>
					<dd class="name"><%= dto.getName() %></dd>
					<dd class="created"><%= dto.getCreated() %></dd>
					<dd class="hitCount"><%= dto.getHitCount() %></dd>
				</dl>
			<% } %>
		</div>
		<div id="footer">
			<%= pageIndexList %>
		</div>
		
	</div>
	
</div>

</body>
</html>
