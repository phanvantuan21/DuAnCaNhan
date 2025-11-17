<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
/* Info Bar */
.info-bar {
    background-color: #f8f9fa;
    padding: 6px 0;
    font-size: 0.85rem;
    border-bottom: 1px solid #e0e0e0;
}

.info-bar a {
    color: #333;
    text-decoration: none;
    margin-right: 20px;
}

.info-bar a:hover {
    color: #667eea;
}

.info-bar i {
    margin-right: 5px;
    color: #667eea;
}

/* Main Header */
.main-header {
    background-color: white;
    padding: 10px 0 !important;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    position: sticky;
    top: 0;
    z-index: 1000;
}

.logo-brand img {
    height: 90px;
    width: 90px;                    /* ⭐ BẮT LOGO THÀNH KHUNG VUÔNG */
    object-fit: cover;              /* ⭐ CẮT VỪA KHUNG ĐỂ TRÒN ĐẸP */
    display: block;

    border-radius: 50%;             /* ⭐ TRÒN 100% */
    background: transparent !important;
    border: none !important;
    outline: none !important;
    box-shadow: none !important;
}

/* Nav Menu */
.main-nav ul li a {
    font-size: 16px;
    font-weight: 600;
}

/* Icons */
.header-icons {
    display: flex;
    align-items: center;
    gap: 18px;
}

.icon-link {
    position: relative;
    color: #333;
    font-size: 1.35rem;
    text-decoration: none;
    transition: color 0.3s;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.icon-link:hover {
    color: #5cb85c;
}

.badge {
    font-size: 0.65rem;
    border-radius: 50%;
}

/* User Dropdown */
.user-dropdown .dropdown-toggle {
    background: none;
    border: none;
    color: #333;
    display: flex;
    align-items: center;
    cursor: pointer;
}

/* Responsive */
@media (max-width: 991px) {
    .main-header {
        padding: 5px 0 !important;
    }
    .logo-brand img {
        height: 75px !important;
    }
}
@media (max-width: 991px) {
    .logo-brand img {
        height: 70px;
    }
}

</style>

<!-- Info Bar -->
<div class="info-bar">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center flex-wrap">
            <div>
                <a href="tel:0338821468"><i class="fas fa-phone"></i>03388.21.468</a>
                <a href="tel:0383945890"><i class="fas fa-phone"></i>0383.945.890</a>
                <a href="mailto:phantun21@gmail.com"><i class="fas fa-envelope"></i>phantun21@gmail.com</a>
            </div>
            <div>
                <a href="#"><i class="fab fa-facebook"></i>Facebook</a>
            </div>
        </div>
    </div>
</div>

<!-- MAIN HEADER -->
<header class="main-header shadow-sm">
    <div class="container d-flex align-items-center justify-content-between py-1">

        <!-- LOGO -->
        <a href="/" class="logo-brand d-flex align-items-center">
            <img src="images/logo/logoCamiune.png" alt="Logo">
        </a>

        <!-- MENU NAV -->
        <nav class="main-nav d-none d-lg-flex">
            <ul class="nav gap-4 fw-semibold">
                <li><a href="/product" class="nav-link text-dark">Sản phẩm</a></li>
                <li><a href="/product?new=true" class="nav-link text-dark">Hàng Mới</a></li>
                <li><a href="/best-seller" class="nav-link text-dark">Hàng Bán Chạy</a></li>
                <li><a href="/denim" class="nav-link text-dark">DENIM</a></li>
                <li><a href="/outlet" class="nav-link text-danger fw-bold">OUTLET -50%</a></li>
                <li><a href="/collection" class="nav-link text-dark">Collection</a></li>
            </ul>
        </nav>

        <!-- ICON GROUP -->
        <div class="header-icons">

            <!-- SEARCH -->
            <a href="/search" class="icon-link text-dark">
                <i class="fas fa-search"></i>
            </a>

            <!-- CART -->
            <a href="/cart" class="icon-link position-relative text-dark">
                <i class="fas fa-shopping-cart"></i>
                <span class="badge bg-danger position-absolute top-0 start-100 translate-middle px-2 py-1" id="cartCount">0</span>
            </a>

            <!-- USER -->
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="dropdown user-dropdown">
                        <a class="text-dark fs-5 dropdown-toggle" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow-sm">
                            <li><a class="dropdown-item" href="/orders">Đơn hàng của tôi</a></li>
                            <li><a class="dropdown-item" href="/profile">Thông tin cá nhân</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="/Logout">Đăng xuất</a></li>
                        </ul>
                    </div>
                </c:when>

                <c:otherwise>
                    <a href="/Login" class="icon-link text-dark">
                        <i class="fas fa-user"></i>
                    </a>
                </c:otherwise>
            </c:choose>

        </div>
    </div>
</header>

<!-- JS cập nhật giỏ hàng -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    updateCartCount();
});

function updateCartCount() {
    const cartBadge = document.getElementById('cartCount');
    if (!cartBadge) return;

    fetch('/cart/count')
            .then(res => res.text())
            .then(count => {
                cartBadge.textContent = count;
                cartBadge.style.display = parseInt(count) > 0 ? 'flex' : 'none';
            })
            .catch(() => cartBadge.style.display = 'none');
}
</script>
