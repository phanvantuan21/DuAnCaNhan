<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý Chất Liệu</title>
    <!-- Link Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body style="display: flex; min-height: 100vh">
<jsp:include page="admin/layout/sidebar.jsp"/>
<div class="main-content">
    <jsp:include page="admin/layout/header.jsp"/>
    <jsp:include page="admin/layout/page-title.jsp">
        <jsp:param name="title" value="Quản Lý Chất Liệu"/>
        <jsp:param name="icon" value="fa-solid fa-shirt"/>
    </jsp:include>
    <div class="d-flex justify-content-between mb-3">
        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addMaterialModal">
            ➕ Thêm Chất Liệu
        </button>
    </div>

    <!-- Hiển thị thông báo -->
    <c:if test="${not empty message}">
        <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
                ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <form class="row g-3 mb-4" method="get" action="/Material/search">
        <div class="col-auto">
            <input type="text" class="form-control" name="query"
                   placeholder="🔍 Tìm theo mã hoặc tên chất liệu" value="${param.query}">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
        </div>
        <div class="col-auto">
            <a href="/Material" class="btn btn-outline-secondary">🔄 Tải lại bảng</a>
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
                <th scope="col">Mã chất liệu</th>
                <th scope="col">Tên chất liệu</th>
                <th scope="col">Trạng thái</th>
                <th scope="col">Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="material" items="${materials}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${material.id}</td>
                    <td>${material.code}</td>
                    <td>${material.name}</td>
                    <td>
                        <span class="badge ${material.status == 'true' ? 'bg-success' : 'bg-danger'}">
                                ${material.status == 'true' ? 'Còn hàng' : 'Hết hàng'}
                        </span>
                    </td>
                    <td>
                        <a href="/Material/update"
                           class="btn btn-warning btn-sm"
                           role="button"
                           data-bs-toggle="modal"
                           data-bs-target="#editMaterialModal${material.id}">
                            Sửa
                        </a>
                        <a href="/Material/delete?id=${material.id}"
                           class="btn btn-sm btn-danger" onclick="return confirm('bạn có muốn xóa chất liệu này ko?')"
                        >Xóa</a>
                    </td>
                </tr>

                <!-- Modal sửa chất liệu -->
                <div class="modal fade" id="editMaterialModal${material.id}" tabindex="-1" aria-labelledby="editMaterialModalLabel${material.id}" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form method="post" action="/Material/update">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editMaterialModalLabel${material.id}">Sửa Chất Liệu</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="id" value="${material.id}">

                                    <div class="mb-3">
                                        <label class="form-label">Mã Chất Liệu</label>
                                        <input type="text" class="form-control" name="code" value="${material.code}">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Tên Chất Liệu</label>
                                        <input type="text" class="form-control" name="name" value="${material.name}">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Trạng Thái</label>
                                        <select class="form-select" name="status">
                                            <option value="true" ${material.status == 'true' ? 'selected' : ''}>Còn hàng</option>
                                            <option value="false" ${material.status == 'false' ? 'selected' : ''}>Hết hàng</option>
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

<!-- Modal thêm chất liệu -->
<div class="modal fade" id="addMaterialModal" tabindex="-1" aria-labelledby="addMaterialModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addMaterialModalLabel">Thêm Chất Liệu Mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form method="post" action="/Material/add">
            <form method="post" action=/Material/add">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="materialCode" class="form-label">Mã Chất Liệu <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="materialCode" name="code">
                    </div>
                    <div class="mb-3">
                        <label for="materialName" class="form-label">Tên Chất Liệu <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="materialName" name="name">
                    </div>
                    <div class="mb-3">
                        <label for="materialStatus" class="form-label">Trạng Thái <span class="text-danger">*</span></label>
                        <select class="form-select" id="materialStatus" name="status">
                            <option value="">Chọn trạng thái</option>
                            <option value="true">Còn hàng</option>
                            <option value="false">Hết hàng</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-success">Thêm Chất Liệu</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>