<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>결재선 지정</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    
    <style>
        .user-list {
            height: 400px;
            overflow-y: auto;
        }
        .selected-users {
            min-height: 100px;
            border: 1px solid #ddd;
            padding: 10px;
            margin-top: 10px;
        }
        .user-item {
            cursor: pointer;
            padding: 5px;
            margin: 2px 0;
        }
        .user-item:hover {
            background-color: #f8f9fa;
        }
        .selected-user {
            background-color: #e9ecef;
            padding: 5px;
            margin: 2px;
            border-radius: 3px;
            display: inline-block;
        }
        .remove-user {
            cursor: pointer;
            margin-left: 5px;
            color: #dc3545;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container-fluid p-4">
        <h5 class="mb-4">
            <c:choose>
                <c:when test="${param.type eq 'reviewer'}">검토자</c:when>
                <c:when test="${param.type eq 'approver'}">결재자</c:when>
                <c:when test="${param.type eq 'referrer'}">참조자</c:when>
            </c:choose>
            지정
        </h5>

        <div class="row">
            <!-- 부서 목록 -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h6 class="mb-0">부서</h6>
                    </div>
                    <div class="card-body user-list">
                        <c:forEach items="${departments}" var="dept">
                            <div class="user-item department" data-department="${dept.id}">
                                <i class="fas fa-building me-2"></i>${dept.name}
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- 사용자 목록 -->
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h6 class="mb-0">사용자</h6>
                        <div class="input-group" style="width: 200px;">
                            <input type="text" class="form-control form-control-sm" id="searchUser" placeholder="사용자 검색">
                            <button class="btn btn-outline-secondary btn-sm" type="button">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                    <div class="card-body user-list">
                        <c:forEach items="${users}" var="user">
                            <div class="user-item user" data-user-id="${user.id}" data-department="${user.departmentId}">
                                <i class="fas fa-user me-2"></i>${user.name} (${user.position})
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <!-- 선택된 사용자 -->
        <div class="mt-4">
            <h6>선택된 ${param.type eq 'reviewer' ? '검토자' : param.type eq 'approver' ? '결재자' : '참조자'}</h6>
            <div class="selected-users" id="selectedUsers"></div>
        </div>

        <!-- 버튼 -->
        <div class="text-end mt-4">
            <button type="button" class="btn btn-secondary" onclick="window.close()">취소</button>
            <button type="button" class="btn btn-primary" onclick="confirmSelection()">확인</button>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        let selectedUsers = [];

        // 부서 클릭 시 해당 부서의 사용자만 표시
        $(document).on('click', '.department', function() {
            const departmentId = $(this).data('department');
            $('.user').hide();
            $('.user[data-department="' + departmentId + '"]').show();
            $('.department').removeClass('active');
            $(this).addClass('active');
        });

        // 사용자 검색
        $('#searchUser').on('input', function() {
            const searchText = $(this).val().toLowerCase();
            $('.user').each(function() {
                const userName = $(this).text().toLowerCase();
                $(this).toggle(userName.includes(searchText));
            });
        });

        // 사용자 선택
        $(document).on('click', '.user', function() {
            const userId = $(this).data('user-id');
            const userName = $(this).text();
            
            // 중복 선택 방지
            if (!selectedUsers.find(user => user.id === userId)) {
                selectedUsers.push({
                    id: userId,
                    name: userName
                });
                updateSelectedUsers();
            }
        });

        // 선택된 사용자 제거
        $(document).on('click', '.remove-user', function() {
            const userId = $(this).data('user-id');
            selectedUsers = selectedUsers.filter(user => user.id !== userId);
            updateSelectedUsers();
        });

        // 선택된 사용자 목록 업데이트
        function updateSelectedUsers() {
            const container = $('#selectedUsers');
            container.empty();
            
            selectedUsers.forEach(user => {
                container.append(`
                    <div class="selected-user">
                        ${user.name}
                        <i class="fas fa-times remove-user" data-user-id="${user.id}"></i>
                    </div>
                `);
            });
        }

        // 선택 확인
        function confirmSelection() {
            if (selectedUsers.length === 0) {
                alert('선택된 사용자가 없습니다.');
                return;
            }

            // 부모 창의 함수 호출
            window.opener.setApprovalLine('${param.type}', selectedUsers);
            window.close();
        }
    </script>
</body>
</html>