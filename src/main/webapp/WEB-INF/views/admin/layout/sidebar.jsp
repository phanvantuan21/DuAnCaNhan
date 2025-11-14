<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar">
    <div class="logo">
        <img src="/images/logo/Group.png" alt="Logo">
        <h2>Admin Page</h2>
    </div>
    <nav>
        <ul>

<c:if test="${user.role.name == 'ROLE_EMPLOYEE' || user.role.name == 'ROLE_ADMIN'}">
            <li class="${pageContext.request.requestURI.contains('/admin/Home') || pageContext.request.requestURI == '/' ? 'active' : ''}">
                <a href="/Home"><i class="fas fa-home"></i><span>Trang chủ</span></a>
            </li>
            <li class="${pageContext.request.requestURI.contains('/admin/products') ? 'active' : ''}">
                <a href="/admin/products"><i class="fas fa-box"></i><span>Sản phẩm</span></a>
            </li>
            <li class="${pageContext.request.requestURI.contains('/admin/sales') ? 'active' : ''}">
                <a href="/admin/sales"><i class="fa-solid fa-cash-register"></i><span>Bán hàng</span></a>
            </li>
            <li class="${pageContext.request.requestURI.contains('/admin/bills') ? 'active' : ''}">
                <a href="/admin/bills"><i class="fas fa-receipt"></i><span>Hóa đơn</span></a>
            </li>
            <li class="${pageContext.request.requestURI.contains('/admin/orders') ? 'active' : ''}">
                <a href="/admin/orders"><i class="fa-solid fa-clipboard-list"></i><span>Quản lý đơn hàng</span></a>
            </li>
</c:if>
            <c:if test="${user.role.name == 'ROLE_EMPLOYEE' || user.role.name == 'ROLE_ADMIN'}">
                <li class="${pageContext.request.requestURI.contains('/Category') ? 'active' : ''}">
                    <a href="/Category"><i class="fas fa-tags"></i><span>Quản lí danh mục</span></a>
                </li>
                <li class="${pageContext.request.requestURI.contains('/Color') ? 'active' : ''}">
                    <a href="/Color"><i class="fas fa-palette"></i><span>Quản lí màu sắc</span></a>
                </li>
                <li class="${pageContext.request.requestURI.contains('/Size') ? 'active' : ''}">
                    <a href="/Size"><i class="fas fa-ruler"></i><span>Quản lí kích thước</span></a>
                </li>
                <li class="${pageContext.request.requestURI.contains('/Brand') ? 'active' : ''}">
                    <a href="/Brand"><i class="fas fa-trademark"></i><span>Quản lí thương hiệu</span></a>
                </li>
                <li class="${pageContext.request.requestURI.contains('/Material') ? 'active' : ''}">
                    <a href="/Material"><i class="fas fa-tshirt"></i><span>Quản lí chất liệu</span></a>
                </li>
            </c:if>

            <!-- Chỉ hiện với ADMIN -->
            <c:if test="${user.role.name == 'ROLE_ADMIN'}">
                <li class="${pageContext.request.requestURI.contains('/admin/account') ? 'active' : ''}">
                    <a href="/admin/account"><i class="fas fa-users"></i><span>Tài khoản</span></a>
                </li>
                <li class="${pageContext.request.requestURI.contains('/admin/Discount') ? 'active' : ''}">
                    <a href="/admin/Discount"><i class="fa-solid fa-tags"></i><span>Mã giảm giá</span></a>
                </li>
                <li class="${pageContext.request.requestURI.contains('/admin/ProductDiscount') ? 'active' : ''}">
                    <a href="/admin/ProductDiscount"><i class="fas fa-chart-bar"></i><span>Giảm giá theo sản phẩm</span></a>

                </li>
            </c:if>
        </ul>
    </nav>
</div>
