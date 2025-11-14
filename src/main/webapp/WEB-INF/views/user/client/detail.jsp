<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>${details[0].product.name} - Camiune</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <style>
        body {
            background-color: #f5f5f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Notification Toast */
        .notification-toast {
            position: fixed;
            top: 100px;
            right: 20px;
            z-index: 9999;
            min-width: 300px;
            padding: 16px 20px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            opacity: 0;
            transform: translateX(400px);
            transition: all 0.4s ease;
        }

        .notification-toast.show {
            opacity: 1;
            transform: translateX(0);
        }

        .notification-toast.success {
            background: #28a745;
            color: white;
        }

        .notification-toast.error {
            background: #dc3545;
            color: white;
        }

        /* Product Detail Container */
        .product-detail-container {
            background: white;
            border-radius: 12px;
            padding: 30px;
            margin-top: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        /* Image Gallery */
        .image-gallery {
            display: flex;
            gap: 15px;
        }

        .thumbnail-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
            max-height: 500px;
            overflow-y: auto;
        }

        .thumbnail-list::-webkit-scrollbar {
            width: 4px;
        }

        .thumbnail-list::-webkit-scrollbar-thumb {
            background: #ddd;
            border-radius: 4px;
        }

        .thumbnail-item {
            width: 80px;
            height: 80px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            cursor: pointer;
            overflow: hidden;
            transition: all 0.3s;
        }

        .thumbnail-item:hover,
        .thumbnail-item.active {
            border-color: #5cb85c;
            transform: scale(1.05);
        }

        .thumbnail-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .main-image {
            flex: 1;
            max-width: 450px;
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            overflow: hidden;
            background: #f8f9fa;
        }

        .main-image img {
            width: 100%;
            height: 450px;
            object-fit: cover;
        }

        /* Product Info */
        .product-info {
            flex: 1;
        }

        .product-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 15px;
            line-height: 1.4;
        }

        .brand-text {
            color: #666;
            font-size: 0.95rem;
            margin-bottom: 10px;
        }

        .brand-name {
            color: #5cb85c;
            font-weight: 600;
        }

        .product-meta {
            display: flex;
            align-items: center;
            gap: 20px;
            padding: 15px 0;
            border-bottom: 1px solid #f0f0f0;
            margin-bottom: 15px;
        }

        .rating-section {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .rating-number {
            font-size: 1rem;
            font-weight: 700;
            color: #333;
        }

        .stars {
            color: #ffc107;
            font-size: 1.1rem;
        }

        .sold-count {
            color: #666;
            font-size: 0.95rem;
        }

        .sold-number {
            color: #5cb85c;
            font-weight: 600;
        }

        /* Price Box */
        .price-section {
            background: linear-gradient(135deg, #fff5f0 0%, #ffe8e0 100%);
            padding: 20px;
            border-radius: 12px;
            margin: 20px 0;
        }

        .current-price {
            font-size: 2rem;
            font-weight: 700;
            color: #ff4757;
        }

        .original-price {
            font-size: 1.1rem;
            color: #999;
            text-decoration: line-through;
            margin-left: 15px;
        }

        .discount-badge {
            display: inline-block;
            background: #ff4757;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            margin-left: 10px;
        }

        /* Product Options */
        .option-section {
            margin: 25px 0;
        }

        .option-label {
            font-size: 1rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 12px;
            display: block;
        }

        .option-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .option-item {
            position: relative;
        }

        .option-radio {
            display: none;
        }

        .option-button {
            display: block;
            padding: 10px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            background: white;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 0.95rem;
            color: #666;
            min-width: 70px;
            text-align: center;
        }

        .option-button:hover {
            border-color: #5cb85c;
            background: #f0fff0;
        }

        .option-radio:checked + .option-button {
            border-color: #5cb85c;
            background: #5cb85c;
            color: white;
            font-weight: 600;
        }

        .option-button.out-of-stock {
            background: #f5f5f5;
            color: #ccc;
            cursor: not-allowed;
            position: relative;
        }

        .option-button.out-of-stock::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 10%;
            right: 10%;
            height: 1px;
            background: #999;
            transform: translateY(-50%) rotate(-15deg);
        }

        /* Quantity Section */
        .quantity-section {
            display: flex;
            align-items: center;
            gap: 20px;
            margin: 25px 0;
        }

        .quantity-label {
            font-size: 1rem;
            font-weight: 600;
            color: #333;
        }

        .quantity-control {
            display: flex;
            align-items: center;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            overflow: hidden;
        }

        .quantity-btn {
            width: 40px;
            height: 40px;
            border: none;
            background: #f8f9fa;
            color: #666;
            font-size: 1.2rem;
            cursor: pointer;
            transition: all 0.2s;
        }

        .quantity-btn:hover {
            background: #5cb85c;
            color: white;
        }

        .quantity-input {
            width: 60px;
            height: 40px;
            border: none;
            text-align: center;
            font-weight: 600;
            font-size: 1rem;
        }

        .stock-status {
            color: #666;
            font-size: 0.95rem;
        }

        .stock-available {
            color: #28a745;
            font-weight: 600;
        }

        .stock-unavailable {
            color: #dc3545;
            font-weight: 600;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 15px;
            margin: 30px 0;
        }

        .btn-add-cart {
            flex: 1;
            padding: 15px 30px;
            background: linear-gradient(135deg, #5cb85c 0%, #4cae4c 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-add-cart:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(92, 184, 92, 0.4);
        }

        .btn-buy-now {
            flex: 1;
            padding: 15px 30px;
            background: linear-gradient(135deg, #ff4757 0%, #ff3838 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-buy-now:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 71, 87, 0.4);
        }

        /* Product Details */
        .product-details {
            margin-top: 30px;
            padding-top: 30px;
            border-top: 1px solid #f0f0f0;
        }

        .details-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 15px;
        }

        .details-list {
            list-style: none;
            padding: 0;
        }

        .details-list li {
            padding: 8px 0;
            color: #666;
            line-height: 1.6;
        }

        .details-list li:before {
            content: "✓";
            color: #5cb85c;
            font-weight: bold;
            margin-right: 10px;
        }

        /* Related Products */
        .related-products {
            margin-top: 50px;
        }

        .related-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }

        .related-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 20px;
        }

        .related-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            text-decoration: none;
        }

        .related-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .related-image {
            width: 100%;
            padding-top: 100%;
            position: relative;
            overflow: hidden;
            background: #f8f9fa;
        }

        .related-image img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .related-info {
            padding: 15px;
        }

        .related-name {
            font-size: 0.95rem;
            color: #333;
            margin-bottom: 10px;
            min-height: 40px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .related-rating {
            display: flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 8px;
            font-size: 0.85rem;
        }

        .related-stars {
            color: #ffc107;
        }

        .related-count {
            color: #999;
        }

        .related-price {
            font-size: 1.1rem;
            font-weight: 700;
            color: #ff4757;
        }

        .related-original-price {
            font-size: 0.85rem;
            color: #999;
            text-decoration: line-through;
            margin-left: 8px;
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .related-grid {
                grid-template-columns: repeat(4, 1fr);
            }
        }

        @media (max-width: 992px) {
            .image-gallery {
                flex-direction: column-reverse;
            }

            .thumbnail-list {
                flex-direction: row;
                max-height: none;
                overflow-x: auto;
            }

            .related-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 768px) {
            .product-detail-container {
                padding: 20px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .related-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .product-meta {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
        }

        @media (max-width: 576px) {
            .related-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 15px;
            }
        }
    </style>
</head>
<body>

<jsp:include page="../layout/header.jsp"/>

<!-- Notification Toast -->
<div id="notificationToast" class="notification-toast"></div>

<div class="container mt-4 mb-5">
    <!-- Product Detail -->
    <div class="product-detail-container">
        <div class="row">
            <!-- Image Gallery -->
            <div class="col-lg-5 col-md-6 mb-4">
                <div class="image-gallery">
                    <!-- Thumbnail List -->
                    <div class="thumbnail-list">
                        <c:forEach items="${details[0].imageList}" var="image" varStatus="status">
                            <div class="thumbnail-item ${status.first ? 'active' : ''}" 
                                 onclick="changeMainImage(this, '/images/product/${image.link}')">
                                <img src="/images/product/${image.link}" alt="Thumbnail ${status.index + 1}">
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Main Image -->
                    <div class="main-image">
                        <img id="mainImage" src="/images/product/${details[0].imageList[0].link}" 
                             alt="${details[0].product.name}">
                    </div>
                </div>
            </div>

            <!-- Product Info -->
            <div class="col-lg-7 col-md-6">
                <div class="product-info">
                    <!-- Title -->
                    <h1 class="product-title">${details[0].product.name}</h1>

                    <!-- Brand -->
                    <p class="brand-text">
                        Thương hiệu: <span class="brand-name">${details[0].product.brand.name}</span>
                    </p>

                    <!-- Meta Info -->
                    <div class="product-meta">
                        <div class="rating-section">
                            <span class="rating-number">5.0</span>
                            <div class="stars">★★★★★</div>
                        </div>
                        <div class="sold-count">
                            Đã bán: <span class="sold-number">${totalSold > 0 ? totalSold : 0}</span>
                        </div>
                    </div>

                    <!-- Price -->
                    <div class="price-section">
                        <c:choose>
                            <c:when test="${details[0].discountedPrice < details[0].price}">
                                <span class="current-price" id="currentPrice">
                                    <fmt:formatNumber value="${details[0].discountedPrice}" type="number" />₫
                                </span>
                                <span class="original-price">
                                    <fmt:formatNumber value="${details[0].price}" type="number" />₫
                                </span>
                                <c:set var="discount" value="${(details[0].price - details[0].discountedPrice) * 100 / details[0].price}" />
                                <span class="discount-badge">-${discount.intValue()}%</span>
                            </c:when>
                            <c:otherwise>
                                <span class="current-price" id="currentPrice">
                                    <fmt:formatNumber value="${details[0].price}" type="number" />₫
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <form id="addToCartForm">
                        <!-- Color Options -->
                        <div class="option-section">
                            <label class="option-label">Màu sắc:</label>
                            <div class="option-grid" id="colorOptions"></div>
                        </div>

                        <!-- Size Options -->
                        <div class="option-section">
                            <label class="option-label">Kích thước:</label>
                            <div class="option-grid" id="sizeOptions"></div>
                        </div>

                        <input type="hidden" name="selectedDetail" id="selectedDetailId">

                        <!-- Quantity -->
                        <div class="quantity-section">
                            <span class="quantity-label">Số lượng:</span>
                            <div class="quantity-control">
                                <button type="button" class="quantity-btn" onclick="decreaseQuantity()">−</button>
                                <input type="number" id="quantity" name="quantity" value="1" 
                                       min="1" max="10" class="quantity-input" readonly>
                                <button type="button" class="quantity-btn" onclick="increaseQuantity()">+</button>
                            </div>
                            <span class="stock-status">
                                Tình trạng: <span id="stockStatus" class="stock-available">Còn hàng</span>
                            </span>
                        </div>

                        <!-- Action Buttons -->
                        <div class="action-buttons">
                            <button type="button" class="btn-add-cart" onclick="addToCart()">
                                <i class="fas fa-shopping-cart me-2"></i>Thêm vào giỏ hàng
                            </button>
                            <button type="button" class="btn-buy-now">
                                <i class="fas fa-bolt me-2"></i>Mua ngay
                            </button>
                        </div>
                    </form>

                    <!-- Product Details -->
                    <div class="product-details">
                        <h3 class="details-title">Chi tiết sản phẩm</h3>
                        <ul class="details-list">
                            <li>Chất liệu: 100% Premium Cotton</li>
                            <li>Kỹ thuật in: Screen Printing + Puff Printing (In Nổi)</li>
                            <li>Mực in đạt chuẩn Eco Friendly, an toàn cho người mặc</li>
                            <li>Vải nhuộm thân thiện môi trường, giảm 70% lượng nước thải</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Related Products -->
    <div class="related-products">
        <h2 class="related-title">SẢN PHẨM LIÊN QUAN</h2>
        <div class="related-grid">
            <c:forEach items="${relatedProducts}" var="product">
                <a href="/product/${product.id}" class="related-card">
                    <div class="related-image">
                        <img src="/images/product/${product.productDetailList[0].imageList[0].link}" 
                             alt="${product.name}">
                    </div>
                    <div class="related-info">
                        <h6 class="related-name">${product.name}</h6>
                        <div class="related-rating">
                            <div class="related-stars">★★★★★</div>
                            <span class="related-count">(125)</span>
                        </div>
                        <div>
                            <c:choose>
                                <c:when test="${product.productDetailList[0].discountedPrice < product.productDetailList[0].price}">
                                    <span class="related-price">
                                        <fmt:formatNumber value="${product.productDetailList[0].discountedPrice}" type="number" />₫
                                    </span>
                                    <span class="related-original-price">
                                        <fmt:formatNumber value="${product.productDetailList[0].price}" type="number" />₫
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="related-price">
                                        <fmt:formatNumber value="${product.productDetailList[0].price}" type="number" />₫
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<script>
// Product data from server
const productDetails = [];
<c:forEach items="${details}" var="detail">
<c:if test="${detail.color != null && detail.size != null}">
productDetails.push({
    id: ${detail.id},
    colorId: ${detail.color.id},
    colorName: '${detail.color.name}',
    sizeId: ${detail.size.id},
    sizeName: '${detail.size.name}',
    price: ${detail.price},
    discountedPrice: ${detail.discountedPrice},
    quantity: ${detail.quantity}
});
</c:if>
</c:forEach>

let selectedColorId = null;
let selectedSizeId = null;
let selectedDetailId = null;

// Initialize
document.addEventListener('DOMContentLoaded', function() {
    initializeProductOptions();
    updateCartCount();
});

// Change main image
function changeMainImage(thumbnail, imageSrc) {
    document.getElementById('mainImage').src = imageSrc;
    document.querySelectorAll('.thumbnail-item').forEach(item => {
        item.classList.remove('active');
    });
    thumbnail.classList.add('active');
}

// Show notification
function showNotification(message, type = 'success') {
    const toast = document.getElementById('notificationToast');
    toast.textContent = message;
    toast.className = 'notification-toast ' + type + ' show';
    
    setTimeout(() => {
        toast.classList.remove('show');
    }, 3000);
}

// Initialize product options
function initializeProductOptions() {
    if (productDetails.length === 0) {
        document.getElementById('colorOptions').innerHTML = '<p>Không có biến thể sản phẩm</p>';
        return;
    }

    createColorOptions();
    
    setTimeout(() => {
        const firstColor = document.querySelector('input[name="selectedColor"]');
        if (firstColor) {
            firstColor.checked = true;
            selectedColorId = parseInt(firstColor.value);
            updateSizeOptions();
        }
    }, 100);
}

// Create color options
function createColorOptions() {
    const container = document.getElementById('colorOptions');
    const uniqueColors = [...new Map(productDetails.map(d => [d.colorId, {id: d.colorId, name: d.colorName}])).values()];
    
    container.innerHTML = uniqueColors.map(color => 
        '<div class="option-item">' +
            '<input type="radio" name="selectedColor" value="' + color.id + '" ' +
                   'id="color_' + color.id + '" class="option-radio" ' +
                   'onchange="handleColorChange(' + color.id + ')">' +
            '<label for="color_' + color.id + '" class="option-button">' + color.name + '</label>' +
        '</div>'
    ).join('');
}

// Handle color change
function handleColorChange(colorId) {
    selectedColorId = colorId;
    selectedSizeId = null;
    updateSizeOptions();
    updateProductInfo();
}

// Update size options
function updateSizeOptions() {
    const container = document.getElementById('sizeOptions');
    if (!selectedColorId) return;
    
    const sizes = productDetails
        .filter(d => d.colorId === selectedColorId)
        .map(d => ({id: d.sizeId, name: d.sizeName, quantity: d.quantity}));
    
    const uniqueSizes = [...new Map(sizes.map(s => [s.id, s])).values()];
    
    container.innerHTML = uniqueSizes.map((size, index) => {
        const outOfStock = size.quantity === 0;
        return '<div class="option-item">' +
            '<input type="radio" name="selectedSize" value="' + size.id + '" ' +
                   'id="size_' + size.id + '" class="option-radio" ' +
                   (outOfStock ? 'disabled' : '') +
                   ' onchange="handleSizeChange(' + size.id + ')">' +
            '<label for="size_' + size.id + '" ' +
                   'class="option-button ' + (outOfStock ? 'out-of-stock' : '') + '">' +
                size.name +
            '</label>' +
        '</div>';
    }).join('');
    
    // Select first available size
    const firstSize = uniqueSizes.find(s => s.quantity > 0);
    if (firstSize) {
        document.getElementById('size_' + firstSize.id).checked = true;
        selectedSizeId = firstSize.id;
        updateProductInfo();
    }
}

// Handle size change
function handleSizeChange(sizeId) {
    selectedSizeId = sizeId;
    updateProductInfo();
}

// Update product info
function updateProductInfo() {
    if (!selectedColorId || !selectedSizeId) return;
    
    const detail = productDetails.find(d => 
        d.colorId === selectedColorId && d.sizeId === selectedSizeId
    );
    
    if (detail) {
        selectedDetailId = detail.id;
        document.getElementById('selectedDetailId').value = selectedDetailId;
        
        // Update price
        const price = detail.discountedPrice < detail.price ? detail.discountedPrice : detail.price;
        document.getElementById('currentPrice').textContent = 
            new Intl.NumberFormat('vi-VN').format(price) + '₫';
        
        // Update stock
        const stockEl = document.getElementById('stockStatus');
        const quantityInput = document.getElementById('quantity');
        
        if (detail.quantity > 0) {
            stockEl.textContent = 'Còn ' + detail.quantity + ' sản phẩm';
            stockEl.className = 'stock-available';
            quantityInput.max = detail.quantity;
        } else {
            stockEl.textContent = 'Hết hàng';
            stockEl.className = 'stock-unavailable';
        }
    }
}

// Quantity controls
function increaseQuantity() {
    const input = document.getElementById('quantity');
    const max = parseInt(input.max);
    if (parseInt(input.value) < max) {
        input.value = parseInt(input.value) + 1;
    }
}

function decreaseQuantity() {
    const input = document.getElementById('quantity');
    if (parseInt(input.value) > 1) {
        input.value = parseInt(input.value) - 1;
    }
}

// Add to cart (và helper để tái sử dụng)
function addToCartRequest(detailId, quantity) {
    return fetch('/cart/add', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'productDetailId=' + encodeURIComponent(detailId) + '&quantity=' + encodeURIComponent(quantity)
    })
    .then(response => response.text());
}

function addToCart() {
    if (!selectedDetailId) {
        showNotification('Vui lòng chọn màu sắc và kích thước', 'error');
        return;
    }

    const quantity = parseInt(document.getElementById('quantity').value, 10);
    const detail = productDetails.find(d => d.id === selectedDetailId);

    if (!detail || detail.quantity === 0) {
        showNotification('Sản phẩm đã hết hàng', 'error');
        return;
    }

    if (quantity > detail.quantity) {
        showNotification('Số lượng vượt quá tồn kho (' + detail.quantity + ')', 'error');
        return;
    }

    // Gửi request và xử lý kết quả
    addToCartRequest(selectedDetailId, quantity)
        .then(data => {
            // server trả về dạng "success:Bạn đã thêm 1 sp" hoặc "error:message"
            if (typeof data === 'string' && data.toLowerCase().startsWith('success')) {
                // Lấy phần thông điệp sau dấu ':' nếu có
                const msg = data.indexOf(':') !== -1 ? data.split(':').slice(1).join(':').trim() : 'Đã thêm vào giỏ hàng';
                showNotification(msg || 'Đã thêm vào giỏ hàng', 'success');
                updateCartCount();
            } else if (typeof data === 'string' && data.toLowerCase().startsWith('error')) {
                const msg = data.indexOf(':') !== -1 ? data.split(':').slice(1).join(':').trim() : 'Có lỗi khi thêm vào giỏ';
                showNotification(msg, 'error');
            } else {
                // fallback: nếu server trả về html hoặc text khác
                showNotification('Đã thêm vào giỏ (phản hồi server)', 'success');
                updateCartCount();
            }
        })
        .catch(err => {
            console.error('Add to cart error:', err);
            showNotification('Lỗi mạng. Vui lòng thử lại', 'error');
        });
}

// "Mua ngay" sẽ thêm vào giỏ (nếu chưa có) rồi chuyển tới trang thanh toán
document.querySelectorAll('.btn-buy-now').forEach(btn => {
    btn.addEventListener('click', buyNow);
});

function buyNow() {
    if (!selectedDetailId) {
        showNotification('Vui lòng chọn màu sắc và kích thước', 'error');
        return;
    }

    const quantity = parseInt(document.getElementById('quantity').value, 10);
    const detail = productDetails.find(d => d.id === selectedDetailId);

    if (!detail || detail.quantity === 0) {
        showNotification('Sản phẩm đã hết hàng', 'error');
        return;
    }

    if (quantity > detail.quantity) {
        showNotification('Số lượng vượt quá tồn kho (' + detail.quantity + ')', 'error');
        return;
    }

    // Nếu server side lưu trực tiếp vào cart, ta thêm rồi chuyển hướng đến checkout
    addToCartRequest(selectedDetailId, quantity)
        .then(data => {
            if (typeof data === 'string' && data.toLowerCase().startsWith('success')) {
                window.location.href = '/cart/checkout';
            } else {
                // Nếu server trả về lỗi, hiện thông báo
                const msg = (typeof data === 'string' && data.indexOf(':') !== -1) ? data.split(':').slice(1).join(':').trim() : 'Không thể mua ngay';
                showNotification(msg, 'error');
            }
        })
        .catch(err => {
            console.error('Buy now error:', err);
            showNotification('Lỗi mạng. Vui lòng thử lại', 'error');
        });
}

// Cập nhật số lượng item trong header/cart icon
function updateCartCount() {
    // giả sử backend có endpoint trả về số lượng items hiện tại ở /cart/count (plain number) 
    // Tùy dự án bạn có thể đổi endpoint này cho phù hợp.
    fetch('/cart/count')
        .then(res => res.text())
        .then(text => {
            const num = parseInt(text, 10);
            const badge = document.getElementById("cartCount") // đảm bảo header có element này
            if (badge) {
                badge.textContent = isNaN(num) ? '' : num;
                badge.style.display = (isNaN(num) || num === 0) ? 'none' : 'flex';
            }
        })
        .catch(err => {
            // không cần show lỗi toast cho count
            console.warn('Cannot update cart count:', err);
        });
}

// Khi load lần đầu: chọn thumbnail đầu tiên làm active (nếu chưa có)
document.addEventListener('DOMContentLoaded', function() {
    // nếu chưa có active ở thumbnail (trường hợp server không gán), gán manually
    const activeThumb = document.querySelector('.thumbnail-item.active');
    if (!activeThumb) {
        const firstThumb = document.querySelector('.thumbnail-item');
        if (firstThumb) {
            firstThumb.classList.add('active');
        }
    }

    // nếu productDetails đã sẵn sàng, ensure options được khởi tạo (bảo đảm gọi 1 lần)
    if (productDetails.length > 0) {
        // gọi lại updateSizeOptions / updateProductInfo nếu đã có lựa chọn mặc định
        const checkedColor = document.querySelector('input[name="selectedColor"]:checked');
        if (checkedColor) {
            selectedColorId = parseInt(checkedColor.value, 10);
            updateSizeOptions();
        }
    }

    // cập nhật cart count ban đầu
    updateCartCount();
});

// Đóng toast sớm khi click vào nó
document.getElementById('notificationToast').addEventListener('click', function() {
    this.classList.remove('show');
});
</script>
</body>
</html>
