<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="unit02.MemberDAO"%>
<%@page import="unit02.DBConn"%>
<html>
<head>

<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>

<script>
function validateForm() {
    var f = document.loginForm;
    var username = document.getElementsByName("userID")[0].value;
    var password = document.getElementsByName("userPassword")[0].value;

    // MemberDAO 객체 생성
    var memberDAO = new com.example.unit01.MemberDAO();

    // MemberDAO의 getNameByUsernameAndPassword 함수 호출하여 name 값 가져오기
    var memberDTO = memberDAO.getNameByUsernameAndPassword(username, password);
    var name = memberDTO !== null ? memberDTO.getName() : null;

    if (name !== null) {
        alert("환영합니다, " + name + "님!");
        f.action = "main_login_success.jsp";
        return true; 
    } else {
        alert("비밀번호가 틀렸습니다."); 
        return false;
    }
}


</script>

</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">커뮤니티 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="board_list.jsp">게시판</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">메뉴<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="main_create.jsp">회원가입</a></li>
						<li class="active"><a href="login_general.jsp">로그인</a></li>
						<li><a href="login.jsp">관리자 로그인</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="" name = "loginForm" onsubmit="return validateForm()">
					<h3 style="text-align: center;">로그인</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="로그인">
				</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>
</html>
