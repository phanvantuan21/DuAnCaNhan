package com.example.demo.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.client.RestClientException;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.Map;
import java.util.List;

@Service
public class GeminiService {

    private static final Logger log = LoggerFactory.getLogger(GeminiService.class);

    @Value("${gemini.api.key}")
    private String apiKey;

    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;

    public GeminiService() {
        // Tạo RestTemplate với timeout
        SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
        factory.setConnectTimeout(5000); // 5 seconds
        factory.setReadTimeout(10000);   // 10 seconds

        this.restTemplate = new RestTemplate(factory);
        this.objectMapper = new ObjectMapper();
    }
    
    public String generateResponse(String prompt) {
        try {
            // Sử dụng API v1beta với model mới nhất
            String url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=" + apiKey;

            // Tạo headers
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            // Tạo request body
            String requestBody = buildRequestBody(prompt);

            // Tạo HTTP entity
            HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

            // Gọi API
            ResponseEntity<String> response = restTemplate.exchange(
                url,
                HttpMethod.POST,
                entity,
                String.class
            );

            return extractTextFromResponse(response.getBody());

        } catch (RestClientException e) {
            log.error("Error calling Gemini API: {}", e.getMessage());
            // Thử fallback với model khác
            return tryFallbackModels(prompt);
        } catch (Exception e) {
            log.error("Unexpected error calling Gemini API", e);
            return "Có lỗi xảy ra khi xử lý yêu cầu của bạn.";
        }
    }

    private String tryFallbackModels(String prompt) {
        String[] models = {
            "gemini-1.5-flash-latest",
            "gemini-1.5-pro-latest",
            "gemini-pro"
        };

        for (String model : models) {
            try {
                String url = "https://generativelanguage.googleapis.com/v1beta/models/" + model + ":generateContent?key=" + apiKey;

                HttpHeaders headers = new HttpHeaders();
                headers.setContentType(MediaType.APPLICATION_JSON);
                String requestBody = buildRequestBody(prompt);
                HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

                ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
                return extractTextFromResponse(response.getBody());

            } catch (Exception e) {
                log.warn("Model {} failed, trying next...", model);
            }
        }

        return "Xin lỗi, tôi không thể kết nối đến dịch vụ AI lúc này. Vui lòng thử lại sau.";
    }
    
    private String buildRequestBody(String prompt) {
        try {
            Map<String, Object> requestBody = Map.of(
                "contents", List.of(
                    Map.of("parts", List.of(
                        Map.of("text", prompt)
                    ))
                )
            );
            return objectMapper.writeValueAsString(requestBody);
        } catch (Exception e) {
            throw new RuntimeException("Error building request body", e);
        }
    }
    
    private String extractTextFromResponse(String response) {
        try {
            JsonNode jsonNode = objectMapper.readTree(response);
            JsonNode candidates = jsonNode.get("candidates");
            
            if (candidates != null && candidates.isArray() && candidates.size() > 0) {
                JsonNode firstCandidate = candidates.get(0);
                JsonNode content = firstCandidate.get("content");
                
                if (content != null) {
                    JsonNode parts = content.get("parts");
                    if (parts != null && parts.isArray() && parts.size() > 0) {
                        JsonNode firstPart = parts.get(0);
                        JsonNode text = firstPart.get("text");
                        if (text != null) {
                            return text.asText();
                        }
                    }
                }
            }
            
            return "Xin lỗi, tôi không thể tạo phản hồi phù hợp.";
            
        } catch (Exception e) {
            log.error("Error parsing Gemini response", e);
            return "Có lỗi xảy ra khi xử lý phản hồi.";
        }
    }
}
