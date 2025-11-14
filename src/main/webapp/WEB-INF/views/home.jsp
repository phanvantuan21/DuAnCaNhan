<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Chat Widget Styles */
        .chat-widget {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
        }

        .chat-button {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: #1abc9c;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            transition: all 0.3s;
        }

        .chat-button:hover {
            background: #16a085;
            transform: scale(1.05);
        }

        .chat-container {
            position: fixed;
            bottom: 90px;
            right: 20px;
            width: 350px;
            height: 450px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            display: none;
            flex-direction: column;
            overflow: hidden;
        }

        .chat-header {
            background: linear-gradient(135deg, #1abc9c, #16a085);
            color: white;
            padding: 15px 20px;
            font-weight: 600;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(26, 188, 156, 0.3);
        }

        .chat-header .bot-name {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .chat-header .status-dot {
            width: 8px;
            height: 8px;
            background: #2ecc71;
            border-radius: 50%;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }

        .chat-messages {
            flex: 1;
            padding: 15px;
            overflow-y: auto;
            max-height: 300px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .chat-messages::after {
            content: "";
            display: table;
            clear: both;
        }

        .message {
            margin-bottom: 12px;
            padding: 12px 15px;
            border-radius: 15px;
            font-size: 14px;
            line-height: 1.5;
            word-wrap: break-word;
            position: relative;
            display: block;
            width: fit-content;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            white-space: pre-line;
        }

        .message.user-message {
            background: linear-gradient(135deg, #007bff, #0056b3) !important;
            color: white !important;
            margin-left: auto !important;
            margin-right: 0 !important;
            border-bottom-right-radius: 5px !important;
            box-shadow: 0 2px 8px rgba(0, 123, 255, 0.4) !important;
            text-align: left !important;
            align-self: flex-end !important;
            max-width: 75% !important;
            border: none !important;
        }

        /* Specific override for user messages */
        #chatMessages .message.user-message {
            background: #007bff !important;
            color: white !important;
        }

        .message.bot-message {
            background: linear-gradient(135deg, #e8f5e8, #d4edda) !important;
            color: #155724 !important;
            margin-right: auto !important;
            margin-left: 0 !important;
            border-bottom-left-radius: 5px !important;
            border-left: 4px solid #28a745 !important;
            box-shadow: 0 2px 8px rgba(40, 167, 69, 0.2) !important;
            text-align: left !important;
            align-self: flex-start !important;
            max-width: 75% !important;
        }

        /* Specific override for bot messages */
        #chatMessages .message.bot-message {
            background: #e8f5e8 !important;
            color: #155724 !important;
            border-left: 4px solid #28a745 !important;
        }

        .typing-indicator {
            display: none;
            padding: 10px 15px;
            color: #666;
            font-style: italic;
            font-size: 13px;
        }

        .typing-dots {
            display: inline-block;
        }

        .typing-dots span {
            display: inline-block;
            width: 4px;
            height: 4px;
            border-radius: 50%;
            background: #1abc9c;
            margin: 0 1px;
            animation: typing 1.4s infinite ease-in-out;
        }

        .typing-dots span:nth-child(1) { animation-delay: -0.32s; }
        .typing-dots span:nth-child(2) { animation-delay: -0.16s; }

        @keyframes typing {
            0%, 80%, 100% { transform: scale(0); }
            40% { transform: scale(1); }
        }

        .chat-input {
            display: flex;
            padding: 15px;
            background: #f8f9fa;
            border-top: 1px solid #dee2e6;
        }

        .chat-input input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 20px;
            outline: none;
        }

        .chat-input button {
            background: #1abc9c;
            color: white;
            border: none;
            border-radius: 20px;
            padding: 10px 15px;
            margin-left: 10px;
            cursor: pointer;
        }

        .chat-input button:hover {
            background: #16a085;
        }

        .chat-container.active {
            display: flex;
        }

        /* Additional Statistics Styles */
        .stats-section {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            height: 100%;
            margin-bottom: 30px;
        }

        .stats-section h3 {
            color: #2c3e50;
            margin-bottom: 20px;
            font-size: 1.2rem;
            font-weight: 600;
        }

        .status-stats {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .status-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 18px;
            background: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid #3498db;
            margin-bottom: 8px;
        }

        .status-label {
            font-weight: 500;
            color: #2c3e50;
        }

        .status-count {
            font-weight: bold;
            color: #3498db;
            background: white;
            padding: 4px 12px;
            border-radius: 20px;
            min-width: 40px;
            text-align: center;
        }

        .low-stock-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .low-stock-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 18px;
            background: #fff5f5;
            border-radius: 8px;
            border-left: 4px solid #e74c3c;
            margin-bottom: 8px;
        }

        .product-name {
            font-weight: 500;
            color: #2c3e50;
            flex: 1;
        }

        .stock-count {
            font-weight: bold;
            color: #e74c3c;
            background: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.9rem;
        }

        .text-success {
            color: #27ae60 !important;
            font-weight: 500;
        }

        /* Status colors */
        .status.pending { background: #f39c12; }
        .status.processing { background: #3498db; }
        .status.shipping { background: #9b59b6; }
        .status.completed { background: #27ae60; }
        .status.cancelled { background: #e74c3c; }

        /* Row spacing */
        .row {
            display: flex;
            gap: 20px;
        }

        .col-md-6 {
            flex: 1;
        }

        /* Section spacing */
        .dashboard > div {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <jsp:include page="admin/layout/sidebar.jsp"/>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
        <jsp:include page="admin/layout/header.jsp"/>

        <!-- Dashboard Content -->
        <div class="dashboard">
            <h1>Dashboard</h1>

            <!-- Stats Cards: Chỉ hiện với ROLE_ADMIN hoặc ROLE_EMPLOYEE -->
            <c:if test="${sessionScope.user.role.name == 'ROLE_ADMIN' || sessionScope.user.role.name == 'ROLE_EMPLOYEE'}">
                <div class="stats-cards" style="margin-bottom: 40px;">
                    <div class="card">
                        <div class="card-icon" style="background: #e3f2fd;">
                            <i class="fas fa-shopping-cart" style="color: #1976d2;"></i>
                        </div>
                        <div class="card-info">
                            <h3>Tổng đơn hàng</h3>
                            <p>${totalOrders}</p>
                            <span class="trend ${orderGrowth >= 0 ? 'up' : 'down'}">
                                ${orderGrowth >= 0 ? '+' : ''}${orderGrowth}%
                                <i class="fas fa-arrow-${orderGrowth >= 0 ? 'up' : 'down'}"></i>
                            </span>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-icon" style="background: #e8f5e9;">
                            <i class="fas fa-dollar-sign" style="color: #2e7d32;"></i>
                        </div>
                        <div class="card-info">
                            <h3>Doanh thu</h3>
                            <p><fmt:formatNumber value="${totalRevenue}" type="number" maxFractionDigits="0"/> VNĐ</p>
                            <!-- Debug: Raw value = ${totalRevenue} -->
                            <span class="trend ${revenueGrowth >= 0 ? 'up' : 'down'}">
                                ${revenueGrowth >= 0 ? '+' : ''}${revenueGrowth}%
                                <i class="fas fa-arrow-${revenueGrowth >= 0 ? 'up' : 'down'}"></i>
                            </span>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-icon" style="background: #fff3e0;">
                            <i class="fas fa-users" style="color: #f57c00;"></i>
                        </div>
                        <div class="card-info">
                            <h3>Khách hàng</h3>
                            <p>${totalCustomers}</p>
                            <span class="trend up">+12% <i class="fas fa-arrow-up"></i></span>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-icon" style="background: #fce4ec;">
                            <i class="fas fa-box" style="color: #c2185b;"></i>
                        </div>
                        <div class="card-info">
                            <h3>Sản phẩm</h3>
                            <p>${totalProducts}</p>
                            <span class="trend up">+5% <i class="fas fa-arrow-up"></i></span>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Đơn hàng gần đây: Luôn hiện với mọi role -->
            <div class="recent-orders" style="margin-bottom: 40px;">
                <div class="section-header">
                    <h2>Đơn hàng gần đây</h2>
                    <a href="/admin/bills" class="view-all">Xem tất cả</a>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                        <tr>
                            <th>Mã đơn hàng</th>
                            <th>Khách hàng</th>
                            <th>Sản phẩm</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${recentOrders}" var="order" varStatus="status">
                            <tr>
                                <td>${order.code}</td>
                                <td>${order.customer.name}</td>
                                <td>${order.billDetails.size()} sản phẩm</td>
                                <td><fmt:formatNumber value="${order.finalAmount}" type="number" maxFractionDigits="0"/> VNĐ</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.status == 'PENDING'}">
                                            <span class="status pending">Chờ xử lý</span>
                                        </c:when>
                                        <c:when test="${order.status == 'PROCESSING'}">
                                            <span class="status processing">Đang xử lý</span>
                                        </c:when>
                                        <c:when test="${order.status == 'SHIPPING'}">
                                            <span class="status shipping">Đang giao</span>
                                        </c:when>
                                        <c:when test="${order.status == 'DELIVERED'}">
                                            <span class="status completed">Hoàn thành</span>
                                        </c:when>
                                        <c:when test="${order.status == 'CANCELLED'}">
                                            <span class="status cancelled">Đã hủy</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status">${order.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty recentOrders}">
                            <tr>
                                <td colspan="6" class="text-center">Chưa có đơn hàng nào</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Additional Statistics Section -->
            <c:if test="${sessionScope.user.role.name == 'ROLE_ADMIN' || sessionScope.user.role.name == 'ROLE_EMPLOYEE'}">
                <div class="row" style="margin-top: 40px;">
                    <!-- Order Status Statistics -->
                    <div class="col-md-6" style="padding-right: 20px;">
                        <div class="stats-section">
                            <h3>Thống kê trạng thái đơn hàng</h3>
                            <div class="status-stats">
                                <div class="status-item">
                                    <span class="status-label">Chờ xử lý:</span>
                                    <span class="status-count">${pendingOrders}</span>
                                </div>
                                <div class="status-item">
                                    <span class="status-label">Đang xử lý:</span>
                                    <span class="status-count">${processingOrders}</span>
                                </div>
                                <div class="status-item">
                                    <span class="status-label">Đang giao:</span>
                                    <span class="status-count">${shippingOrders}</span>
                                </div>
                                <div class="status-item">
                                    <span class="status-label">Hoàn thành:</span>
                                    <span class="status-count">${deliveredOrders}</span>
                                </div>
                                <div class="status-item">
                                    <span class="status-label">Đã hủy:</span>
                                    <span class="status-count">${cancelledOrders}</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Low Stock Products -->
                    <div class="col-md-6" style="padding-left: 20px;">
                        <div class="stats-section">
                            <h3>Sản phẩm sắp hết hàng</h3>
                            <div class="low-stock-list">
                                <c:forEach items="${lowStockProducts}" var="product" varStatus="status">
                                    <div class="low-stock-item">
                                        <span class="product-name">${product.name}</span>
                                        <span class="stock-count">${product.totalQuantity} còn lại</span>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty lowStockProducts}">
                                    <div class="low-stock-item">
                                        <span class="text-success">✅ Tất cả sản phẩm đều có đủ hàng</span>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

        </div>
    </div>
</div>

<!-- Chat Widget -->
<div class="chat-widget">
    <div class="chat-button" onclick="toggleChat()">
        <i class="fas fa-comments"></i>
    </div>

    <div class="chat-container" id="chatContainer">
        <div class="chat-header">
            <div class="bot-name">
                <span>🤖 BeeStore Assistant</span>
                <div class="status-dot"></div>
            </div>
            <i class="fas fa-times" onclick="toggleChat()" style="cursor: pointer;"></i>
        </div>

        <div class="chat-messages" id="chatMessages">
            <div class="message bot-message">
                Xin chào! Tôi là trợ lý ảo của BeeStore. Tôi có thể giúp bạn tìm sản phẩm, kiểm tra giá cả và thông tin. Bạn cần hỗ trợ gì? 😊
            </div>
        </div>

        <div class="typing-indicator" id="typingIndicator">
            🤖 Đang trả lời
            <div class="typing-dots">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>

        <div class="chat-input">
            <input type="text" id="chatInput" placeholder="Nhập tin nhắn..." onkeypress="handleKeyPress(event)">
            <button onclick="sendMessage()">
                <i class="fas fa-paper-plane"></i>
            </button>
        </div>
    </div>
</div>

<script>
function toggleChat() {
    const chatContainer = document.getElementById('chatContainer');
    chatContainer.classList.toggle('active');
}

function handleKeyPress(event) {
    if (event.key === 'Enter') {
        sendMessage();
    }
}

function sendMessage() {
    const input = document.getElementById('chatInput');
    const message = input.value.trim();

    if (message === '') return;

    // Add user message to chat
    addMessage(message, 'user');
    input.value = '';

    // Show typing indicator
    showTypingIndicator();

    // Timeout sau 10 giây
    const timeoutId = setTimeout(() => {
        hideTypingIndicator();
        addMessage('⏰ Phản hồi quá lâu, đang chuyển sang chế độ nhanh...', 'bot');
    }, 10000);

    // Send to backend
    fetch('/api/chatbot/chat', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ message: message })
    })
    .then(response => response.json())
    .then(data => {
        clearTimeout(timeoutId);
        hideTypingIndicator();
        addMessage(data.response, 'bot');
    })
    .catch(error => {
        clearTimeout(timeoutId);
        hideTypingIndicator();
        addMessage('Xin lỗi, có lỗi xảy ra. Vui lòng thử lại sau.', 'bot');
    });
}

function addMessage(message, sender) {
    const messagesContainer = document.getElementById('chatMessages');

    // Create message div with proper styling
    const messageDiv = document.createElement('div');
    messageDiv.className = `message ${sender}-message`;

    // Force styling based on sender
    if (sender === 'user') {
        messageDiv.style.background = 'linear-gradient(135deg, #007bff, #0056b3)';
        messageDiv.style.color = 'white';
        messageDiv.style.marginLeft = 'auto';
        messageDiv.style.marginRight = '0';
        messageDiv.style.alignSelf = 'flex-end';
        messageDiv.style.borderBottomRightRadius = '5px';
        messageDiv.style.boxShadow = '0 2px 8px rgba(0, 123, 255, 0.4)';
    } else if (sender === 'bot') {
        messageDiv.style.background = 'linear-gradient(135deg, #e8f5e8, #d4edda)';
        messageDiv.style.color = '#155724';
        messageDiv.style.marginRight = 'auto';
        messageDiv.style.marginLeft = '0';
        messageDiv.style.alignSelf = 'flex-start';
        messageDiv.style.borderLeft = '4px solid #28a745';
        messageDiv.style.borderBottomLeftRadius = '5px';
        messageDiv.style.boxShadow = '0 2px 8px rgba(40, 167, 69, 0.2)';
    }

    // Use innerHTML to preserve formatting
    messageDiv.innerHTML = message;

    // Add message to container
    messagesContainer.appendChild(messageDiv);

    // Scroll to bottom
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
}

function showTypingIndicator() {
    const typingIndicator = document.getElementById('typingIndicator');
    typingIndicator.style.display = 'block';

    // Scroll to bottom
    const messagesContainer = document.getElementById('chatMessages');
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
}

function hideTypingIndicator() {
    const typingIndicator = document.getElementById('typingIndicator');
    typingIndicator.style.display = 'none';
}
</script>

</body>
</html>
