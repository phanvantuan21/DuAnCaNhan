<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán đơn hàng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Segoe UI', sans-serif;
        }
        .countdown {
            font-weight: bold;
            color: #d35400;
        }
    </style>
</head>
<body>   

<div class="container py-5">
    <div class="card shadow mx-auto" style="max-width: 500px;">
        <div class="card-body text-center">
            <h4 class="card-title text-primary">🔐 Quét mã QR để thanh toán</h4>
            <p class="card-text">Mã đơn hàng: <strong class="text-danger">${billCode}</strong></p>

            <img src="${qrUrl}" alt="QR Code" class="img-fluid border rounded mb-3" style="max-width: 250px;">

            <p class="text-muted">💡 Sau khi chuyển khoản, đơn hàng sẽ được tự động xác nhận.</p>

            <p class="mb-0">⏳ Mã QR sẽ hết hạn sau: <span class="countdown" id="countdown">05:00</span></p>

            <div id="status" class="mt-3 text-success fw-bold">⏱ Đang chờ thanh toán...</div>

            <a href="/orders/${billId}" class="btn btn-outline-primary mt-4">🔍 Xem đơn hàng</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS + Countdown + Auto Check -->
<script>
        // Countdown 5 phút
    let timeLeft = 5 * 60; // 5 phút
    const countdownEl = document.getElementById("countdown");

    const timer = setInterval(() => {
        const minutes = Math.floor(timeLeft / 60);
        const seconds = timeLeft % 60;
        countdownEl.textContent = minutes.toString().padStart(2, '0') + ":" + seconds.toString().padStart(2, '0');
        timeLeft--;

        if (timeLeft < 0) {
            clearInterval(timer);
            document.getElementById("status").textContent = "❌ Hết thời gian thanh toán.";
            document.getElementById("status").classList.remove("text-success");
            document.getElementById("status").classList.add("text-danger");
        }
    }, 1000);

    // Auto check (giả lập - thay bằng gọi API kiểm tra)
    const checkInterval = setInterval(async () => {
        try {
            const response = await fetch("/api/payment-status?billCode=${billCode}");
            const result = await response.json();

            if (result.status === "CONFIRMED") {
                clearInterval(checkInterval);
                clearInterval(timer);
                document.getElementById("status").textContent = "✅ Thanh toán thành công!";
                document.getElementById("status").classList.remove("text-success");
                document.getElementById("status").classList.add("text-primary");
            }
        } catch (error) {
            console.error("Lỗi khi kiểm tra trạng thái:", error);
        }
    }, 5000); // Kiểm tra mỗi 5 giây

</script>

</body>
</html>
