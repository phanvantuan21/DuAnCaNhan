// Format số tiền sang định dạng Việt Nam
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND',
        minimumFractionDigits: 0,
        maximumFractionDigits: 0
    }).format(amount);
}

// Xử lý khi chọn mã giảm giá
function applyDiscount() {
    const discountSelect = document.querySelector('select[name="discountId"]');
    const cartTotalElement = document.getElementById('cartTotal');
    
    if (!discountSelect || !cartTotalElement) {
        console.error('Không tìm thấy các element cần thiết');
        return;
    }

    const discountId = discountSelect.value;
    // Chuyển đổi giá trị tiền tệ sang số
    const totalAmountStr = cartTotalElement.getAttribute('data-value') || cartTotalElement.value;
    const totalAmount = parseFloat(totalAmountStr.replace(/[.,đ₫]/g, ''));

    if (!discountId) {
        return;
    }

    fetch('/cart/api/discount/calculate', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            discountId: discountId,
            totalAmount: totalAmount
        })
    })
    .then(response => response.json())
    .then(data => {
        const messageElement = document.getElementById('discountMessage');
        const discountAmountElement = document.getElementById('discountAmount');
        const finalAmountElement = document.getElementById('finalAmount');
        const discountRow = document.getElementById('discountRow');

        if (data.success) {
            // Hiển thị số tiền giảm giá
            const discountAmount = parseFloat(data.discountAmount.replace(/[.,]/g, ''));
            discountAmountElement.textContent = `-${formatCurrency(discountAmount)}`;
            discountAmountElement.className = 'text-danger';
            
            // Hiển thị tổng tiền sau giảm
            const finalAmount = parseFloat(data.finalAmount.replace(/[.,]/g, ''));
            finalAmountElement.textContent = formatCurrency(finalAmount);
            
            // Hiển thị thông báo thành công
            messageElement.className = 'text-success small';
            messageElement.textContent = data.message;
            
            // Hiện dòng giảm giá
            discountRow.style.display = 'flex';
        } else {
            // Reset về trạng thái ban đầu
            discountAmountElement.textContent = '0₫';
            finalAmountElement.textContent = formatCurrency(totalAmount);
            messageElement.className = 'text-danger small';
            messageElement.textContent = data.message;
            discountRow.style.display = 'flex';
        }
    })
    .catch(error => {
        console.error('Error:', error);
        document.getElementById('discountMessage').textContent = 'Có lỗi xảy ra khi áp dụng mã giảm giá';
    });
}
