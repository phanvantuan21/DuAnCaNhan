<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Camiune - Trang chủ</title>

    <link rel="stylesheet" href="/css/user/home.css">
    <link rel="stylesheet" href="/css/user/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
<jsp:include page="../layout/header.jsp"/>

<div class="content-wrapper">

    <!-- ================= BANNER VỚI MENU BÊN TRÁI ================= -->
    <div class="banner-with-sidebar">
        <!-- Menu dọc bên trái -->
        <div class="sidebar-menu">
            <ul class="menu-list">
                <li><a href="/"><i class="fa fa-home"></i> Trang chủ</a></li>
                <li><a href="/product?categoryId=1"><i class="fa fa-tshirt"></i> Thời trang Nam</a></li>
                <li><a href="/product?categoryId=2"><i class="fa fa-female"></i> Thời trang Nữ</a></li>
                <li><a href="/product?categoryId=3"><i class="fa fa-child"></i> Thời trang Trẻ em</a></li>
                <li><a href="/product?categoryId=4"><i class="fa fa-book"></i> Sách & Văn phòng phẩm</a></li>
                <li><a href="/product?status=sale"><i class="fa fa-fire"></i> SALE SỐC</a></li>
                <li><a href="/product?status=new"><i class="fa fa-star"></i> Hàng mới về</a></li>
            </ul>
        </div>

        <!-- Banner chính giữa với carousel -->
        <div class="main-banner-wrapper">
            <div class="main-banner-slider">
                <div class="banner-slide active">
                    <img src="${pageContext.request.contextPath}/images/slide/mau-banner-website.jpg" alt="Banner 1">
                </div>
                <div class="banner-slide">
                    <img src="${pageContext.request.contextPath}/images/slide/banner-2.jpg" alt="Banner 2">
                </div>
                <div class="banner-slide">
                    <img src="${pageContext.request.contextPath}/images/slide/anh3.jpg" alt="Banner 3">
                </div>
                <div class="banner-slide">
                    <img src="${pageContext.request.contextPath}/images/slide/anh4.jpg" alt="Banner 4">
                </div>
            </div>
            <button class="banner-nav-btn prev-btn" onclick="moveBannerSlide(-1)">
                <i class="fas fa-chevron-left"></i>
            </button>
            <button class="banner-nav-btn next-btn" onclick="moveBannerSlide(1)">
                <i class="fas fa-chevron-right"></i>
            </button>
            <div class="banner-dots">
                <span class="dot active" onclick="currentBannerSlide(0)"></span>
                <span class="dot" onclick="currentBannerSlide(1)"></span>
                <span class="dot" onclick="currentBannerSlide(2)"></span>
                <span class="dot" onclick="currentBannerSlide(3)"></span>
            </div>
        </div>
    </div>

    <!-- ================= BANNER QUẢNG CÁO PHỤ ================= -->
    <div class="top-banner-ads">
        <div class="banner-ad">
            <img src="${pageContext.request.contextPath}/images/slide/banner-1.jpg" alt="Banner 1">
        </div>
        <div class="banner-ad">
            <img src="${pageContext.request.contextPath}/images/slide/banner-2.jpg" alt="Banner 2">
        </div>
        <div class="banner-ad">
            <img src="${pageContext.request.contextPath}/images/slide/banner-3.jpg" alt="Banner 3">
        </div>
        <div class="banner-ad">
            <img src="${pageContext.request.contextPath}/images/slide/banner-4.jpg" alt="Banner 4">
        </div>
    </div>

    <!-- ================= SẢN PHẨM NỔI BẬT HÔM NAY ================= -->
    <c:if test="${not empty discountProducts}">
        <div class="featured-section">
            <div class="section-header">
                <h2 class="section-title">Sản phẩm nổi bật chọn</h2>
                <a href="/product?status=sale" class="view-all-link">Xem tất cả ></a>
            </div>

            <div class="product-carousel-wrapper">
                <button class="carousel-nav-btn prev-btn" onclick="moveCarousel('featured', -1)">
                    <i class="fas fa-chevron-left"></i>
                </button>
                
                <div class="product-grid" id="featured-carousel">
                    <c:forEach items="${discountProducts}" var="product" varStatus="status">
                        <c:set var="pd" value="${product.productDetailList[0]}" />
                        <div class="product-card">
                            <c:set var="percentOff" value="${(pd.price - pd.discountedPrice) * 100 / pd.price}" />
                            <c:if test="${percentOff > 0}">
                                <span class="sale-badge">-${percentOff.intValue()}%</span>
                            </c:if>
                            <div class="product-image-wrapper">
                                <a href="/product/${product.id}">
                                    <c:if test="${not empty pd.imageList}">
                                        <img src="/images/product/${pd.imageList[0].link}" alt="${product.name}">
                                    </c:if>
                                </a>
                            </div>
                            <div class="product-info">
                                <h3 class="product-title">${product.name}</h3>
                                <div class="product-price">
                                    <span class="current-price">${pd.discountedPrice}₫</span>
                                    <c:if test="${pd.discountedPrice lt pd.price}">
                                        <span class="original-price">${pd.price}₫</span>
                                    </c:if>
                                </div>
                                <div class="product-rating-box">
                                    <span class="stars">★★★★★</span>
                                    <span class="rating-count">(${product.productDetailList[0].quantity})</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <button class="carousel-nav-btn next-btn" onclick="moveCarousel('featured', 1)">
                    <i class="fas fa-chevron-right"></i>
                </button>
            </div>
        </div>
    </c:if>

    <!-- ================= SẢN PHẨM BÁN CHẠY ================= -->
    <div class="featured-section">
        <div class="section-header">
            <h2 class="section-title">Sản phẩm bán chạy</h2>
            <a href="/product?status=best" class="view-all-link">Xem tất cả ></a>
        </div>

        <div class="product-carousel-wrapper">
            <button class="carousel-nav-btn prev-btn" onclick="moveCarousel('bestseller', -1)">
                <i class="fas fa-chevron-left"></i>
            </button>
            
            <div class="product-grid" id="bestseller-carousel">
                <c:forEach var="item" items="${bestSellers}" varStatus="status">
                    <div class="product-card">
                        <div class="product-image-wrapper">
                            <a href="/product/${item.productId}">
                                <img src="/images/product/${item.imageLink}" alt="${item.productName}">
                            </a>
                        </div>
                        <div class="product-info">
                            <h3 class="product-title">${item.productName}</h3>
                            <div class="product-price">
                                <span class="sold-count">Đã bán: ${item.totalSoldQuantity}</span>
                            </div>
                            <div class="product-rating-box">
                                <span class="stars">★★★★★</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <button class="carousel-nav-btn next-btn" onclick="moveCarousel('bestseller', 1)">
                <i class="fas fa-chevron-right"></i>
            </button>
        </div>
    </div>

    <!-- ================= GỢI Ý HÔM NAY ================= -->
    <div class="suggestion-section">
        <h2 class="section-main-title">Gợi ý hôm nay</h2>
        
        <div class="filter-tabs">
            <a href="/" class="tab-btn ${empty selectedPercent ? 'active' : ''}">Dành cho bạn</a>
            <a href="/product/filter?percent=40" class="tab-btn ${selectedPercent == 40 ? 'active' : ''}">Sách và báo - 50%</a>
            <a href="/product/filter?percent=50" class="tab-btn ${selectedPercent == 50 ? 'active' : ''}">Thời trang trẻ em - 40%</a>
            <a href="/product/filter?percent=60" class="tab-btn ${selectedPercent == 60 ? 'active' : ''}">Rước thú cưng về - 40%</a>
        </div>

        <div class="product-grid-main">
            <c:forEach items="${products}" var="product">
                <c:set var="pd" value="${product.productDetailList[0]}" />
                <div class="product-card-main">
                    <c:set var="percentOff" value="${(pd.price - pd.discountedPrice) * 100 / pd.price}" />
                    <c:if test="${percentOff > 0}">
                        <span class="sale-badge">-${percentOff.intValue()}%</span>
                    </c:if>
                    <div class="product-image-main">
                        <a href="/product/${product.id}">
                            <c:if test="${not empty pd.imageList}">
                                <img src="/images/product/${pd.imageList[0].link}" alt="${product.name}">
                            </c:if>
                        </a>
                    </div>
                    <div class="product-details">
                        <h3 class="product-name">${product.name}</h3>
                        <c:choose>
                            <c:when test="${pd.discountedPrice lt pd.price}">
                                <div class="price-section">
                                    <span class="current-price">${pd.discountedPrice}₫</span>
                                    <span class="original-price">${pd.price}₫</span>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="price-section">
                                    <span class="current-price">${pd.price}₫</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="rating-section">
                            <span class="stars">★★★★★</span>
                            <span class="rating-count">(${product.productDetailList[0].quantity})</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<script>
