---
name: document-authoring
description: Use to format or restructure an editable Word document, or create one from content and structure explicitly supplied or approved by the user. For requested multi-part writing, plan in two Markdown files and obtain section-by-section approval before assembling the DOCX with Word MCP. Does not apply to slides or standalone web pages.
---

# Định dạng và soạn tài liệu Word

> **Bắt buộc:** tuân theo cấu trúc workspace của skill `structured-workspace` (workspace chưa có thì dựng trước). Mọi bản giao phải có phiên bản `vX.Y.Z` trong `versions/documents/<ten>/v<X.Y.Z>/`, không có bản giao nào không đánh số.

Tạo hoặc chỉnh tài liệu `.docx` rõ ràng, dễ đọc và chỉnh sửa được. Mặc định skill xử lý hình thức, bố cục và thao tác Word; không tự quyết định nội dung, tên chương hoặc loại báo cáo. Chỉ soạn hay sửa nội dung khi người dùng yêu cầu, theo cấu trúc và dữ liệu họ cung cấp hoặc duyệt. Không lấy nội dung của tài liệu mẫu làm dữ liệu cho tài liệu mới.

## Nguyên tắc chung

- **Không bịa dữ liệu.** Phân biệt dữ liệu gốc, nhận xét, suy luận và đề xuất. Không tự tạo tên người, chức danh, địa chỉ, ngày tháng, thông số, kết quả hoặc trích dẫn. Thiếu thông tin quan trọng thì hỏi, hoặc dừng phần phụ thuộc thông tin đó; không điền đại.
- **Bản nộp sạch.** Không chứa chỗ trống, placeholder, lời nhắc biên tập, đường dẫn nội bộ hay câu tự giải thích cách kiểm chứng.
- **Nguồn.** Ghi nguồn và trích dẫn theo quy định của loại tài liệu/mẫu áp dụng. Hình từ nguồn ngoài phải có nguồn bắt buộc, kể cả khi tài liệu mẫu từng dùng ảnh tự chụp. Với ảnh/dữ liệu người dùng cung cấp, giữ dấu vết xuất xứ trong hồ sơ làm việc; không lặp dòng nguồn dài dưới mọi hình khi không được yêu cầu.
- **Không im lặng = đồng ý.** Ảnh bìa, nội dung và bản cuối đều cần xác nhận rõ.

## 1. Thông tin đầu vào

Ví dụ yêu cầu: `/document-authoring lập đề xuất dự án từ các tài liệu trong thư mục này`.

Đọc chỉ dẫn workspace, mẫu chính thức và tài liệu nguồn trước. Xác định các thông tin sau từ lời nhắn và tệp đã có; chỉ hỏi những gì còn thiếu và ảnh hưởng đến bước đang làm:

- Loại tài liệu, mục đích, người đọc, ngôn ngữ, phạm vi và kết quả mong muốn.
- Mẫu/quy định phải theo, thời hạn, định dạng bàn giao và cách dẫn nguồn. Chỉ hỏi số trang mục tiêu nếu người dùng muốn đặt; không mặc định độ dài.
- Nếu có mẫu hình thức, xác định phạm vi cần giống: toàn bộ tài liệu, chỉ bìa, mục lục, bảng, khung, hay một số trang.
- Tài liệu nguồn, dữ liệu, ảnh, bảng, logo được phép dùng; thông tin nào đã xác nhận và thông tin nào cần hỏi.
- Các phần/chương bắt buộc. Nếu nhiệm vụ gồm soạn nội dung, hỏi mức độ viết cho từng phần: `khái quát` (ý chính), `vừa đủ` (ý chính kèm giải thích và căn cứ), `chuyên sâu` (phân tích và đối chiếu có nguồn), hoặc `tùy chỉnh`. Mức độ viết không tự quy đổi thành số trang.
- Bìa có cần không; **ảnh bìa** chọn một trong ba cách: không dùng ảnh, dùng ảnh người dùng cung cấp, hoặc tìm/tạo ảnh khi được cho phép. Bìa không ảnh vẫn có thể có logo và chữ. Nếu dùng ảnh, hỏi tệp/đề tài, quyền sử dụng và yêu cầu cắt/căn chỉnh. Không tự đặt logo, người, địa điểm hay nhận diện tổ chức.
- Báo cáo học thuật tại Trường Đại học Quy Nhơn: dùng [mẫu bìa Quy Nhơn](references/qnu-cover.md) khi người dùng yêu cầu hoặc mẫu chính thức cho phép; thay chủ đề và thông tin mới, không sao chép nội dung báo cáo cũ. Tài liệu thuộc đơn vị khác dùng mẫu phù hợp với đơn vị đó.

