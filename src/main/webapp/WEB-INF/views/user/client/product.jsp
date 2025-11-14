<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm - BeeStore</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        body {
            background-color: #f5f5f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Sidebar */
        .sidebar {
            background: white;
            border-radius: 8px;
            padding: 0;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .sidebar-section {
            padding: 20px;
            border-bottom: 1px solid #f0f0f0;
        }

        .sidebar-section:last-child {
            border-bottom: none;
        }

        .sidebar-title {
            font-size: 1rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 15px;
            text-transform: uppercase;
        }

        .category-item {
            display: block;
            padding: 10px 15px;
            color: #666;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.2s;
            margin-bottom: 5px;
        }

        .category-item:hover {
            background-color: #f8f9fa;
            color: #5cb85c;
        }

        .category-item.active {
            background-color: #5cb85c;
            color: white;
            font-weight: 600;
        }

        /* Filter Checkboxes */
        .filter-checkbox {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .filter-checkbox input {
            margin-right: 10px;
            cursor: pointer;
        }

        .filter-checkbox label {
            cursor: pointer;
            margin: 0;
            font-size: 0.9rem;
            color: #666;
        }

        /* Price Range */
        .price-range {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .price-range input {
            flex: 1;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 0.85rem;
        }

        /* Rating Filter */
        .rating-item {
            display: flex;
            align-items: center;
            padding: 8px 0;
            cursor: pointer;
            transition: all 0.2s;
        }

        .rating-item:hover {
            color: #5cb85c;
        }

        .rating-stars {
            color: #ffc107;
            margin-right: 10px;
        }

        /* Product Grid */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }

        .product-card {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            transition: all 0.3s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 16px rgba(0,0,0,0.15);
        }

        .product-image {
            position: relative;
            padding-top: 100%;
            overflow: hidden;
            background: #f8f9fa;
        }

        .product-image img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.75rem;
            font-weight: 600;
            z-index: 1;
        }

        .badge-sale {
            background: #ff4757;
            color: white;
        }

        .badge-new {
            background: #5cb85c;
            color: white;
        }

        .badge-outstock {
            background: #95a5a6;
            color: white;
        }

        .product-body {
            padding: 15px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .product-title {
            font-size: 0.9rem;
            color: #333;
            margin-bottom: 8px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            min-height: 40px;
            font-weight: 500;
        }

        .product-rating {
            display: flex;
            align-items: center;
            margin-bottom: 8px;
            font-size: 0.85rem;
        }

        .stars {
            color: #ffc107;
            margin-right: 5px;
        }

        .rating-count {
            color: #999;
            font-size: 0.8rem;
        }

        .product-price {
            margin-top: auto;
        }

        .price-current {
            font-size: 1.1rem;
            font-weight: 700;
            color: #ff4757;
        }

        .price-original {
            font-size: 0.85rem;
            color: #999;
            text-decoration: line-through;
            margin-left: 8px;
        }

        .price-discount {
            display: inline-block;
            margin-left: 8px;
            padding: 2px 6px;
            background: #ffe5e5;
            color: #ff4757;
            font-size: 0.75rem;
            font-weight: 600;
            border-radius: 3px;
        }

        /* Page Header */
        .page-header {
            background: white;
            padding: 20px 0;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .page-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #333;
            margin: 0;
        }

        .result-count {
            color: #999;
            font-size: 0.9rem;
        }

        /* Sort Dropdown */
        .sort-select {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 8px 15px;
            font-size: 0.9rem;
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .product-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 768px) {
            .product-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 576px) {
            .product-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Apply Button */
        .btn-apply {
            background: #5cb85c;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            width: 100%;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-apply:hover {
            background: #4cae4c;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-4 mb-5">
    <div class="row">

        <!-- ================= SIDEBAR BÊN TRÁI ================= -->
        <div class="col-lg-3 col-md-4 mb-4">
            <div class="sidebar">
                
                <!-- Danh mục -->
                <div class="sidebar-section">
                    <h6 class="sidebar-title">Danh mục sản phẩm</h6>
                    <a href="/product" class="category-item ${empty selectedCategoryId ? 'active' : ''}">
                        <i class="fas fa-th me-2"></i>Tất cả sản phẩm
                    </a>
                    <c:forEach items="${categories}" var="category">
                        <a href="?categoryId=${category.id}" 
                           class="category-item ${selectedCategoryId eq category.id ? 'active' : ''}">
                            <i class="fas fa-angle-right me-2"></i>${category.name}
                        </a>
                    </c:forEach>
                </div>

                <!-- Form Filter -->
                <form method="get" action="/product" id="filterForm">
                    <input type="hidden" name="categoryId" value="${selectedCategoryId}" />

                    <!-- Khoảng giá -->
                    <div class="sidebar-section">
                        <h6 class="sidebar-title">Khoảng giá</h6>
                        <div class="price-range mb-3">
                            <input type="number" name="minPrice" placeholder="Từ" 
                                   value="${minPrice}" class="form-control form-control-sm">
                            <span>-</span>
                            <input type="number" name="maxPrice" placeholder="Đến" 
                                   value="${maxPrice}" class="form-control form-control-sm">
                        </div>
                    </div>

                    <!-- Trạng thái -->
                    <div class="sidebar-section">
                        <h6 class="sidebar-title">Trạng thái</h6>
                        <div class="filter-checkbox">
                            <input type="radio" name="status" value="" id="status_all" 
                                   ${empty selectedStatus ? 'checked' : ''}>
                            <label for="status_all">Tất cả</label>
                        </div>
                        <div class="filter-checkbox">
                            <input type="radio" name="status" value="1" id="status_stock" 
                                   ${selectedStatus eq '1' ? 'checked' : ''}>
                            <label for="status_stock">Còn hàng</label>
                        </div>
                        <div class="filter-checkbox">
                            <input type="radio" name="status" value="0" id="status_out" 
                                   ${selectedStatus eq '0' ? 'checked' : ''}>
                            <label for="status_out">Hết hàng</label>
                        </div>
                        <div class="filter-checkbox">
                            <input type="radio" name="status" value="sale" id="status_sale" 
                                   ${selectedStatus eq 'sale' ? 'checked' : ''}>
                            <label for="status_sale">Đang giảm giá</label>
                        </div>
                    </div>

                    <!-- Nhà cung cấp (nếu có) -->
                    <c:if test="${not empty brands}">
                        <div class="sidebar-section">
                            <h6 class="sidebar-title">Nhà cung cấp</h6>
                            <c:forEach items="${brands}" var="brand" varStatus="status">
                                <c:if test="${status.index < 5}">
                                    <div class="filter-checkbox">
                                        <input type="checkbox" name="brandId" value="${brand.id}" 
                                               id="brand_${brand.id}">
                                        <label for="brand_${brand.id}">${brand.name}</label>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </c:if>

                    <!-- Đánh giá -->
                    <div class="sidebar-section">
                        <h6 class="sidebar-title">Đánh giá</h6>
                        <div class="rating-item">
                            <div class="rating-stars">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </div>
                            <span>(5 sao)</span>
                        </div>
                        <div class="rating-item">
                            <div class="rating-stars">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="far fa-star"></i>
                            </div>
                            <span>(4 sao trở lên)</span>
                        </div>
                        <div class="rating-item">
                            <div class="rating-stars">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="far fa-star"></i>
                                <i class="far fa-star"></i>
                            </div>
                            <span>(3 sao trở lên)</span>
                        </div>
                    </div>

                    <!-- Button áp dụng -->
                    <div class="sidebar-section">
                        <button type="submit" class="btn-apply">
                            <i class="fas fa-filter me-2"></i>Áp dụng lọc
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- ================= NỘI DUNG CHÍNH ================= -->
        <div class="col-lg-9 col-md-8">
            
            <!-- Page Header -->
            <div class="page-header px-4">
                <div class="d-flex justify-content-between align-items-center flex-wrap">
                    <div>
                        <h1 class="page-title">
                            <c:choose>
                                <c:when test="${not empty selectedCategoryId}">
                                    <c:forEach items="${categories}" var="c">
                                        <c:if test="${c.id eq selectedCategoryId}">${c.name}</c:if>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    Tất cả sản phẩm
                                </c:otherwise>
                            </c:choose>
                        </h1>
                        <p class="result-count">Tìm thấy ${products.size()} sản phẩm</p>
                    </div>
                    
                    <!-- Sort -->
                    <div>
                        <select name="sortBy" class="sort-select" onchange="applySort(this.value)">
                            <option value="newest" ${selectedSortBy eq 'newest' ? 'selected' : ''}>Mới nhất</option>
                            <option value="price_asc" ${selectedSortBy eq 'price_asc' ? 'selected' : ''}>Giá thấp đến cao</option>
                            <option value="price_desc" ${selectedSortBy eq 'price_desc' ? 'selected' : ''}>Giá cao đến thấp</option>
                            <option value="bestseller" ${selectedSortBy eq 'bestseller' ? 'selected' : ''}>Bán chạy</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Product Grid -->
            <div class="product-grid">
                <c:forEach items="${products}" var="product">
                    <div class="product-card">
                        <!-- Image -->
                        <a href="/product/${product.id}" class="product-image">
                            <!-- Badge -->
                            <c:set var="pd" value="${product.productDetailList[0]}" />
                            <c:choose>
                                <c:when test="${pd.quantity <= 0}">
                                    <span class="product-badge badge-outstock">Hết hàng</span>
                                </c:when>
                                <c:when test="${pd.discountedPrice < pd.price}">
                                    <span class="product-badge badge-sale">
                                        -<fmt:formatNumber value="${(1 - pd.discountedPrice / pd.price) * 100}" 
                                                          maxFractionDigits="0" />%
                                    </span>
                                </c:when>
                            </c:choose>

                            <!-- Image -->
                            <c:choose>
                                <c:when test="${not empty product.productDetailList and not empty product.productDetailList[0].imageList}">
                                    <img src="/images/product/${product.productDetailList[0].imageList[0].link}" 
                                         alt="${product.name}">
                                </c:when>
                                <c:otherwise>
                                    <img src="/images/no-image.png" alt="No image">
                                </c:otherwise>
                            </c:choose>
                        </a>

                        <!-- Body -->
                        <div class="product-body">
                            <a href="/product/${product.id}" style="text-decoration: none;">
                                <h6 class="product-title">${product.name}</h6>
                            </a>

                            <!-- Rating -->
                            <div class="product-rating">
                                <div class="stars">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                <span class="rating-count">(125)</span>
                            </div>

                            <!-- Price -->
                            <div class="product-price">
                                <c:choose>
                                    <c:when test="${pd.discountedPrice < pd.price}">
                                        <span class="price-current">
                                            <fmt:formatNumber value="${pd.discountedPrice}" type="number" />₫
                                        </span>
                                        <span class="price-original">
                                            <fmt:formatNumber value="${pd.price}" type="number" />₫
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="price-current">
                                            <fmt:formatNumber value="${pd.price}" type="number" />₫
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Empty State -->
            <c:if test="${empty products}">
                <div class="text-center py-5">
                    <i class="fas fa-box-open fa-4x text-muted mb-3"></i>
                    <h5>Không tìm thấy sản phẩm nào</h5>
                    <p class="text-muted">Vui lòng thử lại với bộ lọc khác</p>
                </div>
            </c:if>
        </div>

    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<script>
function applySort(value) {
    const url = new URL(window.location.href);
    url.searchParams.set('sortBy', value);
    window.location.href = url.toString();
}
</script>

</body>
</html>