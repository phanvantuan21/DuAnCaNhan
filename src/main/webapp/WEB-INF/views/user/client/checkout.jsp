<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - BeeStore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        .checkout-container {
            background: #f8f9fa;
            min-height: 100vh;
            padding: 2rem 0;
        }

        .checkout-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .checkout-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.5rem;
            text-align: center;
        }

        .form-section {
            padding: 2rem;
        }

        .section-title {
            color: #333;
            font-weight: 600;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #e9ecef;
        }

        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }

        .order-summary {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 1.5rem;
            margin-top: 2rem;
        }

        .product-item {
            background: white;
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1rem;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .product-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
        }

        .price-row {
            padding: 0.5rem 0;
            border-bottom: 1px solid #e9ecef;
        }

        .price-row:last-child {
            border-bottom: none;
            font-weight: 600;
            font-size: 1.1rem;
            color: #667eea;
        }

        .btn-checkout {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 25px;
            padding: 1rem 2rem;
            font-weight: 600;
            color: white;
            width: 100%;
            transition: all 0.3s ease;
        }

        .btn-checkout:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
            color: white;
        }

        .discount-section {
            background: #e8f5e8;
            border-radius: 10px;
            padding: 1rem;
            margin: 1rem 0;
        }

        .alert {
            border-radius: 10px;
            border: none;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp"/>
<div class="checkout-container">
    <div class="container">
        <div class="checkout-card">
            <div class="checkout-header">
                <h2 class="mb-0"><i class="fas fa-credit-card me-2"></i>Thanh toán</h2>
                <p class="mb-0 mt-2">Hoàn tất đơn hàng của bạn</p>
            </div>

            <div class="form-section">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger"><i class="fas fa-exclamation-circle me-2"></i>${error}</div>
                </c:if>
    
    <form action="/cart/place-order" method="post">
        <div class="row">
            <div class="col-lg-8">
                <!-- Thông tin giao hàng -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-shipping-fast me-2"></i>Thông tin giao hàng</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <label class="form-label">Họ tên *</label>
                                <input type="text" class="form-control" value="${customer.name}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Email *</label>
                                <input type="email" class="form-control" value="${customer.email}" readonly>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <label class="form-label">Số điện thoại *</label>
                                <input type="tel" class="form-control" value="${customer.phoneNumber}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Loại hóa đơn *</label>
                                <select class="form-select" name="invoiceType" required>
                                    <option value="PERSONAL">Cá nhân</option>
                                    <option value="COMPANY">Công ty</option>
                                </select>
                            </div>
                        </div>
                        <div class="mt-3">
                            <label class="form-label">Địa chỉ giao hàng *</label>
                            <textarea class="form-control" name="billingAddress" rows="3" 
                                      placeholder="Nhập địa chỉ chi tiết..." required></textarea>
                        </div>
                    </div>
                </div>

                <!-- Phương thức thanh toán -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-credit-card me-2"></i>Phương thức thanh toán</h5>
                    </div>
                    <div class="card-body">
                        <c:forEach items="${paymentMethods}" var="method">
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="paymentMethodId" 
                                       value="${method.id}" id="payment${method.id}" required>
                                <label class="form-check-label" for="payment${method.id}">
                                    ${method.name}
                                </label>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- Mã giảm giá (chỉ hiển thị mã có percentage) -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-tags me-2"></i>Mã giảm giá</h5>
                    </div>
                    <div class="card-body">
                        <select class="form-select" name="discountId">
                            <option value="">Chọn mã giảm giá</option>
                            <c:forEach items="${discounts}" var="discount">
                                <option value="${discount.id}"
                                        data-percentage="${discount.percentage}"
                                        data-amount="${discount.amount}"
                                        data-max-amount="${discount.maximumAmount}"
                                        data-min-amount="${discount.minimumAmountInCart}">
                                    ${discount.code}
                                    <c:choose>
                                        <c:when test="${discount.percentage != null}">
                                            - Giảm ${discount.percentage}%
                                        </c:when>
                                        <c:when test="${discount.amount != null}">
                                            - Giảm <fmt:formatNumber value="${discount.amount}" type="currency" currencySymbol="₫"/>
                                        </c:when>
                                    </c:choose>
                                </option>
                            </c:forEach>

                        </select>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <!-- Tóm tắt đơn hàng -->
                <div class="order-summary">
                    <h4 class="section-title"><i class="fas fa-receipt me-2"></i>Tóm tắt đơn hàng</h4>

                    <!-- Danh sách sản phẩm -->
                    <div class="mb-3">
                        <h6 class="mb-3">Sản phẩm đã chọn:</h6>
                        <c:forEach items="${cartItems}" var="item">
                            <div class="product-item cart-item">
                                <div class="d-flex align-items-center">
                                    <img src="/images/product/${item.productImage}"
                                         alt="${item.productName}" class="product-image me-3">
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1">${item.productName}</h6>
                                        <small class="text-muted">${item.productColor} - ${item.productSize}</small><br>
                                        <small class="item-quantity">Số lượng: ${item.quantity}</small>
                                    </div>
                                    <div class="text-end">
                                        <span class="item-price fw-bold" data-price="${item.totalPrice}">
                                            <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="₫"/>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
            
                    <hr>

                    <!-- Tính toán -->
                    <div class="price-row d-flex justify-content-between">
                        <span>Tạm tính:</span>
                        <span><fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="₫"/></span>
                    </div>
                    <div class="price-row d-flex justify-content-between">
                        <span>Phí vận chuyển:</span>
                        <span class="text-success">Miễn phí</span>
                    </div>
                    <div class="price-row d-flex justify-content-between" id="discountRow" style="display: none;">
                        <span>Giảm giá:</span>
                        <span id="discountAmount" class="text-success">0%</span>
                    </div>
                    <div class="price-row d-flex justify-content-between">
                        <strong>Tổng cộng:</strong>
                        <strong class="text-primary" id="finalTotal">
                            <fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="₫"/>
                        </strong>
                    </div>

                    <!-- Thời gian giao hàng dự kiến -->
                    <div class="alert alert-info">
                        <i class="fas fa-clock me-2"></i>
                        <strong>Thời gian giao hàng dự kiến:</strong><br>
                        2-3 ngày làm việc (Nội thành)<br>
                        3-5 ngày làm việc (Ngoại thành)
                    </div>

                    <button type="submit" class="btn-checkout">
                        <i class="fas fa-credit-card me-2"></i>Đặt hàng ngay
                    </button>
                    <a href="/cart" class="btn btn-outline-secondary w-100 mt-3" style="border-radius: 25px;">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại giỏ hàng
                    </a>
                </div>
            </div>
        </div>
    </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
<script>
// Biến toàn cục
let subtotal = 0;
let currentDiscountPercentage = 0;
let maximumDiscountAmount = 0;
let currentDiscountAmount = 0;
let minimumAmountInCart = 0;
// Tính toán subtotal từ các sản phẩm
function calculateSubtotal() {
    const cartItems = document.querySelectorAll('.cart-item');
    let total = 0;

    cartItems.forEach(item => {
        const priceElement = item.querySelector('.item-price');

        if (priceElement) {
            // Lấy giá trị từ text và chuyển đổi thành số
            const priceText = priceElement.getAttribute('data-price');
            const price = parseFloat(priceText);
            if (!isNaN(price)) {
                total += price;
            }
        }
    });

    subtotal = total;
    return total;
}

// Format tiền tệ
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND',
        maximumFractionDigits: 2,
        minimumFractionDigits:2
    }).format(amount);
}

