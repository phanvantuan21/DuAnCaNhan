<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Giảm giá theo Biến thể</title>
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
                    <jsp:param name="title" value="Quản Lý Giảm giá theo Biến thể Sản phẩm"/>
                    <jsp:param name="icon" value="fa-solid fa-percent"/>
                </jsp:include>

                <div class="d-flex align-items-center gap-2 mb-3">
                    <a class="btn btn-secondary" href="/Home">🏠 Trang chủ</a>
                        <form class="d-flex" action="/admin/sales/searchProductName" method="get">
                            <div class="input-group">
                                <input class="form-control me-2" type="search" name="keyword" 
                                    placeholder="Nhập tên sản phẩm..." value="${searchQuery}">
                                <button class="btn btn-outline-primary" type="submit">
                                    <i class="fa fa-search"></i> Tìm kiếm
                                </button>
                            </div>
                        </form>
                    <a href="/admin/ProductDiscount/create" class="btn btn-success">
                        <i class="fas fa-plus me-2"></i>Thêm giảm giá
                    </a>
                    <div class="col-auto">
                        <a href="/admin/ProductDiscount" class="btn btn-outline-secondary">🔄 Tải lại bảng</a>
                    </div>
                </div>

                <!-- Thông báo -->
                <c:if test="${not empty message}">
                    <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
                            ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="table-responsive">
                    <table class="table table-bordered table-striped table-hover align-middle">
                        <thead class="table-dark">
                        <tr>
                            <th>STT</th>
                            <th>Sản phẩm</th>
                            <th>Thương hiệu</th>
                            <th>Chất liệu</th>
                            <th>Màu</th>
                            <th>Size</th>
                            <th>Giá gốc</th>
                            <th>Giá KM</th>
                            <th>Bắt đầu</th>
                            <th>Kết thúc</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="detail" items="${productDetails}" varStatus="i">
                                <form method="post" action="/admin/update">
                                    <tr>
                                        <td>${i.index + 1}</td>
                                        <td>${detail.product.name}</td>
                                        <td>${detail.product.brand.name}</td>
                                        <td>${detail.product.material.name}</td>
                                        <td>${detail.color.name}</td>
                                        <td>${detail.size.name}</td>
                                        <td>${detail.price}</td>

                                        <input type="hidden" name="productDetailId" value="${detail.id}" />
                                        <td>
                                            <input type="number" step="1000" class="form-control" name="discountedAmount"
                                            value="${detail.productDiscount != null ? detail.productDiscount[0].discountedAmount : 0.0
                                            }"
                                            min="0" 
                                            max="${detail.price}"/>
                                        </td>
                                        <td>
                                            <input type="datetime-local" class="form-control" name="startDate"
                                                value="${detail.productDiscount != null ? detail.productDiscount[0].startDate : ''}"/>
                                        </td>
                                        <td>
                                            <input type="datetime-local" class="form-control" name="endDate"
                                                value="${detail.productDiscount != null ? detail.productDiscount[0].endDate : ''}"/>
                                        </td>
                                        <td>
                                            <select name="closed" class="form-select">
                                                <option value="false"
                                                        <c:if test="${detail.productDiscount != null && !detail.productDiscount[0].closed}">selected</c:if>>
                                                    Đang bật
                                                </option>
                                                <option value="true"
                                                        <c:if test="${detail.productDiscount != null && detail.productDiscount[0].closed}">selected</c:if>>
                                                    Đã tắt
                                                </option>
                                            </select>
                                        </td>
                                        <td>
                                            <button type="submit" class="btn btn-primary btn-sm">Lưu</button>
                                        </td>
                                    </tr>
                                </form>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
