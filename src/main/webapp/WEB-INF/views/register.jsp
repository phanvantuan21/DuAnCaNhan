<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Đăng ký tài khoản - BeeStore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background-color: #f9fafb;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 60px 20px;
        }

        .register-container {
            display: flex;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 6px 24px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            max-width: 960px;
            width: 100%;
            min-height: 520px;
        }

        /* BÊN TRÁI - ẢNH */
        .register-image {
            flex: 1.2;
            background-color: #f4f6f6;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px;
        }

        .register-image img {
            width: 100%;
            max-width: 420px;
            height: auto;
            object-fit: contain;
        }

        /* BÊN PHẢI - FORM */
        .register-form {
            flex: 1;
            padding: 60px 50px;
            background: #fff;
        }

        .register-form h2 {
            font-weight: 700;
            color: #111827;
            margin-bottom: 10px;
        }

        .register-form p {
            color: #6b7280;
            margin-bottom: 28px;
        }

        .form-label {
            font-weight: 600;
            color: #374151;
        }

        .form-control {
            border-radius: 10px;
            border: 1px solid #d1d5db;
            padding: 10px 14px;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            border-color: #22c55e;
            box-shadow: 0 0 0 0.25rem rgba(34, 197, 94, 0.25);
        }

        .btn-success {
            background-color: #22c55e;
            border: none;
            font-weight: 600;
            border-radius: 10px;
            padding: 10px;
            transition: all 0.2s ease;
        }

        .btn-success:hover {
            background-color: #16a34a;
            transform: translateY(-1px);
        }

        .register-form a {
            color: #22c55e;
            text-decoration: none;
            font-weight: 500;
        }

        .register-form a:hover {
            text-decoration: underline;
        }

        .text-danger {
            font-size: 0.875rem;
            margin-top: 4px;
        }

        .required-field::after {
            content: " *";
            color: red;
        }

        /* Thông báo */
        .message-top-right {
            position: fixed;
            top: 100px;
            right: 32px;
            background: #ffe0e0;
            color: #d8000c;
            padding: 10px 24px;
            border-radius: 8px;
            box-shadow: 0 2px 8px #bbb;
            font-weight: bold;
            z-index: 9999;
        }

        /* RESPONSIVE */
        @media (max-width: 992px) {
            .register-container {
                flex-direction: column;
                text-align: center;
            }

            .register-image {
                padding: 30px;
            }

            .register-form {
                padding: 40px 24px;
            }
        }
    </style>
</head>

<body>
<jsp:include page="user/layout/header.jsp"/>

<c:if test="${not empty message}">
    <div id="message" class="message-top-right">${message}</div>
    <script>
        window.onload = function () {
            const x = document.getElementById("message");
            if (x) {
                setTimeout(() => {
                    x.style.display = "none";
                }, 2500);
            }
        }
    </script>
</c:if>

<main>
    <div class="register-container">
        <!-- HÌNH ẢNH -->
        <div class="register-image">
            <img src="/images/admin-login-illustration.png" alt="Đăng ký BeeStore">
        </div>

        <!-- FORM ĐĂNG KÝ -->
        <div class="register-form">
            <h2>Tạo tài khoản BeeStore</h2>
            <p>Đăng ký để mua sắm và quản lý đơn hàng dễ dàng hơn.</p>

            <form:form modelAttribute="RegistDto" action="/DangKy" method="post">
                <div class="mb-3 text-start">
                    <label for="email" class="form-label required-field">Email (Tài khoản):</label>
                    <form:input path="email" cssClass="form-control" id="email"/>
                    <form:errors path="email" cssClass="text-danger"/>
                </div>

                <div class="mb-3 text-start">
                    <label for="password" class="form-label required-field">Mật khẩu:</label>
                    <form:password path="password" cssClass="form-control" id="password"/>
                    <form:errors path="password" cssClass="text-danger"/>
                </div>

                <button type="submit" class="btn btn-success w-100">Đăng ký</button>

                <div class="mt-3 text-center text-muted">
                    Đã có tài khoản?
                    <a href="/Login">Đăng nhập tại đây</a>
                </div>
            </form:form>
        </div>
    </div>
</main>

<jsp:include page="user/layout/footer.jsp"/>
</body>
</html>
