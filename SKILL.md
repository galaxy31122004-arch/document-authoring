---
name: document-authoring
description: Use to format or restructure an editable Word document, or create one from content and structure explicitly supplied or approved by the user. For requested multi-part writing, plan in two Markdown files and obtain section-by-section approval before assembling the DOCX with Word MCP. Does not apply to slides or standalone web pages.
---

# Định dạng và soạn tài liệu Word

Tạo hoặc chỉnh tài liệu `.docx` rõ ràng, dễ đọc và chỉnh sửa được. Mặc định skill xử lý hình thức, bố cục và thao tác Word; không tự quyết định nội dung, tên chương hoặc loại báo cáo. Chỉ soạn hay sửa nội dung khi người dùng yêu cầu, theo cấu trúc và dữ liệu họ cung cấp hoặc duyệt. Không lấy nội dung của tài liệu mẫu làm dữ liệu cho tài liệu mới.

## Cách gọi và thông tin đầu vào

Gọi bằng `$document-authoring` kèm yêu cầu, ví dụ: `$document-authoring lập đề xuất dự án từ các tài liệu trong thư mục này`.

Khi bắt đầu, xác định những thông tin sau từ lời nhắn và tệp đã có; chỉ hỏi những gì còn thiếu và ảnh hưởng đến bước đang làm:

- Loại tài liệu, mục đích, người đọc, ngôn ngữ, phạm vi và kết quả mong muốn.
- Mẫu/quy định phải theo, thời hạn, định dạng bàn giao và cách dẫn nguồn. Chỉ hỏi mục tiêu số trang/khoảng trang nếu người dùng muốn đặt; không mặc định độ dài.
- Nếu người dùng đưa mẫu hình thức, xác định phạm vi cần giống: toàn bộ tài liệu, chỉ bìa, mục lục, bảng, khung, hay một số trang. Nội dung của mẫu không được tự chuyển sang tài liệu mới.
- Tài liệu nguồn, dữ liệu, ảnh, bảng, logo được phép dùng; thông tin nào đã xác nhận và thông tin nào cần hỏi.
- Các phần/chương bắt buộc theo yêu cầu hoặc mẫu. Nếu nhiệm vụ gồm soạn nội dung, hỏi mức độ viết cho từng phần: `khái quát` (ý chính), `vừa đủ` (ý chính kèm giải thích và căn cứ), `chuyên sâu` (phân tích và đối chiếu có nguồn), hoặc `tùy chỉnh`. Mức độ viết không tự quy đổi thành số trang; có thể hỏi thêm số trang mục tiêu như một ràng buộc riêng.
- Bìa có cần không; **ảnh bìa** chọn một trong ba cách: không dùng ảnh, dùng ảnh người dùng cung cấp, hoặc tìm/tạo ảnh khi người dùng cho phép. Bìa không có ảnh vẫn có thể có logo và chữ. Nếu dùng ảnh, hỏi tệp/đề tài ảnh, quyền sử dụng và yêu cầu cắt/căn chỉnh khi cần. Không tự đặt logo, người, địa điểm hay nhận diện tổ chức.
- Với báo cáo học thuật tại Trường Đại học Quy Nhơn, dùng [mẫu bìa Quy Nhơn](references/qnu-cover.md) khi người dùng yêu cầu hoặc mẫu chính thức cho phép. Mẫu `.docx` đi kèm là chuẩn hình thức có sẵn; thay chủ đề và thông tin của tài liệu mới, không sao chép nội dung báo cáo cũ. Khi tài liệu thuộc đơn vị khác hoặc có mẫu chính thức khác, dùng mẫu phù hợp với tài liệu đó.

Không ép người dùng điền đủ mọi mục ngay từ đầu. Ghi các điểm chưa rõ vào tệp yêu cầu thông tin, hỏi theo ưu tiên và tiếp tục phần việc không phụ thuộc câu trả lời. Không coi im lặng là đồng ý cho ảnh bìa, nội dung hoặc bản cuối.

