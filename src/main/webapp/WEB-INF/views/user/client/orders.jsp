<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng của tôi - BeeStore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* Bố cục hai cột: Sidebar trái + Nội dung phải */
        .account-layout {
            display: flex;
            align-items: flex-start;
            justify-content: flex-start;
            gap: 20px;
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            margin-top: 100px; /* cách header 1 chút */
            padding: 0 15px;
            box-sizing: border-box;
        }

        .account-sidebar {
            flex: 0 0 200px; /* cố định sidebar nhỏ gọn */
        }

        .account-content {
            flex: 1;
        }
    </style>
</head>
<body>
    <jsp:include page="../layout/header.jsp"/>

    <!-- Bọc sidebar + nội dung -->
    <div class="account-layout">
        <!-- Sidebar -->
        <div class="account-sidebar">
            <jsp:include page="../layout/sidebar.jsp"/>
        </div>

        <!-- Nội dung chính -->
        <div class="account-content">
            <h1 class="mb-4">Đơn hàng của tôi</h1>
            
                <div class="mb-4 d-flex flex-wrap gap-2">
                    <a href="/orders" class="btn btn-outline-secondary btn-sm ${param.status == null ? 'active' : ''}">Tất cả</a>
                    <a href="/orders?status=PENDING" class="btn btn-outline-warning btn-sm ${param.status == 'PENDING' ? 'active' : ''}">Chờ xác nhận</a>
                    <a href="/orders?status=CONFIRMED" class="btn btn-outline-info btn-sm ${param.status == 'CONFIRMED' ? 'active' : ''}">Đã xác nhận</a>
                    <a href="/orders?status=PROCESSING" class="btn btn-outline-primary btn-sm ${param.status == 'PROCESSING' ? 'active' : ''}">Đang xử lý</a>
                    <a href="/orders?status=SHIPPING" class="btn btn-outline-secondary btn-sm ${param.status == 'SHIPPING' ? 'active' : ''}">Đang giao</a>
                    <a href="/orders?status=DELIVERED" class="btn btn-outline-success btn-sm ${param.status == 'DELIVERED' ? 'active' : ''}">Đã giao</a>
                    <a href="/orders?status=CANCELLED" class="btn btn-outline-danger btn-sm ${param.status == 'CANCELLED' ? 'active' : ''}">Đã hủy</a>
                </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <c:choose>
                <c:when test="${empty bills}">
                    <div class="text-center py-5">
                        <i class="fas fa-receipt fa-3x text-muted mb-3"></i>
                        <h3>Chưa có đơn hàng nào</h3>
                        <p class="text-muted">Hãy mua sắm và tạo đơn hàng đầu tiên của bạn</p>
                        <a href="/" class="btn btn-primary">Mua sắm ngay</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row">
                        <c:forEach items="${bills}" var="bill">
                            <div class="col-12 mb-4">
                                <div class="card">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="mb-0">Đơn hàng #${bill.code}</h6>
                                            <small class="text-muted">
                                                Đặt ngày: <fmt:formatDate value="${bill.createDateAsDate}" pattern="dd/MM/yyyy HH:mm"/>
                                            </small>
                                        </div>
                                        <div class="text-end">
                                            <c:choose>
                                                <c:when test="${bill.status == 'PENDING'}">
                                                    <span class="badge bg-warning">Chờ xác nhận</span>
                                                </c:when>
                                                <c:when test="${bill.status == 'CONFIRMED'}">
                                                    <span class="badge bg-info">Đã xác nhận</span>
                                                </c:when>
                                                <c:when test="${bill.status == 'PROCESSING'}">
                                                    <span class="badge bg-primary">Đang xử lý</span>
                                                </c:when>
                                                <c:when test="${bill.status == 'SHIPPING'}">
                                                    <span class="badge bg-secondary">Đang giao hàng</span>
                                                </c:when>
                                                <c:when test="${bill.status == 'DELIVERED'}">
                                                    <span class="badge bg-success">Đã giao hàng</span>
                                                </c:when>
                                                <c:when test="${bill.status == 'CANCELLED'}">
                                                    <span class="badge bg-danger">Đã hủy</span>
                                                </c:when>
                                                <c:when test="${bill.status == 'EXPIRED'}">
                                                    <span class="badge bg-warning">Hết hạn</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${bill.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>

                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <p class="mb-1"><strong>Địa chỉ giao hàng:</strong> ${bill.billingAddress}</p>
                                                <p class="mb-1"><strong>Phương thức thanh toán:</strong> ${bill.paymentMethod.name}</p>
                                                <c:if test="${bill.discountCode != null}">
                                                    <p class="mb-1"><strong>Mã giảm giá:</strong> ${bill.discountCode.code}</p>
                                                </c:if>
                                            </div>
                                            <div class="col-md-4 text-end">
                                                <p class="mb-1">
                                                    <strong>Tổng tiền:</strong> 
                                                    <span class="text-primary fs-5">
                                                        <fmt:formatNumber value="${bill.finalAmount}" type="currency" currencySymbol="₫"/>
                                                    </span>
                                                </p>
                                            </div>
                                        </div>

                                        <div class="mt-3">
                                            <a href="/orders/${bill.id}" class="btn btn-outline-primary btn-sm">
                                                <i class="fas fa-eye me-1"></i>Xem chi tiết 
                                            </a>
                                            
                                            <c:if test="${bill.status != 'CANCELLED' && bill.status != 'DELIVERED' && bill.status != 'SHIPPING'}">
                                                <button class="btn btn-outline-danger btn-sm ms-2" 
                                                        onclick="cancelOrder(${bill.id})">
                                                    <i class="fas fa-times me-1"></i>Hủy đơn hàng
                                                </button>
                                            </c:if>

                                            <c:if test="${bill.status == 'DELIVERED'}">
                                                <button class="btn btn-outline-success btn-sm ms-2">
                                                    <i class="fas fa-star me-1"></i>Đánh giá
                                                </button>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <jsp:include page="../layout/footer.jsp"/>

    <script>
    async function cancelOrder(orderId) {
        const ok = await showConfirm('Bạn có chắc chắn muốn hủy đơn hàng này?');
        if(!ok) return;
            fetch('/orders/' + orderId + '/cancel', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                }
            })
            .then(response => {
                if (response.ok) {
                    location.reload();
                } else {
                    alert('Có lỗi xảy ra khi hủy đơn hàng');
                }
            })
            .catch(error => {
                alert('Có lỗi xảy ra: ' + error.message);
            });
        }
    function showConfirm(message, {okText = 'Đồng ý', cancelText = 'Hủy'} = {}) {
    return new Promise((resolve) => {
        // Tạo modal nếu chưa có
        let overlay = document.getElementById('customConfirm');
        if (!overlay) {
            document.body.insertAdjacentHTML('beforeend', `
                <div id="customConfirm" class="cc-overlay">
                  <div class="cc-modal">
                    <div class="cc-body">
                      <p id="cc-message"></p>
                    </div>
                    <div class="cc-actions">
                      <button id="cc-cancel" class="cc-btn">Hủy</button>
                      <button id="cc-ok" class="cc-btn primary">Đồng ý</button>
                    </div>
                  </div>
                </div>
            `);
        }

        overlay = document.getElementById('customConfirm');
        const msgEl = document.getElementById('cc-message');
        const okBtn = document.getElementById('cc-ok');
        const cancelBtn = document.getElementById('cc-cancel');

        msgEl.textContent = message;
        okBtn.textContent = okText;
        cancelBtn.textContent = cancelText;

        overlay.classList.add('show');

        const cleanup = () => {
            overlay.classList.remove('show');
            okBtn.onclick = cancelBtn.onclick = null;
        };

        okBtn.onclick = () => { cleanup(); resolve(true); };
        cancelBtn.onclick = () => { cleanup(); resolve(false); };
    });
}
</script>
</body>
</html>
