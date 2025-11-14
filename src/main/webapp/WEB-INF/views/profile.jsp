<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <title>Cập nhật thông tin cá nhân</title>

    <style>
        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            background-color: #f5f6fa;
            margin: 0;
        }

        /* Bố cục tổng thể */
        .main-layout {
            display: flex;
            align-items: flex-start;
            justify-content: center;
            padding-top: 80px; /* tránh bị header che */
            gap: 40px;
        }

        /* Sidebar */
        .sidebar-wrapper {
            margin-left: 60px; /* đẩy sidebar ra khỏi mép trái */
        }

        /* Container form */
        .form-container {
            background-color: #fff;
            width: 420px;
            margin-top: 40px;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 25px;
            font-weight: 700;
            font-size: 22px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #333;
        }
/* 
        input[type="text"] {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        } */

        .submit-profile {
            width: 100%;
            padding: 12px;
            background-color: #1abc9c;
            color: #fff;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
        }

        .submit-profile:hover {
            background-color: #16a085;
        }

        .text-danger {
            font-size: 13px;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <jsp:include page="user/layout/header.jsp"/>

    <div class="main-layout">
        <!-- Sidebar -->
        <div class="sidebar-wrapper">
            <jsp:include page="user/layout/sidebar.jsp"/>
        </div>

        <!-- Form cập nhật thông tin -->
        <div class="form-container">
            <c:if test="${not empty error}">
                <div class="text-danger" style="margin-bottom: 10px;">
                    ${error}
                </div>
            </c:if>

            <h2>Cập nhật thông tin</h2>
            <form:form action="${pageContext.request.contextPath}/postFile" method="post" modelAttribute="InfoDto">
                <!-- Họ và tên -->
                <div class="mb-3">
                    <label for="name" class="form-label">Họ và tên</label>
                    <form:input path="name" type="text" cssClass="form-control" id="name"/>
                    <form:errors path="name" cssClass="text-danger"/>
                </div>

                <!-- Số điện thoại -->
                <div class="mb-3">
                    <label for="phoneNumber" class="form-label">Số điện thoại</label>
                    <form:input path="phoneNumber" type="text" cssClass="form-control" id="phoneNumber"/>
                    <form:errors path="phoneNumber" cssClass="text-danger"/>
                </div>

                <!-- Địa chỉ -->
                <div class="mb-3">
                    <label for="address" class="form-label">Địa chỉ</label>
                    <form:input path="address" type="text" cssClass="form-control" id="address"/>
                    <form:errors path="address" cssClass="text-danger"/>
                </div>

                <!-- Nút xác nhận -->
                <button type="submit" class="submit-profile">Xác nhận</button>
            </form:form>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="user/layout/footer.jsp"/>

</body>
</html>
