# End-to-End-Customer-Conversion-Funnel-Analysis
Các truy vấn SQL để phân tích quá trình tiến triển của khách hàng và phễu chuyển đổi.Đồng thời lấy dữ liệu để phân tích hành vi khách hàng trên PBi
Tổng Quan: Dự án này xử lý và chuẩn hóa dữ liệu hành trình khách hàng từ giai đoạn tiếp cận (C3) đến khi hoàn thành đóng phí (L8) từ hệ thống CRM. Mục tiêu là tạo ra một cấu trúc dữ liệu sạch, tối ưu để sẵn sàng đối chiếu sử dụng trong Power BI trực tiếp qua Datawarehouse nhằm phân tích hiệu suất phễu marketing.
the Funnel Stages:Hành trình chuyển đổi của khách hàng trải qua các mốc:
**C3 (Để lại SĐT)** → **L3 (Nghe máy)** → **L4** → **L5** → **L6** → **L8 (Đóng full tiền)**
Trọng tâm xử lý kỹ thuật (SQL Logic)
*Dữ liệu thô trong bảng `Customer` có tần suất lặp lại cao và đôi khi bị khuyết thiếu mốc thời gian do lỗi hệ thống. Đoạn script SQL trong repository này giải quyết 3 bài toán lõi:
-Khử trùng lặp dữ liệu (Deduplication):** Sử dụng `ROW_NUMBER() OVER (PARTITION BY... ORDER BY created_at ASC)` để chỉ lọc ra mốc thời gian đầu tiên khách hàng đạt được ở từng cấp độ, loại bỏ hoàn toàn các bản ghi cập nhật trùng lặp phía sau.
-Logic Bù trừ Dữ liệu (Fallback Mechanism):** Ứng dụng hàm `COALESCE` kết hợp với cấu trúc `LEFT JOIN` giữa các bảng tạm (`CTE`). Nếu hệ thống bị sót ngày kích hoạt ở bước trước (ví dụ `L3`), câu lệnh sẽ tự động tìm ngày ở các bước kế tiếp (`L4`, `L5`...) để đảm bảo không bỏ sót khách hàng trong báo cáo tháng.
-Tối ưu cấu trúc cho Downstream (Power BI):** Chuyển đổi dữ liệu từ dạng dọc (Row-based) về dạng phẳng (Flattened Table). Việc này giúp giảm tải tính năng tính toán nặng cho Power BI, giữ cho Data Model nhẹ và tối ưu hóa hiệu suất của các câu lệnh DAX sau này.
Kết quả đầu ra
*   **Tập dữ liệu sạch:** Lọc chính xác danh sách khách hàng thuộc nhóm MKT (`status = 'MOL'`) được kích hoạt trong giai đoạn cụ thể (Tháng 06/2026).
*   **Sẵn sàng trực quan hóa:** Cung cấp data source chuẩn để Power BI tính toán các chỉ số: Tỷ lệ chuyển đổi qua từng bước (Conversion Rate) và Thời gian chuyển đổi trung bình (Velocity).
