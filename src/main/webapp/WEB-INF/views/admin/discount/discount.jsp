<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Discount</title>
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
                    <jsp:param name="title" value="Quản Lý Giảm giá"/>
                    <jsp:param name="icon" value="fa-solid fa-tags"/>
                </jsp:include>

                <!-- Form tìm kiếm -->
                <form class="row g-3 mb-4" method="get" action="/admin/Discount/search">
                        <div class="col-auto">
                                <input type="text" class="form-control" name="keyword" placeholder="Tìm theo mã hoặc mô tả...">
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">🔍 Tìm kiếm</button>
                            </div>
                            <div class="col-auto">
                                <a href="/admin/Discount" class="btn btn-outline-secondary">🔄 Tải lại bảng</a>
                            </div>
                        <div class="col-auto">
                            <a href="/admin/Discount/create" class="btn btn-success">
                                ➕ Thêm mã giảm giá
                            </a>
                        </div>
                </form>

                <!-- Bảng dữ liệu -->
                <div class="table-responsive">
                    <table class="table table-bordered table-striped table-hover align-middle">
                        <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Mã</th>
                            <th>Chi tiết</th>
                            <th>Giá trị giảm</th>
                            <th>Ngày bắt đầu</th>
                            <th>Ngày kết thúc</th>
                            <th>Giảm tối đa</th>
                            <th>Số lượt dùng tối đa</th>
                            <th>Giá trị đơn tối thiểu</th>
                            <th>Tỷ lệ (%)</th>
                            <th>Trạng thái</th>
                            <th>Loại giảm</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="discount" items="${discounts}">
                            <tr>
                                <td>${discount.id}</td>
                                <td>${discount.code}</td>
                                <td>${discount.detail}</td>
                                <td>${discount.amount}</td>
                                <td>${discount.startDate}</td>
                                <td>${discount.endDate}</td>
                                <td>${discount.maximumAmount}</td>
                                <td>${discount.maximumUsage}</td>
                                <td>${discount.minimumAmountInCart}</td>
                                <td>${discount.percentage}</td>
                                <td>
                                    <span class="badge ${discount.status == 1 ? 'bg-success' : 'bg-secondary'}">
                                        ${discount.status == 1 ? 'ACTIVE' : 'INACTIVE'}
                                    </span>
                                </td>
                                <td>${discount.type}</td>
                                <td>
                                    <a href="/admin/Discount/delete?id=${discount.id}"
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Bạn có chắc muốn xóa giảm giá này không?')">
                                        Xóa
                                    </a>
                                    <a href="/admin/Discount/update/${discount.id}" class="btn btn-sm">Sửa</a>

                                </td>
                            </tr>
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
