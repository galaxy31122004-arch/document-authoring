# Mẫu slide "Kem – xanh ngọc" (báo cáo học thuật)

Người dùng đã duyệt mẫu này cho slide bảo vệ đồ án (bản gốc: deck SMS spam,
https://claude.ai/artifact/FfyySR3KGKL6P6x3Hno91t). Dùng mặc định cho slide báo cáo/bảo vệ khi
người dùng không đưa file mẫu khác. Dựng bằng Artifact type **Slides** của claude.ai (canvas
1920×1080, mỗi slide một file `project/slides/<id>.html`), xuất PPTX/PDF từ nút Export.

## Quy tắc bố cục

- **Khoảng 10 slide, mỗi slide nhiều nội dung**: gộp ý liên quan (bài toán + dữ liệu; tiền xử lý +
  kiến trúc; bổ sung dữ liệu + kiểm thử thủ công). Không dùng slide ngăn phần chỉ có một dòng
  tiêu đề, không slide cảm ơn riêng (gộp vào dải tối cuối slide kết luận).
- Ưu tiên bảng thật, thẻ (card) và số lớn thay cho gạch đầu dòng. Mỗi slide số liệu = bảng + 2–3
  thẻ nhận xét ngắn.
- Bìa và slide chứa phát hiện quan trọng nhất dùng nền tối; các slide khác xen kẽ hai nền sáng.
- Số liệu lấy đúng báo cáo; làm tròn để vừa ô thì nói rõ với người dùng. Ghi chú lời nói đặt trong
  `<aside>` từng slide.

## Thông số

| Mục | Giá trị |
|---|---|
| Phông | Tiêu đề `Lora` 700; thân `Be Vietnam Pro` 400/600 (đủ dấu tiếng Việt). Link: `https://fonts.googleapis.com/css2?family=Lora:wght@500;700&family=Be+Vietnam+Pro:wght@400;600&display=swap` |
| Nền | Sáng `#F7F3EC`, sáng 2 `#EFE8DB`, tối `#1E2B2F`, thẻ trên nền tối `#2A3A3F` |
| Chữ | Đậm `#1E2B2F`, phụ `#55606A`; trên nền tối `#F7F3EC` / `#B9C3C0` |
| Nhấn | Xanh ngọc `#0F766E` (trên nền tối `#7FC8BE`), cam đất `#C2410C` (trên nền tối `#E07A3F`); ô bảng nổi bật `#CDE8E3` |
| Cỡ chữ | Tiêu đề bìa 88; tiêu đề slide 60; số lớn 72; tiêu đề thẻ 28–30; thân 24–26 (không dưới 24) |
| Lề | `padding:112px 128px 160px` |
| Bảng | Hàng tiêu đề nền `#1E2B2F` chữ `#F7F3EC`; hàng xen kẽ `#FFFFFF` / `#EFE8DB`; cỡ 24–26 |
| Thẻ | Nền `#FFFFFF`, `border-radius:12px`, `padding:28–32px`, viền nhấn 8px ở trên hoặc trái |

## Khung lặp lại

Tiêu đề slide (số thứ tự lớn + tên, cùng hàng):

```html
<div style="display:flex;flex-direction:row;align-items:baseline;gap:32px"><p style="font-family:'Lora', Georgia, serif;font-size:60px;font-weight:700;color:#0F766E">05</p><h2 style="font-family:'Lora', Georgia, serif;font-size:60px;font-weight:700;line-height:1.15">Tiêu đề</h2></div>
```

Chân trang (ghim, mọi slide trừ bìa):

```html
<div style="position:absolute;left:128px;right:128px;bottom:64px;height:40px;display:flex;flex-direction:row;justify-content:space-between"><p style="font-size:24px;color:#55606A">Tên đề tài ngắn · Tên sinh viên</p><p style="font-size:24px;color:#55606A">05 / 10</p></div>
```

Bìa: lưới `1fr 520px` — trái là trường/khoa, tên đề tài, sinh viên và giảng viên; phải là 3 thẻ
số liệu tóm tắt có viền trái màu nhấn.

## Lỗi đã gặp

- Nội dung dồn nửa trên, nửa dưới trống: khối nội dung chính (bảng/lưới/hàng thẻ) đặt
  `flex:1;align-items:center` để nằm giữa khoảng còn lại dưới tiêu đề. Không kéo giãn thẻ cho
  đầy (người dùng thấy rối); giữ kích thước tự nhiên và căn giữa.

- Bộ dựng `render_pptx.py` của axon tự cắt ý (dạng metrics giữ 3 ý, cards giữ 4): không dùng
  cho slide nhiều số liệu.
- Hàng chip nhiều mục phải có `flex-wrap:wrap`; số lớn dạng `3.900 / 836 / 836` cần
  `white-space:nowrap` và ô đủ rộng.
- Bảng: mọi hàng phải nằm trên một dòng (số `a → b` và tên mô hình dài). Ô to hơn dùng
  `padding:18px 14px`. Hai bảng cạnh nhau thì lưới `1.25fr 1fr`, bảng hẹp cỡ 26.
- Mẫu xanh dương/trắng đơn giản (theme `light`) và bản 14 slide ít chữ bị người dùng chê "xấu".
