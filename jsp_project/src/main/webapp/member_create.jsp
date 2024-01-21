<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String id = request.getParameter("id");

	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회 원 가 입</title>

<link rel="stylesheet" type="text/css" href="css/member_style.css"/>
<link rel="stylesheet" type="text/css" href="css/member_created.css"/>

<script type="text/javascript" src="js/util.js"></script>
<script type="text/javascript">








//아이디 중복 확인
function checkId() {
  var id = document.getElementsByName("id")[0].value;
  var url = "check_duplicate_id.jsp?id=" + encodeURIComponent(id);
  window.open(url, "_blank", "width=400,height=200");
}


function showSelectedFile(input) {
	  var file = input.files[0];
	  var imageInput = document.getElementsByName('image')[0];

	  if (file) {
	    var reader = new FileReader();
	    reader.onload = function(e) {
	      imageInput.value = input.value; // 파일 경로 저장
	      saveImagePathToDatabase(e.target.result);
	    };
	    reader.readAsDataURL(file);
	  } else {
	    imageInput.value = "";
	  }
	}






//회원가입 조건
function sendIt() {
  var f = document.myForm;


  var str = f.name.value.trim();
  if (!str) {
      alert("\n이름을 입력하세요.");
      f.name.focus();
      return;
  }
  f.name.value = str;

  str = f.id.value.trim();
  if (!str) {
      alert("\n아이디를 입력하세요.");
      f.id.focus();
      return;
  }
  f.id.value = str;

  str = f.pwd.value.trim();
  if (!str) {
      alert("\n비밀번호를 입력하세요.");
      f.pwd.focus();
      return;
  }

  str = f.pwdConfirm.value.trim();
  if (!str) {
      alert("\n비밀번호 확인을 입력하세요.");
      f.pwdConfirm.focus();
      return;
  }

  var pwd = f.pwd.value.trim();
  var confirmPwd = f.pwdConfirm.value.trim();
  if (pwd !== confirmPwd) {
      alert("\n비밀번호가 일치하지 않습니다.");
      f.pwdConfirm.focus();
      return;
  }


  str = f.email1.value.trim();
  if (!str) {
      alert("\n이메일을 입력하세요.");
      f.email1.focus();
      return;
  }

  str = f.phoneNumber2.value.trim();
  if (!str || str.length !== 4) {
      alert("\n올바른 형식의 휴대폰 번호를 입력하세요.");
      f.phoneNumber2.focus();
      return;
  }

  str = f.phoneNumber3.value.trim();
  if (!str || str.length !== 4) {
      alert("\n올바른 형식의 휴대폰 번호를 입력하세요.");
      f.phoneNumber3.focus();
      return;
  }


  str = f.address.value.trim();
  if (!str) {
      alert("\n주소를 입력하세요.");
      f.address.focus();
      return;
  }


  str = f.birthYear.value.trim();
  if (!str ) {
      alert("\n일을 입력하세요.");
      f.birthYear.focus();
      return;
  }

  str = f.birthMonth.value.trim();
  if (!str) {
      alert("\n월을 입력하세요.");
      f.birthMonth.focus();
      return;
  }

  str = f.birthDay.value.trim();
  if (!str) {
      alert("\n일을 입력하세요.");
      f.birthDay.focus();
      return;
  }
  
  str = f.birthYear.value.trim();
  const year = parseInt(str);
  if (str.length !== 4 || year > 2023 || isNaN(year)) {
    alert("\n올바른 형식의 년도를 입력하세요.");
    f.birthYear.focus();
    return;
  }


  str = f.birthMonth.value.trim();
  const month = parseInt(str);
  if (str.length !== 2 || month < 1 || month > 12 || isNaN(month)) {
    alert("\n올바른 형식의 월을 입력하세요.");
    f.birthMonth.focus();
    return;
  }


  str = f.birthDay.value.trim();
  const day = parseInt(str);
  if (str.length !== 2 || day < 1 || day > 31 || isNaN(day)) {
    alert("\n올바른 형식의 일을 입력하세요.");
    f.birthDay.focus();
    return;
  }



  str = f.intro.value.trim();
  if (!str) {
      alert("\n자기소개를 입력하세요.");
      f.intro.focus();
      return;
  }
  
  str = f.image.value.trim();
  if (!str) {
      alert("\n사진을 넣어주세요");
      f.image.focus();
      return;
  }

  f.action = "member_created.jsp";
  f.submit();
}


</script>


