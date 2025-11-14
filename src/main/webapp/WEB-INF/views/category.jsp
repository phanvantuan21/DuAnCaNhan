<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý Loại Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body style="min-with:100vh; display:flex">
<jsp:include page="admin/layout/sidebar.jsp"/>
<div class="main-content">
    <jsp:include page="admin/layout/header.jsp"/>
    <jsp:include page="admin/layout/page-title.jsp">
        <jsp:param name="title" value="Quản Lý Loại Sản Phẩm"/>
        <jsp:param name="icon" value="fa-solid fa-tags"/>
    </jsp:include>
    <div class="d-flex justify-content-between mb-3">
        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
            ➕ Thêm Loại SP
        </button>
    </div>

    <c:if test="${not empty message}">
        <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
                ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <form class="row g-3 mb-4" method="get" action="/Category/search">
        <div class="col-auto">
            <input type="text" class="form-control" name="query" placeholder="🔍 Tìm theo mã hoặc tên danh mục" value="${param.query}">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
        </div>
        <div class="col-auto">
            <a href="/Category" class="btn btn-outline-secondary">🔄 Tải lại bảng</a>
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
                <th scope="col">Mã loại sản phẩm</th>
                <th scope="col">Tên loại sản phẩm</th>
                <th scope="col">Trạng thái</th>
                <th scope="col">Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="category" items="${categories}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${category.id}</td>
                    <td>${category.code}</td>
                    <td>${category.name}</td>
                    <td>
                        <span class="badge ${category.status ? 'bg-success' : 'bg-danger'}">
                                ${category.status ? 'Còn hàng' : 'Hết hàng'}
                        </span>
                    </td>
                    <td>
                        <a href="/Category/update"
                           class="btn btn-warning btn-sm"
                           role="button"
                           data-bs-toggle="modal"
                           data-bs-target="#editCategoryModal${category.id}">
                            Sửa
                        </a>
                        <a href="/Category/delete?id=${category.id}"
                           class="btn btn-sm btn-danger"
                           onclick="return confirm('Bạn có muốn xóa loại sản phẩm này không?')">
                            Xóa
                        </a>
                    </td>
                </tr>

                <!-- Modal sửa loại sản phẩm -->
                <div class="modal fade" id="editCategoryModal${category.id}" tabindex="-1" aria-labelledby="editCategoryModalLabel${category.id}" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form method="post" action="/Category/update">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editCategoryModalLabel${category.id}">Sửa Loại Sản Phẩm</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="id" value="${category.id}">

                                    <div class="mb-3">
                                        <label class="form-label">Mã loại SP</label>
                                        <input type="text" class="form-control" name="code" value="${category.code}">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Tên loại SP</label>
                                        <input type="text" class="form-control" name="name" value="${category.name}">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Trạng Thái</label>
                                        <select class="form-select" name="status">
                                            <option value="true" ${category.status ? 'selected' : ''}>Còn hàng</option>
                                            <option value="false" ${!category.status ? 'selected' : ''}>Hết hàng</option>
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

<!-- Modal thêm loại sản phẩm -->
<div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCategoryModalLabel">Thêm Loại SP Mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="post" action="/Category/add">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Mã Danh Mục <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="code">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Tên Danh Mục <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="name">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Trạng Thái <span class="text-danger">*</span></label>
                        <select class="form-select" name="status">
                            <option value="">Chọn trạng thái</option>
                            <option value="true">Còn hàng</option>
                            <option value="false">Hết hàng</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-success">Thêm</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