## Quy trình cho tài liệu mới nhiều phần

Chỉ áp dụng quy trình này khi người dùng yêu cầu **soạn nội dung mới hoặc sửa nội dung nhiều phần**. Với nhiệm vụ chỉ chỉnh form, giữ nguyên nội dung và sửa trực tiếp bản Word sau khi xác định mẫu hình thức; không bắt buộc tạo hai tệp kế hoạch hay duyệt từng chương.

1. Đọc chỉ dẫn workspace, mẫu và nguồn liên quan. Phân biệt dữ kiện, nhận xét, suy luận và đề xuất. Không bịa tên, chức danh, địa chỉ, ngày, thông số, kết quả hay trích dẫn.
   Trước khi chốt dàn ý, nếu có mẫu hình thức, đọc [quy trình đo và tái tạo hình thức](references/visual-layout.md); ghi thông số và phạm vi áp dụng vào tệp cấu trúc tổng thể.
2. **Tạo tệp Markdown thứ nhất: cấu trúc tổng thể.** Đặt tên rõ nghĩa, ví dụ `01-cau-truc-tong-the.md`. Ghi mục tiêu tài liệu; người đọc; quy định/mẫu áp dụng; mục lục dự kiến đến cấp phù hợp; mục tiêu, ý chính, độ dài tương đối và đầu ra mong muốn của từng chương hoặc phần lớn; kế hoạch hình/bảng/phụ lục; quyết định về bìa và ảnh bìa. Đây là dàn ý để duyệt, chưa phải văn bản hoàn chỉnh.
3. **Tạo tệp Markdown thứ hai: yêu cầu thông tin và độ sâu nội dung.** Ví dụ `02-yeu-cau-thong-tin.md`. Với mỗi chương/phần lớn do người dùng chọn, ghi: mục tiêu; các ý bắt buộc; mức độ viết đã chọn (`khái quát`, `vừa đủ`, `chuyên sâu` hoặc `tùy chỉnh`); số trang mục tiêu nếu người dùng có đặt; dữ liệu/nguồn/hình đã có; thông tin còn thiếu; câu hỏi ưu tiên; trạng thái duyệt. Không mặc định các phần có cùng độ dài hoặc quy đổi mức độ viết thành số trang.
4. Gửi đường dẫn của **cả hai tệp** để người dùng xem và sửa. Chỉ bắt đầu viết chương/phần đầu tiên khi người dùng đã xác nhận cấu trúc và mức độ yêu cầu nội dung liên quan. Nếu có thay đổi, cập nhật hai tệp và xin duyệt phần thay đổi trước khi viết tiếp.
5. Viết từng chương/phần lớn vào tệp Markdown riêng, theo thứ tự đã duyệt. Gửi bản vừa viết cho người dùng kiểm tra; sửa đến khi họ xác nhận, rồi mới chuyển sang chương/phần kế tiếp. Với tài liệu không chia chương, dùng đơn vị duyệt tương đương như mục lớn hoặc nhóm mục. Không soạn hàng loạt phần chưa được duyệt.
6. Khi toàn bộ nội dung đã được duyệt, ghép và định dạng `.docx` theo mẫu bằng Word MCP. Gửi bản Word để duyệt hình thức; chỉnh lại sau phản hồi. Khi người dùng xác nhận Word đã đạt, xuất PDF cùng tên cạnh bản Word trong `drafts/`. Chỉ tạo ảnh bìa riêng, cài skill hoặc đăng tải tệp khi người dùng đã yêu cầu hay cho phép tương ứng.

Hai tệp kế hoạch là tài liệu làm việc: cập nhật khi phạm vi đổi, giữ trạng thái duyệt rõ ràng, không chèn câu hỏi biên tập hoặc chỗ trống vào bản nộp. Nếu một thông tin bắt buộc vẫn thiếu, hỏi hoặc dừng phần phụ thuộc thông tin đó; không điền đại.