Không ép người dùng điền đủ mọi mục ngay từ đầu. Ghi các điểm chưa rõ vào tệp yêu cầu thông tin, hỏi theo ưu tiên và tiếp tục phần việc không phụ thuộc câu trả lời.

Chọn bố cục theo loại tài liệu và yêu cầu cụ thể; không ép mọi tài liệu thành bốn chương, một số trang cố định hoặc một kiểu bìa. **Khi chỉ chỉnh form**, giữ nguyên nội dung và cấu trúc trừ phần được yêu cầu đổi, sửa trực tiếp bản Word sau khi xác định mẫu hình thức; không cần hai tệp kế hoạch hay duyệt từng chương.

## 2. Quy trình cho tài liệu mới nhiều phần

Áp dụng khi người dùng yêu cầu **soạn nội dung mới hoặc sửa nội dung nhiều phần**.

1. Nếu có mẫu hình thức, đọc [quy trình đo và tái tạo hình thức](references/visual-layout.md) trước khi chốt dàn ý; ghi thông số và phạm vi áp dụng vào tệp cấu trúc tổng thể.
2. **Tệp Markdown thứ nhất: cấu trúc tổng thể** (ví dụ `01-cau-truc-tong-the.md`). Ghi mục tiêu tài liệu; người đọc; quy định/mẫu áp dụng; mục lục dự kiến; mục tiêu, ý chính, độ dài tương đối và đầu ra của từng chương/phần lớn; kế hoạch hình/bảng/phụ lục; quyết định về bìa và ảnh bìa. Đây là dàn ý để duyệt, chưa phải văn bản hoàn chỉnh.
3. **Tệp Markdown thứ hai: yêu cầu thông tin và độ sâu** (ví dụ `02-yeu-cau-thong-tin.md`). Với mỗi chương/phần lớn: mục tiêu; ý bắt buộc; mức độ viết đã chọn; số trang mục tiêu nếu có; dữ liệu/nguồn/hình đã có; thông tin còn thiếu; câu hỏi ưu tiên; trạng thái duyệt. Không mặc định các phần dài bằng nhau.
4. Gửi đường dẫn **cả hai tệp** để người dùng xem và sửa. Chỉ viết phần đầu tiên khi cấu trúc và mức độ liên quan đã được xác nhận. Nếu có thay đổi, cập nhật hai tệp và xin duyệt phần thay đổi trước khi viết tiếp.
5. Viết từng chương/phần lớn vào tệp Markdown riêng theo thứ tự đã duyệt. Gửi bản vừa viết để kiểm tra; sửa đến khi được xác nhận rồi mới chuyển phần kế tiếp. Tài liệu không chia chương dùng đơn vị duyệt tương đương (mục lớn hoặc nhóm mục). Không soạn hàng loạt phần chưa duyệt.
6. Khi toàn bộ nội dung đã duyệt, ghép và định dạng `.docx` theo mẫu bằng Word MCP. Gửi bản Word để duyệt hình thức; chỉnh theo phản hồi. Khi Word được xác nhận đạt, tạo phiên bản giao trong `versions/documents/<ten>/v<X.Y.Z>/` kèm PDF cùng tên (mục 3). Chỉ tạo ảnh bìa riêng, cài skill hoặc đăng tải tệp khi được yêu cầu/cho phép.

Hai tệp kế hoạch là tài liệu làm việc: cập nhật khi phạm vi đổi, giữ trạng thái duyệt rõ ràng, không chèn nội dung của chúng vào bản nộp.

## 3. Thư mục và phiên bản

Trong workspace theo `structured-workspace` (trừ khi mẫu chính thức hoặc quy ước sẵn có quy định khác):

```text
documents/sources/<topic>/        Đầu vào gốc kèm ghi chú .md (giữ tên tệp gốc)
documents/<ten>/                  Tài liệu đang soạn
  01-cau-truc-tong-the.md
  02-yeu-cau-thong-tin.md
  figures/                        Hình dựng/xử lý, không trộn với tệp nguồn
  drafts/                         Bản Word đang làm và bản gửi duyệt
versions/documents/<ten>/v<X.Y.Z>/
  <ten>_v<X.Y.Z>.docx             Bản đã giao
  <ten>_v<X.Y.Z>.pdf
```

