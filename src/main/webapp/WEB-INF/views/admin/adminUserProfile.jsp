<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết khách hàng</title>

    <!-- Bootstrap 5 & Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">

    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
        }
        
        .profile-container {
            display: flex;
            min-height: 100vh;
        }
        
        .sidebar-wrapper { 
            flex: 0 0 280px;
        }
        
        .content-wrapper { 
            flex: 1;
            padding: 20px;
        }

        .profile-card {
            background: white;
            border-radius: 12px;
            padding: 32px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            max-width: 900px;
        }

        .profile-header {
            background: #ffc107;
            color: #000;
            padding: 12px 20px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 16px;
            margin-bottom: 32px;
            display: inline-block;
        }

        .info-group {
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 1px solid #f0f0f0;
        }
        .info-group:last-of-type {
            border-bottom: none;
        }
        .info-label { 
            font-weight: 600; 
            color: #666; 
            margin-bottom: 8px;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .info-value { 
            font-size: 16px; 
            color: #333;
        }

        .btn-back {
            background: white;
            color: #666;
            padding: 12px 28px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
            transition: all 0.2s;
        }
        .btn-back:hover { 
            background: #f8f8f8; 
            border-color: #d0d0d0; 
            color: #333;
        }
    </style>
</head>

<body>

<div class="profile-container">
    <!-- Sidebar -->
    <div class="sidebar-wrapper">
        <jsp:include page="layout/sidebar.jsp"/>
    </div>

    <!-- Content -->
    <div class="content-wrapper">
        <jsp:include page="layout/header.jsp"/>
        
        <div class="profile-card">
            <div class="profile-header">Thông tin chi tiết khách hàng</div>

            <div class="info-group">
                <div class="info-label">Mã khách hàng</div>
                <div class="info-value"><c:out value="${customer.code}"/></div>
            </div>

            <div class="info-group">
                <div class="info-label">Tên khách hàng</div>
                <div class="info-value"><c:out value="${customer.name}"/></div>
            </div>

            <div class="info-group">
                <div class="info-label">Email</div>
                <div class="info-value">
                    <c:choose>
                        <c:when test="${not empty customer.email}">
                            <c:out value="${customer.email}"/>
                        </c:when>
                        <c:otherwise><em style="color: #999;">Chưa cập nhật</em></c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="info-group">
                <div class="info-label">Số điện thoại</div>
                <div class="info-value"><c:out value="${customer.phoneNumber}"/></div>
            </div>

            <div class="info-group">
                <div class="info-label">Địa chỉ</div>
                <div class="info-value"><c:out value="${address.address}"/></div>
            </div>

            <div class="mt-4">
                <a href="/Home" class="btn-back">
                    <i class="fas fa-arrow-left"></i> Quay lại danh sách
                </a>
            </div>
        </div>
    </div>
</div>

</body>
</html>