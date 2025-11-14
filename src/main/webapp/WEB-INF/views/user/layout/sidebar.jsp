<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="user" value="${sessionScope.user}" /> 
<c:set var="currentPath" value="${requestScope['javax.servlet.forward.servlet_path']}"/>

<style>
    /* Bố cục chính của Sidebar */
    .account-sidebar {
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        padding: 20px 10px;
        min-width: 250px; /* Đảm bảo sidebar không quá hẹp */
    }

    /* Vùng thông tin người dùng (Avatar & Tên) */
    .user-info {
        text-align: center;
        padding-bottom: 20px;
        border-bottom: 1px solid #eee;
        margin-bottom: 20px;
    }

.user-avatar {
    width: 60px;              /* tăng hoặc giảm tùy ý */
    height: 60px;
    border-radius: 50%;       /* làm tròn hoàn toàn */
    object-fit: cover;        /* giữ tỉ lệ ảnh, cắt viền dư */
    display: block;
    margin: 0 auto 10px auto; /* căn giữa */
    border: 3px solid #5cb85c; /* viền xanh lá nhẹ */
    box-shadow: 0 2px 6px rgba(0,0,0,0.1); /* tạo chiều sâu nhẹ */
}


    .user-name {
        font-weight: bold;
        font-size: 1.1rem;
        color: #333;
    }

    /* Vùng Menu Links */
    .sidebar-menu-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .menu-item a {
        display: flex;
        align-items: center;
        padding: 12px 15px;
        margin-bottom: 5px;
        text-decoration: none;
        color: #555;
        border-radius: 8px;
        transition: background-color 0.2s, color 0.2s;
    }

    /* Style cho Icon */
    .menu-item i {
        margin-right: 15px;
        font-size: 1.1rem;
        width: 20px; /* Cố định chiều rộng icon để căn chỉnh tốt hơn */
    }

    /* Trạng thái active/hover */
    .menu-item a.active {
        background-color: #f0f8f0; /* Màu nền nhạt */
        color: #5cb85c; /* Màu xanh lá cây */
        font-weight: 600;
    }
    
    .menu-item a.active i {
        color: #5cb85c; 
    }

    .menu-item a:not(.active):hover {
        background-color: #f7f7f7;
        color: #333;
    }

    /* Màu icon tùy chỉnh theo hình ảnh */
    .text-green { color: #5cb85c !important; } /* Ví dụ cho icon Đơn hàng/Thông báo */
    .text-orange { color: #f0ad4e !important; }
    .text-brown { color: #aa6c39 !important; }
    .text-red { color: #d9534f !important; }
    .text-blue { color: #007bff !important; }
</style>

<div class="account-sidebar">
    <div class="user-info">
        <img src="/images/tải xuống.jpg" alt="Avatar" class="user-avatar">
        <div class="user-name">${user.name != null ? user.name : 'Thuy Tomoe'}</div>
        
        <span class="badge bg-success mt-1"><i class="fas fa-seedling"></i></span> 
    </div>

    <ul class="sidebar-menu-list">
        <li class="menu-item">
            <a href="/profile" class="<c:if test="${currentPath eq '/profile'}">active</c:if>">
                <i class="fas fa-user text-green"></i> Thông tin cá nhân
            </a>
        </li>
        
        <li class="menu-item">
            <a href="/orders" class="<c:if test="${currentPath eq '/orders'}">active</c:if>">
                <i class="fas fa-shopping-bag text-orange"></i> Đơn hàng của bạn
            </a>
        </li>
        
        <li class="menu-item">
            <a href="/notifications" class="<c:if test="${currentPath eq '/notifications'}">active</c:if>">
                <i class="fas fa-bell text-red"></i> Thông báo
            </a>
        </li>
        
        <li class="menu-item">
            <a href="/Logout" class="text-danger">
                <i class="fas fa-sign-out-alt"></i> Đăng xuất
            </a>
        </li>
    </ul>
</div>