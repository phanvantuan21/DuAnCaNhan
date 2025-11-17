<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bán hàng - Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        :root { --primary:#2563eb;--primary-light:#dbeafe;--gray-100:#f8fafc;
            --gray-200:#e2e8f0;--gray-600:#475569;--gray-800:#1e293b;}
        body {background-color:#f9fafb;font-family:'Segoe UI',system-ui,sans-serif;}
        .main-content {background:#fff;border-radius:12px;box-shadow:0 1px 3px rgba(0,0,0,0.05);
            padding:24px;margin-top:20px;}
        .page-title {color:var(--gray-800);font-weight:600;font-size:1.5rem;margin-bottom:0;}
        .tab {display:inline-flex;align-items:center;padding:8px 16px;background:var(--gray-100);
            border-radius:6px;margin-right:8px;cursor:pointer;transition:all 0.2s;
            border:1px solid var(--gray-200);font-size:0.9rem;}
        .tab:hover {background:var(--gray-200);}
        .tab.active {background:white;font-weight:500;border-color:var(--primary);
            box-shadow:0 0 0 1px var(--primary);}
        .remove-tab-btn {margin-left:8px;color:#6b7280;cursor:pointer;
            font-size:0.8rem;opacity:0.7;}
        .remove-tab-btn:hover {opacity:1;}
        .product-image {width:50px;height:50px;object-fit:cover;border-radius:6px;border:1px solid var(--gray-200);}
        .cart-summary {background:var(--gray-100);border-radius:8px;padding:16px;}
        .summary-row {display:flex;justify-content:space-between;margin-bottom:8px;}
        .summary-total {font-size:1.1rem;font-weight:600;color:var(--gray-800);
            border-top:1px solid var(--gray-200);padding-top:12px;margin-top:8px;}
        .payment-method-label {display:flex;align-items:center;padding:10px;border:1px solid var(--gray-200);
            border-radius:6px;margin-bottom:8px;cursor:pointer;transition:all 0.2s;}
        .payment-method-label:hover,.payment-method-label.active {border-color:var(--primary);background:var(--primary-light);}
        .payment-method-label input {margin-right:10px;}
        .qr-frame {background:linear-gradient(135deg,#f8fafc 0%,#e2e8f0 100%);border-radius:12px;padding:20px;
            border:1px solid #e2e8f0;box-shadow:0 4px 6px rgba(0,0,0,0.05);margin:15px 0;text-align:center;}
        .qr-header {display:flex;align-items:center;justify-content:center;margin-bottom:15px;color:#2563eb;font-weight:600;}
        .qr-header i {margin-right:8px;font-size:1.2rem;}
        .qr-container {background:white;padding:15px;border-radius:8px;display:inline-block;
            box-shadow:0 2px 4px rgba(0,0,0,0.1);margin-bottom:10px;border:1px solid #d1d5db;}
        .qr-container img {border-radius:6px;display:block;max-width:180px;height:auto;}
        .qr-info {background:white;border-radius:8px;padding:12px;margin-top:10px;border-left:3px solid #2563eb;text-align:left;}
        .qr-info-item {display:flex;justify-content:space-between;margin-bottom:5px;font-size:0.9rem;}
        .qr-info-label {color:#6b7280;font-weight:500;}
        .qr-info-value {color:#1f2937;font-weight:600;}
        .qr-instruction {margin-top:10px;font-size:0.85rem;color:#6b7280;line-height:1.4;}
        #transferQrBox {display:none;}
    </style>
</head>
<body>
<div class="containerr">
    <jsp:include page="layout/sidebar.jsp"/>
    <div class="main-content">
        <jsp:include page="layout/header.jsp"/>
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="page-title">Quản lý Bán Hàng</h3>
        </div>

        <!-- Tabs -->
        <div id="cartTabs" class="mb-4 d-flex align-items-center">
            <c:set var="currentTab" value="${currentTab != null ? currentTab : 1}"/>
            <c:forEach var="entry" items="${carts}">
                <c:set var="tabId" value="${entry.key}" />
                <div class="tab ${tabId == currentTab ? 'active' : ''}">
                    <a href="/admin/sales?tab=${tabId}" style="text-decoration:none;color:inherit;">
                        Đơn ${tabId}
                    </a>
                    <span class="remove-tab-btn" onclick="removeTab(${tabId}, event)">×</span>
                </div>
            </c:forEach>
            <button onclick="window.location.href='/admin/sales?newTab=true'" class="btn btn-outline-primary ms-3">Thêm đơn</button>
        </div>

        <!-- Alerts -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${success}
                <c:if test="${not empty lastBillId}">
                    <a href="/admin/sales/print/${lastBillId}" target="_blank" class="btn btn-outline-primary btn-sm ms-2">
                        In hóa đơn
                    </a>
                </c:if>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row g-4">
            <!-- ================= SẢN PHẨM ================= -->
            <div class="col-md-7">
                <div class="card">
                    <div class="card-header">Danh sách sản phẩm</div>
                    <div class="card-body">
                        <form method="get" action="/admin/sales" class="d-flex mb-3">
                            <input type="hidden" name="tab" value="${currentTab}"/>
                            <input type="text" class="form-control me-2" name="keyword"
                                   value="${searchQuery}" placeholder="Tìm sản phẩm..."/>
                            <button type="submit" class="btn btn-primary">Tìm</button>
                        </form>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>Ảnh</th>
                                    <th>Tên SP</th>
                                    <th>Màu</th>
                                    <th>Size</th>
                                    <th>Giá</th>
                                    <th>Tồn kho</th>
                                    <th style="width:120px;">Thao tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="p" items="${productDetails}">
                                    <tr>
                                        <td>
                                            <img src="/images/product/${p.imageList[0].link}" alt="Ảnh sản phẩm"
                                                 class="product-image">
                                        </td>
                                        <td>${p.product.name}</td>
                                        <td>${p.color.name}</td>
                                        <td>${p.size.name}</td>
                                        <td class="fw-bold text-dark">
                                            <fmt:formatNumber value="${p.price}" type="number" pattern="#,###"/> đ
                                        </td>
                                        <td>${p.quantity}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${p.quantity == 0}">
                                                    <span class="badge bg-secondary">Hết hàng</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <form method="post" action="/admin/sales/cart/add" class="d-flex">
                                                        <input type="hidden" name="tabId" value="${currentTab}"/>
                                                        <input type="hidden" name="productDetailId" value="${p.id}"/>
                                                        <input type="number" name="quantity" value="1" min="1" max="${p.quantity}"
                                                               class="form-control form-control-sm me-1"/>
                                                        <button type="submit" class="btn btn-sm btn-primary">Thêm</button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ================= GIỎ HÀNG + THANH TOÁN ================= -->
            <div class="col-md-5">
                <div class="card mb-4">
                    <div class="card-header">Giỏ hàng (Đơn ${currentTab})</div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-sm">
                                <thead>
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th style="width:110px;">SL</th>
                                    <th>Thành tiền</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="c" items="${cartItems}" varStatus="status">
                                    <tr>
                                        <td>${c.productDetail.product.name}</td>
                                        <td>
                                            <input type="number"
                                                   class="form-control form-control-sm quantity-input"
                                                   data-tab="${currentTab}"
                                                   data-index="${status.index}"
                                                   value="${c.quantity}" min="0"/>
                                        </td>
                                        <td class="fw-bold text-dark">
                                            <fmt:formatNumber value="${c.totalPrice}" type="number" pattern="#,###"/> đ
                                        </td>
                                        <td>
                                            <form method="post" action="/admin/sales/cart/remove">
                                                <input type="hidden" name="tabId" value="${currentTab}"/>
                                                <input type="hidden" name="cartIndex" value="${status.index}"/>
                                                <button type="submit" class="btn btn-sm btn-outline-secondary">Xóa</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="cart-summary mt-3">
                            <div class="summary-row">
                                <span>Tổng cộng:</span>
                                <span class="fw-bold">
                                    <fmt:formatNumber value="${cartTotal}" type="number" pattern="#,###"/> đ
                                </span>
                            </div>
                            <div class="summary-row">
                                <span>Giảm giá:</span>
                                <span class="text-success fw-bold" id="discountAmount">0 đ</span>
                            </div>
                            <div class="summary-row summary-total">
                                <span>Khách cần trả:</span>
                                <span class="text-dark fw-bold" id="finalAmount">
                                    <fmt:formatNumber value="${cartTotal}" type="number" pattern="#,###"/> đ
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">Thanh toán</div>
                    <div class="card-body">
                        <form method="post" action="/admin/sales/place-order" id="checkoutForm">
                            <input type="hidden" name="tabId" value="${currentTab}"/>

                            <div class="mb-3">
                                <label class="form-label">Mã giảm giá</label>
                                <select name="discountId" class="form-select" id="discountSelect">
                                    <option value="">Không áp dụng</option>
                                    <c:forEach var="d" items="${discounts}">
                                        <option value="${d.id}"
                                                data-percentage="${d.percentage}"
                                                data-amount="${d.amount}"
                                                data-max-amount="${d.maximumAmount}"
                                                data-min-amount="${d.minimumAmountInCart}">
                                            <c:choose>
                                                <c:when test="${d.percentage != null}">
                                                    ${d.code} - Giảm ${d.percentage}%
                                                </c:when>
                                                <c:otherwise>
                                                    ${d.code} - Giảm <fmt:formatNumber value="${d.amount}" type="number" pattern="#,###"/>đ
                                                </c:otherwise>
                                            </c:choose>
                                        </option>
                                    </c:forEach>

                                </select>

                            </div>
                            <div class="mb-3">
                                <label class="form-label">Phương thức thanh toán</label>
                                <div id="paymentMethodBox">
                                    <label class="payment-method-label active">
                                        <input class="form-check-input" type="radio" name="paymentMethodId" value="1" required checked>
                                        <span>Tiền mặt</span>
                                    </label>
                                    <label class="payment-method-label">
                                        <input class="form-check-input" type="radio" name="paymentMethodId" value="2">
                                        <span>Chuyển khoản</span>
                                    </label>
                                </div>
                            </div>

                            <!-- VietQR Frame -->
                            <div id="transferQrBox">
                                <div class="qr-frame">
                                    <div class="qr-header">
                                        <i class="fas fa-qrcode"></i>
                                        <span>Quét mã để thanh toán</span>
                                    </div>
                                    <div class="qr-container">
                                        <div id="qrContainer"></div>
                                    </div>
                                    <div class="qr-info">
                                        <div class="qr-info-item">
                                            <span class="qr-info-label">Ngân hàng:</span>
                                            <span class="qr-info-value" id="qrBankName">MB Bank</span>
                                        </div>
                                        <div class="qr-info-item">
                                            <span class="qr-info-label">Số tài khoản:</span>
                                            <span class="qr-info-value" id="qrAccountNumber">0338821468</span>
                                        </div>
                                        <div class="qr-info-item">
                                            <span class="qr-info-label">Chủ tài khoản:</span>
                                            <span class="qr-info-value" id="qrAccountHolder">PHAN VAN TUAN</span>
                                        </div>
                                        <div class="qr-info-item">
                                            <span class="qr-info-label">Số tiền:</span>
                                            <span class="qr-info-value" id="qrAmount">
                                                <fmt:formatNumber value="${cartTotal}" type="number" pattern="#,###"/> đ
                                            </span>
                                        </div>
                                    </div>
                                    <div class="qr-instruction">
                                        <i class="fas fa-info-circle me-1"></i>
                                        Mở ứng dụng ngân hàng, quét mã QR để chuyển khoản nhanh chóng
                                    </div>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-success w-100 py-2 fw-bold">Tạo hóa đơn</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Xác nhận Xóa (trung tính, không đỏ) -->
        <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow-sm">
                    <div class="modal-header border-0">
                        <h5 class="modal-title text-dark fw-semibold">Xác nhận xóa</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body text-muted">
                        Bạn có chắc chắn muốn xóa đơn hàng này không?
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="button" class="btn btn-primary" id="confirmDeleteBtn">Xóa</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            let tabToDelete = null;
            function removeTab(tabId, event) {
                event.preventDefault();
                tabToDelete = tabId;
                $("#confirmDeleteModal").modal("show");
            }
            $("#confirmDeleteBtn").on("click", function() {
                if (tabToDelete) {
                    window.location.href = "/admin/sales?removeTab=" + tabToDelete;
                }
            });

            let cartTotal = ${cartTotal};
            let discountValue = 0;
            let finalAmount = cartTotal;

            const discountSelect = document.getElementById("discountSelect");
            const discountAmountEl = document.getElementById("discountAmount");
            const finalAmountEl = document.getElementById("finalAmount");
            const qrAmountEl = document.getElementById("qrAmount");

            function renderQr() {
                const selectedVal = $("input[name='paymentMethodId']:checked").val();
                if (parseInt(selectedVal) === 2) {
                    const amount = finalAmount;
                    const bankId = "mbbank";
                    const accountNo = "0338821468";
                    const accountName = "PHAN VAN TUAN";
                    const description = "Camiune - Đơn hàng " + new Date().getTime();

                    const qrUrl = "https://img.vietqr.io/image/" + bankId + "-" + accountNo + "-compact2.jpg" +
                        "?amount=" + amount +
                        "&addInfo=" + encodeURIComponent(description) +
                        "&accountName=" + encodeURIComponent(accountName);

                    $("#qrContainer").html('<img src="' + qrUrl + '" alt="QR Code Thanh Toán">');
                    qrAmountEl.textContent = finalAmount.toLocaleString() + " đ";
                    $("#transferQrBox").show();
                } else {
                    $("#transferQrBox").hide();
                }
            }

            function updateFinalAmount() {
                finalAmount = cartTotal - discountValue;
                if (finalAmount < 0) finalAmount = 0;

                discountAmountEl.textContent = discountValue.toLocaleString() + " đ";
                finalAmountEl.textContent = finalAmount.toLocaleString() + " đ";
                qrAmountEl.textContent = finalAmount.toLocaleString() + " đ";

                renderQr();
            }

            function reloadDiscounts(tabId) {
                $.get("/admin/sales/valid-discounts", {tabId: tabId}, function(discounts) {
                    const select = $("#discountSelect");
                    select.empty();
                    select.append('<option value="">Không áp dụng</option>');
                    discounts.forEach(d => {
                        select.append(`<option value="${d.id}" data-amount="${d.amount}">${d.code}</option>`);
                    });
                    discountValue = 0;
                    updateFinalAmount();
                });
            }

            discountSelect.addEventListener("change", function() {
                const selectedOption = discountSelect.options[discountSelect.selectedIndex];
                const discountAttr = selectedOption.getAttribute("data-amount");
                const percentageAttr = selectedOption.getAttribute("data-percentage");
                if(percentageAttr && percentageAttr !== "0") {
                    const percentage = parseFloat(selectedOption.getAttribute("data-percentage"));
                    const maxAmount = parseFloat(selectedOption.getAttribute("data-max-amount"));
                    const minAmount = parseFloat(selectedOption.getAttribute("data-min-amount"));
                    if(percentage === "0") {
                        discountValue = discountAttr ? parseFloat(discountAttr) : 0;
                    }
                    if(cartTotal >= minAmount) {
                        discountValue = Math.floor(cartTotal * (percentage / 100));
                        if(discountValue > maxAmount)   {
                            discountValue = maxAmount;
                        }
                    } else {
                        discountValue = 0;
                        alert("Giá trị đơn hàng chưa đạt mức tối thiểu để áp dụng mã giảm giá này.");
                        discountSelect.value = "";
                    }
                } else if(discountAttr) {
                    discountValue = parseFloat(discountAttr);
                } else {
                    discountValue = 0;
                }
                updateFinalAmount();
            });

            $(document).on("change", "input[name='paymentMethodId']", function() {
                $(".payment-method-label").removeClass("active");
                $(this).closest(".payment-method-label").addClass("active");
                renderQr();
            });

            $(document).on("change", ".quantity-input", function() {
                const tabId = $(this).data("tab");
                const cartIndex = $(this).data("index");
                const quantity = $(this).val();
                $.post("/admin/sales/cart/update", {tabId, cartIndex, quantity}, function() {
                    reloadDiscounts(tabId);
                    location.reload();
                });
            });

            $(document).ready(function() {
                updateFinalAmount();
                $("#transferQrBox").hide();
            });
        </script>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
