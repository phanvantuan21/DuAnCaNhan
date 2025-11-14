<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="vi">
<head>
    <title>Đăng nhập - BeeStore Admin</title>
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

        .login-container {
            display: flex;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 6px 24px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            max-width: 960px;
            width: 100%;
            min-height: 520px;
        }

        /* BÊN TRÁI: ẢNH MINH HỌA */
        .login-image {
            flex: 1.2;
            background-color: #f4f6f6;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px;
        }

        .login-image img {
            width: 100%;
            max-width: 420px;
            height: auto;
            object-fit: contain;
        }

        /* BÊN PHẢI: FORM */
        .login-form {
            flex: 1;
            padding: 60px 50px;
            background: #fff;
        }

        .login-form h2 {
            font-weight: 700;
            color: #111827;
            margin-bottom: 10px;
        }

        .login-form p {
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

        .btn-primary {
            background-color: #22c55e;
            border: none;
            font-weight: 600;
            border-radius: 10px;
            padding: 10px;
            transition: all 0.2s ease;
        }

        .btn-primary:hover {
            background-color: #16a34a;
            transform: translateY(-1px);
        }

        .text-muted {
            color: #6b7280 !important;
        }

        .login-form a {
            color: #22c55e;
            text-decoration: none;
            font-weight: 500;
        }

        .login-form a:hover {
            text-decoration: underline;
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
            .login-container {
                flex-direction: column;
                text-align: center;
            }

            .login-image {
                padding: 30px;
            }

            .login-form {
                padding: 40px 24px;
            }
        }
    </style>
</head>
<body>

<c:if test="${not empty message}">
    <div id="message" class="message-top-right">
        ${message}
    </div>
</c:if>

<jsp:include page="user/layout/header.jsp"/>

<main>
    <div class="login-container">
        <!-- ẢNH BÊN TRÁI -->
        <div class="login-image">
            <img src="/images/admin-login-illustration.png" alt="Đăng nhập BeeStore Admin">
        </div>

        <!-- FORM BÊN PHẢI -->
        <div class="login-form">
            <h2>Chào mừng bạn đến với BeeStore</h2>
            <p>Đăng nhập để truy cập trang quản trị cửa hàng.</p>

            <form action="/Login" method="post">
                <div class="mb-3 text-start">
                    <label class="form-label">Tên tài khoản:</label>
                    <input type="text" name="name" class="form-control" required>
                </div>
                <div class="mb-3 text-start">
                    <label class="form-label">Mật khẩu:</label>
                    <input type="password" name="password" class="form-control" required>
                </div>

                <div class="text-end mb-3">
                    <a href="/forgot-password">Quên mật khẩu?</a>
                </div>

                <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>

                <div class="mt-3 text-center text-muted">
                    Nếu bạn chưa có tài khoản,
                    <a href="/DangKy">đăng ký tại đây</a>
                </div>
            </form>
        </div>
    </div>
</main>

<jsp:include page="user/layout/footer.jsp"/>

</body>
</html>
