<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quên Mật Khẩu</title>
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
        <h2 class="text-center mb-4">Quên Mật Khẩu</h2>
        <p class="text-center">Vui lòng nhập địa chỉ email của bạn để nhận mã xác minh.</p>

        <form id="forgotPasswordForm">
            <div class="form-group mb-3">
                <label for="email" class="form-label">Email:</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Gửi mã xác minh</button>
        </form>

        <div id="message" class="message"></div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {
        $('#forgotPasswordForm').on('submit', function(e) {
            e.preventDefault();
            var email = $('#email').val();

            $('#message').html('<div class="alert alert-info">Đang gửi yêu cầu...</div>');

            $.ajax({
                type: 'POST',
                url: '/api/auth/forgot-password',
                data: { email: email },
                success: function(response) {
                    $('#message').html('<div class="alert alert-success">' + response + '</div>');
                     setTimeout(function() {

                         window.location.href = 'reset-password';
                    }, 3000);
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