## Project folders

When a document project needs separate folders, use clear English names unless
an official template or existing workspace convention says otherwise:
`source/` for original inputs, `figures/` for derived visuals, and `drafts/`
for working and approved versions. Keep original filenames and do not mix
source files with generated figures. Do not create `final/` by default. Once
the user approves a DOCX, export its PDF beside it in `drafts/`; keep earlier
versions without deleting them. Leave any existing `final/` folder unchanged
unless the user asks to reorganize it.

Before moving existing files, inventory them and check references to their
paths. Update project rules, README links, and working paths after the move;
verify the DOCX and exports at their new locations. Do not reorganize
unrelated projects or impose folders on a single simple document.

## 1. Xác định yêu cầu

1. Xác định loại tài liệu, người đọc, mục đích, ngôn ngữ, phạm vi nội dung, định dạng nộp và thời hạn nếu có. Đọc chỉ dẫn của workspace, mẫu chính thức và tài liệu nguồn trước khi soạn.
2. Lập danh sách phần bắt buộc và thông tin đã được xác nhận. Phân biệt dữ liệu gốc, nhận xét, suy luận và đề xuất. Không tự tạo tên người, chức danh, địa chỉ, ngày tháng, thông số, kết quả hoặc trích dẫn.
3. Khi thiếu dữ liệu quan trọng, hỏi người dùng hoặc đánh dấu trong bản nháp và tệp yêu cầu thông tin. Bản nộp không chứa chỗ trống, lời nhắc biên tập, đường dẫn nội bộ hay câu tự giải thích cách kiểm chứng.
4. Chọn bố cục theo loại tài liệu và yêu cầu cụ thể; không ép mọi tài liệu thành bốn chương, một số trang cố định hoặc một kiểu bìa. Khi chỉ chỉnh form, giữ nguyên nội dung và cấu trúc trừ phần người dùng yêu cầu thay đổi.

## 2. Viết và tổ chức nội dung

- Lập dàn ý trước khi dàn trang. Đặt thông tin chính ở đầu mục, mỗi đoạn một ý và chuyển ý rõ ràng. Dùng một hệ thống thuật ngữ, đơn vị, tên riêng và cách viết tắt nhất quán.
- Khi được yêu cầu soạn nội dung, triển khai theo dàn ý và độ sâu từng phần đã được người dùng duyệt; không mặc định các mục như công việc đã làm, kết quả thực nghiệm hoặc kiến nghị cho mọi báo cáo.
- Viết số liệu cùng đơn vị và điều kiện áp dụng. Không biến ảnh, slide hoặc nhận xét cá nhân thành kết quả đo hay thông số sản phẩm. Chi tiết chưa chắc chắn thì tìm nguồn, hỏi hoặc lược bỏ.
- Với ký hiệu toán học và kỹ thuật như tần số, chu kỳ, điện áp hoặc chỉ số bit, đặt phần chỉ số bằng thuộc tính subscript/superscript thật của Word (`f` với `CK` ở chỉ số dưới, `2` với `4` ở chỉ số trên). Không để dạng gõ tạm `f_CK`, `T_bit`, `T_seq` trong bản nộp. Rà toàn tài liệu, gồm cả ô bảng, để tìm dấu `_` còn sót trong biểu thức. Dùng Word MCP `format_math_expression` hoặc `format_math_expression_in_table_cell` với cú pháp `f_{CK}`, `b_{k-1}`, `x^{2}` rồi kiểm tra lại ký hiệu sau khi lưu.
- Cân đối độ dài bằng nội dung có ích. Không dùng câu lặp, ảnh trùng, ngắt trang tùy tiện hoặc dòng trống để đạt số trang.
- Đặt nguồn và trích dẫn theo quy định của loại tài liệu. Nếu là ảnh hoặc dữ liệu do người dùng cung cấp, giữ dấu vết nguồn trong hồ sơ làm việc; cách ghi nguồn trong bản cuối theo mẫu/yêu cầu, không lặp dòng nguồn dài dưới mọi hình khi không cần.