- Khi người dùng xác nhận bản Word đạt, chép DOCX sang thư mục phiên bản mới và xuất PDF cùng tên cạnh nó. Không sửa trực tiếp trong `versions/`; không ghi đè phiên bản đã giao.
- Đánh số bắt đầu `1.0.0`, so với bản giao gần nhất: sửa nhỏ/định dạng tăng PATCH; sửa hoặc bổ sung một phần nội dung tăng MINOR và reset PATCH; đổi mục tiêu hoặc cấu trúc toàn bộ tăng MAJOR và reset hai số sau. Bản gửi duyệt trong `drafts/` không tính là phiên bản.
- Không tạo `final/`; giữ nguyên `final/` hoặc bản lịch sử chưa đánh số có sẵn, không đánh số lại khi chưa được yêu cầu.
- Tài liệu đơn lẻ ngoài workspace có cấu trúc thì không ép bố cục này; lưu bản mới cạnh bản gốc với tên rõ ràng.

Trước khi di chuyển tệp có sẵn, liệt kê và kiểm tra các tham chiếu đến đường dẫn của chúng. Sau khi di chuyển, cập nhật rule dự án, liên kết README và đường dẫn làm việc; kiểm tra lại DOCX và bản xuất ở vị trí mới. Không sắp xếp lại dự án không liên quan hoặc áp thư mục cho một tài liệu đơn giản.

## 4. Viết và tổ chức nội dung

- Lập dàn ý trước khi dàn trang. Đặt thông tin chính ở đầu mục, mỗi đoạn một ý, chuyển ý rõ ràng. Thuật ngữ, đơn vị, tên riêng và viết tắt nhất quán.
- Triển khai theo dàn ý và độ sâu đã duyệt; không mặc định các mục như công việc đã làm, kết quả thực nghiệm hoặc kiến nghị cho mọi báo cáo.
- Viết số liệu cùng đơn vị và điều kiện áp dụng. Không biến ảnh, slide hoặc nhận xét cá nhân thành kết quả đo hay thông số sản phẩm. Chi tiết chưa chắc chắn thì tìm nguồn, hỏi hoặc lược bỏ.
- Ký hiệu toán học/kỹ thuật (tần số, chu kỳ, điện áp, chỉ số bit) dùng subscript/superscript thật của Word (`f` với `CK` ở chỉ số dưới, `2` với `4` ở chỉ số trên). Không để dạng gõ tạm `f_CK`, `T_bit`, `T_seq` trong bản nộp. Dùng Word MCP `format_math_expression` hoặc `format_math_expression_in_table_cell` với cú pháp `f_{CK}`, `b_{k-1}`, `x^{2}`; rà toàn tài liệu, kể cả ô bảng, tìm dấu `_` còn sót và kiểm tra lại sau khi lưu.
- Công thức có phân số, căn, tổng hoặc hệ phương trình phải là **biểu thức Word thật**, không viết `a/b`, `sqrt(x)` hay dán ảnh: xem [quy trình dựng công thức](references/cong-thuc-word.md) để biết cú pháp UnicodeMath, cách gọi Word COM, năm lỗi đã gặp và các bước kiểm tra. Một ký hiệu đơn như `$V$` cũng là công thức; nhận diện công thức bằng khoảng trắng, không bằng toán tử.
- Cân đối độ dài bằng nội dung có ích. Không dùng câu lặp, ảnh trùng, ngắt trang tùy tiện hoặc dòng trống để đạt số trang.

## 5. Cấu trúc Word

- Chỉ thêm các phần phù hợp: bìa, thông tin phát hành, lời cảm ơn/tóm tắt, mục lục, danh mục hình/bảng/từ viết tắt, nội dung chính, kết luận, tài liệu tham khảo, phụ lục. Giữ đúng thứ tự của mẫu chính thức khi có.
- Dùng `Heading 1`, `Heading 2`, `Heading 3` cho tiêu đề tương ứng; đánh số chương/mục nhất quán nếu cần. Màu tiêu đề theo mẫu; kiểm tra màu kế thừa từ style cũ, không để màu xanh mặc định của Word.
- **Mỗi chương (`Heading 1`) luôn bắt đầu ở đầu trang mới.** Đặt bằng thuộc tính `Page break before` của style `Heading 1`, không chèn ngắt trang thủ công hay dòng trống. Kiểm tra không sinh trang trắng (ví dụ ngắt trang thủ công còn sót ngay trước chương). Mục con (`Heading 2`, `Heading 3`) không tự sang trang; dùng `keep with next` để tiêu đề không đứng lẻ cuối trang.
- Mục lục sinh từ tiêu đề thật bằng trường Word, có phân cấp, chấm dẫn và số trang căn phải khi phù hợp. Sau khi sửa bố cục, cập nhật mục lục và kiểm tra vài mục đầu, giữa, cuối. Không tin số trang lưu sẵn trong DOCX nếu Word chưa dàn trang lại.
- Danh mục viết tắt chỉ chứa thuật ngữ thực sự dùng; có thể dùng bảng ba cột: viết tắt, tên đầy đủ, nghĩa/giải thích. Cho trang riêng khi độ dài và mẫu cần.
- Báo cáo đồ án môn học của Trường Đại học Thủ Đô Hà Nội: lấy [thông số và bìa mẫu nhóm](references/bao-cao-dh-thu-do.md) làm chuẩn (Times New Roman 14, bìa chữ không khung, heading đánh số căn trái).
- Báo cáo trong workspace này theo NCKH: lấy [thông số heading và danh sách NCKH](references/nckh-headings.md) làm chuẩn. Ý chính dùng dấu `-`; ý phụ dùng dấu `+` và thụt sâu hơn; không dùng dấu tròn mặc định.