// Tính toán số tiền giảm giá dựa trên phần trăm
function calculateDiscountAmount(percentage) {
    return subtotal * (percentage / 100);
}
function updateTotal() {
    let discountAmount = 0;
    if (currentDiscountPercentage > 0) {
        discountAmount = calculateDiscountAmount(currentDiscountPercentage);
    } else if (currentDiscountPercentage === -1 && currentDiscountAmount > 0)
    {
        discountAmount = currentDiscountAmount;
    }
     if( discountAmount > maximumDiscountAmount && maximumDiscountAmount > 0){
        discountAmount = maximumDiscountAmount;
    }
    if( minimumAmountInCart != null && subtotal < minimumAmountInCart){
        discountAmount = 0;
    }
    if( discountAmount > subtotal){
        discountAmount = subtotal;
    }
    const finalTotal = subtotal - discountAmount >= 0 ? subtotal - discountAmount : 0;

    const totalElement = document.getElementById('finalTotal');
    if (totalElement) {
        totalElement.textContent = formatCurrency(finalTotal);
    }

    const discountRow = document.getElementById('discountRow');
    const discountAmountElement = document.getElementById('discountAmount');

    if( subtotal < minimumAmountInCart && (currentDiscountPercentage > 0 || currentDiscountPercentage === -1)){
        discountRow.style.display = 'flex';
        discountAmountElement.textContent = '0đ';
    } else if( currentDiscountPercentage >0 ){
        if(discountRow) discountRow.style.display = 'flex';
        if(discountAmountElement) {
            if( discountAmount === maximumDiscountAmount && maximumDiscountAmount > 0){
                discountAmountElement.textContent = 'Tối đa ' + formatCurrency(maximumDiscountAmount);
            } else {
                discountAmountElement.textContent = formatCurrency(discountAmount) + ' (' + currentDiscountPercentage + '%)';
            }
        }
    } else if( currentDiscountPercentage === -1 && currentDiscountAmount > 0){
        if(discountRow) discountRow.style.display = 'flex';
        if(discountAmountElement) {
            if( discountAmount === maximumDiscountAmount && maximumDiscountAmount > 0){
                discountAmountElement.textContent = formatCurrency(maximumDiscountAmount);
            } else {
                discountAmountElement.textContent = formatCurrency(discountAmount);
            }
        }
    } else {
        if(discountRow) discountRow.style.display = 'none';
        if(discountAmountElement) discountAmountElement.textContent = '0đ';
    }
}