// ================= BANNER SLIDER =================
let currentBannerIndex = 0;

function showBannerSlide(index) {
    const bannerSlides = document.querySelectorAll('.banner-slide');
    const bannerDots = document.querySelectorAll('.banner-dots .dot');
    
    if (!bannerSlides.length) return;
    
    if (index >= bannerSlides.length) {
        currentBannerIndex = 0;
    } else if (index < 0) {
        currentBannerIndex = bannerSlides.length - 1;
    } else {
        currentBannerIndex = index;
    }
    
    bannerSlides.forEach(slide => slide.classList.remove('active'));
    bannerDots.forEach(dot => dot.classList.remove('active'));
    
    bannerSlides[currentBannerIndex].classList.add('active');
    if (bannerDots[currentBannerIndex]) {
        bannerDots[currentBannerIndex].classList.add('active');
    }
}

function moveBannerSlide(direction) {
    showBannerSlide(currentBannerIndex + direction);
}

function currentBannerSlide(index) {
    showBannerSlide(index);
}

// Auto slide banner
let bannerInterval = setInterval(() => {
    showBannerSlide(currentBannerIndex + 1);
}, 5000);

// Dừng auto slide khi hover
const bannerWrapper = document.querySelector('.main-banner-wrapper');
if (bannerWrapper) {
    bannerWrapper.addEventListener('mouseenter', () => {
        clearInterval(bannerInterval);
    });
    bannerWrapper.addEventListener('mouseleave', () => {
        bannerInterval = setInterval(() => {
            showBannerSlide(currentBannerIndex + 1);
        }, 5000);
    });
}

