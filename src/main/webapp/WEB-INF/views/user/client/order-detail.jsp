<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng #${bill.code} - BeeStore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<jsp:include page="../layout/header.jsp"/>

<div class="container mt-4">
    <div id="nofication-cart" class="nofication-cart"></div>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1>Chi tiết đơn hàng #${bill.code}</h1>
        <a href="/orders" class="btn btn-outline-secondary">
            <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
        </a>
    </div>
    
    <div class="row">
        <div class="col-lg-8">
            <!-- Thông tin đơn hàng -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Thông tin đơn hàng</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Mã đơn hàng:</strong> ${bill.code}</p>
                            <p><strong>Ngày đặt:</strong> 
                                <fmt:formatDate value="${bill.createDateAsDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </p>
                            <p><strong>Trạng thái:</strong> 
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
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Phương thức thanh toán:</strong> ${bill.paymentMethod.name}</p>
                            <p><strong>Loại hóa đơn:</strong> ${bill.invoiceType}</p>
                            <c:if test="${bill.discountCode != null}">
                                <p><strong>Mã giảm giá:</strong> ${bill.discountCode.code}</p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Địa chỉ giao hàng -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-map-marker-alt me-2"></i>Địa chỉ giao hàng</h5>
                </div>
                <div class="card-body">
                    <p class="mb-1"><strong>Người nhận:</strong> ${bill.customer.name}</p>
                    <p class="mb-1"><strong>Số điện thoại:</strong> ${bill.customer.phoneNumber}</p>
                    <p class="mb-0"><strong>Địa chỉ:</strong> ${bill.billingAddress}</p>
                </div>
            </div>

            <!-- Sản phẩm đã đặt -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-box me-2"></i>Sản phẩm đã đặt</h5>
                </div>
                <div class="card-body">
                    <c:forEach items="${billDetails}" var="detail">
                        <div class="row align-items-center mb-3 pb-3 border-bottom">
                            <div class="col-md-2">
                                <img src="/images/product/${detail.productDetail.imageList[0].link}" 
                                     alt="${detail.productName}" 
                                     class="img-fluid rounded">
                            </div>
                            <div class="col-md-5">
                                <h6 class="mb-1">${detail.productName}</h6>
                                <p class="text-muted mb-1">Màu: ${detail.productColor}</p>
                                <p class="text-muted mb-0">Size: ${detail.productSize}</p>
                            </div>
                            <div class="col-md-2 text-center">
                                <span class="fw-bold">x${detail.quantity}</span>
                            </div>
                            <div class="col-md-3 text-end">
                                <p class="mb-1">
                                    <fmt:formatNumber value="${detail.momentPrice}" type="currency" currencySymbol="₫"/>
                                </p>
                                <p class="mb-0 fw-bold text-primary">
                                    <fmt:formatNumber value="${detail.totalPrice}" type="currency" currencySymbol="₫"/>
                                </p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <!-- Tóm tắt thanh toán -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-calculator me-2"></i>Tóm tắt thanh toán</h5>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between mb-2">
                        <span>Tạm tính:</span>
                        <span><fmt:formatNumber value="${bill.amount}" type="currency" currencySymbol="₫"/></span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Phí vận chuyển:</span>
                        <span>Miễn phí</span>
                    </div>
                    <c:if test="${bill.promotionPrice != null && bill.promotionPrice > 0}">
                        <div class="d-flex justify-content-between mb-2 text-success">
                            <span>Giảm giá:</span>
                            <span>-<fmt:formatNumber value="${bill.promotionPrice}" type="currency" currencySymbol="₫"/></span>
                        </div>
                    </c:if>
                    <hr>
                    <div class="d-flex justify-content-between mb-3">
                        <strong>Tổng cộng:</strong>
                        <strong class="text-primary fs-5">
                            <fmt:formatNumber value="${bill.finalAmount}" type="currency" currencySymbol="₫"/>
                        </strong>
                    </div>
                </div>
            </div>

            <!-- Trạng thái vận chuyển -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-truck me-2"></i>Trạng thái vận chuyển</h5>
                </div>
                <div class="card-body">
                    <div class="timeline">
                        <div class="timeline-item ${bill.status == 'PENDING' || bill.status == 'CONFIRMED' || bill.status == 'PROCESSING' || bill.status == 'SHIPPING' || bill.status == 'DELIVERED' ? 'completed' : ''}">
                            <i class="fas fa-check-circle"></i>
                            <div class="timeline-content">
                                <h6>Đơn hàng đã được đặt</h6>
                                <small class="text-muted">
                                    <fmt:formatDate value="${bill.createDateAsDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </small>
                            </div>
                        </div>
                        
                        <div class="timeline-item ${bill.status == 'CONFIRMED' || bill.status == 'PROCESSING' || bill.status == 'SHIPPING' || bill.status == 'DELIVERED' ? 'completed' : ''}">
                            <i class="fas fa-check-circle"></i>
                            <div class="timeline-content">
                                <h6>Đơn hàng đã được xác nhận</h6>
                                <small class="text-muted">Đang chờ xử lý</small>
                            </div>
                        </div>
                        
                        <div class="timeline-item ${bill.status == 'PROCESSING' || bill.status == 'SHIPPING' || bill.status == 'DELIVERED' ? 'completed' : ''}">
                            <i class="fas fa-box"></i>
                            <div class="timeline-content">
                                <h6>Đang chuẩn bị hàng</h6>
                                <small class="text-muted">Đóng gói sản phẩm</small>
                            </div>
                        </div>
                        
                        <div class="timeline-item ${bill.status == 'SHIPPING' || bill.status == 'DELIVERED' ? 'completed' : ''}">
                            <i class="fas fa-truck"></i>
                            <div class="timeline-content">
                                <h6>Đang giao hàng</h6>
                                <small class="text-muted">Dự kiến 2-3 ngày</small>
                            </div>
                        </div>
                        
                        <div class="timeline-item ${bill.status == 'DELIVERED' ? 'completed' : ''}">
                            <i class="fas fa-home"></i>
                            <div class="timeline-content">
                                <h6>Đã giao hàng</h6>
                                <small class="text-muted">Hoàn thành</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Hành động -->
            <div class="card">
                <div class="card-body">
                    <c:if test="${ bill.status != 'CANCELLED' && bill.status != 'DELIVERED' && bill.status != 'SHIPPING'}">
                        <button class="btn btn-danger w-100 mb-2" onclick="cancelOrder(${bill.id})">
                            <i class="fas fa-times me-2"></i>Hủy đơn hàng
                        </button>
                    </c:if>
                    
                    <c:if test="${bill.status == 'DELIVERED'}">
                        <button class="btn btn-success w-100 mb-2">
                            <i class="fas fa-star me-2"></i>Đánh giá sản phẩm
                        </button>
                    </c:if>
                    
                    <button class="btn btn-outline-primary w-100">
                        <i class="fas fa-headset me-2"></i>Liên hệ hỗ trợ
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>