// Tính toán lại tổng tiền khi chọn mã giảm giá
document.addEventListener('DOMContentLoaded', function() {
    // Tính subtotal ban đầu
    calculateSubtotal();
    updateTotal();
    const discountSelect = document.querySelector('select[name="discountId"]');
    const discountRow = document.getElementById('discountRow');
    const discountAmountElement = document.getElementById('discountAmount');
    if (discountSelect) {
        discountSelect.addEventListener('change', function() {
            const selectedOption = this.options[this.selectedIndex];

            if (selectedOption.value) {
                // Lấy phần trăm từ data attribute
                const percentage = parseFloat(selectedOption.getAttribute('data-percentage'));
                const amount = parseFloat(selectedOption.getAttribute('data-amount'));
                const maximumAmount = parseFloat(selectedOption.getAttribute('data-max-amount'));
                const minAmount = parseFloat(selectedOption.getAttribute('data-min-amount'));

                maximumDiscountAmount = !isNaN(maximumAmount) && maximumAmount > 0 ? maximumAmount : 0;
                minimumAmountInCart = !isNaN(minAmount) && minAmount > 0 ? minAmount : 0;

                if (!isNaN(percentage) && percentage > 0) {
                    currentDiscountPercentage = percentage;
                    // Hiển thị phần trăm giảm giá
                    discountAmountElement.textContent = `${percentage}%`;
                    discountRow.style.display = 'flex';
                    
                    // Cập nhật tổng tiền
                    updateTotal();
                
                }else if(!isNaN(amount) && amount > 0 && percentage === 0) {
                    currentDiscountPercentage = -1; // Đánh dấu là giảm theo số tiền
                    currentDiscountAmount = amount;
                    discountAmountElement.textContent = `${amount}đ`;
                    discountRow.style.display = 'flex';
                    updateTotal();
                } 
                else {
                    // Nếu không có phần trăm hợp lệ, reset về 0
                    currentDiscountPercentage = 0;
                    discountAmountElement.textContent = '0%';
                    discountRow.style.display = 'none';
                    updateTotal();
                }
            } else {
                // Không chọn mã giảm giá
                currentDiscountPercentage = 0;
                discountAmountElement.textContent = '0%';
                discountRow.style.display = 'none';
                updateTotal();
            }
        });
    }
});
</script>
</body>
</html>