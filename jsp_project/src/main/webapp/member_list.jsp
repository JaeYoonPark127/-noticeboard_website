<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="unit02.MyUtil"%>
<%@page import="unit02.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="unit02.MemberDAO"%>
<%@page import="unit02.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	Connection conn = DBConn.getConnection();
	MemberDAO dao = new MemberDAO(conn);
	
	MyUtil myUtil = new MyUtil();
	
	String pageNum = request.getParameter("pageNum");
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
	} else {
		searchKey = "id";
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
	
	List<MemberDTO> lists = dao.getLists(start, end,searchKey,searchValue); 
	
	String param = "";
	
	if(!searchValue.equals("")) {
		param = "?searchKey=" + searchKey;
		param+= "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
	}

	String listUrl = "member_list.jsp" + param;
	String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
	
	String updateUrl = "member_update.jsp";
	
	if(param.equals("")) {
		updateUrl += "?pageNum=" + currentPage;
	} else {
		updateUrl += param + "&pageNum=" + currentPage;
	}
	
	DBConn.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회 원 관 리</title>

<link rel="stylesheet" type="text/css" href="css/member_style.css"/>
<link rel="stylesheet" type="text/css" href="css/member_list.css"/>

<script type="text/javascript">
	function sendIt() {
		var f = document.searchForm;
		f.action = "member_list.jsp";
		f.submit();
	}
	
	function deleteSelected() {
		  var selectedElements = document.querySelectorAll('input[name="selectedIds"]:checked');
		  var selectedValues = Array.from(selectedElements).map(function(input) {
		    var idElement = input.parentElement.nextElementSibling.querySelector('.id a');
		    return idElement.innerHTML;
		  });

		  // 선택된 항목이 없을 경우 알림을 표시하고 종료
		  if (selectedValues.length === 0) {
		    alert("선택된 항목이 없습니다.");
		    return;
		  }

		  // 선택된 ID 값을 숨겨진 필드에 설정
		  var selectedIdsField = document.getElementById('selectedIds');
		  selectedIdsField.value = selectedValues.join(',');

		  // 폼 제출
		  document.getElementById('deleteForm').submit();
		}

</script>
</head>
<body>
<div id="bbsList">
	<div id="bbsList_title">
		회 원 관 리
	</div>
	<div id="bbsList_header">
		<div id="leftHeader">
			<form action="" method="post" name="searchForm">
				<select name="searchKey" class="selectField">
					<option value="name">이름</option>
					<option value="id">아이디</option>
					<option value="phoneNumber">전화번호</option>
				</select>
				<input type="text" name="searchValue" class="textField"/>
				<input type="button" value=" 검 색 " class="btn2" onclick="sendIt();"/>		
			</form>				
		</div>
		<div id="rightHeader">
			<form id="deleteForm" method="post" action="member_deleted.jsp">
				<input type="hidden" name="selectedIds" id="selectedIds">
				<input type="button" value=" 삭제 " class="btn2" onclick="deleteSelected();"/>
			</form>
			<input type="button" value=" 회원생성 " class="btn2" onclick="javascript:location.href='member_create.jsp';"/>
			<input type="button" value=" 메인이동 " class="btn2" onclick="javascript:location.href='main.jsp';"/>
		</div>
	</div>
	<div id="bbsList_list">
		<div id="title">
			<dl>
				<dt class="num">번호</dt>
				<dt class="select"><input type="checkbox" id="allCheck"></dt>
					<dt class="id">아이디</dt>
					<dt class="pwd">비밀번호</dt>
					<dt class="birth">생년월일</dt>
					<dt class="name">이름</dt>
					<dt class="email">e-mail</dt>
					<dt class="phoneNumber">전화번호</dt>
					<dt class="address">주소</dt>
					<dt class="regDate">등록일</dt>
			</dl>
		</div>
		<div id="lists">
			<% for (MemberDTO dto : lists) { %>
			<dl>
				<dd class="num"><%= dto.getNum() %></dd>
				<dd class="select">
					<input type="checkbox" name="selectedIds" value="<%= dto.getNum() %>">
				</dd>
				<dd class="id">
					<a href="<%= updateUrl %>&num=<%= dto.getNum() %>"><%= dto.getId() %></a>
				</dd>
				<dd class="pwd"><%= dto.getPwd() %></dd>
				<dd class="birth"><%= dto.getBirth() %></dd>
				<dd class="name"><%= dto.getName() %></dd>
				<dd class="email"><%= dto.getEmail() %></dd>
				<dd class="phoneNumber"><%= dto.getPhoneNumber() %></dd>
				<dd class="address"><%= dto.getAddress() %></dd>
				<dd class="regDate"><%= dto.getRegDate() %></dd>
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
