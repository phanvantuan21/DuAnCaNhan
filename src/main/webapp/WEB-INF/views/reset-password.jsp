<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt Lại Mật Khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #f8f9fa;
        }
        .form-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 40px;
            border: 1px solid #ddd;
            border-radius: 12px;
            background-color: #fff;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .message {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="form-container">
        <h2 class="text-center mb-4">Đặt Lại Mật Khẩu</h2>
        <p class="text-center">Vui lòng nhập mã xác minh và mật khẩu mới của bạn.</p>

        <form id="resetPasswordForm">
            <div class="form-group mb-3">
                <label for="verificationCode" class="form-label">Mã xác minh:</label>
                <input type="text" class="form-control" id="verificationCode" name="code" required>
            </div>
            <div class="form-group mb-3">
                <label for="newPassword" class="form-label">Mật khẩu mới:</label>
                <input type="password" class="form-control" id="newPassword" name="newPassword" required>
            </div>
            <div class="form-group mb-3">
                <label for="confirmPassword" class="form-label">Nhập lại mật khẩu mới:</label>
                <input type="password" class="form-control" id="confirmPassword" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Đặt lại mật khẩu</button>
        </form>

        <div id="message" class="message"></div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {
        $('#resetPasswordForm').on('submit', function(e) {
            e.preventDefault();
            var newPassword = $('#newPassword').val();
            var confirmPassword = $('#confirmPassword').val();

            if (newPassword !== confirmPassword) {
                $('#message').html('<div class="alert alert-danger">Mật khẩu mới không khớp.</div>');
                return;
            }

            var code = $('#verificationCode').val();

            $('#message').html('<div class="alert alert-info">Đang xử lý...</div>');

            $.ajax({
                type: 'POST',
                url: '/api/auth/reset-password',
                data: { code: code, newPassword: newPassword },
                success: function(response) {
                    $('#message').html('<div class="alert alert-success">' + response + '</div>');
                },
                error: function(xhr) {
                    $('#message').html('<div class="alert alert-danger">' + xhr.responseText + '</div>');
                }
            });
        });
    });
</script>
</body>
</html>