<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="sidebar pe-4 pb-3">
    <nav class="navbar bg-light navbar-light">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand mx-4 mb-3">
            <h3 style="font-family: 'Noto Sans KR', sans-serif; margin: 0;">
                <span style="color: #007bff;">재고</span><span style="color: #343a40;">마스터</span>
            </h3>
        </a>
        <div class="navbar-nav w-100">
            <a href="${pageContext.request.contextPath}/" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>대시보드</a>
            <a href="${pageContext.request.contextPath}/notices.do" class="nav-item nav-link"><i class="fa fa-bullhorn me-2"></i>공지사항</a>
            <a href="${pageContext.request.contextPath}/warehouse.do" class="nav-item nav-link"><i class="fa fa-warehouse me-2"></i>창고관리</a>
            <a href="${pageContext.request.contextPath}/vendors.do" class="nav-item nav-link"><i class="fa fa-handshake me-2"></i>거래처관리</a>
            <div class="nav-item dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-shopping-cart me-2"></i>주문관리</a>
                <div class="dropdown-menu bg-transparent border-0">
                    <a href="${pageContext.request.contextPath}/orders/list.do" class="dropdown-item">주문 조회</a>
                    <a href="${pageContext.request.contextPath}/orders/register.do" class="dropdown-item">주문 등록</a>
                </div>
            </div>
            <div class="nav-item dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-barcode me-2"></i>상품관리</a>
                <div class="dropdown-menu bg-transparent border-0">
                    <a href="${pageContext.request.contextPath}/products/list.do" class="dropdown-item">상품 조회</a>
                    <a href="${pageContext.request.contextPath}/products/register.do" class="dropdown-item">상품 등록</a>
                </div>
            </div>
            <div class="nav-item dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-boxes me-2"></i>재고관리</a>
                <div class="dropdown-menu bg-transparent border-0">
                    <a href="${pageContext.request.contextPath}/inventory/currentInventory.do" class="dropdown-item">현재고 조회</a>
                    <a href="${pageContext.request.contextPath}/inventory/dailyInventory.do" class="dropdown-item">일자 별 재고 조회</a>
                    <a href="${pageContext.request.contextPath}/inventory/monthlyInventory.do" class="dropdown-item">월 별 재고 조회</a>
                </div>
            </div>
            <div class="nav-item dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-truck me-2"></i>입출고관리</a>
                <div class="dropdown-menu bg-transparent border-0">
                    <a href="${pageContext.request.contextPath}/inout/list.do" class="dropdown-item">입출고 조회</a>
                    <a href="${pageContext.request.contextPath}/inout/register.do" class="dropdown-item">전표 등록</a>
                </div>
            </div>
            <div class="nav-item dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-chart-bar me-2"></i>통계분석</a>
                <div class="dropdown-menu bg-transparent border-0">
                    <a href="${pageContext.request.contextPath}/statistics/top-sales.do" class="dropdown-item">판매베스트</a>
                    <a href="${pageContext.request.contextPath}/statistics/product-sales.do" class="dropdown-item">상품매출통계</a>
                    <a href="${pageContext.request.contextPath}/statistics/daily-chart.do" class="dropdown-item">일별매출차트</a>
                    <a href="${pageContext.request.contextPath}/statistics/inout.do" class="dropdown-item">입출고 통계</a>
                </div>
            </div>
            <div class="nav-item dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-file-alt me-2"></i>결재관리</a>
                <div class="dropdown-menu bg-transparent border-0">
                    <a href="${pageContext.request.contextPath}/approval/documents.do" class="dropdown-item">결재문서</a>
                    <a href="${pageContext.request.contextPath}/approval/management.do" class="dropdown-item">결재문서관리</a>
                    <a href="${pageContext.request.contextPath}/tax-invoices.do" class="dropdown-item">세금계산서</a>
                    <a href="${pageContext.request.contextPath}/receipts.do" class="dropdown-item">영수증</a>
                </div>
            </div>
            <div class="nav-item dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-cog me-2"></i>설정</a>
                <div class="dropdown-menu bg-transparent border-0">
                    <a href="${pageContext.request.contextPath}/users.do" class="dropdown-item">사용자 관리</a>
                    <a href="${pageContext.request.contextPath}/roles.do" class="dropdown-item">권한 관리</a>
                    <a href="${pageContext.request.contextPath}/categories.do" class="dropdown-item">카테고리 관리</a>
                </div>
            </div>
            <div class="nav-item dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-sign-in-alt me-2"></i>인증</a>
                <div class="dropdown-menu bg-transparent border-0">
                    <a href="${pageContext.request.contextPath}/member/loginPage.do" class="dropdown-item">로그인</a>
                    <a href="${pageContext.request.contextPath}/member/enrollPage.do" class="dropdown-item">회원가입</a>
                    <a href="${pageContext.request.contextPath}/member/logout.do" class="dropdown-item">로그아웃</a>
                    <a href="${pageContext.request.contextPath}/member/pwdreset.do" class="dropdown-item">비밀번호 초기화</a>
                </div>
            </div>
        </div>
        <div class="emergency-contacts mt-3 ms-4">
            <h6 class="text-muted mb-1"><i class="fa fa-phone me-2"></i>비상연락망</h6>
            <p class="small text-muted mb-1">담당자: 김관리</p>
            <p class="small text-muted mb-1">전화: 010-1234-5678</p>
            <p class="small text-muted mb-0">이메일: emergency@stockmaster.com</p>
        </div>
    </nav>
</div> 