</head>
<body>
<div id="bbs">
	<div id="bbs_title">
		회 원 가 입
	</div>
	
	<form action="" method="post" name="myForm">
	<div id="bbsCreated">
		
		<!-- 이름 -->
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>이&nbsp;&nbsp;&nbsp;&nbsp;름</dt>
				<dd>
				<input type="text" name="name" size="20" 
				maxlength="20" class="boxTF"/>
				</dd>
			</dl>		
		</div>
		

		<!-- 아이디 -->
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>아이디</dt>
				<dd>
					<input type="text" name="id" size="20" maxlength="20" class="boxTF" />
					<input type="button" value="중복체크" onclick="checkId();" class="btn2" />
				</dd>
			</dl>		
		</div>
		
		<!-- 비밀번호 -->
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>비밀번호</dt>
				<dd>
					<input type="password" name="pwd" size="20" maxlength="20" class="boxTF" />
				</dd>
			</dl>		
		</div>

		<!-- 비밀번호 확인 -->
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>비밀번호 확인</dt>
				<dd>
					<input type="password" name="pwdConfirm" size="20" maxlength="20" class="boxTF" />
				</dd>
			</dl>		
		</div>

		<!-- 이메일 -->
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>이메일</dt>
				<dd>
					<input type="text" name="email1" size="20" maxlength="50" class="boxTF" />
					@
					<select name="email2">
						<option value="gmail.com">gmail.com</option>
						<option value="naver.com">naver.com</option>
						<option value="yahoo.com">yahoo.com</option>
						<option value="hotmail.com">hotmail.com</option>
						<option value="outlook.com">outlook.com</option>
						<option value="icloud.com">icloud.com</option>
						<option value="aol.com">aol.com</option>
						<option value="protonmail.com">protonmail.com</option>
						<option value="zoho.com">zoho.com</option>
						<option value="yandex.com">yandex.com</option>
						<option value="mail.com">mail.com</option>
						
						<!-- 다른 이메일 도메인 옵션 추가 -->
					</select>
				</dd>
			</dl>		
		</div>

		<!-- 휴대폰 -->
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>휴대폰</dt>
				<dd>
					<select name="phoneNumber1">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<!-- 다른 휴대폰 접두사 옵션 추가 -->
					</select>
					-
					<input type="text" name="phoneNumber2" size="5" maxlength="4" class="boxTF" /> 
					-
					<input type="text" name="phoneNumber3" size="5" maxlength="4" class="boxTF" />
				</dd>
			</dl>		
		</div>

		<!-- 주소 -->
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>주소</dt>
				<dd>
					<input type="text" name="address" size="60" maxlength="100" class="boxTF" />
				</dd>
			</dl>		
		</div>

		<!-- 생년월일 -->
      	<div class="bbsCreated_bottomLine">
  			<dl>
    			<dt>생년월일</dt>
    			<dd>
      				<input type="text" name="birthYear" size="5" maxlength="4" id="birthYear" placeholder="YYYY" class="boxTF" />년
      				<input type="text" name="birthMonth" size="3" maxlength="2" id="birthMonth" placeholder="MM" class="boxTF" />월
      				<input type="text" name="birthDay" size="3" maxlength="2" id="birthDay" placeholder="DD" class="boxTF" />일
    			</dd>
  			</dl>
		</div>
 
		<!-- 자기소개 -->
		<div id="bbsCreated_content">
			<dl>
				<dt>자기소개</dt>
				<dd>
					<textarea rows="12" cols="63" name="intro" class="boxTA"></textarea>
				</dd>
			</dl>
		</div>

		<!-- 사진 첨부 -->
		<div class="bbsCreated_bottomLine">
  			<dl>
    			<dt>회원 사진</dt>
    			<dd>
      				<input type="file" id="fileInput" style="display:none;" onchange="showSelectedFile(this)" />
      				<input type="text" name="image" size="30" class="boxTF" id="imageInput" readonly />
      				<input type="button" value="찾아보기..." onclick="document.getElementById('fileInput').click();" class="btn2" />
    			</dd>
  			</dl>		
		</div>

	</div>
	
	<div id="bbsCreated_footer">
		<input type="button" value=" 작성취소 " class="btn2" onclick="javascript:location.href='member_list.jsp';"/>
			<input type="reset" value=" 다시입력 " class="btn2" onclick="document.myForm.name.focus();"/>
			<input type="button" value=" 등록하기 " class="btn2" onclick="sendIt();"/>
	</div>
	
	</form>

</div>
</body>
</html>