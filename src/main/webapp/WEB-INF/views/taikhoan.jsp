<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Người Dùng</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="containerr">
    <!-- Sidebar -->
    <jsp:include page="admin/layout/sidebar.jsp"/>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
        <jsp:include page="admin/layout/header.jsp"/>

        <!-- User Management Content -->
        <div class="dashboard">
            <jsp:include page="admin/layout/page-title.jsp">
                <jsp:param name="title" value="Quản Lý Người Dùng"/>
                <jsp:param name="icon" value="fa-solid fa-users"/>
            </jsp:include>

            <div class="d-flex justify-content-between mb-3">
                <form class="d-flex" method="get" action="/admin/account">
                   <input type="text"
                              class="form-control me-2"
                              name="query"
                              placeholder="🔍 Tìm theo mã tài khoản, email hoặc tên người dùng"
                              style="width: 280px;"
                              value="${param.query}">
                       <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                </form>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover align-middle">
                    <thead class="table-dark">
                    <tr>
                        <th scope="col">STT</th>
                        <th scope="col">ID</th>
                        <th scope="col">Mã tài khoản</th>
                        <th scope="col">Tên người dùng</th>
                        <th scope="col">Email</th>
                        <th scope="col">Trạng thái</th>
                        <th scope="col">Vai trò</th>
                        <th scope="col">Ngày tạo</th>
                    </tr>
                    </thead>
                    <tbody>
<%--                    <c:forEach var="acc" items="${users}" varStatus="status">--%>
<%--                        <tr>--%>
<%--                            <td>${status.index + 1}</td>--%>
<%--                            <td>${acc.id}</td>--%>
<%--                            <td>${acc.code}</td>--%>
<%--                            <td>${acc.customer.name}</td>--%>
<%--                            <td>${acc.email}</td>--%>
<%--                            <td>--%>
<%--                                <span class="badge ${acc.isNonLocked ? 'bg-success' : 'bg-danger'}">--%>
<%--                                        ${acc.isNonLocked ? 'Hoạt động' : 'Bị khóa'}--%>
<%--                                </span>--%>
<%--                            </td>--%>
<%--                            <td>${acc.role.name}</td>--%>
<%--                            <td>${acc.createDate}</td>--%>
<%--                        </tr>--%>
<%--                    </c:forEach>--%>

                        <c:forEach var="acc" items="${users}" varStatus="status">
                            <c:if test="${acc.role.name == 'ROLE_USER'}">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>${acc.id}</td>
                                    <td>${acc.code}</td>
                                    <td>${acc.customer.name}</td>
                                    <td>${acc.email}</td>
                                    <td>
                                        <span class="badge ${acc.isNonLocked ? 'bg-success' : 'bg-danger'}">
                                                ${acc.isNonLocked ? 'Hoạt động' : 'Bị khóa'}
                                        </span>
                                    </td>
                                    <td>${acc.role.name}</td>
                                    <td>${acc.createDate}</td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

<!-- Bootstrap JS (tùy chọn nếu cần chức năng nâng cao) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