// ================= PRODUCT CAROUSEL =================
const carouselStates = {
    featured: { currentPage: 0, itemsPerPage: 5 },
    bestseller: { currentPage: 0, itemsPerPage: 5 }
};

function updateCarouselView(carouselId) {
    const carousel = document.getElementById(carouselId + '-carousel');
    if (!carousel) return;
    
    const cards = carousel.querySelectorAll('.product-card');
    if (!cards.length) return;
    
    const state = carouselStates[carouselId];
    const itemsPerPage = state.itemsPerPage;
    
    cards.forEach((card, index) => {
        const startIndex = state.currentPage * itemsPerPage;
        const endIndex = startIndex + itemsPerPage;
        
        if (index >= startIndex && index < endIndex) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
}

function moveCarousel(carouselId, direction) {
    const carousel = document.getElementById(carouselId + '-carousel');
    if (!carousel) return;
    
    const cards = carousel.querySelectorAll('.product-card');
    if (!cards.length) return;
    
    const state = carouselStates[carouselId];
    const maxPages = Math.ceil(cards.length / state.itemsPerPage) - 1;
    
    state.currentPage += direction;
    
    if (state.currentPage < 0) {
        state.currentPage = 0;
    }
    if (state.currentPage > maxPages) {
        state.currentPage = maxPages;
    }
    
    updateCarouselView(carouselId);
}

// Khởi tạo carousel khi trang load
window.addEventListener('DOMContentLoaded', () => {
    updateCarouselView('featured');
    updateCarouselView('bestseller');
    
    // Cập nhật items per page khi resize
    window.addEventListener('resize', () => {
        const width = window.innerWidth;
        let itemsPerPage = 5;
        
        if (width <= 768) {
            itemsPerPage = 2;
        } else if (width <= 992) {
            itemsPerPage = 3;
        } else if (width <= 1200) {
            itemsPerPage = 4;
        }
        
        carouselStates.featured.itemsPerPage = itemsPerPage;
        carouselStates.bestseller.itemsPerPage = itemsPerPage;
        carouselStates.featured.currentPage = 0;
        carouselStates.bestseller.currentPage = 0;
        
        updateCarouselView('featured');
        updateCarouselView('bestseller');
    });
});
</script>
</body>
</html>