## 3. Cấu trúc Word

- Chỉ thêm các phần phù hợp: bìa, thông tin phát hành, lời cảm ơn/tóm tắt, mục lục, danh mục hình/bảng/từ viết tắt, nội dung chính, kết luận, tài liệu tham khảo và phụ lục. Giữ đúng thứ tự của mẫu chính thức khi có.
- Dùng `Heading 1`, `Heading 2`, `Heading 3` cho tiêu đề tương ứng; đánh số chương/mục nhất quán nếu tài liệu cần đánh số. Tiêu đề không đứng lẻ ở cuối trang.
- Mục lục phải sinh từ tiêu đề thật, có phân cấp, chấm dẫn và số trang căn phải khi phù hợp. Dùng trường Word để có thể cập nhật; sau khi sửa bố cục, cập nhật mục lục và kiểm tra vài mục đầu, giữa, cuối. Không tin số trang lưu sẵn trong DOCX nếu Word chưa dàn trang lại.
- Danh mục viết tắt chỉ chứa thuật ngữ thực sự dùng. Có thể dùng bảng ba cột: viết tắt, tên đầy đủ, nghĩa/giải thích. Cho danh mục một trang riêng khi độ dài và mẫu trình bày cần như vậy.

## 4. Bìa, trang và chân trang

- Bìa chỉ dùng khi loại tài liệu hoặc mẫu yêu cầu. Đặt tên cơ quan/đơn vị, tên tài liệu, tiêu đề/đề tài, người lập và ngày/phiên bản theo thông tin đã xác nhận. Không để lại chữ mẫu hoặc thông tin không được cung cấp. Lựa chọn ảnh bìa theo phần thông tin đầu vào, kể cả lựa chọn không dùng ảnh.
- Logo phải đúng nguồn và giữ tỷ lệ. Nếu dùng khung bìa, đặt theo khổ giấy thay vì theo lề đoạn; chừa mép đóng gáy theo yêu cầu in ấn để khung không bị che. Giữ chữ và logo cân đối bên trong khung. Ảnh bìa xuất riêng, nếu được yêu cầu, phải khớp bản Word.
- Ưu tiên phông, khổ giấy, lề và giãn dòng của mẫu. Khi không có mẫu, chọn định dạng trang trọng, dễ đọc; tài liệu học thuật tiếng Việt thường dùng A4, Times New Roman cỡ 13 và lề trái rộng hơn lề phải để đóng gáy. Không áp những giá trị này cho mọi loại tài liệu.
- Chân trang ngắn và cùng cỡ chữ với trường số trang. Dùng trường `PAGE` thật thay vì gõ số cố định; ẩn hoặc đổi cách đánh số trên bìa/trang đầu theo mẫu.
- Khi người dùng yêu cầu giống một tài liệu mẫu về **hình thức**, bắt buộc đọc [quy trình đo và tái tạo hình thức](references/visual-layout.md) trước khi sửa Word. Ghi kích thước khung, khoảng cách giữa các hàng, cỡ chữ và thiết lập từng section bằng số đo thực tế; không coi việc giữ nguyên file mẫu hoặc chỉ đổi lề là đã dàn trang xong.
- Với báo cáo trong workspace này khi người dùng yêu cầu theo NCKH, lấy [thông số heading và danh sách NCKH](references/nckh-headings.md) làm chuẩn. Cấp ý chính dùng dấu `-`; ý phụ dùng dấu `+` và thụt sâu hơn. Không dùng dấu tròn mặc định hoặc màu xanh mặc định của Word cho heading.

## 5. Hình, bảng và chú thích

