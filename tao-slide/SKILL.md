---
name: tao-slide
description: Tạo bộ slide MỚI (báo cáo, bảo vệ đồ án, thuyết trình) khi người dùng không đưa file PowerPoint mẫu. Dựng trên claude.ai Slides theo mẫu đã duyệt "Kem – xanh ngọc", khoảng 10 slide nhiều nội dung, xuất PPTX/PDF. Có file mẫu PPTX thì dùng presentation-from-reference.
---

# Tạo slide mới

> **Bắt buộc:** tuân theo cấu trúc workspace của skill `structured-workspace` (workspace chưa có thì dựng trước), kể cả quy tắc tải về ổ D và không xoá file dự án. Mọi bản giao phải có phiên bản `vX.Y.Z` trong `versions/presentations/<topic>/v<X.Y.Z>/` (mục 4).

Quy tắc rút ra từ deck đồ án SMS spam (06/11/2026) mà người dùng đã sửa qua nhiều vòng.

## 1. Quy trình

1. Đọc tài liệu nguồn (báo cáo, kết quả); mọi số liệu phải lấy đúng nguồn, không tự bịa.
2. Viết dàn ý Markdown, gửi người dùng duyệt trước khi dựng.
3. Dựng bằng Artifact type **Slides** của claude.ai (`quickstart` intent `slides`). Không dùng
   `render_pptx.py` của axon cho deck nhiều số liệu (nó tự cắt ý) và không dùng theme xanh–trắng
   đơn giản (người dùng chê xấu).
4. Áp mẫu trong
   [mau-kem-xanh-ngoc.md](../presentation-from-reference/references/mau-kem-xanh-ngoc.md):
   màu, phông, cỡ chữ, khung tiêu đề, chân trang, bìa.
5. Gửi link; khi người dùng chốt, xuất PPTX và lưu phiên bản theo mục 4.

## 2. Bố cục

- Người dùng đã đổi ý từ 10 lên 17 slide ("thêm nội dung thành 17 slide, đừng làm thưa quá"):
  hỏi số slide mong muốn; khi tăng số slide thì thêm nội dung có nguồn (lọc dữ liệu, cấu hình,
  phân tích lỗi), mỗi slide vẫn dày, không chỉ tách slide cũ cho thưa ra.
- **Mặc định khoảng 10 slide, mỗi slide nhiều nội dung.** Gộp ý liên quan; không slide ngăn phần chỉ có
  một dòng; lời cảm ơn gộp vào cuối slide kết luận.
- Ưu tiên bảng thật, thẻ, số lớn, sơ đồ luồng thay cho gạch đầu dòng. Slide số liệu = bảng + 2–3
  thẻ nhận xét.
- **Không để nửa dưới trống:** khối nội dung chính đặt `flex:1;align-items:center` (hoặc
  `justify-content:center` cho cột) để nằm giữa phần còn lại dưới tiêu đề. Không kéo giãn thẻ
  cho đầy — người dùng thấy rối.
- **Không để chữ nhỏ khi slide còn chỗ:** bảng 26–28px, tiêu đề khối 30–34px, đoạn nhận xét
  26–27px. 24px chỉ dùng khi slide thật sự chật.
- Ô số liệu dạng `96,8 → 95,4` không được xuống dòng: tính độ rộng cột ≈ 0,6 × cỡ chữ × số ký
  tự + đệm; thiếu thì nới cột đó (lưới `1.3fr 1fr`), rút gọn tiêu đề cột, giảm 2px cỡ chữ bảng.
- **Mọi hàng bảng nằm trên một dòng**, kể cả cột tên: cột đầu phải đủ rộng cho tên dài nhất
  (ví dụ "Transformer aug." ở cỡ 26 cần ~49% bảng hẹp). Hai bảng cạnh nhau: kiểm tra cả hai,
  chỉnh tỉ lệ lưới (`1.25fr 1fr`) và cỡ chữ từng bảng riêng.
- Người dùng bảo sửa một bảng (ví dụ "cho ô to ra" ở bảng trái) thì chỉ sửa bảng đó; bảng kia
  giữ nguyên như cũ.
- Slide còn thoáng: thêm nội dung có nguồn (dòng chú thích kỹ thuật, khung nền tối bao sơ đồ),
  không thêm chữ lấp chỗ.
- Bìa và slide phát hiện quan trọng nhất dùng nền tối; các slide khác xen kẽ hai nền sáng.
- Ghi chú lời nói trong `<aside>` từng slide.

## 3. Báo cáo với người dùng

- Nói rõ chỗ nào đã làm tròn số hoặc tự tính từ số liệu gốc.
- Chưa tự xem bản dựng thì nói chưa xem; mời người dùng chỉ số slide cần chỉnh.
- Sửa theo từng slide người dùng nêu (ví dụ "slide 8 nhỏ", "slide 9 thoáng"), chỉ đổi slide đó.
- Mỗi lỗi bố cục mới gặp: ghi thêm vào mục 2 của file này.

## 4. Phiên bản

Nháp (dàn ý, file slide của deck) đặt trong `sandbox/presentations/<topic>/` theo `structured-workspace`. Bản chốt chép sang
`versions/presentations/<topic>/v<X.Y.Z>/` gồm `<topic>_v<X.Y.Z>.pptx`, `NOI_DUNG.md`,
`KICH_BAN_THUYET_TRINH.md`. Không ghi đè phiên bản đã giao; sửa nhỏ tăng PATCH, sửa một phần
tăng MINOR, đổi cả mạch tăng MAJOR.