## 6. Bìa, trang, chân trang và giãn dòng

- Bìa chỉ dùng khi loại tài liệu hoặc mẫu yêu cầu. Đặt tên cơ quan/đơn vị, tên tài liệu, tiêu đề/đề tài, người lập và ngày/phiên bản theo thông tin đã xác nhận; không để lại chữ mẫu.
- Logo đúng nguồn, giữ tỷ lệ. Khung bìa đặt theo khổ giấy thay vì lề đoạn; chừa mép đóng gáy để khung không bị che; chữ và logo cân đối trong khung. Ảnh bìa xuất riêng, nếu được yêu cầu, phải khớp bản Word.
- Ưu tiên phông, khổ giấy, lề và giãn dòng của mẫu. Khi không có mẫu, tài liệu học thuật tiếng Việt thường dùng A4, Times New Roman cỡ 13, lề trái rộng hơn lề phải; không áp các giá trị này cho mọi loại tài liệu.
- Cấu hình giãn dòng cho **mọi vùng có chữ**, kể cả ô bảng, bìa, mục lục, phần ký và chú thích. Đổi cỡ chữ, chiều cao hàng hay khoảng cách đoạn không thay cho giãn dòng. Đo và ghi riêng `line spacing`, `Space Before`, `Space After` cho từng vai trò; kiểm tra lại các ô có chữ nhiều dòng.
- Chân trang ngắn, cùng cỡ chữ với trường số trang. Dùng trường `PAGE` thật; ẩn hoặc đổi cách đánh số trên bìa/trang đầu theo mẫu.
- Khi người dùng yêu cầu giống một tài liệu mẫu về **hình thức**, bắt buộc đọc [quy trình đo và tái tạo hình thức](references/visual-layout.md) trước khi sửa Word. Ghi kích thước khung, khoảng cách hàng, cỡ chữ và thiết lập từng section bằng số đo thực tế; giữ nguyên file mẫu hoặc chỉ đổi lề chưa phải là đã dàn trang xong.

## 7. Hình, bảng và chú thích

- Chỉ chèn hình/bảng giúp hiểu một nội dung cụ thể, đặt gần đoạn dẫn chiếu. Giữ tỷ lệ ảnh, đủ rõ khi xem/in, không cắt mất thông tin quan trọng.
- Đánh số và chú thích nhất quán, ví dụ `Hình 3. Sơ đồ kết nối các khối.`, `Bảng 2. Đối chiếu thông số.` Chú thích mô tả ngắn nội dung hình; không thêm suy đoán, lời phủ định dài hay ghi chú biên tập. Giữ hình và chú thích cùng trang.
- Đồ thị dạng sóng do tác giả dựng: chú thích gọi tên tín hiệu, kênh hoặc khối; tránh cụm như `mô phỏng lý thuyết`, `đầu ra lý tưởng` trong chú thích, giải thích bản chất hình ở đoạn dẫn. Không mô tả hình dựng như ảnh chụp phép đo thực tế.
- Ảnh thực nghiệm: ưu tiên một ảnh một chú thích thành khối riêng; chỉ đặt hai ảnh cạnh nhau khi cần so trực tiếp và chữ vẫn rõ ở cỡ in. Không dồn ảnh vào bảng để tiết kiệm trang. Trước khi chú thích, đối chiếu ảnh gốc, kênh đo, vị trí trong quy trình và phần tương ứng; không gán chi tiết ảnh không chứng minh được. Không lặp cùng ảnh dưới tên khác.
- Bảng dùng cấu trúc bảng thật, có đường kẻ và khoảng đệm đủ thoáng, hàng tiêu đề rõ, cỡ chữ dễ đọc. Tránh vỡ hàng qua trang; lặp hàng tiêu đề khi bảng dài.
- Mặc định bảng chữ đen nền trắng toàn bộ, kể cả hàng tiêu đề. Chỉ dùng nền màu khi người dùng/mẫu yêu cầu rõ, và kiểm tra tương phản khi in đen trắng.
- Bảng tóm tắt trong báo cáo học thuật theo đúng kiểu bảng của mẫu (ví dụ kẻ mảnh, nền trắng, hàng đầu đậm); không tự thêm nền đậm hay màu xen kẽ. Mỗi ô một ý chính; độ rộng cột theo lượng chữ, hàng tự giãn.
- Sau khi Word dàn trang, kiểm tra phần trống cuối từng trang, nhất là trang có ảnh. Nếu trống lớn mà nội dung tiếp tục ở trang sau, kiểm tra ảnh trùng, đoạn rỗng, ngắt trang và kích thước ảnh; chuyển ảnh đúng mục, xóa đoạn rỗng thừa hoặc thu ảnh vừa đủ để chữ trên ảnh vẫn đọc được. Không ép mỗi ảnh sang một trang riêng. Khoảng trống cuối trang ngay trước một chương mới là bình thường.

