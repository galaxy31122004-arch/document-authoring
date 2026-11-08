# Dựng công thức thành biểu thức Word

Áp dụng khi tài liệu có phân số, căn, tổng, hệ phương trình hoặc chỉ số. Mục tiêu: công thức là
**đối tượng Equation của Word**, sửa được, có gạch phân số ngang — không phải `a/b`, không phải ảnh.

## Quy trình

1. Chuyển công thức nguồn sang **UnicodeMath**, dạng tuyến tính mà Word dựng được:
   `(tử)/(mẫu)` phân số, `x_(i,j)` chỉ số dưới, `x^(2)` chỉ số trên, `√(x)` căn,
   `∑_(i=1)^(n)` tổng, `{■(dòng1@dòng2)┤` hệ phương trình, `"chữ"` cho phần chữ đứng.
   Dấu ngoặc tròn bọc trọn tử, mẫu hoặc đối số sau `_`, `^`, `√` là ngoặc gom, Word không in ra.
   **Không dùng ngoặc nhọn `{}` để gom**: Word in nguyên `{1}` lên trang.
   Hàm áp lên phân số (`\log\frac{a}{b}`) viết `log((a)/(b))`; viết trần thì log chỉ áp cho tử.
   Không dùng `▒〖〗`: Word nuốt tab và dấu `(` của số hiệu công thức, và in `log` nghiêng.
   Khoảng cách `\quad` đổi thành em space `U+2003`; dấu cách thường bị Word gộp mất.
2. Đặt chuỗi đó vào tài liệu, bọc giữa hai ký tự mốc thuộc vùng dùng riêng (`U+E000`, `U+E001`).
3. Mở bằng Word COM, **đánh dấu bookmark** vùng công thức (không gồm ký tự mốc) trước khi sửa gì.
4. `doc.OMaths.Add(range)` cho từng bookmark, rồi `doc.OMaths.BuildUp()` một lần cho cả tập.
5. Xóa ký tự mốc, xóa bookmark, lưu và đóng.
6. **Mở lại tài liệu** rồi mới cập nhật trường và dàn trang.

## Năm lỗi đã gặp, phải tránh

- `OMaths.Add` trả về đối tượng COM **không gọi được** `BuildUp` qua PowerShell. Dùng
  `doc.OMaths.Item(i).BuildUp()` hoặc `doc.OMaths.BuildUp()` cho cả tập.
- Tính vị trí ký tự để cắt mốc bị lệch khi đoạn có hình, trường hoặc công thức. Dùng bookmark;
  Word tự dời bookmark khi nội dung đổi.
- `Find` của Word **không khớp ký tự vùng dùng riêng**. Xóa mốc bằng cách duyệt
  `Range.Characters` từ cuối về đầu rồi `Delete()` từng ký tự khớp.
- Sau khi sửa công thức, `doc.Fields` trên cùng handle có thể trả `null`. Lưu, đóng, mở lại
  tài liệu rồi mới `Fields.Update()` và cập nhật mục lục.
- Phân số **trong dòng văn** dựng dạng hai tầng sẽ kéo giãn dòng chữ. Dùng dấu chia `U+2215`
  cho công thức trong dòng, trừ khi công thức đã có phần cao sẵn (`√`, `∑`, `∏`, `∫`, hệ phương
  trình) — khi đó dạng hai tầng lại dễ đọc hơn.

## Nhận diện công thức trong văn bản Markdown

- `$...$` một ký hiệu như `$V$`, `$t$` **vẫn là công thức**, không chứa toán tử nào. Đừng nhận
  diện bằng cách tìm `=`, `_`, `^` hay `\`: `$V$` sẽ bị bỏ sót và in ra nguyên dấu đô la.
- Phân biệt với hai dấu đô la tiền tệ trong một câu bằng **khoảng trắng**: nội dung công thức
  không có khoảng trắng, hoặc có lệnh bắt đầu bằng `\`; còn `$300 cho tiền nhà $` thì có.
- Tách phần mã trong dấu `` ` `` **trước** khi tìm công thức, để `$<MONEY>` không bị hiểu nhầm.

## Kiểm tra bắt buộc sau khi dựng

- **Nhìn trang thật**: xuất vài trang có công thức ra PDF bằng Word (`ExportAsFixedFormat`,
  dải trang), render bằng PyMuPDF rồi xem ảnh. Đếm `OMaths` đúng vẫn có thể sai hình thức
  (ngoặc nhọn bị in, log áp sai phạm vi, số hiệu bị nuốt) — ba lỗi này chỉ thấy khi nhìn trang.

- Không còn dấu `\` theo sau là chữ cái trong văn xuôi: nghĩa là còn lệnh LaTeX chưa chuyển
  (`\mathbb{R}`, `\phi`, `\nabla`, `\{`). Quét cả bản thảo trước khi dựng và báo lỗi, đừng để
  lọt vào bản Word.
- Không còn ký tự mốc `U+E000`/`U+E001`.
- `doc.OMaths.Count` bằng đúng số công thức đã đánh dấu.
