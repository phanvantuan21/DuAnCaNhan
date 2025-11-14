<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập nhật Mã Giảm Giá</title>
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
                    <jsp:param name="title" value="Cập nhật Mã Giảm Giá"/>
                    <jsp:param name="icon" value="fa-solid fa-edit"/>
                </jsp:include>

                <!-- Breadcrumb -->
                <nav aria-label="breadcrumb" class="mb-4">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin/Discount">Quản lý mã giảm giá</a></li>
                        <li class="breadcrumb-item active">Cập nhật</li>
                    </ol>
                </nav>

                <!-- Form cập nhật -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-edit me-2"></i>Thông tin mã giảm giá
                        </h5>
                    </div>
                    <div class="card-body">
                        <form method="post" action="/admin/Discount/update">
                            <input type="hidden" name="id" value="${discount.id}"/>

                            <div class="row">
                                <!-- Cột trái -->
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="code" class="form-label">Mã giảm giá</label>
                                        <input type="text" class="form-control" id="code" name="code"
                                               value="${discount.code}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="detail" class="form-label">Mô tả chi tiết</label>
                                        <textarea class="form-control" id="detail" name="detail" rows="3">${discount.detail}</textarea>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="amount" class="form-label">Số tiền giảm (VNĐ)</label>
                                                <input type="number" class="form-control" id="amount" name="amount"
                                                       value="${discount.amount}" min="0" step="1000">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="percentage" class="form-label">Phần trăm giảm (%)</label>
                                                <input type="number" class="form-control" id="percentage" name="percentage"
                                                       value="${discount.percentage}" min="0" max="100">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="startDate" class="form-label">Ngày bắt đầu</label>
                                                <input type="datetime-local" class="form-control" id="startDate" name="startDate"
                                                       value="${discount.startDate}">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="endDate" class="form-label">Ngày kết thúc</label>
                                                <input type="datetime-local" class="form-control" id="endDate" name="endDate"
                                                       value="${discount.endDate}">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Cột phải -->
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="maximumAmount" class="form-label">Số tiền giảm tối đa (VNĐ)</label>
                                        <input type="number" class="form-control" id="maximumAmount" name="maximumAmount"
                                               value="${discount.maximumAmount}" min="0" step="1000">
                                    </div>

                                    <div class="mb-3">
                                        <label for="maximumUsage" class="form-label">Số lần sử dụng tối đa</label>
                                        <input type="number" class="form-control" id="maximumUsage" name="maximumUsage"
                                               value="${discount.maximumUsage}" min="1">
                                    </div>

                                    <div class="mb-3">
                                        <label for="minimumAmountInCart" class="form-label">Giá trị đơn hàng tối thiểu (VNĐ)</label>
                                        <input type="number" class="form-control" id="minimumAmountInCart" name="minimumAmountInCart"
                                               value="${discount.minimumAmountInCart}" min="0" step="1000">
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="status" class="form-label">Trạng thái</label>
                                                <select class="form-select" id="status" name="status">
                                                    <option value="1" ${discount.status == 1 ? 'selected' : ''}>Kích hoạt</option>
                                                    <option value="0" ${discount.status == 0 ? 'selected' : ''}>Tạm dừng</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="type" class="form-label">Loại giảm giá</label>
                                                <select class="form-select" id="type" name="type">
                                                    <option value="1" ${discount.type == 1 ? 'selected' : ''}>Giảm theo số tiền</option>
                                                    <option value="2" ${discount.type == 2 ? 'selected' : ''}>Giảm theo phần trăm</option>
                                                    <option value="3" ${discount.type == 3 ? 'selected' : ''}>Miễn phí vận chuyển</option>
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
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save me-2"></i>Cập nhật
                                        </button>
                                        <a href="/admin/Discount" class="btn btn-secondary">
                                            <i class="fas fa-arrow-left me-2"></i>Quay lại
                                        </a>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
