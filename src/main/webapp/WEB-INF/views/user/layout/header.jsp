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
    padding: 8px 0;
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
    padding: 15px 0;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    position: sticky;
    top: 0;
    z-index: 1000;
}

/* Logo */
.logo-brand {
    font-size: 1.8rem;
    font-weight: bold;
    color: #ff4da6 !important;   /* 🔥 màu hồng */
    text-decoration: none;
    white-space: nowrap;
}

/* Search Box */
.search-box-user {
    width: 100%;
    max-width: 500px;
    margin: 0 auto;
    position: relative;
    display: flex;
    align-items: stretch;
    border: 2px solid #ff4da6;   /* 🔥 viền ô tìm kiếm */
    border-radius: 25px;
    overflow: hidden;
}

.search-box-user input {
    flex: 1;
    border: none;
    outline: none;
    padding: 10px 15px;
    font-size: 14px;
}

.logo-brand:hover {
    color: #ff1f8a !important;
}

.search-box-user button {
    background: #ff4da6;
    border: none;
    padding: 0 15px;
    color: white;
    cursor:  pointer;
    transition: background 0.3s;
}

.search-box-user button:hover {
    background: #4cae4c;
}

/* Icon Buttons */
.header-icons {
    display: flex;
    align-items: center;
    gap: 15px;
    justify-content: flex-end;
}

.icon-link {
    position: relative;
    color: #333;
    font-size: 1.3rem;
    text-decoration: none;
    transition: color 0.3s;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.icon-link:hover {
    color: #5cb85c;
}

.icon-link .label {
    font-size: 0.75rem;
    margin-top: 2px;
    color: #666;
    white-space: nowrap;
}

.badge-count {
    position: absolute;
    top: -8px;
    right: -10px;
    background: #ff4757;
    color: white;
    border-radius: 50%;
    width: 20px;
    height: 20px;
    font-size: 0.7rem;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
}

/* User Dropdown */
.user-dropdown .dropdown-toggle {
    background: none;
    border: none;
    color: #333;
    display: flex;
    align-items: center;
    gap: 8px;
    cursor: pointer;
    padding: 5px 10px;
}

.user-dropdown .dropdown-toggle:hover {
    background: #f8f9fa;
    border-radius: 5px;
}

.user-dropdown .dropdown-toggle::after {
    display: none;
}

.user-avatar-header {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    background: #5cb85c;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-weight: bold;
}

/* Dropdown Menu */
.dropdown-menu {
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    border: none;
    min-width: 250px;
}

.dropdown-item {
    padding: 10px 15px;
    transition: background 0.2s;
}

.dropdown-item:hover {
    background: #f8f9fa;
    color: #5cb85c;
}

.dropdown-item i {
    margin-right: 10px;
    width: 20px;
}

/* Notification Dropdown */
.notification-dropdown .dropdown-menu {
    min-width: 320px;
    max-height: 400px;
    overflow-y: auto;
}

.notification-item {
    padding: 12px;
    border-bottom: 1px solid #f0f0f0;
    cursor: pointer;
    transition: background 0.2s;
}

.notification-item:hover {
    background: #f8f9fa;
}

.notification-item:last-child {
    border-bottom: none;
}

.notification-empty {
    padding: 20px;
    text-align: center;
    color: #999;
}

/* Responsive */
@media (max-width: 991px) {
    .main-header {
        padding: 10px 0;
    }
    
    .logo-brand {
        font-size: 1.5rem;
    }
    
    .search-box-user {
        max-width: 100%;
    }
    
    .header-icons {
        gap: 10px;
    }
    
    .icon-link .label {
        font-size: 0.7rem;
    }
}

@media (max-width: 768px) {
    .info-bar {
        font-size: 0.75rem;
    }
    
    .info-bar a {
        margin-right: 10px;
    }
    
    .icon-link .label {
        display: none;
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

<!-- Main Header -->
<header class="main-header">
    <div class="container">
        <div class="row align-items-center">
            
            <!-- Logo -->
            <div class="col-lg-2 col-md-2 col-4">
                <a class="logo-brand" href="/">Camiune</a>
            </div>

            <!-- Search Box -->
            <div class="col-lg-6 col-md-5 col-12 order-lg-2 order-md-2 order-3">
                <form action="/product" method="get" class="search-box-user">
                    <input type="text" name="keyword" placeholder="Bạn muốn tìm sản phẩm gì hôm nay?"
                        value="${keyword != null ? keyword : ''}">
                    <button type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>

            <!-- Header Icons -->
            <div class="col-lg-4 col-md-5 col-8 order-lg-3 order-md-3 order-2">
                <div class="header-icons">
                    
                    <!-- Khuyến mãi -->
                    <a href="/promotions" class="icon-link">
                        <i class="fas fa-bell"></i>
                        <span class="label">Khuyến mãi</span>
                    </a>

                    <!-- Giỏ hàng -->
                    <a href="/cart" class="icon-link">
                        <i class="fas fa-shopping-cart"></i>
                        <span class="label">Giỏ hàng</span>
                        <c:if test="${not empty sessionScope.user}">
                            <span class="badge-count" id="cartCount">0</span>
                        </c:if>
                    </a>

                    <!-- User Account -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <div class="dropdown user-dropdown">
                                <button class="dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                    <div class="user-avatar-header">
                                        ${sessionScope.user.email.substring(0,1).toUpperCase()}
                                    </div>
                                    <i class="fas fa-chevron-down"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="/orders">
                                        <i class="fas fa-shopping-bag"></i>Đơn hàng của tôi
                                    </a></li>
                                    <li><a class="dropdown-item" href="/profile">
                                        <i class="fas fa-user-edit"></i>Thông tin cá nhân
                                    </a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="/Logout">
                                        <i class="fas fa-sign-out-alt"></i>Đăng xuất
                                    </a></li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="/Login" class="icon-link">
                                <i class="fas fa-user"></i>
                                <span class="label">Đăng nhập</span>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</header>

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