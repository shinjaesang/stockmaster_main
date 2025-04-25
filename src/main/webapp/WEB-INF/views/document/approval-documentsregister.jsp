<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <title>Stockmaster - 전자문서 작성</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">

    <!-- Critical CSS -->
    <style>
        .spinner-border {
            display: inline-block;
            width: 2rem;
            height: 2rem;
            vertical-align: text-bottom;
            border: .25em solid currentColor;
            border-right-color: transparent;
            border-radius: 50%;
            animation: spinner-border .75s linear infinite;
        }

        @keyframes spinner-border {
            to {
                transform: rotate(360deg);
            }
        }

        #spinner {
            opacity: 0;
            visibility: hidden;
            transition: opacity .5s ease-out, visibility 0s linear .5s;
            z-index: 99999;
        }

        #spinner.show {
            transition: opacity .5s ease-out, visibility 0s linear 0s;
            visibility: visible;
            opacity: 1;
        }

        .content {
            opacity: 0;
            transition: opacity 0.3s ease-in;
        }

        .content.show {
            opacity: 1;
        }
    </style>
</head>

<body>
    <div class="container-fluid position-relative bg-white d-flex p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->

        <!-- Sidebar Start -->
        <jsp:include page="../common/sidebar.jsp" />
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <jsp:include page="../common/navbar.jsp" />
            <!-- Navbar End -->

            <!-- 문서 작성 폼 시작 -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h5 class="mb-0">전자문서 등록</h5>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/document/register.do" method="post" enctype="multipart/form-data">
                        <!-- 문서 기본 정보 -->
                        <div class="row mb-3">
                            <!-- 문서 제목 -->
                            <div class="col-12 mb-3">
                                <label for="title" class="form-label">문서 제목</label>
                                <input type="text" class="form-control" id="title" name="title" 
                                    placeholder="문서 제목을 입력하세요" required>
                            </div>
                            
                            <!-- 기안자 정보 -->
                            <div class="col-md-6 mb-3">
                                <label for="writer" class="form-label">기안자</label>
                                <input type="text" class="form-control" id="writer" name="writer" 
                                    value="${sessionScope.username}" readonly>
                            </div>
                            
                            <!-- 작성일자 -->
                            <div class="col-md-6 mb-3">
                                <label for="writeDate" class="form-label">작성일자</label>
                                <input type="date" class="form-control" id="writeDate" name="writeDate" 
                                    value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
                            </div>
                        </div>

                        <!-- 결재선 지정 -->
                        <div class="mb-4">
                            <label class="form-label">결재선</label>
                            <div class="d-flex gap-2 mb-2">
                                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="openEmployeeSearch('결재자')">
                                    결재자 추가
                                </button>
                                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="openEmployeeSearch('검토자')">
                                    검토자 추가
                                </button>
                                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="openEmployeeSearch('참조자')">
                                    참조자 추가
                                </button>
                            </div>
                            
                            <!-- 결재선 표시 영역 -->
                            <div class="bg-white rounded p-3 border">
                                <div class="row">
                                    <!-- 기안 -> 참조로 변경 -->
                                    <div class="col-md-4">
                                        <h6 class="text-center mb-2">참조</h6>
                                        <div class="border rounded p-2" style="min-height: 80px">
                                            <div class="text-center" id="referrerArea">
                                                <!-- 참조자가 추가되면 여기에 표시 -->
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- 검토 -->
                                    <div class="col-md-4">
                                        <h6 class="text-center mb-2">검토</h6>
                                        <div class="border rounded p-2" style="min-height: 80px">
                                            <div class="text-center" id="reviewerArea">
                                                <!-- 검토자가 추가되면 여기에 표시 -->
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- 승인 -->
                                    <div class="col-md-4">
                                        <h6 class="text-center mb-2">승인</h6>
                                        <div class="border rounded p-2" style="min-height: 80px">
                                            <div class="text-center" id="approverArea">
                                                <!-- 승인자가 추가되면 여기에 표시 -->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 문서 유형 -->
                        <div class="mb-3">
                            <label for="documentType" class="form-label">문서 유형</label>
                            <select class="form-select" id="documentType" name="documentType" required>
                                <option value="">문서 유형을 선택하세요</option>
                                <option value="지출결의서">지출결의서</option>
                                <option value="품의서">품의서</option>
                                <option value="입고요청서">입고요청서</option>
                                <option value="출고요청서">출고요청서</option>
                                <option value="기안서">기안서</option>
                                <option value="보고서">보고서</option>
                            </select>
                        </div>

                        <!-- 문서 내용 -->
                        <div class="mb-3">
                            <label for="content" class="form-label">내용</label>
                            <textarea class="form-control" id="content" name="content" 
                                rows="10" placeholder="내용을 입력하세요" required></textarea>
                        </div>

                        <!-- 첨부파일 -->
                        <div class="mb-4">
                            <label for="attachments" class="form-label">첨부 파일</label>
                            <div class="input-group">
                                <input type="file" class="form-control" id="attachments" name="attachments" multiple>
                                <button type="button" class="btn btn-outline-secondary" onclick="document.getElementById('attachments').value = ''">
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                            <div class="form-text">파일 용량 (최대 20MB)</div>
                        </div>

                        <!-- 버튼 그룹 -->
                        <div class="d-flex justify-content-end gap-2">
                            <button type="button" class="btn btn-secondary" onclick="history.back()">
                                취소
                            </button>
                            <button type="button" class="btn btn-outline-primary" onclick="saveTemp()">
                                임시저장
                            </button>
                            <button type="submit" class="btn btn-dark">
                                결재상신
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- 문서 작성 폼 끝 -->

            <!-- Footer Start -->
            <jsp:include page="../common/footer.jsp" />
            <!-- Footer End -->
        </div>
        <!-- Content End -->

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top">
            <i class="bi bi-arrow-up"></i>
        </a>
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/chart/chart.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/easing/easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/waypoints/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/tempusdominus/js/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>

    <!-- Page specific Javascript -->
    <script>
        $(document).ready(function() {
            // 페이지 로드 시 스피너 숨기기
            hideSpinner();
        });

        // 스피너 제어 함수
        function showSpinner() {
            $('#spinner').addClass('show');
        }

        function hideSpinner() {
            $('#spinner').removeClass('show');
            $('.content').addClass('show');
        }

        // 결재선 지정 함수
        function openEmployeeSearch(type) {
            // TODO: 사원 검색 모달 구현
            alert(type + ' 검색 기능은 추후 구현될 예정입니다.');
        }

        // 임시저장 함수
        function saveTemp() {
            // TODO: 임시저장 기능 구현
            alert('임시저장 기능은 추후 구현될 예정입니다.');
        }

        // 참조자 추가 함수
        function addReferrer(department, name) {
            const referrerArea = document.getElementById('referrerArea');
            const referrerDiv = document.createElement('div');
            referrerDiv.className = 'mb-2';
            referrerDiv.innerHTML = `
                <div class="fw-bold">${name}</div>
                <div class="small text-muted">${department}</div>
            `;
            referrerArea.appendChild(referrerDiv);
        }
    </script>
</body>
</html>