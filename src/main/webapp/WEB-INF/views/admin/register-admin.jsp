<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <title>Đăng kí tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        /* Reset cơ bản */
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    font-family: 'Poppins', sans-serif;
}

/* Toàn trang */
body {
    background: linear-gradient(135deg, #dcecff, #f0fff4);
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
}

/* Khung chính */
.container {
    width: 100%;
    max-width: 600px;
    padding: 20px;
}

/* Form đăng ký */
.register-form {
    background-color: #fff;
    border-radius: 16px;
    padding: 40px 30px;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;
    animation: fadeIn 0.6s ease-in-out;
}

.register-form:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 24px rgba(0, 0, 0, 0.15);
}

/* Tiêu đề */
.register-form h2 {
    font-weight: 600;
    color: #2c3e50;
    margin-bottom: 25px;
    text-align: center;
}

/* Label và input */
.form-label {
    font-weight: 500;
    color: #333;
    margin-bottom: 6px;
    display: inline-block;
}

.required-field::after {
    content: " *";
    color: #e74c3c;
}

.form-control {
    border: 1px solid #ccc;
    border-radius: 10px;
    padding: 10px 12px;
    font-size: 15px;
    transition: border-color 0.3s, box-shadow 0.3s;
}

.form-control:focus {
    border-color: #42b983;
    box-shadow: 0 0 0 3px rgba(66, 185, 131, 0.2);
    outline: none;
}

/* Nút đăng ký */
.btn-success {
    background-color: #42b983 !important;
    border: none;
    border-radius: 10px;
    font-weight: 600;
    letter-spacing: 0.5px;
    padding: 10px;
    transition: background-color 0.3s ease, transform 0.2s ease;
}

.btn-success:hover {
    background-color: #37a372 !important;
    transform: scale(1.03);
}

/* Link đăng nhập */
.register-form a {
    color: #42b983;
    text-decoration: none;
    font-weight: 500;
}

.register-form a:hover {
    text-decoration: underline;
}

/* Thông báo lỗi */
.text-danger {
    font-size: 14px;
    margin-top: 4px;
}

/* Thông báo nhỏ góc phải */
.message-top-right {
    position: fixed;
    top: 20px;
    right: 30px;
    background: #ffe0e0;
    color: #d8000c;
    padding: 10px 24px;
    border-radius: 8px;
    box-shadow: 0 2px 8px #bbb;
    font-weight: bold;
    z-index: 9999;
    animation: fadeInOut 3s ease-in-out;
}

/* Hiệu ứng */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes fadeInOut {
    0% { opacity: 0; transform: translateY(-10px); }
    10%, 90% { opacity: 1; transform: translateY(0); }
    100% { opacity: 0; transform: translateY(-10px); }
}

/* Responsive */
@media (max-width: 576px) {
    .register-form {
        padding: 30px 20px;
    }
}

    </style>
</head>
<body>
<c:if test="${not empty message}">
    <div id="message" class="message-top-right">${message}</div>
    <script>
        window.onload = function () {
            const x = document.getElementById("message");
            if(x){
                setTimeout(() => {
                    x.style.display = "none";
                }, 2000);
            }
        }
    </script>
</c:if>
<div class="container">
    <div class="register-form">
        <h2 class="text-center mb-4">Đăng kí tài khoản</h2>

        <form:form modelAttribute="RegistDto" action="/admin/register-admin" method="post">

            <!-- Email (dùng làm tên đăng nhập) -->
            <div class="mb-3">
                <label for="email" class="form-label required-field">Email (Tài khoản):</label>
                <form:input path="email" cssClass="form-control" id="email"/>
                <form:errors path="email" cssClass="text-danger"/>
            </div>

            <!-- Mật khẩu -->
            <div class="mb-3">
                <label for="password" class="form-label required-field">Mật khẩu:</label>
                <form:password path="password" cssClass="form-control" id="password"/>
                <form:errors path="password" cssClass="text-danger"/>
            </div>
            <button type="submit" class="btn btn-success w-100">
                <i class="fa fa-user-plus me-2"></i> Đăng ký
            </button>
            <div class="mt-3">
                Nếu bạn đã có tài khoản,
                <a href="/admin/login">đăng nhập tại đây</a>
            </div>
        </form:form>
    </div>
</div>
</body>
</html>
