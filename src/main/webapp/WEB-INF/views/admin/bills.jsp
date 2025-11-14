<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý hóa đơn - Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        .bills-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .main-table {
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0px 3px 8px rgba(0,0,0,0.1);
            margin-top: 20px;
        }

        .main-table thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
        }

        .main-table thead th {
            border: none;
            padding: 15px;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }

        .main-table tbody tr {
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .main-table tbody tr:hover {
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f0ff 100%) !important;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .main-table tbody td {
            padding: 15px;
            vertical-align: middle;
            border-bottom: 1px solid #e9ecef;
        }

        .detail-row {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        }

        .detail-table {
            margin: 0;
            border-radius: 8px;
            overflow: hidden;
        }

        .detail-table thead {
            background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
            color: white;
        }

        .detail-table thead th {
            padding: 12px;
            font-size: 0.8rem;
            font-weight: 600;
            border: none;
        }

        .detail-table tbody td {
            padding: 10px 12px;
            font-size: 0.9rem;
        }

        .page-title {
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 0;
        }

        .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
            transition: transform 0.3s ease;
        }

        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 35px rgba(102, 126, 234, 0.4);
        }

        .bill-code {
            font-family: 'Courier New', monospace;
            font-weight: bold;
            color: #495057;
        }

        .amount-text {
            font-size: 1.1rem;
            font-weight: 700;
        }

        .btn-print {
            transition: all 0.3s ease;
        }

        .btn-print:hover {
            transform: scale(1.1);
            box-shadow: 0 4px 12px rgba(0,123,255,0.3);
        }

        .table-responsive {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }

        /* Status Filter Styles */
        .status-filter {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .status-btn {
            display: inline-block;
            padding: 8px 16px;
            margin: 5px;
            border-radius: 20px;
            text-decoration: none;
            color: #6c757d;
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            transition: all 0.3s ease;
            font-size: 0.9rem;
        }

        .status-btn:hover {
            color: #495057;
            background: #e9ecef;
            text-decoration: none;
            transform: translateY(-2px);
        }

        .status-btn.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: #667eea;
        }

        /* Order Status Badges */
        .order-status {
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending { background: #fff3cd; color: #856404; }
        .status-confirmed { background: #d1ecf1; color: #0c5460; }
        .status-processing { background: #d4edda; color: #155724; }
        .status-shipping { background: #e2e3e5; color: #383d41; }
        .status-delivered { background: #d1e7dd; color: #0f5132; }
        .status-cancelled { background: #f8d7da; color: #721c24; }
        .status-expired { background: #fff3cd; color: #856404; }
        .status-success { background: #d1e7dd; color: #0f5132; }
    </style>
</head>
<body>
<div class="containerr">
    <!-- Sidebar -->
    <jsp:include page="layout/sidebar.jsp"/>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
        <jsp:include page="layout/header.jsp"/>

        <!-- Bills Content -->
        <div class="bills-header">
            <h3 class="page-title">
                <i class="fa-solid fa-file-invoice text-primary me-2"></i> Quản lý hóa đơn
            </h3>
        </div>
        <form class="d-flex mb-4" method="get" action="/admin/bills/search">
            <!-- Ô tìm kiếm theo mã, tên KH, địa chỉ -->
            <input class="form-control me-2"
                   type="search"
                   name="query"
                   placeholder="Tìm kiếm theo mã đơn hàng, tên khách hàng, địa chỉ..."
                   aria-label="Search"
                   value="${param.query}">

            <!-- Tìm kiếm theo ngày bắt đầu -->
            <input class="form-control me-2"
                       type="date"
                       name="startDate"
                       value="${param.startDate}"
                       style="width: 200px;">

            <!-- Tìm kiếm theo ngày kết thúc -->
            <input class="form-control me-2"
                       type="date"
                       name="endDate"
                       value="${param.endDate}"
                       style="width: 200px;">

            <button class="btn btn-outline-success" type="submit">
                <i class="fas fa-search"></i> Tìm kiếm
            </button>
        </form>

        <!-- Status Filter -->
        <div class="status-filter">
            <h6 class="mb-3"><i class="fas fa-filter me-2"></i>Lọc theo trạng thái:</h6>
            <a href="/admin/bills" class="status-btn ${empty selectedStatus ? 'active' : ''}">
                <i class="fas fa-list me-1"></i>Tất cả
            </a>
            <a href="/admin/bills?status=PENDING" class="status-btn ${selectedStatus == 'PENDING' ? 'active' : ''}">
                <i class="fas fa-clock me-1"></i>Chờ xác nhận
            </a>
            <a href="/admin/bills?status=CONFIRMED" class="status-btn ${selectedStatus == 'CONFIRMED' ? 'active' : ''}">
                <i class="fas fa-check me-1"></i>Đã xác nhận
            </a>
            <a href="/admin/bills?status=PROCESSING" class="status-btn ${selectedStatus == 'PROCESSING' ? 'active' : ''}">
                <i class="fas fa-cog me-1"></i>Đang xử lý
            </a>
            <a href="/admin/bills?status=SHIPPING" class="status-btn ${selectedStatus == 'SHIPPING' ? 'active' : ''}">
                <i class="fas fa-truck me-1"></i>Đang giao
            </a>
            <a href="/admin/bills?status=DELIVERED" class="status-btn ${selectedStatus == 'DELIVERED' ? 'active' : ''}">
                <i class="fas fa-check-circle me-1"></i>Đã giao
            </a>
            <a href="/admin/bills?status=SUCCESS" class="status-btn ${selectedStatus == 'SUCCESS' ? 'active' : ''}">
                <i class="fas fa-trophy me-1"></i>Thành công
            </a>
            <a href="/admin/bills?status=CANCELLED" class="status-btn ${selectedStatus == 'CANCELLED' ? 'active' : ''}">
                <i class="fas fa-times me-1"></i>Đã hủy
            </a>
            <a href="/admin/bills?status=EXPIRED" class="status-btn ${selectedStatus == 'EXPIRED' ? 'active' : ''}">
                <i class="fas fa-clock me-1"></i>Hết hạn
            </a>
        </div>

        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="mb-1">Tổng hóa đơn</h6>
                            <h4 class="mb-0">${recentBills.size()}</h4>
                        </div>
                        <i class="fas fa-receipt fa-2x opacity-75"></i>
                    </div>
                </div>
            </div>
        </div>

    <div class="table-responsive">
        <table class="table main-table">
            <thead>
                <tr>
                    <th class="text-center"><i class="fas fa-list-ol me-2"></i>STT</th>
                    <th><i class="fas fa-hashtag me-2"></i>Mã hóa đơn</th>
                    <th><i class="fas fa-user me-2"></i>Khách hàng</th>
                    <th><i class="fas fa-user me-2"></i>Địa chỉ</th>
                    <th><i class="fas fa-calendar me-2"></i>Ngày tạo</th>
                    <th class="text-end"><i class="fas fa-money-bill me-2"></i>Tổng tiền</th>
                    <th class="text-center"><i class="fas fa-info-circle me-2"></i>Trạng thái</th>
                    <th class="text-center"><i class="fas fa-cogs me-2"></i>Thao tác</th>
                </tr>
            </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty recentBills}">
                    <tr>
                        <td colspan="7" class="text-center py-4">
                            <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                            <h5 class="text-muted">Không có hóa đơn nào</h5>
                            <p class="text-muted">
                                <c:choose>
                                    <c:when test="${not empty selectedStatus}">
                                        Không có hóa đơn với trạng thái "${selectedStatus}"
                                    </c:when>
                                    <c:otherwise>
                                        Chưa có hóa đơn nào trong hệ thống
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
            <c:forEach var="bill" items="${recentBills}" varStatus="status">
                <!-- Hóa đơn -->
                <tr data-bs-toggle="collapse" data-bs-target="#bill-${bill.id}">
                    <td class="text-center">
                        <span class="fw-bold text-muted">${status.index + 1}</span>
                    </td>
                    <td>
                        <span class="bill-code">
                            <i class="fa-solid fa-receipt me-2 text-primary"></i>${bill.code}
                        </span>
                    </td>
                    <td>
                        <i class="fas fa-user-circle me-2 text-muted"></i>
                        <c:out value="${bill.customer != null ? bill.customer.name : 'Khách lẻ'}"/>
                    </td>
                    <td>
                        <i class="fas fa-map-marker-alt me-2 text-muted"></i>
                        <c:out value="${bill.billingAddress}"/>
                    </td>
                    <td>
                        <i class="fas fa-clock me-2 text-muted"></i>
                        <fmt:formatDate value="${bill.createDateAsDate}" pattern="dd/MM/yyyy HH:mm"/>
                    </td>
                    <td class="text-end">
                        <span class="amount-text text-success">
                            <fmt:formatNumber value="${bill.finalAmount}" type="number"/> đ
                        </span>
                    </td>
                    <td class="text-center">
                        <c:choose>
                            <c:when test="${bill.status == 'PENDING'}">
                                <span class="order-status status-pending">Chờ xác nhận</span>
                            </c:when>
                            <c:when test="${bill.status == 'CONFIRMED'}">
                                <span class="order-status status-confirmed">Đã xác nhận</span>
                            </c:when>
                            <c:when test="${bill.status == 'PROCESSING'}">
                                <span class="order-status status-processing">Đang xử lý</span>
                            </c:when>
                            <c:when test="${bill.status == 'SHIPPING'}">
                                <span class="order-status status-shipping">Đang giao</span>
                            </c:when>
                            <c:when test="${bill.status == 'DELIVERED'}">
                                <span class="order-status status-delivered">Đã giao</span>
                            </c:when>
                            <c:when test="${bill.status == 'SUCCESS'}">
                                <span class="order-status status-success">Thành công</span>
                            </c:when>
                            <c:when test="${bill.status == 'CANCELLED'}">
                                <span class="order-status status-cancelled">Đã hủy</span>
                            </c:when>
                            <c:when test="${bill.status == 'EXPIRED'}">
                                <span class="order-status status-expired">Hết hạn</span>
                            </c:when>
                            <c:otherwise>
                                <span class="order-status">${bill.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="text-center">
                        <a href="/admin/sales/print/${bill.id}" target="_blank"
                           class="btn btn-sm btn-outline-primary btn-print" title="In hóa đơn">
                            <i class="fas fa-print"></i>
                        </a>
                    </td>
                </tr>

                <!-- Chi tiết hóa đơn (ẩn/hiện khi click) -->
                <tr class="collapse detail-row" id="bill-${bill.id}">
                    <td colspan="7">
                        <table class="table table-sm table-bordered detail-table mb-0">
                            <thead>
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th>Màu</th>
                                    <th>Size</th>
                                    <th class="text-center">Số lượng</th>
                                    <th class="text-end">Giá tại thời điểm</th>
                                    <th class="text-end">Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="detail" items="${bill.billDetails}">
                                    <tr>
                                        <td>${detail.productName}</td>
                                        <td>${detail.productColor}</td>
                                        <td>${detail.productSize}</td>
                                        <td class="text-center">${detail.quantity}</td>
                                        <td class="text-end">
                                            <fmt:formatNumber value="${detail.momentPrice}" type="number"/> đ
                                        </td>
                                        <td class="text-end fw-bold">
                                            <fmt:formatNumber value="${detail.totalPrice}" type="number"/> đ
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
        </table>
    </div>

        <!-- Back Button -->
        <div class="mt-4">
            <a href="/Home" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-2"></i>Quay lại trang chủ
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Add hover effects and animations
    document.addEventListener('DOMContentLoaded', function() {
        // Add click animation for bill rows
        const billRows = document.querySelectorAll('tr[data-bs-toggle="collapse"]');
        billRows.forEach(row => {
            row.addEventListener('click', function() {
                this.style.transform = 'scale(0.98)';
                setTimeout(() => {
                    this.style.transform = 'scale(1)';
                }, 100);
            });
        });
    });
</script>
</body>
</html>
