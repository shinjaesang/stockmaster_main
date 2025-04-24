<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
    <style>
        nav > ul#menubar {
            list-style: none;
            padding: 0;
            margin: 0;
            position: relative;
            left: 100px;
        }
        nav > ul#menubar li {
            float: left;
            width: 120px;
            height: 35px;
            margin-right: 5px;
        }
        nav > ul#menubar li a {
            display: block;
            width: 100%;
            height: 100%;
            line-height: 35px;
            background: orange;
            color: navy;
            text-align: center;
            font-weight: bold;
            text-decoration: none;
            border-radius: 6px;
            transition: all 0.3s ease;
        }
        nav > ul#menubar li a:hover {
            background: navy;
            color: white;
        }
        hr { clear: both; }
    </style>
</head>
<body>

<!-- 로그인하지 않았을 때 -->
<c:if test="${empty sessionScope.loginUser}">
    <nav>
        <ul id="menubar">
            <li><a href="${pageContext.servletContext.contextPath}/main.do">Home</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/nlist.do?page=1">공지사항</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/blist.do?page=1">게시글</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/moveAOP.do">AOP란</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/moveAjax.do">Ajax 처리</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/moveAPI.do">API 테스트</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/moveJSTL.do">JSTL 테스트</a></li>
        </ul>
    </nav>
</c:if>

<!-- 일반 회원 로그인 -->
<c:if test="${!empty sessionScope.loginUser and sessionScope.loginUser.adminYN eq 'N'}">
    <nav>
        <ul id="menubar">
            <li><a href="${pageContext.servletContext.contextPath}/main.do">Home</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/nlist.do?page=1">공지사항</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/blist.do?page=1">게시글</a></li>
        </ul>
    </nav>
</c:if>

<!-- 관리자 로그인 -->
<c:if test="${!empty sessionScope.loginUser and sessionScope.loginUser.adminYN eq 'Y'}">
    <nav>
        <ul id="menubar">
            <li><a href="${pageContext.servletContext.contextPath}/main.do">Home</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/nlist.do?page=1">공지사항관리</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/blist.do?page=1">게시글관리</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/mlist.do?page=1">회원관리</a></li>
        </ul>
    </nav>
</c:if>

</body>
</html>
