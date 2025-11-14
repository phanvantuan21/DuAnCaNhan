<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thông tin cá nhân</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">

    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: #f5f5f5;
            display: flex;
            flex-direction: column;
        }

        /* Layout */
        .profile-container {
            display: flex;
            align-items: flex-start;
            gap: 24px;
            max-width: 1200px;
            margin: 100px auto 40px;
            padding: 0 20px;
        }

        .sidebar-wrapper {
            flex: 0 0 220px;
        }

        .content-wrapper {
            flex: 1;
            min-width: 0;
        }

        /* Profile Card */
        .profile-card {
            background: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            max-width: 600px;
        }

        /* Header */
        .profile-header {
            background: #ffd400;
            color: #000;
            padding: 8px 16px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 16px;
            margin-bottom: 24px;
            display: inline-block;
        }

        /* Info Section */
        .info-section {
            margin-bottom: 24px;
        }

        .info-group {
            margin-bottom: 20px;
            padding-bottom: 16px;
            border-bottom: 1px solid #f5f5f5;
        }

        .info-group:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .info-label {
            font-size: 13px;
            color: #666;
            margin-bottom: 6px;
        }

        .info-value {
            font-size: 15px;
            color: #333;
            font-weight: 500;
        }

        .info-value em {
            color: #999;
            font-weight: 400;
        }

        /* Buttons */
        .btn-edit {
            background: #4CAF50;
            color: white;
            padding: 10px 24px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-edit:hover {
            background: #45a049;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
        }

        .btn-back {
            background: white;
            color: #666;
            padding: 10px 24px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-back:hover {
            background: #f8f8f8;
            border-color: #d0d0d0;
            color: #333;
        }

        .action-buttons {
            display: flex;
            gap: 12px;
            padding-top: 20px;
            border-top: 1px solid #f0f0f0;
        }

        /* Modal Styling */
        .modal-content {
            border-radius: 12px;
            border: none;
            box-shadow: 0 8px 32px rgba(0,0,0,0.2);
        }

        .modal-header {
            background: #4CAF50;
            color: white;
            border-radius: 12px 12px 0 0;
            padding: 16px 24px;
            border-bottom: none;
        }

        .modal-header .btn-close {
            filter: brightness(0) invert(1);
        }

        .modal-title {
            font-weight: 600;
            font-size: 18px;
        }

        .modal-body {
            padding: 24px;
        }

        .modal-footer {
            padding: 16px 24px;
            border-top: 1px solid #f0f0f0;
        }

        .form-label {
            font-size: 14px;
            font-weight: 500;
            color: #333;
            margin-bottom: 8px;
        }

        .form-control {
            padding: 10px 14px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.2s;
        }

        .form-control:focus {
            outline: none;
            border-color: #4CAF50;
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
        }

        .modal-footer .btn {
            padding: 10px 24px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
        }

        .modal-footer .btn-secondary {
            background: #e0e0e0;
            color: #666;
            border: none;
        }

        .modal-footer .btn-primary {
            background: #4CAF50;
            border: none;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .profile-container {
                flex-direction: column;
                margin-top: 80px;
            }

            .sidebar-wrapper {
                width: 100%;
            }

            .profile-card {
                max-width: 100%;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn-back, .btn-edit {
                width: 100%;
                justify-content: center;
            }
        }
        
    </style>
</head>

<body>
<jsp:include page="user/layout/header.jsp"/>

<div class="profile-container">
    <!-- Sidebar -->
    <div class="sidebar-wrapper">
        <jsp:include page="user/layout/sidebar.jsp"/>
    </div>

    <!-- Content -->
    <div class="content-wrapper">
        <div class="profile-card">
            <!-- Header with Yellow Badge -->
            <div class="profile-header">
                Thông tin cá nhân
            </div>

            <!-- Info Section -->
            <div class="info-section">
                <div class="info-group">
                    <div class="info-label">Mã khách hàng:</div>
                    <div class="info-value">
                        <c:out value="${customer.code}"/>
                    </div>
                </div>

                <div class="info-group">
                    <div class="info-label">Email khách hàng:</div>
                    <div class="info-value">
                        <c:choose>
                            <c:when test="${not empty customer.email}">
                                <c:out value="${customer.email}"/>
                            </c:when>
                            <c:otherwise>
                                <em>Chưa cập nhật</em>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="info-group">
                    <div class="info-label">Tên khách hàng:</div>
                    <div class="info-value">
                        <c:out value="${customer.name}"/>
                    </div>
                </div>

                <div class="info-group">
                    <div class="info-label">Số điện thoại:</div>
                    <div class="info-value">
                        <c:out value="${customer.phoneNumber}"/>
                    </div>
                </div>

                <div class="info-group">
                    <div class="info-label">Địa chỉ:</div>
                    <div class="info-value">
                        <c:out value="${address.address}"/>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="action-buttons">
                <a href="/" class="btn-back">
                    <i class="fas fa-arrow-left"></i>
                    Trở về trang chủ
                </a>
                <button type="button" class="btn-edit" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                    <i class="fas fa-edit"></i>
                    Sửa thông tin
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Modal sửa thông tin -->
<div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/updateProfile" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="editProfileModalLabel">
                        <i class="fas fa-user-edit me-2"></i>Sửa thông tin cá nhân
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    <div class="mb-3">
                        <label for="editEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="editEmail" name="email"
                               value="${customer.email}" placeholder="Nhập email của bạn">
                    </div>

                    <div class="mb-3">
                        <label for="editName" class="form-label">Tên khách hàng</label>
                        <input type="text" class="form-control" id="editName" name="name"
                               value="${customer.name}" required placeholder="Nhập tên của bạn">
                    </div>

                    <div class="mb-3">
                        <label for="editPhone" class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" id="editPhone" name="phoneNumber"
                               value="${customer.phoneNumber}" required placeholder="Nhập số điện thoại">
                    </div>

                    <div class="mb-3">
                        <label for="editAddress" class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" id="editAddress" name="address"
                               value="${address.address}" required placeholder="Nhập địa chỉ của bạn">
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>Hủy
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-1"></i>Lưu thay đổi
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>


</body>
<jsp:include page="user/layout/footer.jsp"/>
</html>