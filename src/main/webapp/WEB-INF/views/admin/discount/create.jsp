<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Mã Giảm Giá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-2 p-0">
            <jsp:include page="../layout/sidebar.jsp" />
        </div>

        <!-- Main Content -->
        <div class="col-10">
            <jsp:include page="../layout/header.jsp"/>
            <div class="p-4">
                <jsp:include page="../layout/page-title.jsp">
                    <jsp:param name="title" value="Thêm Mã Giảm Giá"/>
                    <jsp:param name="icon" value="fa-solid fa-plus"/>
                </jsp:include>

                <!-- Breadcrumb -->
                <nav aria-label="breadcrumb" class="mb-4">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin/Discount">Quản lý mã giảm giá</a></li>
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

                <!-- Form thêm mã giảm giá -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-plus-circle me-2"></i>Thông tin mã giảm giá
                        </h5>
                    </div>
                    <div class="card-body">
                        <form method="post" action="/admin/Discount/add">
                            <div class="row">
                                <!-- Cột trái -->
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="code" class="form-label">
                                            <i class="fas fa-tag me-1"></i>Mã giảm giá <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" class="form-control" id="code" name="code" 
                                               placeholder="Nhập mã giảm giá (VD: SALE20)" required>
                                        <div class="form-text">Mã phải là duy nhất và không được trùng lặp</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="detail" class="form-label">
                                            <i class="fas fa-info-circle me-1"></i>Mô tả chi tiết
                                        </label>
                                        <textarea class="form-control" id="detail" name="detail" rows="3" 
                                                  placeholder="Mô tả về mã giảm giá này..."></textarea>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="amount" class="form-label">
                                                    <i class="fas fa-money-bill me-1"></i>Số tiền giảm (VNĐ)
                                                </label>
                                                <input type="number" class="form-control" id="amount" name="amount" 
                                                       min="0" step="1000" placeholder="0">
                                                <div class="form-text">Để trống nếu dùng phần trăm</div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="percentage" class="form-label">
                                                    <i class="fas fa-percent me-1"></i>Phần trăm giảm (%)
                                                </label>
                                                <input type="number" class="form-control" id="percentage" name="percentage" 
                                                       min="0" max="100" placeholder="0">
                                                <div class="form-text">Để trống nếu dùng số tiền cố định</div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
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
                                        </div>
                                    </div>
                                </div>

                                <!-- Cột phải -->
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="maximumAmount" class="form-label">
                                            <i class="fas fa-coins me-1"></i>Số tiền giảm tối đa (VNĐ)
                                        </label>
                                        <input type="number" class="form-control" id="maximumAmount" name="maximumAmount" 
                                               min="0" step="1000" placeholder="0">
                                        <div class="form-text">Áp dụng khi dùng phần trăm giảm</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="maximumUsage" class="form-label">
                                            <i class="fas fa-users me-1"></i>Số lần sử dụng tối đa
                                        </label>
                                        <input type="number" class="form-control" id="maximumUsage" name="maximumUsage" 
                                               min="1" placeholder="Không giới hạn">
                                        <div class="form-text">Để trống nếu không giới hạn</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="minimumAmountInCart" class="form-label">
                                            <i class="fas fa-shopping-cart me-1"></i>Giá trị đơn hàng tối thiểu (VNĐ)
                                        </label>
                                        <input type="number" class="form-control" id="minimumAmountInCart" name="minimumAmountInCart" 
                                               min="0" step="1000" placeholder="0">
                                        <div class="form-text">Đơn hàng phải đạt giá trị này mới áp dụng được</div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="status" class="form-label">
                                                    <i class="fas fa-toggle-on me-1"></i>Trạng thái <span class="text-danger">*</span>
                                                </label>
                                                <select class="form-select" id="status" name="status" required>
                                                    <option value="1">Kích hoạt</option>
                                                    <option value="0">Tạm dừng</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="type" class="form-label">
                                                    <i class="fas fa-tags me-1"></i>Loại giảm giá <span class="text-danger">*</span>
                                                </label>
                                                <select class="form-select" id="type" name="type" required>
                                                    <option value="1">Giảm theo số tiền</option>
                                                    <option value="2">Giảm theo phần trăm</option>
                                                    <option value="3">Miễn phí vận chuyển</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Buttons -->
                            <div class="row mt-4">
                                <div class="col-12">
                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-success">
                                            <i class="fas fa-save me-2"></i>Lưu mã giảm giá
                                        </button>
                                        <a href="/admin/Discount" class="btn btn-secondary">
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
    // Validation cho form
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.querySelector('form');
        const amountInput = document.getElementById('amount');
        const percentageInput = document.getElementById('percentage');
        const startDateInput = document.getElementById('startDate');
        const endDateInput = document.getElementById('endDate');

        // Validation: Phải có ít nhất amount hoặc percentage
        form.addEventListener('submit', function(e) {
            const amount = parseFloat(amountInput.value) || 0;
            const percentage = parseInt(percentageInput.value) || 0;
            
            if (amount === 0 && percentage === 0) {
                e.preventDefault();
                alert('Vui lòng nhập số tiền giảm hoặc phần trăm giảm!');
                return false;
            }

            // Validation: Ngày kết thúc phải sau ngày bắt đầu
            const startDate = new Date(startDateInput.value);
            const endDate = new Date(endDateInput.value);
            
            if (endDate <= startDate) {
                e.preventDefault();
                alert('Ngày kết thúc phải sau ngày bắt đầu!');
                return false;
            }
        });

        // Auto clear khi nhập amount thì clear percentage và ngược lại
        amountInput.addEventListener('input', function() {
            if (this.value) {
                percentageInput.value = '';
            }
        });

        percentageInput.addEventListener('input', function() {
            if (this.value) {
                amountInput.value = '';
            }
        });

        // Set default start date to now
        const now = new Date();
        now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
        startDateInput.value = now.toISOString().slice(0, 16);
        
        // Set default end date to 7 days from now
        const nextWeek = new Date(now.getTime() + 7 * 24 * 60 * 60 * 1000);
        endDateInput.value = nextWeek.toISOString().slice(0, 16);
    });
</script>
</body>
</html>
