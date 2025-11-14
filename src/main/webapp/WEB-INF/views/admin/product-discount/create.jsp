<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Giảm Giá Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-2 p-0">
            <jsp:include page="../layout/sidebar.jsp"/>
        </div>

        <!-- Main Content -->
        <div class="col-10">
            <jsp:include page="../layout/header.jsp"/>
            <div class="p-4">
                <jsp:include page="../layout/page-title.jsp">
                    <jsp:param name="title" value="Thêm Giảm Giá Sản Phẩm"/>
                    <jsp:param name="icon" value="fa-solid fa-plus"/>
                </jsp:include>

                <!-- Breadcrumb -->
                <nav aria-label="breadcrumb" class="mb-4">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin/ProductDiscount">Quản lý giảm giá sản phẩm</a></li>
                        <li class="breadcrumb-item active">Thêm mới</li>
                    </ol>
                </nav>

                <!-- Thông báo -->
                <c:if test="${not empty message}">
                    <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
                        ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Form thêm giảm giá sản phẩm -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-plus-circle me-2"></i>Thông tin giảm giá sản phẩm
                        </h5>
                    </div>
                    <div class="card-body">
                        <form method="post" action="/admin/ProductDiscount/add">
                            <div class="row">
                                <!-- Chọn sản phẩm -->
                                <div class="col-12">
                                    <div class="mb-4">
                                        <label for="productDetailId" class="form-label">
                                            <i class="fas fa-box me-1"></i>Chọn biến thể sản phẩm <span class="text-danger">*</span>
                                        </label>
                                        <select class="form-select" id="productDetailId" name="productDetailId" required>
                                            <option value="">-- Chọn biến thể sản phẩm --</option>
                                            <c:forEach var="detail" items="${productDetails}">
                                                <option value="${detail.id}" 
                                                        data-price="${detail.price}"
                                                        data-product="${detail.product.name}"
                                                        data-brand="${detail.product.brand.name}"
                                                        data-material="${detail.product.material.name}"
                                                        data-color="${detail.color.name}"
                                                        data-size="${detail.size.name}">
                                                    ${detail.product.name} - ${detail.product.brand.name} - 
                                                    ${detail.color.name} - ${detail.size.name} - 
                                                    ${detail.price}đ
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="form-text">Chọn biến thể sản phẩm cần áp dụng giảm giá</div>
                                    </div>
                                </div>

                                <!-- Thông tin chi tiết sản phẩm đã chọn -->
                                <div class="col-12" id="productInfo" style="display: none;">
                                    <div class="card bg-light mb-4">
                                        <div class="card-body">
                                            <h6 class="card-title">
                                                <i class="fas fa-info-circle me-2"></i>Thông tin sản phẩm đã chọn
                                            </h6>
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <strong>Sản phẩm:</strong> <span id="selectedProduct"></span>
                                                </div>
                                                <div class="col-md-2">
                                                    <strong>Thương hiệu:</strong> <span id="selectedBrand"></span>
                                                </div>
                                                <div class="col-md-2">
                                                    <strong>Chất liệu:</strong> <span id="selectedMaterial"></span>
                                                </div>
                                                <div class="col-md-2">
                                                    <strong>Màu:</strong> <span id="selectedColor"></span>
                                                </div>
                                                <div class="col-md-1">
                                                    <strong>Size:</strong> <span id="selectedSize"></span>
                                                </div>
                                                <div class="col-md-2">
                                                    <strong>Giá gốc:</strong> <span id="selectedPrice"></span>đ
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Thông tin giảm giá -->
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="discountedAmount" class="form-label">
                                            <i class="fas fa-money-bill me-1"></i>Số tiền giảm (VNĐ) <span class="text-danger">*</span>
                                        </label>
                                        <input type="number" class="form-control" id="discountedAmount" name="discountedAmount" 
                                               min="1000" step="1000" placeholder="Nhập số tiền giảm" required>
                                        <div class="form-text">Số tiền sẽ được trừ trực tiếp từ giá sản phẩm</div>
                                        <div id="priceAfterDiscount" class="text-success fw-bold mt-2" style="display: none;">
                                            Giá sau giảm: <span id="finalPrice"></span>đ
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="startDate" class="form-label">
                                            <i class="fas fa-calendar-alt me-1"></i>Ngày bắt đầu <span class="text-danger">*</span>
                                        </label>
                                        <input type="datetime-local" class="form-control" id="startDate" name="startDate" required>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="endDate" class="form-label">
                                            <i class="fas fa-calendar-times me-1"></i>Ngày kết thúc <span class="text-danger">*</span>
                                        </label>
                                        <input type="datetime-local" class="form-control" id="endDate" name="endDate" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="closed" class="form-label">
                                            <i class="fas fa-toggle-on me-1"></i>Trạng thái <span class="text-danger">*</span>
                                        </label>
                                        <select class="form-select" id="closed" name="closed" required>
                                            <option value="false">Đang bật (Áp dụng giảm giá)</option>
                                            <option value="true">Đã tắt (Tạm dừng giảm giá)</option>
                                        </select>
                                        <div class="form-text">Chọn trạng thái hoạt động của giảm giá</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Buttons -->
                            <div class="row mt-4">
                                <div class="col-12">
                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-success">
                                            <i class="fas fa-save me-2"></i>Lưu giảm giá
                                        </button>
                                        <a href="/admin/ProductDiscount" class="btn btn-secondary">
                                            <i class="fas fa-arrow-left me-2"></i>Quay lại
                                        </a>
                                        <button type="reset" class="btn btn-outline-warning">
                                            <i class="fas fa-undo me-2"></i>Đặt lại
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JS -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const productSelect = document.getElementById('productDetailId');
        const productInfo = document.getElementById('productInfo');
        const discountInput = document.getElementById('discountedAmount');
        const startDateInput = document.getElementById('startDate');
        const endDateInput = document.getElementById('endDate');
        const form = document.querySelector('form');

        // Hiển thị thông tin sản phẩm khi chọn
        productSelect.addEventListener('change', function() {
            const selectedOption = this.options[this.selectedIndex];
            
            if (this.value) {
                document.getElementById('selectedProduct').textContent = selectedOption.dataset.product;
                document.getElementById('selectedBrand').textContent = selectedOption.dataset.brand;
                document.getElementById('selectedMaterial').textContent = selectedOption.dataset.material;
                document.getElementById('selectedColor').textContent = selectedOption.dataset.color;
                document.getElementById('selectedSize').textContent = selectedOption.dataset.size;
                document.getElementById('selectedPrice').textContent = parseFloat(selectedOption.dataset.price).toLocaleString();
                
                productInfo.style.display = 'block';
                updatePriceAfterDiscount();
            } else {
                productInfo.style.display = 'none';
                document.getElementById('priceAfterDiscount').style.display = 'none';
            }
        });

        // Cập nhật giá sau giảm khi nhập số tiền giảm
        discountInput.addEventListener('input', updatePriceAfterDiscount);

        function updatePriceAfterDiscount() {
            const selectedOption = productSelect.options[productSelect.selectedIndex];
            const originalPrice = parseFloat(selectedOption.dataset.price) || 0;
            const discountAmount = parseFloat(discountInput.value) || 0;
            
            if (originalPrice > 0 && discountAmount > 0) {
                const finalPrice = originalPrice - discountAmount;
                if (finalPrice >= 0) {
                    document.getElementById('finalPrice').textContent = finalPrice.toLocaleString();
                    document.getElementById('priceAfterDiscount').style.display = 'block';
                    document.getElementById('priceAfterDiscount').className = finalPrice >= 0 ? 'text-success fw-bold mt-2' : 'text-danger fw-bold mt-2';
                } else {
                    document.getElementById('finalPrice').textContent = finalPrice.toLocaleString();
                    document.getElementById('priceAfterDiscount').style.display = 'block';
                    document.getElementById('priceAfterDiscount').className = 'text-danger fw-bold mt-2';
                }
            } else {
                document.getElementById('priceAfterDiscount').style.display = 'none';
            }
        }

        // Validation form
        form.addEventListener('submit', function(e) {
            const selectedOption = productSelect.options[productSelect.selectedIndex];
            const originalPrice = parseFloat(selectedOption.dataset.price) || 0;
            const discountAmount = parseFloat(discountInput.value) || 0;
            
            // Kiểm tra số tiền giảm không được lớn hơn giá gốc
            if (discountAmount >= originalPrice) {
                e.preventDefault();
                alert('Số tiền giảm không được lớn hơn hoặc bằng giá gốc của sản phẩm!');
                return false;
            }

            // Kiểm tra ngày kết thúc phải sau ngày bắt đầu
            const startDate = new Date(startDateInput.value);
            const endDate = new Date(endDateInput.value);
            
            if (endDate <= startDate) {
                e.preventDefault();
                alert('Ngày kết thúc phải sau ngày bắt đầu!');
                return false;
            }
        });

        // Set default dates
        const now = new Date();
        now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
        startDateInput.value = now.toISOString().slice(0, 16);
        
        const nextWeek = new Date(now.getTime() + 7 * 24 * 60 * 60 * 1000);
        endDateInput.value = nextWeek.toISOString().slice(0, 16);
    });
</script>
</body>
</html>
