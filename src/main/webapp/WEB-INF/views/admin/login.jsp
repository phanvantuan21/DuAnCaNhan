<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Đăng nhập</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <style>
        body {
            margin: 0;
            background: #f8f9fa;
            display: flex;
            flex-direction: column; /* sắp xếp từ trên xuống */
            min-height: 100vh;
        }

        main {
            flex: 1; /* chiếm không gian giữa header và footer */
            display: flex;
            justify-content: center;
            align-items: center; /* căn giữa login-box */
        }

        .login-box {
            padding: 40px 32px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            min-width: 320px;
            text-align: center;
        }

        .message-top-right {
            position: fixed;
            top: 24px;
            right: 32px;
            background: #ffe0e0;
            color: #d8000c;
            padding: 10px 24px;
            border-radius: 8px;
            box-shadow: 0 2px 8px #bbb;
            font-weight: bold;
            z-index: 9999;
        }

        .login-box a {
            text-decoration: none;
            color: #0d6efd;
            transition: color 0.2s;
        }

        .login-box a:hover {
            color: #0a58ca;
            text-decoration: underline;
        }

        .login-box .form-label {
            font-weight: 500;
        }
    </style>
</head>
<body>
<c:if test="${not empty message}">
    <div id="message" class="message-top-right">
        ${message}
    </div>
</c:if>
<!-- MAIN -->
<main>
    <div class="login-box">
        <h2 class="mb-4">Đăng nhập</h2>
        <form action="/admin/login" method="post">
            <div class="mb-3 text-start">
                <label class="form-label">Tên tài khoản:</label>
                <input type="text" name="name" class="form-control" required/>
            </div>
            <div class="mb-3 text-start">
                <label class="form-label">Mật khẩu:</label>
                <input type="password" name="password" class="form-control" required/>
            </div>
            <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
            <div class="mt-3 text-start">
                <a href="/forgot-password">Quên mật khẩu?</a><br/>
                Nếu bạn chưa có tài khoản,
                <a href="/admin/register-admin">đăng ký tại đây</a>
            </div>
        </form>
    </div>
</main>

</body>
</html>
