package com.example.demo.service;

import com.example.demo.Entity.Bill;
import com.example.demo.Entity.BillDetail;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.format.DateTimeFormatter;

@Service
public class InvoicePdfService {

    public void exportBillToPdf(Bill bill, HttpServletResponse response) throws IOException, DocumentException {
        response.setContentType("application/pdf");
        String headerKey = "Content-Disposition";
        String headerValue = "attachment; filename=invoice_" + bill.getCode() + ".pdf";
        response.setHeader(headerKey, headerValue);

        Document document = new Document(PageSize.A4, 36, 36, 64, 36);
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        // ====== FONT UNICODE ======
        String fontPath = "C:/Windows/Fonts/arial.ttf"; // đổi sang resources/fonts/arial.ttf nếu deploy Linux
        BaseFont bf = BaseFont.createFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

        Font fontTitle = new Font(bf, 18, Font.BOLD, BaseColor.BLUE);
        Font fontNormal = new Font(bf, 11, Font.NORMAL, BaseColor.BLACK);
        Font fontBold = new Font(bf, 12, Font.BOLD, BaseColor.BLACK);

        // ====== HEADER: BEE STORE (trái) + Địa chỉ (phải) ======
        PdfPTable headerTable = new PdfPTable(2);
        headerTable.setWidthPercentage(100);

        PdfPCell leftCell = new PdfPCell(new Phrase("BEE STORE", fontBold));
        leftCell.setBorder(Rectangle.NO_BORDER);
        leftCell.setHorizontalAlignment(Element.ALIGN_LEFT);

        PdfPCell rightCell = new PdfPCell(new Phrase("Địa chỉ: Số 1 Trịnh Văn Bô, Nam Từ Liêm, Hà Nội", fontNormal));
        rightCell.setBorder(Rectangle.NO_BORDER);
        rightCell.setHorizontalAlignment(Element.ALIGN_RIGHT);

        headerTable.addCell(leftCell);
        headerTable.addCell(rightCell);

        document.add(headerTable);

        // ====== TIÊU ĐỀ HÓA ĐƠN ======
        Paragraph title = new Paragraph("HÓA ĐƠN BÁN HÀNG", fontTitle);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);

        document.add(new Paragraph(" ", fontNormal));

        // ====== THÔNG TIN HÓA ĐƠN ======
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        document.add(new Paragraph("Mã hóa đơn: " + bill.getCode(), fontNormal));
        document.add(new Paragraph("Ngày tạo: " +
                (bill.getCreateDate() != null ? bill.getCreateDate().format(fmt) : ""), fontNormal));
        document.add(new Paragraph("Loại hóa đơn: " +
                (bill.getInvoiceType() != null ? bill.getInvoiceType() : ""), fontNormal));
        document.add(new Paragraph("Phương thức thanh toán: " +
                (bill.getPaymentMethod() != null ? bill.getPaymentMethod().getName() : ""), fontNormal));
        document.add(new Paragraph("-------------------------------------------------------------", fontNormal));

        // ====== BẢNG SẢN PHẨM ======
        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100f);
        table.setSpacingBefore(10);
        table.setWidths(new float[]{3f, 1f, 1.5f, 2f, 2f});

        addTableHeader(table, "Sản phẩm", fontBold);
        addTableHeader(table, "SL", fontBold);
        addTableHeader(table, "Giá", fontBold);
        addTableHeader(table, "Màu", fontBold);
        addTableHeader(table, "Thành tiền", fontBold);

        for (BillDetail detail : bill.getBillDetails()) {
            String productName = detail.getProductName() + " " + detail.getProductSize();
            table.addCell(new Phrase(productName, fontNormal));
            table.addCell(new Phrase(String.valueOf(detail.getQuantity()), fontNormal));
            table.addCell(new Phrase(String.format("%,.0f đ", detail.getMomentPrice()), fontNormal));
            table.addCell(new Phrase(detail.getProductColor(), fontNormal));
            table.addCell(new Phrase(String.format("%,.0f đ", detail.getTotalPrice()), fontNormal));
        }

        document.add(table);

        // ====== TỔNG KẾT ======
        document.add(new Paragraph(" ", fontNormal));
        document.add(new Paragraph("Tổng cộng: " + String.format("%,.0f đ", bill.getAmount()), fontBold));

        if (bill.getPromotionPrice() != null && bill.getPromotionPrice() > 0) {
            document.add(new Paragraph("Giảm giá: -" + String.format("%,.0f đ", bill.getPromotionPrice()), fontBold));
        }

        document.add(new Paragraph("Khách cần trả: " + String.format("%,.0f đ", bill.getFinalAmount()), fontBold));

        document.add(new Paragraph(" ", fontNormal));

        // ====== FOOTER ======
        Paragraph footer1 = new Paragraph("Cảm ơn quý khách! Hẹn gặp lại!", fontNormal);
        footer1.setAlignment(Element.ALIGN_CENTER);
        document.add(footer1);

        Paragraph footer2 = new Paragraph("Hotline: 037 222 6880", fontBold);
        footer2.setAlignment(Element.ALIGN_CENTER);
        document.add(footer2);

        document.close();
    }

    private void addTableHeader(PdfPTable table, String title, Font font) {
        PdfPCell header = new PdfPCell(new Phrase(title, font));
        header.setBackgroundColor(BaseColor.LIGHT_GRAY);
        header.setHorizontalAlignment(Element.ALIGN_CENTER);
        header.setPadding(5);
        table.addCell(header);
    }
}