## 8. Dùng Word MCP

- Khi `mcp__word_document_server` có sẵn, **luôn dùng MCP làm đường chính**: `get_document_info`, `get_document_outline`, `get_document_text` để đọc; `copy_document` để tạo bản làm việc; lệnh MCP phù hợp để sửa và đọc lại kết quả. Dùng đường dẫn đầy đủ và lưu bản mới có tên rõ ràng.
- Mã nguồn Word MCP nằm trong `word-mcp/` của cùng repo. Khi thêm/sửa lệnh MCP, chỉnh tại đây, chạy kiểm thử và khởi động lại MCP để nhận mã mới; commit skill và MCP trong cùng repo.
- Nếu MCP không có lệnh cho thuộc tính cần sửa (giãn dòng, neo khung bìa, mục lục, trường số trang), dùng Word/OOXML **chỉ cho thuộc tính đó**; sau đó đọc lại bằng MCP và kiểm tra cấu trúc DOCX. Không dùng tự động hóa giao diện hay ảnh chụp màn hình thay cho MCP. Sau thao tác mở/lưu, xác nhận các trường động như `PAGE` và mục lục vẫn còn.
- **Phối hợp với chỉnh tay trong Word.** Trước mỗi lần sửa bằng MCP, đọc lại tệp (`get_document_text`/`get_document_outline`) thay vì dựa vào nội dung đã đọc trước đó; người dùng có thể đã chỉnh tay. Giữ nguyên các chỗ người dùng đã sửa trừ khi được yêu cầu đổi. Nếu tệp đang mở trong Word (có tệp khóa `~$<tên>.docx` cạnh nó), nhắc người dùng lưu và đóng trước; không ghi vào tệp đang mở.
- `get_document_info` chỉ xác nhận đọc được file và metadata; `page_count` có thể là giá trị cũ. Khi chưa xem được trang đã dàn, chỉ báo đã kiểm tra cấu trúc/thuộc tính, không tuyên bố bố cục in hoặc độ giống mẫu đã đạt.

## 9. Kiểm tra trước khi bàn giao

- So bản cuối với yêu cầu, hai tệp kế hoạch, các phần đã duyệt và mẫu: đủ mục bắt buộc, đúng thứ tự, không dữ liệu tự tạo hoặc placeholder, tên và ngày nhất quán, nguồn đúng quy định.
- Kiểm tra mục lục, số trang, chữ tiếng Việt, khung bìa, ảnh và chú thích, bảng, trang trắng, nội dung tràn lề, tiêu đề đứng lẻ. Với thay đổi bố cục đáng kể, kiểm tra trực quan trang đầu, trang nhiều hình/bảng, điểm chuyển chương và trang cuối.
- Khi có mẫu hình thức, đối chiếu bản đã dàn với mẫu ở cùng mức thu phóng: vị trí khối, độ rộng khung, độ thoáng dòng/hàng, cỡ chữ, ngắt trang. Đọc được file và đúng số trang chưa đủ để xác nhận giống mẫu.
- Giữ bản `.docx` chỉnh sửa được; chỉ xuất PDF khi người dùng duyệt Word hoặc yêu cầu xuất. Không ghi đè file mẫu gốc hoặc thay đổi tài liệu không liên quan.
