<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>first</title>
<style type="text/css">
table th { background-color: #9ff; }
table#outer { border: 2px solid navy; }
</style>
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
function dupIdCheck() {
    $.ajax({
        url: '${pageContext.request.contextPath}/idchk.do',
        type: 'post',
        data: { userId: $('#userId').val() },
        success: function(data) {
            console.log('success : ' + data);
            if (data === 'ok') {
                alert('사용 가능한 아이디입니다.');
                $('#userPwd').focus();
            } else {
                alert('이미 사용중인 아이디입니다. 다시 입력하세요.');
                $('#userId').select();
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log('error : ' + jqXHR + ', ' + textStatus + ', ' + errorThrown);
        }
    });
}

function validate() {
    var pwdValue = $('#userPwd').val();
    var pwdValue2 = document.getElementById('userPwd2').value;
    var userId = $('#userId').val();

    // 아이디 형식 검증 (4~12자, 영문+숫자)
    var idRegex = /^[A-Za-z0-9]{4,12}$/;
    if (!idRegex.test(userId)) {
        alert('아이디는 4~12자이며, 영문자와 숫자만 사용할 수 있습니다.');
        $('#userId').val('');
        $('#userId').focus();
        return false;
    }

    // 암호와 암호확인 일치 여부
    if (pwdValue !== pwdValue2) {
        alert('암호와 암호확인이 일치하지 않습니다. 다시 입력하세요.');
        $('#userPwd').val('');
        $('#userPwd2').val('');
        $('#userPwd').focus();
        return false;
    }

    // 암호 형식 검증 (최소 8자, 영문+숫자)
    var pwdRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
    if (!pwdRegex.test(pwdValue)) {
        alert('암호는 최소 8자 이상이며, 영문자와 숫자를 포함해야 합니다.');
        $('#userPwd').val('');
        $('#userPwd2').val('');
        $('#userPwd').focus();
        return false;
    }

    return true;
}

window.onload = function() {
    var photofile = document.getElementById('photofile');
    photofile.addEventListener('change', function(event) {
        const files = event.currentTarget.files;
        const file = files[0];
        console.log(file.name);

        const photo = document.getElementById('photo');
        const reader = new FileReader();
        reader.onload = (e) => {
            photo.setAttribute('src', e.target.result);
            photo.setAttribute('data-file', file.name);
        };
        reader.readAsDataURL(file);
    });
};
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<h1 align="center">회원 가입 페이지</h1>
<br>
<form action="${pageContext.request.contextPath}/enroll.do" method="post" onsubmit="return validate();" enctype="multipart/form-data">
<table id="outer" align="center" width="700" cellspacing="5" cellpadding="0">
    <tr><th colspan="2">회원 정보를 입력하세요. (* 표시는 필수입력 항목입니다.)</th></tr>
    <tr><th width="120">*아이디</th>
        <td><input type="text" name="userId" id="userId" required> &nbsp;
            <input type="button" value="중복검사" onclick="return dupIdCheck();"></td></tr>
    <tr><th>사진첨부</th>
        <td>
            <div id="myphoto" style="margin:0; width:150px; height:160px; padding:0; border:1px solid navy;">
                <img src="${pageContext.servletContext.contextPath}/resources/images/photo1.jpg" id="photo" 
                    style="width:150px;height:160px;border:1px solid navy;display:block;margin:0;padding:0;" 
                    alt="사진을 드래그 드롭하세요.">
            </div> <br>
            <input type="file" id="photofile" name="photofile">
        </td></tr>
    <tr><th>*암호</th>
        <td><input type="password" name="userPwd" id="userPwd" required></td></tr>
    <tr><th>*암호확인</th>
        <td><input type="password" id="userPwd2" required></td></tr>
    <tr><th>*이름</th>
        <td><input type="text" name="userName" id="userName" required></td></tr>
    <tr><th>*성별</th>
        <td>
            <input type="radio" name="gender" value="M"> 남자 &nbsp;
            <input type="radio" name="gender" value="F"> 여자 
        </td></tr>
    <tr><th>*나이</th>
        <td><input type="number" name="age" min="19" max="100" value="20" required></td></tr>
    <tr><th>*전화번호</th>
        <td><input type="tel" name="phone" required></td></tr>
    <tr><th>*이메일</th>
        <td><input type="email" name="email" required></td></tr>
    <tr><th colspan="2">
        <input type="submit" value="가입하기"> &nbsp;
        <input type="reset" value="작성취소"> &nbsp;
        <a href="${pageContext.request.contextPath}/main.do">Home</a>
    </th></tr>
</table>
</form>
<hr style="clear:both">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>