- Chỉ chèn hình hoặc bảng giúp người đọc hiểu một nội dung cụ thể; đặt gần đoạn dẫn chiếu. Giữ tỷ lệ ảnh, đủ rõ khi xem/in, không cắt mất thông tin quan trọng.
- Đánh số và chú thích nhất quán, ví dụ `Hình 3. Sơ đồ kết nối các khối.` hoặc `Bảng 2. Đối chiếu thông số.` Chú thích mô tả ngắn nội dung hình; không thêm suy đoán, lời phủ định dài hay ghi chú biên tập. Giữ hình và chú thích trên cùng trang.
- Với đồ thị dạng sóng do tác giả dựng để giải thích bài học, chú thích gọi tên tín hiệu, kênh hoặc khối được thể hiện. Tránh các cụm biên tập như `mô phỏng lý thuyết`, `đầu ra lý tưởng` trong chú thích; giải thích bản chất hình ở đoạn dẫn khi cần. Không mô tả hình dựng như ảnh chụp phép đo thực tế.
- Với hình do người dùng cung cấp, cách ghi nguồn theo rule riêng của dự án và mẫu áp dụng; giữ thông tin xuất xứ trong hồ sơ làm việc. Chú thích tập trung mô tả hình, không chép ghi chú nguồn dài khi không được yêu cầu.
- Bảng cần đường kẻ và khoảng đệm đủ thoáng; hàng tiêu đề rõ, cỡ chữ dễ đọc. Tránh vỡ hàng qua trang; lặp hàng tiêu đề khi bảng kéo dài. Dùng cấu trúc bảng thật, không căn cột bằng nhiều dấu cách.
- Với bảng tóm tắt trong báo cáo học thuật, lấy đúng kiểu bảng của mẫu: nếu mẫu dùng kẻ ô mảnh, nền trắng và hàng đầu đậm thì giữ cách đó; không tự thêm nền đậm, màu xen kẽ hoặc nhiều chữ trong một ô. Rút nội dung mỗi ô xuống một ý chính, chọn độ rộng cột theo lượng chữ và để hàng tự giãn đủ đọc.
- Quy tắc mặc định cho bảng chữ đen là nền trắng cho toàn bộ bảng, gồm cả hàng tiêu đề. Chỉ dùng nền xanh, xám hoặc màu đậm khi người dùng/mẫu chính thức yêu cầu rõ; nếu dùng nền màu phải kiểm tra tương phản chữ và không làm giảm khả năng đọc khi in đen trắng.
- Với ảnh thực nghiệm, ưu tiên một ảnh và một chú thích thành một khối riêng; chỉ đặt hai ảnh cạnh nhau khi cả hai cần được so trực tiếp và chữ/chú thích vẫn rõ ở cỡ in. Không để ảnh liên tiếp trong một bảng chỉ để tiết kiệm trang. Trước khi ghi chú thích, đối chiếu ảnh gốc, kênh đo, vị trí trong quy trình và phần/bài tương ứng; ảnh không chứng minh được chi tiết nào thì không gán chi tiết đó. Không lặp cùng ảnh dưới tên khác ở nhiều phần.
- Sau khi Word dàn trang, kiểm tra phần trống ở cuối từng trang nội dung, đặc biệt các trang có ảnh. Nếu khoảng trống lớn mà nội dung vẫn tiếp tục ở trang sau, kiểm tra ảnh trùng, đoạn rỗng, ngắt trang và kích thước ảnh; chuyển ảnh đến đúng mục, xóa đoạn rỗng thừa hoặc thu ảnh vừa đủ để dòng chữ trên ảnh vẫn đọc được. Giữ ảnh với chú thích cùng trang và không ép mỗi ảnh sang một trang riêng khi không cần.
- Chương hoặc mục lớn được phép bắt đầu ngay trên trang hiện tại khi còn đủ chỗ cho tiêu đề và đoạn mở đầu; không tự đặt `page break before` chỉ vì lên chương mới. Dùng `keep with next` để giữ tiêu đề với đoạn đầu và chỉ ngắt trang khi mẫu chính thức, giảng viên hoặc người dùng yêu cầu. Kiểm tra cả màu chữ kế thừa từ style Word cũ: tiêu đề phải theo màu của mẫu, không tự mang màu xanh mặc định.
- Cấu hình giãn dòng cho **mọi vùng có chữ**, kể cả ô bảng, bìa, mục lục, phần ký và chú thích. Không coi việc đổi cỡ chữ, tăng chiều cao hàng hay đổi khoảng cách đoạn là đã đặt giãn dòng. Đo và ghi riêng `line spacing`, `Space Before` và `Space After` cho từng vai trò; kiểm tra lại các ô có chữ xuống nhiều dòng.
- Hình từ nguồn ngoài phải được ghi nguồn theo yêu cầu áp dụng; không bỏ nguồn bắt buộc vì một tài liệu mẫu từng dùng ảnh tự chụp.

