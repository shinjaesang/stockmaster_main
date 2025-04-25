<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="nowpage" value="1" />
<c:if test="${!empty requestScope.paging.currentPage}">
    <c:set var="nowpage" value="${requestScope.paging.currentPage}" />
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>first</title>
<style type="text/css">
fieldset#ss {
    width: 650px;
    position: relative;
    left: 250px;
}
form fieldset {
    width: 600px;
}
form.sform {
    background: lightgray;
    width: 650px;
    position: relative;
    left: 250px;
    display: none;
}
</style>
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function() {
    $('input[name=item]').on('change', function() {
        $('input[name=item]').each(function(index) {
            if ($(this).is(':checked')) {
                $('form.sform').eq(index).css('display', 'block');
            } else {
                $('form.sform').eq(index).css('display', 'none');
            }
        });
    });
});

function changeLogin(element) {
    var userid = element.name.substring(8);
    var loginOk = element.value === 'true' ? 'Y' : 'N';

    $.ajax({
        url: '${pageContext.request.contextPath}/loginok.do',
        type: 'get',
        data: { userId: userid, loginOk: loginOk },
        success: function(data) {
            console.log('Login status updated for user: ' + userid);
            alert('로그인 상태가 업데이트되었습니다.');
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log('Error updating login status: ' + textStatus);
            alert('로그인 상태 업데이트에 실패했습니다.');
        }
    });
}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<h1 align="center">회원 관리</h1>
<br>
<center>
    <button onclick="location.href='${pageContext.request.contextPath}/mlist.do?page=1';">목록</button>
</center>
<br>
<fieldset id="ss">
    <legend>검색할 항목을 선택하세요.</legend>
    <input type="radio" name="item" id="uid"> 회원 아이디 &nbsp;
    <input type="radio" name="item" id="ugen"> 성별 &nbsp;
    <input type="radio" name="item" id="uage"> 연령대 &nbsp;
    <input type="radio" name="item" id="uenroll"> 가입날짜 &nbsp;
    <input type="radio" name="item" id="ulogok"> 로그인제한여부 &nbsp;
</fieldset>
<form action="${pageContext.request.contextPath}/msearch.do" id="uidform" class="sform" method="get">
    <input type="hidden" name="action" value="uid">
    <fieldset>
        <legend>검색할 회원 아이디를 입력하세요.</legend>
        <input type="search" name="keyword" size="50"> &nbsp;
        <input type="submit" value="검색">
    </fieldset>
</form>
<form action="${pageContext.request.contextPath}/msearch.do" id="ugenform" class="sform" method="get">
    <input type="hidden" name="action" value="ugen">
    <fieldset>
        <legend>검색할 성별을 선택하세요.</legend>
        <input type="radio" name="keyword" value="M"> 남자 &nbsp;
        <input type="radio" name="keyword" value="F"> 여자 &nbsp;
        <input type="submit" value="검색">
    </fieldset>
</form>
<form action="${pageContext.request.contextPath}/msearch.do" id="uageform" class="sform" method="get">
    <input type="hidden" name="action" value="uage">
    <fieldset>
        <legend>검색할 연령대를 선택하세요.</legend>
        <input type="radio" name="keyword" value="20"> 20대 &nbsp;
        <input type="radio" name="keyword" value="30"> 30대 &nbsp;
        <input type="radio" name="keyword" value="40"> 40대 &nbsp;
        <input type="radio" name="keyword" value="50"> 50대 &nbsp;
        <input type="radio" name="keyword" value="60"> 60대 이상 &nbsp;
        <input type="submit" value="검색">
    </fieldset>
</form>
<form action="${pageContext.request.contextPath}/msearch.do" id="uenrollform" class="sform" method="get">
    <input type="hidden" name="action" value="uenroll">
    <fieldset>
        <legend>검색할 가입날짜를 입력하세요.</legend>
        <input type="date" name="begin"> ~ <input type="date" name="end"> &nbsp;
        <input type="submit" value="검색">
    </fieldset>
</form>
<form action="${pageContext.request.contextPath}/msearch.do" id="ulogokform" class="sform" method="get">
    <input type="hidden" name="action" value="ulogok">
    <fieldset>
        <legend>검색할 로그인제한 또는 가능을 선택하세요.</legend>
        <input type="radio" name="keyword" value="Y"> 로그인 가능 회원 &nbsp;
        <input type="radio" name="keyword" value="N"> 로그인 제한 회원 &nbsp;
        <input type="submit" value="검색">
    </fieldset>
</form>
<br><br>
<table align="center" border="1" cellspacing="0" cellpadding="0">
    <tr>
        <th>아이디</th>
        <th>이름</th>
        <th>성별</th>
        <th>나이</th>
        <th>전화번호</th>
        <th>이메일</th>
        <th>가입날짜</th>
        <th>마지막 수정날짜</th>
        <th>가입방식</th>
        <th>로그인 제한여부</th>
    </tr>
    <c:forEach items="${requestScope.list}" var="m">
        <tr align="center">
            <td>${m.userId}</td>
            <td>${m.userName}</td>
            <td>${m.gender eq "M" ? "남자" : "여자"}</td>
            <td>${m.age}</td>
            <td>${m.phone}</td>
            <td>${m.email}</td>
            <td>${m.enrollDate}</td>
            <td>${m.lastModified}</td>
            <td>${m.signType}</td>
            <td>
                <c:if test="${m.loginOk eq 'Y'}">
                    <input type="radio" name="loginok_${m.userId}" value="true" checked onchange="changeLogin(this);"> 가능 &nbsp;
                    <input type="radio" name="loginok_${m.userId}" value="false" onchange="changeLogin(this);"> 제한
                </c:if>
                <c:if test="${m.loginOk eq 'N'}">
                    <input type="radio" name="loginok_${m.userId}" value="true" onchange="changeLogin(this);"> 가능 &nbsp;
                    <input type="radio" name="loginok_${m.userId}" value="false" checked onchange="changeLogin(this);"> 제한
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>
<br>
<c:import url="/WEB-INF/views/common/pagingView.jsp" />
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>