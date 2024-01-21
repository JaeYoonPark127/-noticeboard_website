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
	
	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	BoardDTO dto = dao.getReadData(num);
	
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
	
	if(dto==null) {
		response.sendRedirect("board_list.jsp" + pageNum + param);
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게 시 글</title>

<link rel="stylesheet" type="text/css" href="css/board_style.css"/>
<link rel="stylesheet" type="text/css" href="css/board_created.css"/>

<script type="text/javascript" src="js/util.js"></script>
<script type="text/javascript">

function sendIt(){
    var f = document.myForm;

    var str = f.pwd.value.trim();
    if (!str){
        alert("\n패스워드를 입력하세요.");
        f.pwd.focus();
        return;
    }
    f.pwd.value = str;

	
	var temp = '<%=dto.getPwd()%>';
	if(str != temp) {
		alert("패스워드가 틀립니다.");
		f.pwd.focus();
		return;
	}

    f.action = "board_deleted.jsp";
    f.submit();
}


</script>


</head>
<body>

<div id="bbs">
	<div id="bbs_title">
		게 시 글
	</div>
	
	<form action="" method="post" name="myForm">
	<div id="bbsCreated">
		

		<div class="bbsCreated_noLine">
			<dl>
				<dt>패스워드</dt>
				<dd>
				<input type="password" name="pwd" size="35" 
				maxlength="7" class="boxTF"/>
				
				</dd>
			</dl>		
		</div>	
	
	</div>
	
	<div id="bbsCreated_footer">
	
		<input type="hidden" name="num" value="<%=dto.getNum()%>"/>
		<input type="hidden" name="pageNum" value="<%=pageNum%>"/>
		<input type="hidden" name="searchKey" value="<%=searchKey%>"/>
		<input type="hidden" name="searchValue" value="<%=searchValue%>"/>
	
		
		<input type="button" value=" 취소 " class="btn2" 
		onclick="javascript:location.href='board_list.jsp?pageNum=<%=pageNum%><%=param%>';"/>
		<input type="button" value=" 삭제하기 " class="btn2" onclick="sendIt();"/>
		
		
	</div>
	
	</form>

</div>


</body>
</html>