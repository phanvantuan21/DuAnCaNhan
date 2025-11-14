package com.example.demo.service;

import com.example.demo.Entity.Cart;
import com.example.demo.Entity.User;
import com.example.demo.Entity.ProductDetail;
import com.example.demo.repository.CartRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class CartService {

    @Autowired
    private CartRepository cartRepository;

    // Thêm sản phẩm vào giỏ hàng
    public Cart addToCart(User user, ProductDetail productDetail, Integer quantity) {
        // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
        Optional<Cart> existingCart = cartRepository.findByAccountAndProductDetail(user, productDetail);
        
        if (existingCart.isPresent()) {
            // Nếu đã có, cập nhật số lượng
            Cart cart = existingCart.get();
            cart.setQuantity(cart.getQuantity() + quantity);
            return cartRepository.save(cart);
        } else {
            // Nếu chưa có, tạo mới
            Cart cart = Cart.builder()
                    .account(user)
                    .productDetail(productDetail)
                    .quantity(quantity)
                    .build();
            return cartRepository.save(cart);
        }
    }

    // Cập nhật số lượng sản phẩm trong giỏ hàng
    public Cart updateCartItemQuantity(Long cartId, Integer quantity) {
        Optional<Cart> cartOpt = cartRepository.findById(cartId);
        if (cartOpt.isPresent()) {
            Cart cart = cartOpt.get();
            if (quantity <= 0) {
                cartRepository.delete(cart);
                return null;
            } else {
                cart.setQuantity(quantity);
                return cartRepository.save(cart);
            }
        }
        throw new RuntimeException("Không tìm thấy sản phẩm trong giỏ hàng");
    }

    // Xóa sản phẩm khỏi giỏ hàng
    public void removeFromCart(Long cartId) {
        cartRepository.deleteById(cartId);
    }

    // Lấy giỏ hàng của user
    public List<Cart> getCartByUser(User user) {
        return cartRepository.findByAccountOrderByCreateDateDesc(user);
    }

    // Xóa toàn bộ giỏ hàng
    public void clearCart(User user) {
        cartRepository.deleteByAccount(user);
    }

    // Tính tổng tiền giỏ hàng
    public Double getCartTotal(User user) {
        List<Cart> cartItems = getCartByUser(user);
        return cartItems.stream()
                .mapToDouble(item -> item.getProductDetail().getDiscountedPrice() * item.getQuantity())
                .sum();
    }

    // Đếm số lượng item trong giỏ hàng
    public long getCartItemCount(User user) {
        return cartRepository.countByAccount(user);
    }

    // Kiểm tra tồn kho trước khi checkout
    public boolean validateCartStock(User user) {
        List<Cart> cartItems = getCartByUser(user);
        for (Cart cartItem : cartItems) {
            if (cartItem.getProductDetail().getQuantity() < cartItem.getQuantity()) {
                return false;
            }
        }
        return true;
    }
}
