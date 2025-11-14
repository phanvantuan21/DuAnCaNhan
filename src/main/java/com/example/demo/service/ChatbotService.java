package com.example.demo.service;

import com.example.demo.Entity.Product;
import com.example.demo.repository.ProductRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class ChatbotService {

    private static final Logger log = LoggerFactory.getLogger(ChatbotService.class);

    @Autowired
    private ProductRepo productRepository;

    @Autowired
    private GeminiService geminiService;

    public String processChatRequest(String userMessage) {
        try {
            // Thử dùng AI trước với timeout ngắn
            try {
                log.info("Trying AI service for message: {}", userMessage);
                long startTime = System.currentTimeMillis();

                String productContext = getProductContext(userMessage);
                String prompt = buildPromptWithContext(userMessage, productContext);

                // Timeout sau 8 giây
                String aiResponse = callGeminiWithTimeout(prompt, 8000);

                long endTime = System.currentTimeMillis();
                log.info("AI response time: {}ms", (endTime - startTime));

                // Nếu AI response không phải error message thì return
                if (aiResponse != null && !aiResponse.contains("Xin lỗi") &&
                    !aiResponse.contains("lỗi") && !aiResponse.contains("không thể") &&
                    aiResponse.length() > 10) {
                    return aiResponse;
                }
                log.warn("AI response seems to be error message: {}", aiResponse);
            } catch (Exception aiError) {
                log.warn("AI service failed: {}", aiError.getMessage());
            }

            // Fallback: Sử dụng logic đơn giản
            return handleWithSimpleLogic(userMessage);

        } catch (Exception e) {
            return "Xin lỗi, có lỗi xảy ra. Vui lòng thử lại với câu hỏi khác.";
        }
    }

    private String handleWithSimpleLogic(String userMessage) {
        String lowerMessage = userMessage.toLowerCase();

        // Chi tiết sản phẩm
        if (lowerMessage.contains("chi tiết") || lowerMessage.contains("thông tin") ||
            lowerMessage.contains("xem thêm")) {
            return handleProductDetailSimple(userMessage);
        }

        // Chào hỏi
        if (lowerMessage.contains("xin chào") || lowerMessage.contains("chào") ||
            lowerMessage.contains("hello") || lowerMessage.contains("hi")) {
            return "Xin chào! 👋 Tôi là trợ lý ảo của BeeStore. Tôi có thể giúp bạn:\n" +
                   "• Tìm sản phẩm theo tên, danh mục\n" +
                   "• Kiểm tra giá cả và tồn kho\n" +
                   "• Gợi ý sản phẩm phù hợp\n\n" +
                   "Bạn đang tìm sản phẩm gì? 😊";
        }

        // Tìm sản phẩm
        if (lowerMessage.contains("tìm") || lowerMessage.contains("có") ||
            lowerMessage.contains("sản phẩm") || lowerMessage.contains("giày") ||
            lowerMessage.contains("áo") || lowerMessage.contains("quần")) {
            return handleProductSearchSimple(userMessage);
        }

        // Hỏi giá
        if (lowerMessage.contains("giá") || lowerMessage.contains("bao nhiêu") ||
            lowerMessage.contains("tiền")) {
            return handlePriceInquirySimple(userMessage);
        }

        // Help
        if (lowerMessage.contains("giúp") || lowerMessage.contains("hỗ trợ") ||
            lowerMessage.contains("help")) {
            return "🤖 Tôi có thể giúp bạn:\n\n" +
                   "🔍 **Tìm sản phẩm**: 'Tôi muốn tìm giày thể thao'\n" +
                   "💰 **Kiểm tra giá**: 'Giá áo Nike là bao nhiêu?'\n" +
                   "📦 **Xem tồn kho**: 'Còn hàng không?'\n" +
                   "🛍️ **Gợi ý sản phẩm**: 'Có sản phẩm nào hot không?'\n\n" +
                   "Hãy cho tôi biết bạn cần gì! 😊";
        }

        // Default
        return "Tôi chưa hiểu rõ yêu cầu của bạn. Bạn có thể:\n" +
               "• Hỏi về sản phẩm: 'Có giày Nike không?'\n" +
               "• Kiểm tra giá: 'Giá áo Adidas bao nhiêu?'\n" +
               "• Hoặc gõ 'help' để xem hướng dẫn\n\n" +
               "Tôi luôn sẵn sàng hỗ trợ bạn! 💪";
    }

    private String handleProductSearchSimple(String query) {
        List<String> keywords = extractKeywords(query);
        List<Product> products = findProductsByKeywords(keywords);

        if (products.isEmpty()) {
            return "🔍 Tôi không tìm thấy sản phẩm nào phù hợp với yêu cầu của bạn.\n\n" +
                   "Bạn có thể thử:\n" +
                   "• Tìm theo thương hiệu: 'Nike', 'Adidas'\n" +
                   "• Tìm theo loại: 'giày', 'áo', 'quần'\n" +
                   "• Hoặc gõ từ khóa khác\n\n" +
                   "Tôi sẽ cố gắng tìm sản phẩm phù hợp nhất! 😊";
        }

        return formatProductResultsSimple(products);
    }

    private String handlePriceInquirySimple(String query) {
        List<String> keywords = extractKeywords(query);
        List<Product> products = findProductsByKeywords(keywords);

        if (products.isEmpty()) {
            return "💰 Để kiểm tra giá chính xác, tôi cần biết sản phẩm cụ thể.\n\n" +
                   "Bạn có thể hỏi:\n" +
                   "• 'Giá giày Nike Air Max'\n" +
                   "• 'Áo Adidas giá bao nhiêu'\n" +
                   "• Hoặc cho tôi mã sản phẩm\n\n" +
                   "Tôi sẽ tìm thông tin giá cho bạn! 💪";
        }

        return formatPriceResultsSimple(products);
    }

    private String formatProductResultsSimple(List<Product> products) {
        StringBuilder result = new StringBuilder();

        result.append("🛍️ TÌM THẤY ").append(products.size()).append(" SẢN PHẨM\n");
        result.append("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n");

        for (int i = 0; i < Math.min(products.size(), 5); i++) {
            Product product = products.get(i);
            String productName = product.getName() != null ? product.getName() : "Sản phẩm " + product.getCode();

            result.append(i + 1).append(". ").append(productName).append("\n");
            result.append("   Mã: ").append(product.getCode());

            if (product.getCategory() != null) {
                result.append(" | Danh mục: ").append(product.getCategory().getName());
            }

            if (product.getBrand() != null) {
                result.append(" | Thương hiệu: ").append(product.getBrand().getName());
            }

            result.append("\n\n");
        }

        result.append("💡 Gõ \"chi tiết [tên sản phẩm]\" để xem thông tin đầy đủ!");

        return result.toString();
    }

    private String formatPriceResultsSimple(List<Product> products) {
        StringBuilder result = new StringBuilder();

        result.append("💰 THÔNG TIN GIÁ\n");
        result.append("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n");

        for (Product product : products.subList(0, Math.min(products.size(), 3))) {
            String productName = product.getName() != null ? product.getName() : "Sản phẩm " + product.getCode();

            result.append("Sản phẩm: ").append(productName).append("\n");
            result.append("Mã: ").append(product.getCode()).append("\n");

            if (product.getProductDetailList() != null && !product.getProductDetailList().isEmpty()) {
                var productDetail = product.getProductDetailList().get(0);
                if (productDetail.getPrice() != null) {
                    result.append("Giá bán: ").append(String.format("%,d", productDetail.getPrice().intValue())).append("đ\n");
                }
                if (productDetail.getQuantity() != null) {
                    result.append("Tồn kho: ").append(productDetail.getQuantity()).append(" sản phẩm\n");
                }
            } else {
                result.append("Giá: Liên hệ để biết giá chính xác\n");
            }

            result.append("\n");
        }

        return result.toString();
    }

    private String handleProductDetailSimple(String query) {
        List<String> keywords = extractKeywords(query);
        List<Product> products = findProductsByKeywords(keywords);

        if (products.isEmpty()) {
            return "🔍 Tôi cần biết sản phẩm cụ thể để xem chi tiết.\n" +
                   "Ví dụ: 'Chi tiết áo Nike' hoặc 'Thông tin giày Adidas'\n" +
                   "Bạn muốn xem chi tiết sản phẩm nào? 😊";
        }

        // Lấy sản phẩm đầu tiên để hiển thị chi tiết
        Product product = products.get(0);
        StringBuilder result = new StringBuilder();

        result.append("📋 CHI TIẾT SẢN PHẨM\n");
        result.append("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n");

        result.append("Mã sản phẩm: ").append(product.getCode()).append("\n");
        result.append("Tên sản phẩm: ").append(product.getName()).append("\n");

        if (product.getCategory() != null) {
            result.append("Danh mục: ").append(product.getCategory().getName()).append("\n");
        }

        if (product.getBrand() != null) {
            result.append("Thương hiệu: ").append(product.getBrand().getName()).append("\n");
        }

        if (product.getProductDetailList() != null && !product.getProductDetailList().isEmpty()) {
            var detail = product.getProductDetailList().get(0);
            if (detail.getPrice() != null) {
                result.append("Giá bán: ").append(String.format("%,d", detail.getPrice().intValue())).append("đ\n");
            }
            if (detail.getQuantity() != null) {
                result.append("Tồn kho: ").append(detail.getQuantity()).append(" sản phẩm\n");
            }
        }

        return result.toString();
    }

    /**
     * Method để test truy cập database
     */
    public String testProductAccess() {
        StringBuilder result = new StringBuilder();

        try {
            // Test 1: Lấy tất cả sản phẩm
            List<Product> allProducts = productRepository.findAll();
            result.append("Total products in database: ").append(allProducts.size()).append("\n\n");

            // Test 2: Lấy sản phẩm không bị xóa
            List<Product> activeProducts = productRepository.findByDeleteFlag(false);
            result.append("Active products: ").append(activeProducts.size()).append("\n\n");

            // Test 3: Hiển thị 5 sản phẩm đầu tiên
            result.append("First 5 products:\n");
            List<Product> sampleProducts = activeProducts.stream().limit(5).collect(Collectors.toList());

            for (Product product : sampleProducts) {
                result.append("- ID: ").append(product.getId())
                      .append(", Name: ").append(product.getName())
                      .append(", Code: ").append(product.getCode());

                if (product.getCategory() != null) {
                    result.append(", Category: ").append(product.getCategory().getName());
                }

                if (product.getBrand() != null) {
                    result.append(", Brand: ").append(product.getBrand().getName());
                }

                result.append("\n");

                // Kiểm tra product details
                if (product.getProductDetailList() != null && !product.getProductDetailList().isEmpty()) {
                    result.append("  Details: ").append(product.getProductDetailList().size()).append(" variants\n");
                    var detail = product.getProductDetailList().get(0);
                    result.append("  First variant - Price: ").append(detail.getPrice())
                          .append(", Quantity: ").append(detail.getQuantity()).append("\n");
                } else {
                    result.append("  No product details\n");
                }

                result.append("\n");
            }

            return result.toString();

        } catch (Exception e) {
            return "Error testing product access: " + e.getMessage() + "\n" +
                   "Stack trace: " + e.getStackTrace()[0];
        }
    }

    /**
     * Call Gemini with timeout
     */
    private String callGeminiWithTimeout(String prompt, long timeoutMs) {
        try {
            // Sử dụng CompletableFuture để timeout
            return java.util.concurrent.CompletableFuture
                    .supplyAsync(() -> geminiService.generateResponse(prompt))
                    .get(timeoutMs, java.util.concurrent.TimeUnit.MILLISECONDS);
        } catch (java.util.concurrent.TimeoutException e) {
            log.warn("Gemini API timeout after {}ms", timeoutMs);
            return null;
        } catch (Exception e) {
            log.error("Error calling Gemini with timeout", e);
            return null;
        }
    }

    private String getProductContext(String userMessage) {
        try {
            // Tìm sản phẩm liên quan đến câu hỏi
            List<String> keywords = extractKeywords(userMessage);
            log.info("Extracted keywords: {}", keywords);

            List<Product> relevantProducts = findProductsByKeywords(keywords);
            log.info("Found {} relevant products", relevantProducts.size());

            if (relevantProducts.isEmpty()) {
                // Nếu không tìm thấy sản phẩm cụ thể, lấy một số sản phẩm mẫu
                relevantProducts = productRepository.findByDeleteFlag(false).stream()
                        .limit(5)
                        .collect(Collectors.toList());
                log.info("Using fallback products: {} items", relevantProducts.size());
            }

            String context = formatProductsForContext(relevantProducts);
            log.info("Generated context: {}", context);
            return context;
        } catch (Exception e) {
            log.error("Error getting product context", e);
            return "Hiện tại cửa hàng có nhiều sản phẩm đa dạng.";
        }
    }

    private String buildPromptWithContext(String userMessage, String productContext) {
        String lowerMessage = userMessage.toLowerCase();

        if (lowerMessage.contains("chi tiết") || lowerMessage.contains("thông tin")) {
            return "Hiển thị chi tiết sản phẩm từ data:\n" + productContext +
                   "\nHỎI: " + userMessage + "\nTRẢ LỜI chi tiết với giá, tồn kho:";
        }

        return "Chatbot BeeStore. Trả lời ngắn gọn dựa trên data:\n\n" +
               "SẢN PHẨM:\n" + productContext + "\n\n" +
               "QUY TẮC: CHỈ dùng data trên, max 2-3 dòng, có emoji 🛍️💰📦\n" +
               "HỎI: " + userMessage + "\nTRẢ LỜI:";
    }

    private String formatProductsForContext(List<Product> products) {
        StringBuilder context = new StringBuilder();

        for (Product product : products) {
            context.append("- ").append(product.getName());
            context.append(" (Mã: ").append(product.getCode()).append(")");

            if (product.getCategory() != null) {
                context.append(" - Danh mục: ").append(product.getCategory().getName());
            }

            if (product.getBrand() != null) {
                context.append(" - Thương hiệu: ").append(product.getBrand().getName());
            }

            if (product.getProductDetailList() != null && !product.getProductDetailList().isEmpty()) {
                var detail = product.getProductDetailList().get(0);
                if (detail.getPrice() != null) {
                    context.append(" - Giá: ").append(String.format("%,.0f", detail.getPrice())).append("đ");
                }
                if (detail.getQuantity() != null && detail.getQuantity() > 0) {
                    context.append(" - Còn hàng: ").append(detail.getQuantity()).append(" sản phẩm");
                }
            }

            context.append("\n");
        }

        return context.toString();
    }

    private String analyzeIntent(String message) {
        String lowerMessage = message.toLowerCase();
        
        if (lowerMessage.contains("xin chào") || lowerMessage.contains("hello") || 
            lowerMessage.contains("chào") || lowerMessage.contains("hi")) {
            return "GREETING";
        }
        
        if (lowerMessage.contains("giá") || lowerMessage.contains("bao nhiêu") || 
            lowerMessage.contains("tiền")) {
            return "PRICE_INQUIRY";
        }
        
        if (lowerMessage.contains("tìm") || lowerMessage.contains("có") || 
            lowerMessage.contains("sản phẩm") || lowerMessage.contains("giày") ||
            lowerMessage.contains("áo") || lowerMessage.contains("quần")) {
            return "PRODUCT_SEARCH";
        }
        
        if (lowerMessage.contains("giúp") || lowerMessage.contains("hỗ trợ") || 
            lowerMessage.contains("help")) {
            return "HELP";
        }
        
        return "GENERAL";
    }

    private String handleProductSearch(String query) {
        List<String> keywords = extractKeywords(query);
        List<Product> products = findProductsByKeywords(keywords);
        
        if (products.isEmpty()) {
            return "Xin lỗi, tôi không tìm thấy sản phẩm nào phù hợp với yêu cầu của bạn. " +
                   "Bạn có thể thử với từ khóa khác không?";
        }
        
        return formatProductResults(products);
    }

    private String handlePriceInquiry(String query) {
        List<String> keywords = extractKeywords(query);
        List<Product> products = findProductsByKeywords(keywords);
        
        if (products.isEmpty()) {
            return "Tôi cần thêm thông tin để kiểm tra giá. Bạn có thể cho tôi biết tên sản phẩm cụ thể không?";
        }
        
        return formatPriceResults(products);
    }

    private String handleGeneralQuery(String query) {
        // Thử tìm sản phẩm với query tổng quát
        List<String> keywords = extractKeywords(query);
        List<Product> products = findProductsByKeywords(keywords);
        
        if (!products.isEmpty()) {
            return "Tôi tìm thấy một số sản phẩm có thể bạn quan tâm:\n\n" + 
                   formatProductResults(products);
        }
        
        return "Tôi chưa hiểu rõ yêu cầu của bạn. Bạn có thể hỏi về:\n" +
               "• Tìm sản phẩm: 'Tôi muốn tìm giày thể thao'\n" +
               "• Kiểm tra giá: 'Giá áo Nike là bao nhiêu?'\n" +
               "• Hoặc gõ 'help' để xem thêm hướng dẫn";
    }

    private List<String> extractKeywords(String query) {
        // Đơn giản hóa: tách từ và loại bỏ stop words
        String[] words = query.toLowerCase()
                .replaceAll("[^a-zA-ZÀ-ỹ0-9\\s]", "")
                .split("\\s+");
        
        return List.of(words).stream()
                .filter(word -> word.length() > 2)
                .filter(word -> !isStopWord(word))
                .collect(Collectors.toList());
    }

    private boolean isStopWord(String word) {
        String[] stopWords = {"tôi", "bạn", "của", "và", "có", "là", "trong", "với", "cho", "về"};
        return List.of(stopWords).contains(word);
    }

    private List<Product> findProductsByKeywords(List<String> keywords) {
        if (keywords.isEmpty()) {
            return List.of();
        }
        
        // Tìm sản phẩm theo tên chứa keywords (chỉ lấy sản phẩm chưa bị xóa)
        return productRepository.findByDeleteFlag(false).stream()
                .filter(product -> {
                    String productName = product.getName() != null ? product.getName().toLowerCase() : "";
                    String categoryName = product.getCategory() != null ?
                            product.getCategory().getName().toLowerCase() : "";
                    String brandName = product.getBrand() != null ?
                            product.getBrand().getName().toLowerCase() : "";

                    return keywords.stream().anyMatch(keyword ->
                            productName.contains(keyword) ||
                            categoryName.contains(keyword) ||
                            brandName.contains(keyword));
                })
                .limit(5) // Giới hạn 5 sản phẩm
                .collect(Collectors.toList());
    }

    private String formatProductResults(List<Product> products) {
        StringBuilder result = new StringBuilder();
        result.append("Tôi tìm thấy ").append(products.size()).append(" sản phẩm:\n\n");
        
        for (int i = 0; i < products.size(); i++) {
            Product product = products.get(i);
            result.append(i + 1).append(". **").append(product.getName()).append("**\n");
            result.append("   📦 Mã: ").append(product.getCode()).append("\n");
            
            if (product.getCategory() != null) {
                result.append("   🏷️ Danh mục: ").append(product.getCategory().getName()).append("\n");
            }
            
            if (product.getBrand() != null) {
                result.append("   🏢 Thương hiệu: ").append(product.getBrand().getName()).append("\n");
            }
            
            result.append("\n");
        }
        
        result.append("Bạn muốn xem chi tiết sản phẩm nào? Hoặc cần tôi tìm thêm sản phẩm khác?");
        return result.toString();
    }

    private String formatPriceResults(List<Product> products) {
        StringBuilder result = new StringBuilder();
        result.append("Thông tin giá sản phẩm:\n\n");
        
        for (Product product : products) {
            result.append("🛍️ **").append(product.getName()).append("**\n");
            
            // Lấy giá từ ProductDetail nếu có
            if (product.getProductDetailList() != null && !product.getProductDetailList().isEmpty()) {
                var productDetail = product.getProductDetailList().get(0);
                if (productDetail.getPrice() != null) {
                    result.append("   💰 Giá: ").append(String.format("%,d", productDetail.getPrice())).append("đ\n");
                }
                if (productDetail.getQuantity() != null) {
                    result.append("   📦 Tồn kho: ").append(productDetail.getQuantity()).append(" sản phẩm\n");
                }
            }
            result.append("\n");
        }
        
        result.append("Bạn có muốn đặt hàng sản phẩm nào không?");
        return result.toString();
    }
}
