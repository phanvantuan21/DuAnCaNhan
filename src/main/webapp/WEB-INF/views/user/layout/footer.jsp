<%@page contentType="text/html" pageEncoding="UTF-8" %>

<style>
/* Main Footer */
.site-footer {
    background-color: #fff;
    padding: 40px 0 0;
    margin-top: 50px;
    border-top: 1px solid #e0e0e0;
}

.footer-section {
    margin-bottom: 30px;
}

.footer-title {
    font-size: 1rem;
    font-weight: 700;
    color: #333;
    margin-bottom: 15px;
    text-transform: uppercase;
}

.footer-content {
    font-size: 0.9rem;
    color: #666;
    line-height: 1.8;
}

.footer-content p {
    margin-bottom: 8px;
}

.footer-content a {
    color: #666;
    text-decoration: none;
    display: block;
    margin-bottom: 8px;
    transition: color 0.3s;
}

.footer-content a:hover {
    color: #5cb85c;
}

.footer-content i {
    margin-right: 8px;
    width: 16px;
    color: #5cb85c;
}

/* Payment & Partner Logos */
.payment-methods {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    align-items: center;
}

.payment-logo {
    height: 30px;
    width: auto;
}

.partner-logos {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    align-items: center;
}

.partner-logo {
    height: 40px;
    width: auto;
}

/* Social Icons */
.social-links {
    display: flex;
    gap: 10px;
}

.social-icon {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    text-decoration: none;
    transition: transform 0.3s;
}

.social-icon:hover {
    transform: translateY(-3px);
}

.social-icon.facebook { background: #3b5998; }
.social-icon.youtube { background: #ff0000; }
.social-icon.tiktok { background: #000; }

/* Certification Badge */
.cert-badge {
    width: 120px;
    height: auto;
}

/* Footer Bottom */
.footer-bottom {
    background-color: #f8f9fa;
    padding: 20px 0;
    margin-top: 30px;
    border-top: 1px solid #e0e0e0;
}

.footer-bottom p {
    margin: 0;
    font-size: 0.85rem;
    color: #666;
}

.company-info {
    font-size: 0.8rem;
    color: #999;
    line-height: 1.6;
}

@media (max-width: 768px) {
    .footer-section {
        margin-bottom: 25px;
    }
    
    .payment-methods,
    .partner-logos {
        justify-content: center;
    }
}
</style>

<footer class="site-footer">
    <div class="container">
        <div class="row">
            
            <!-- Thông tin liên hệ -->
            <div class="col-lg-3 col-md-6">
                <div class="footer-section">
                    <h5 class="footer-title">Thông tin liên hệ</h5>
                    <div class="footer-content">
                        <p><strong>Hệ thống Mua bán Trực tuyến Camiune</strong></p>
                        <p>Công ty TNHH 1 Thanh vien Phantun, GPĐKKD số 0123456789 do Sở KHĐT TP Hà Nội cấp ngày 21/11/2004</p>
                        <p><i class="fas fa-map-marker-alt"></i>1 Đ. Lê Đức Thọ, Mỹ Đình, Nam Từ Liêm, Hà Nội, Vietnam</p>
                        <p><i class="fas fa-phone"></i>Hỗ trợ trực tuyến: 1900 21 11 hoặc 0338821468 (8h30 - 21h từ thứ 2 - thứ 6, 8h30 - 11h30 thứ 7)</p>
                        <p><i class="fas fa-envelope"></i>phantun21@gmail.com</p>
                    </div>
                </div>
            </div>

            <!-- Về Camiune -->
            <div class="col-lg-3 col-md-6">
                <div class="footer-section">
                    <h5 class="footer-title">Về Camiune</h5>
                    <div class="footer-content">
                        <a href="/policy/security">Chính sách bảo mật</a>
                        <a href="/policy/terms">Quy chế hoạt động</a>
                        <a href="/policy/delivery">Điều khoản & Điều kiện giao dịch</a>
                        <a href="/policy/resolution">Chính sách giải quyết tranh chấp & khiếu nại</a>
                        <a href="/policy/shipping">Chính sách vận chuyển</a>
                        <a href="/policy/warranty">Chính sách bảo hành hàng hóa</a>
                        <a href="/policy/return">Quy định đổi trả hàng & hoàn tiền</a>
                    </div>
                </div>
            </div>

            <!-- Chấp nhận thanh toán -->
            <div class="col-lg-3 col-md-6">
                <div class="footer-section">
                    <h5 class="footer-title">Chấp Nhận Thanh Toán</h5>
                    <div class="payment-methods">
                        <img src="https://cdn.haitrieu.com/wp-content/uploads/2022/10/Logo-VNPAY-QR.png" alt="VNPAY" class="payment-logo">
                        <img src="https://cdn.haitrieu.com/wp-content/uploads/2022/10/Logo-Napas.png" alt="NAPAS" class="payment-logo">
                    </div>
                    
                    <h5 class="footer-title mt-4">Đối tác vận chuyển</h5>
                    <div class="partner-logos">
                        <img src="https://cdn.haitrieu.com/wp-content/uploads/2022/05/Logo-GHTK-Slogan-VN.png" alt="GHTK" class="partner-logo">
                    </div>
                </div>
            </div>

            <!-- Kết nối với Camiune -->
            <div class="col-lg-3 col-md-6">
                <div class="footer-section">
                    <h5 class="footer-title">Kết nối với Camiune</h5>
                    <div class="social-links mb-3">
                        <a href="#" class="social-icon facebook">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="social-icon youtube">
                            <i class="fab fa-youtube"></i>
                        </a>
                        <a href="#" class="social-icon tiktok">
                            <i class="fab fa-tiktok"></i>
                        </a>
                    </div>
                    
                    <img src="https://cdn.haitrieu.com/wp-content/uploads/2022/05/Logo-Bo-Cong-Thuong-Dat-Nen-Trang.png" alt="Đã thông báo Bộ Công Thương" class="cert-badge">
                </div>
            </div>
        </div>
    </div>

    <!-- Footer Bottom -->
    <div class="footer-bottom">
        <div class="container">
            <div class="text-center">
                <p>&copy; Copyright 2025 Furniture Camiune. All Rights Reserved. MS: 0338821468</p>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>