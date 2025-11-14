<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm - Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .btn {
            display: inline-block;
            font-weight: 400;
            line-height: 1.5;
            color: #212529;
            text-align: center;
            text-decoration: none;
            vertical-align: middle;
            cursor: pointer;
            user-select: none;
            background-color: transparent;
            border: 1px solid transparent;
            padding: 0.375rem 0.75rem;
            font-size: 1rem;
            border-radius: 0.375rem;
            transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out,
            border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
        }

        .btn-info {
            color: #000;
            background-color: #0dcaf0;
            border-color: #0dcaf0;
        }

        .btn-info:hover {
            color: #000;
            background-color: #31d2f2;
            border-color: #25cff2;
        }

        .btn-info:focus {
            color: #000;
            background-color: #31d2f2;
            border-color: #25cff2;
            box-shadow: 0 0 0 0.25rem rgba(11, 172, 204, 0.5);
        }

        .btn-info:active {
            color: #000;
            background-color: #3dd5f3;
            border-color: #25cff2;
        }

        .products-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .btn {
            display: inline-block;
            font-weight: 400;
            line-height: 1.5;
            color: #212529;
            text-align: center;
            text-decoration: none;
            vertical-align: middle;
            cursor: pointer;
            user-select: none;
            background-color: transparent;
            border: 1px solid transparent;
            padding: 0.375rem 0.75rem;
            font-size: 1rem;
            border-radius: 0.375rem;
            transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out,
            border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
        }

        .btn-info {
            color: #000;
            background-color: #0dcaf0;
            border-color: #0dcaf0;
        }

        .btn-info:hover {
            color: #000;
            background-color: #31d2f2;
            border-color: #25cff2;
        }

        .btn-info:focus {
            color: #000;
            background-color: #31d2f2;
            border-color: #25cff2;
            box-shadow: 0 0 0 0.25rem rgba(11, 172, 204, 0.5);
        }

        .btn-info:active {
            color: #000;
            background-color: #3dd5f3;
            border-color: #25cff2;
        }

        .btn-add {
            background: #2ecc71;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: background 0.3s ease;
            text-decoration: none;
        }

        .btn-add:hover {
            background: #27ae60;
        }

        .product-image {
            width: 50px;
            height: 50px;
            border-radius: 5px;
            object-fit: cover;
        }

        .product-actions {
            display: flex;
            gap: 10px;
        }

        .btn-edit {
            background: #3498db;
            color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 3px;
            cursor: pointer;
        }

        .btn-delete {
            background: #e74c3c;
            color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 3px;
            cursor: pointer;
        }

        .filters {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }

        .filter-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .filter-group select {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            outline: none;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <jsp:include page="../layout/sidebar.jsp"/>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
     <jsp:include page="../layout/header.jsp"/>

        <!-- Products Content -->
        <div class="products-header">
            <h1>Chi tiết sản phẩm
                <c:if test="${not empty product}">
                    - ${product.name}
                </c:if>
            </h1>
        </div>
        <!-- Products Table -->
        <div class="table-container">
            <c:choose>
                <c:when test="${empty productDetails}">
                    <!-- Empty State -->
                    <div style="text-align: center; padding: 60px 20px; background: #f8f9fa; border-radius: 10px; margin: 20px 0;">
                        <div style="font-size: 4rem; color: #6c757d; margin-bottom: 20px;">
                            <i class="fas fa-inbox"></i>
                        </div>
                        <h3 style="font-size: 1.5rem; font-weight: 600; color: #495057; margin-bottom: 10px;">
                            Chưa có chi tiết sản phẩm
                        </h3>
                        <p style="color: #6c757d; margin-bottom: 30px;">
                            <c:if test="${not empty product}">
                                Sản phẩm "<strong>${product.name}</strong>" chưa có các biến thể (size, màu sắc, giá).
                                <br>
                            </c:if>
                            Hãy thêm chi tiết sản phẩm để khách hàng có thể mua hàng.
                        </p>

                        <div style="display: flex; justify-content: center; gap: 15px;">
                            <a href="/product-detail/create<c:if test='${not empty product}'>?productId=${product.id}</c:if>"
                               class="btn-add" style="padding: 12px 30px; font-size: 1.1rem;">
                                <i class="fas fa-plus"></i> Thêm chi tiết sản phẩm
                            </a>
                            <a href="/admin/products" class="btn btn-info" style="padding: 12px 30px;">
                                <i class="fas fa-arrow-left"></i> Quay lại danh sách
                            </a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Add Product Detail Button -->
                    <div style="margin-bottom: 20px; text-align: center;">
                        <a href="/product-detail/create"
                           style="display: inline-block; padding: 12px 30px; font-size: 1.1rem; text-decoration: none;
                                  background: #28a745; color: white; border-radius: 5px; transition: all 0.3s ease;">
                            <i class="fas fa-plus"></i> Thêm chi tiết sản phẩm mới
                        </a>
                    </div>

                    <!-- Products Table -->
                    <table>
                        <thead>
                        <tr>
                            <th>Hình ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Danh mục</th>
                            <th>Size</th>
                            <th>Màu sắc</th>
                            <th>Giá</th>
                            <th>Tồn kho</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${productDetails}" var="productDetail">
                            <tr>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty productDetail.imageList}">
                                            <c:forEach items="${productDetail.imageList}" var ="img">
                                                <img src="/images/product/${img.link}" alt="image product detail" class="product-image">
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="product-image" style="background: #f8f9fa; display: flex; align-items: center; justify-content: center; color: #6c757d;">
                                                <i class="fas fa-image"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${productDetail.product.name}</td>
                                <td>${productDetail.product.category.name}</td>
                                <td>${productDetail.size.name}</td>
                                <td>${productDetail.color.name}</td>
                                <td>${productDetail.price}</td>
                                <td>${productDetail.quantity}</td>
                                <td class="product-actions">
                                    <a href="/product-detail/edit/${productDetail.id}" class="btn-edit">
                                        <i class="fas fa-edit">
                                        </i></a>
                                    <a class="btn-delete" href="/product-detail/delete/${productDetail.id}">
                                        <i class="fas fa-trash">
                                        </i></a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div>
                        <a href="/admin/products" class="btn btn-info" style="margin-top:48px">Quay lại</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>