<style>
    .nofication-cart {
    position: fixed;
    top: 20px;
    right: 20px;
    z-index: 9999;
    min-width: 280px;
    max-width: 360px;
    padding: 16px 22px;
    border-radius: 10px;
    font-size: 15px;
    font-weight: 500;
    color: #fff;
    background-color: #333;
    box-shadow: 0 6px 16px rgba(0,0,0,0.25);
    opacity: 0;
    transform: translateY(-20px);
    pointer-events: none;
    transition: opacity 0.4s ease, transform 0.4s ease;
    display: none;
}

/* Hiển thị notification */
.nofication-cart.show {
    display: block;
    opacity: 1;
    transform: translateY(0);
    pointer-events: all;
    animation: popIn 0.4s ease forwards;
}

/* Các loại thông báo */
.nofication-cart.success {
    background-color: #28a745; /* Xanh lá */
}

.nofication-cart.error {
    background-color: #dc3545; /* Đỏ */
}

.nofication-cart.info {
    background-color: #17a2b8; /* Xanh dương nhạt */
}

.nofication-cart.warning {
    background-color: #ffc107; /* Vàng cam */
    color: #333;
}

/* Hiệu ứng “bật” nhẹ khi xuất hiện */
@keyframes popIn {
    0% {
        transform: scale(0.95) translateY(-15px);
        opacity: 0;
    }
    100% {
        transform: scale(1) translateY(0);
        opacity: 1;
    }
}
.timeline {
    position: relative;
    padding-left: 30px;
}

.timeline-item {
    position: relative;
    margin-bottom: 20px;
}

.timeline-item::before {
    content: '';
    position: absolute;
    left: -22px;
    top: 8px;
    width: 2px;
    height: calc(100% + 20px);
    background-color: #dee2e6;
}

.timeline-item:last-child::before {
    display: none;
}

.timeline-item i {
    position: absolute;
    left: -30px;
    top: 0;
    width: 16px;
    height: 16px;
    background-color: #fff;
    border: 2px solid #dee2e6;
    border-radius: 50%;
    color: #6c757d;
    font-size: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.timeline-item.completed i {
    background-color: #198754;
    border-color: #198754;
    color: white;
}

.timeline-content h6 {
    margin-bottom: 5px;
    font-size: 14px;
}
</style>

<script>
function showNotification(message, type) {
    const notification = document.getElementById('nofication-cart');
    notification.textContent = message;
    notification.className = 'nofication-cart show ' + type;

    // Ẩn thông báo sau 3 giây
    setTimeout(() => {
        notification.classList.remove('show');
        setTimeout(() => {
            notification.style.display = 'none';
        }, 400); // Thời gian khớp với CSS transition
    }, 3000);
}
async function cancelOrder(orderId) {
    const ok = await showConfirm('Bạn có chắc chắn muốn hủy đơn hàng này?')
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
                showNotification('Hủy đơn hàng thất bại!', 'error');
            }
        })
        .catch(error => {
            showNotification('Đã xảy ra lỗi!', 'error');
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
