<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý Kích Thước</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body style="display: flex; min-height: 100vh">
<jsp:include page="admin/layout/sidebar.jsp"/>
<div class="main-content">
    <jsp:include page="admin/layout/header.jsp"/>
    <jsp:include page="admin/layout/page-title.jsp">
        <jsp:param name="title" value="Quản Lý Kích Thước"/>
        <jsp:param name="icon" value="fa-solid fa-ruler"/>
    </jsp:include>
    <div class="d-flex justify-content-between mb-3">
        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addSizeModal">
            ➕ Thêm Kích Thước
        </button>
    </div>

    <c:if test="${not empty message}">
        <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
                ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <form class="row g-3 mb-4" method="get" action="/Size/search">
        <div class="col-auto">
            <input type="text" class="form-control" name="query"
                   placeholder="🔍 Tìm theo mã hoặc tên kích cỡ" value="${param.query}">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
        </div>
        <div class="col-auto">
            <a href="/Size" class="btn btn-outline-secondary">🔄 Tải lại bảng</a>
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
                <th>STT</th>
                <th>ID</th>
                <th>Mã kích thước</th>
                <th>Tên kích thước</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="size" items="${sizes}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${size.id}</td>
                    <td>${size.code}</td>
                    <td>${size.name}</td>
                    <td>
                        <a href="/Size/update"
                           class="btn btn-warning btn-sm"
                           data-bs-toggle="modal"
                           data-bs-target="#editSizeModal${size.id}">Sửa</a>
                        <a href="/Size/delete?id=${size.id}"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Bạn có muốn xóa kích thước này không?')">Xóa</a>
                    </td>
                </tr>

                <!-- Modal sửa kích thước -->
                <div class="modal fade" id="editSizeModal${size.id}" tabindex="-1" aria-labelledby="editSizeModalLabel${size.id}" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form method="post" action="/Size/update">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editSizeModalLabel${size.id}">Sửa Kích Thước</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="id" value="${size.id}">
                                    <div class="mb-3">
                                        <label class="form-label">Mã Kích Thước</label>
                                        <input type="text" class="form-control" name="code" value="${size.code}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Tên Kích Thước</label>
                                        <input type="text" class="form-control" name="name" value="${size.name}">
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

<!-- Modal thêm kích thước -->
<div class="modal fade" id="addSizeModal" tabindex="-1" aria-labelledby="addSizeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addSizeModalLabel">Thêm Kích Thước Mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="post" action="/Size/add">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="sizeCode" class="form-label">Mã Kích Thước <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="sizeCode" name="code">
                    </div>
                    <div class="mb-3">
                        <label for="sizeName" class="form-label">Tên Kích Thước <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="sizeName" name="name">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-success">Thêm Kích Thước</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
