<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý Thương Hiệu</title>
    <!-- Link Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body style="min-with:100vh; display:flex">
<jsp:include page="admin/layout/sidebar.jsp"/>
<div class="main-content">
    <jsp:include page="admin/layout/header.jsp"/>
    <jsp:include page="admin/layout/page-title.jsp">
        <jsp:param name="title" value="Quản Lý Thương Hiệu"/>
        <jsp:param name="icon" value="fa-solid fa-trademark"/>
    </jsp:include>
    <div class="d-flex justify-content-between mb-3">
        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addBrandModal">
            ➕ Thêm Thương Hiệu
        </button>
    </div>
    <!-- Hiển thị thông báo -->
    <c:if test="${not empty message}">
        <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <form class="row g-3 mb-4" method="get" action="/Brand/search">
        <!-- Ô nhập tìm kiếm -->
        <div class="col-auto">
            <input type="text"
                   class="form-control"
                   name="query"
                   placeholder="Tìm theo mã hoặc tên thương hiệu..."
                   value="${param.query}">
        </div>

        <!-- Nút tìm kiếm -->
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">
                🔍 Tìm kiếm
            </button>
        </div>

        <!-- Nút tải lại -->
        <div class="col-auto">
            <a href="/Brand" class="btn btn-outline-secondary">
                🔄 Tải lại bảng
            </a>
        </div>
    </form>

    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <div class="table-responsive">
        <table class="table table-bordered table-striped table-hover align-middle">
            <thead class="table-dark">
            <tr>
                <th scope="col">STT</th>
                <th scope="col">ID</th>
                <th scope="col">Mã Thương hiệu</th>
                <th scope="col">Tên thương hiệu</th>
                <th scope="col">Trạng thái</th>
                <th scope="col">Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="brand" items="${brands}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${brand.id}</td>
                        <td>${brand.code}</td>
                        <td>${brand.name}</td>
                        <td>
                        <span class="badge ${brand.status == 'true' ? 'bg-success' : 'bg-danger'}">
                                ${brand.status == 'true' ? 'Còn hàng' : 'Hết hàng'}
                        </span>
                        </td>
                        <td>
                            <a href="/Brand/update"
                               class="btn btn-warning btn-sm"
                               role="button"
                               data-bs-toggle="modal"
                               data-bs-target="#editBrandModal${brand.id}">
                                Sửa
                            </a>
                            <a href="/Brand/delete?id=${brand.id}"
                               class="btn btn-sm btn-danger" onclick="return confirm('bạn có muốn xóa thương hiệu này ko?')"
                            >Xóa</a>
                        </td>
                    </tr>

                <!-- Modal sửa thương hiệu -->
                <div class="modal fade" id="editBrandModal${brand.id}" tabindex="-1" aria-labelledby="editBrandModalLabel${brand.id}" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form method="post" action="/Brand/update">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editBrandModalLabel${brand.id}">Sửa Thương Hiệu</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="id" value="${brand.id}">

                                    <div class="mb-3">
                                        <label class="form-label">Mã Thương Hiệu</label>
                                        <input type="text" class="form-control" name="code" value="${brand.code}">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Tên Thương Hiệu</label>
                                        <input type="text" class="form-control" name="name" value="${brand.name}">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Trạng Thái</label>
                                        <select class="form-select" name="status">
                                            <option value="true" ${brand.status == 'true' ? 'selected' : ''}>Còn hàng</option>
                                            <option value="false" ${brand.status == 'false' ? 'selected' : ''}>Hết hàng</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal thêm thương hiệu -->
<div class="modal fade" id="addBrandModal" tabindex="-1" aria-labelledby="addBrandModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addBrandModalLabel">Thêm Thương Hiệu Mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form method="post" action="/Brand/add">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="brandCode" class="form-label">Mã Thương Hiệu <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="brandCode" name="code">
                    </div>
                    <div class="mb-3">
                        <label for="brandName" class="form-label">Tên Thương Hiệu <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="brandName" name="name">
                    </div>
                    <div class="mb-3">
                        <label for="brandStatus" class="form-label">Trạng Thái <span class="text-danger">*</span></label>
                        <select class="form-select" id="brandStatus" name="status">
                            <option value="">Chọn trạng thái</option>
                            <option value="true">Còn hàng</option>
                            <option value="false">Hết hàng</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-success">Thêm Thương Hiệu</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