## 6. Dùng Word MCP

- Khi `mcp__word_document_server` có sẵn, **luôn dùng MCP làm đường chính**: `get_document_info`, `get_document_outline`, `get_document_text` để đọc; `copy_document` để tạo bản làm việc; lệnh MCP phù hợp để sửa và đọc lại kết quả. Dùng đường dẫn đầy đủ và lưu bản mới có tên rõ ràng.
- Mã nguồn Word MCP đi kèm skill nằm trong `word-mcp/` của cùng repo. Khi cần thêm hoặc sửa lệnh MCP, chỉnh tại đây, chạy kiểm thử và khởi động lại MCP để nhận mã mới; commit skill và MCP trong cùng repo.
- Nếu MCP thực sự không có lệnh cho thuộc tính cần sửa như giãn dòng, neo khung bìa, mục lục hay trường số trang, dùng Word/OOXML **chỉ cho thuộc tính đó**; sau đó mở/đọc lại tài liệu bằng MCP và kiểm tra cấu trúc DOCX. Không dùng tự động hóa giao diện hay ảnh chụp màn hình thay cho MCP. Sau thao tác mở/lưu, xác nhận các trường động như `PAGE` và mục lục vẫn còn.
- `get_document_info` chỉ xác nhận đọc được file và metadata; `page_count` có thể là giá trị cũ. Khi MCP chưa cho xem trang đã dàn, chỉ báo đã kiểm tra cấu trúc/thuộc tính, không tuyên bố bố cục in hoặc độ giống mẫu đã đạt. Chỉ xuất PDF khi người dùng yêu cầu hoặc xác nhận bản Word đã đạt.

## 7. Kiểm tra trước khi bàn giao

- So sánh bản cuối với yêu cầu, hai tệp kế hoạch, các phần đã duyệt và mẫu: đủ mục bắt buộc, đúng thứ tự, không có dữ liệu tự tạo hoặc placeholder, tên và ngày nhất quán, nguồn/citation đúng quy định.
- Kiểm tra mục lục, số trang, chữ tiếng Việt, khung bìa, ảnh và chú thích, bảng, trang trắng, nội dung tràn lề và tiêu đề đứng lẻ. Với thay đổi bố cục đáng kể, kiểm tra trực quan trang đầu, trang có nhiều hình/bảng, điểm chuyển chương và trang cuối.
- Giữ bản `.docx` chỉnh sửa được; xuất PDF sau khi người dùng duyệt Word hoặc yêu cầu xuất, và chỉ tạo ảnh bìa riêng khi được yêu cầu. Không ghi đè file mẫu gốc hoặc thay đổi tài liệu không liên quan.
- Khi có mẫu hình thức, đối chiếu bản đã dàn với mẫu ở cùng mức thu phóng hoặc cùng kích thước trang: vị trí các khối, độ rộng khung, độ thoáng giữa các dòng/hàng, chữ lớn nhỏ, ngắt trang. Việc đọc được file và đếm đúng số trang chưa đủ để xác nhận giống mẫu.
