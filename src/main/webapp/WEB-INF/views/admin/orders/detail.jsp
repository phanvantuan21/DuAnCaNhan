<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        /* CSS tùy chỉnh */
        body {
            background-color: #f8f9fa;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .back-link {
            margin-top: 20px;
            display: inline-block;
        }
        .content-area {
            padding: 20px;
        }
    </style>
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

                <!-- Header -->
                <jsp:include page="../layout/header.jsp"/>

                <!-- Page Title -->
                <div class="p-4">
                    <jsp:include page="../layout/page-title.jsp">
                        <jsp:param name="title" value="Chi tiết đơn hàng: ${bill.code}"/>
                        <jsp:param name="icon" value="fa-solid fa-receipt"/>
                    </jsp:include>
                </div>
                <!-- Content chi tiết đơn hàng -->
                <div class="content-area">
                    <p><strong>Khách hàng:</strong> ${bill.customer.name}</p>
                    <p><strong>Ngày đặt:</strong> <fmt:formatDate value="${bill.createDateAsDate}" pattern="dd/MM/yyyy HH:mm"/></p>
                    <p><strong>Địa chỉ khách hàng: </strong> ${bill.billingAddress}</p>
                    <p><strong>Tổng tiền:</strong> <fmt:formatNumber value="${bill.finalAmount}" type="number"/> đ</p>

                    <table class="table table-bordered table-striped">
                        <thead class="table-dark">
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Số lượng</th>
                                <th>Giá</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="d" items="${billDetails}">
                                <tr>
                                    <td>${d.productDetail.product.name}</td>
                                    <td>${d.quantity}</td>
                                    <td><fmt:formatNumber value="${d.momentPrice}" type="number"/> đ</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <a href="/admin/orders" class="btn btn-secondary back-link">← Quay lại danh sách</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
