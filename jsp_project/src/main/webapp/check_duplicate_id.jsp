<%@page import="unit02.MemberDAO"%>
<%@page import="unit02.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();

    String id = request.getParameter("id");
    Connection conn = DBConn.getConnection();
    MemberDAO dao = new MemberDAO(conn);

    boolean isDuplicateId = dao.checkDuplicateId(id);
    DBConn.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>아이디 중복 체크</title>
    <style>
        .red-text {
            color: red;  
        }
        .blue-text {
            color: blue;  
        }
    </style>
</head>
<body>
    <h2>중복 체크</h2>
    
    <p>입력한 아이디: <%= id %></p>
    <p id="result"></p>

    <button onclick="cancel()">취소</button>
    <button onclick="use()">사용하기</button>

    <script type="text/javascript">
        var isDuplicateId = <%= isDuplicateId %>;
        var id = '<%= id %>'; // 아이디 변수 추가

        if (isDuplicateId) {
            document.getElementById("result").innerHTML = "이미 사용 중인 아이디입니다.";
            document.getElementById("result").classList.add("red-text");
        } else {
            document.getElementById("result").innerHTML = "사용 가능한 아이디입니다.";
            document.getElementById("result").classList.add("blue-text");
        }

        function cancel() {
            window.close();
        }

        function use() {
            window.opener.document.getElementsByName("id")[0].value = id; // 수정된 부분
            window.close();
        }
    </script>
</body>
</html>
