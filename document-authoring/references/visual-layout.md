# Đo và tái tạo hình thức Word

Áp dụng khi người dùng yêu cầu tài liệu mới hoặc biểu mẫu có hình thức giống một tài liệu Word khác. Mẫu là chuẩn hình thức trong phạm vi người dùng chỉ định; không lấy tên, ngày, số liệu hoặc câu chữ của mẫu làm nội dung.

## 1. Lập bảng thông số trước khi sửa

Đọc mẫu và tài liệu đích trong Word hoặc OOXML. Ghi **giá trị, đơn vị, trang/section áp dụng và nguồn quan sát** cho từng mục dưới đây. Nếu mẫu dùng nhiều section hoặc nhiều kiểu trang, lập một hàng riêng cho từng kiểu. Không suy ra số đo từ ảnh chụp màn hình có mức thu phóng chưa biết; dùng ảnh để đối chiếu thị giác, dùng tệp Word để lấy kích thước.

| Nhóm | Cần ghi |
| --- | --- |
| Trang | Khổ giấy, hướng giấy, lề trái/phải/trên/dưới, gutter, khoảng cách header/footer; trang nào có section break. |
| Khung | Khung là page border, shape hay ảnh; kích thước rộng/cao, tọa độ so với mép giấy, độ dày/màu đường, khoảng cách đến nội dung, chừa gáy, lớp trước/sau chữ và cách neo. |
| Chữ | Họ phông, cỡ chữ, đậm/nghiêng/hoa, màu, căn lề của từng vai trò: đầu trang, tên tài liệu, đề tài, thông tin cá nhân, Heading 1–3, nội dung, caption, TOC 1–3, chân trang. |
| Nhịp dọc | Giãn dòng theo `single`, `multiple` hoặc `exactly` và giá trị tương ứng; `Space Before/After` theo pt; thụt đầu dòng; khoảng cách giữa các nhóm trên bìa và giữa các mục; nơi thật sự có page break. Đo riêng cho chữ trong ô bảng và các đoạn có nhiều dòng. |
| Bảng | Số cột, độ rộng từng cột, độ rộng toàn bảng, `AutoFit`, lề trong ô trên/dưới/trái/phải, chiều cao hàng và quy tắc `at least`/`exactly`, căn chữ ngang/dọc, đường viền, khoảng cách trước/sau bảng, hàng tiêu đề lặp lại và cho phép tách hàng. |
| Ảnh và logo | Kích thước hiển thị, tỷ lệ gốc, vị trí, cách bọc chữ, caption; ảnh nào nằm trong header/footer hoặc neo theo đoạn. |
| Đầu/cuối trang | Trường số trang, nội dung chân trang, cỡ chữ, vị trí; trang đầu có khác không; phần nào dùng số La Mã hoặc số Ả Rập. |

Ghi rõ một thông số thuộc **mẫu bắt buộc**, **yêu cầu trực tiếp của người dùng**, hay **giá trị đề xuất vì mẫu không quy định**. Khi mẫu tổ chức và mẫu tham khảo khác nhau, giữ các trường bắt buộc của tổ chức; áp dụng ngôn ngữ thiết kế của mẫu tham khảo cho phần còn lại. Báo cho người dùng biết điểm xung đột cụ thể nếu không thể đồng thời làm cả hai.

## 2. Dàn theo vùng, không chỉnh toàn file một lượt

1. Chia tài liệu thành vùng có vai trò khác nhau: bìa, trang đầu, mục lục, nội dung, phụ lục, biểu mẫu, chữ ký. Xác định section trước khi đặt lề hoặc đánh số trang; một lề chung có thể làm hỏng bìa hay bảng rộng.
2. Dùng style Word cho các vai trò lặp lại. Đặt phông, cỡ chữ, **giãn dòng**, `Space Before` và `Space After` ở style; chỉ ghi đè trực tiếp cho trường hợp cá biệt. Đo cỡ chữ thực của **các run** trong một đoạn nếu đoạn có nhiều cỡ; giá trị `Paragraph.Range.Font.Size` có thể là hỗn hợp.
3. Đặt nhịp dọc bằng ba thông số riêng: khoảng cách **giữa các dòng trong cùng đoạn**, khoảng cách **giữa các đoạn**, và chiều cao/lề trong **hàng bảng**. Áp dụng cho mọi đoạn trong ô bảng, không chỉ đoạn ngoài bảng. Đổi cỡ chữ không tự cập nhật giãn dòng `exactly`; kiểm tra tiêu đề lớn và các ô có chữ xuống dòng để tránh chồng chữ hoặc cắt chữ. Không dùng chuỗi dòng rỗng hoặc nhiều dấu cách để đẩy nội dung. Khi biểu mẫu có dòng trống để viết tay, giữ số dòng đúng mẫu; nếu cần tăng khoảng viết, dùng chiều cao hàng hoặc khoảng cách đoạn có kiểm soát.
4. Nếu mẫu có khung bìa, tính tọa độ từ **mép trang** và kiểm tra mép trái còn đủ chỗ đóng gáy. Với shape, kiểm tra `RelativeHorizontalPosition`, `RelativeVerticalPosition`, anchor, wrap và `BehindText`; tọa độ shape đo từ đoạn hoặc cột không thể so trực tiếp với mép giấy. Khung phải nằm trong vùng in và không chạm chữ, logo hay footer.
5. Với bảng, đặt độ rộng cột trước, sau đó lề trong ô và chiều cao hàng. Dùng `at least` khi nội dung có thể xuống dòng; chỉ dùng `exactly` khi đã chắc văn bản không bị cắt. Không cho hàng thông tin/chữ ký bị tách qua trang; với bảng nhiều trang, lặp hàng tiêu đề. Căn giữa theo chiều dọc cho nhãn ngắn, giữ khoảng thở trên/dưới chữ.
   Với bảng tóm tắt, so kiểu đường kẻ, nền ô và độ đậm hàng đầu với bảng cùng vai trò trong mẫu. Nếu mẫu là bảng trắng kẻ mảnh, bỏ nền màu và rút câu trong từng ô để bảng đọc được ngay khi lướt.
   Khi bảng dùng chữ đen, đặt nền trắng cho cả ô tiêu đề và ô nội dung theo mặc định. Chỉ giữ nền màu khi mẫu hoặc yêu cầu trực tiếp quy định; kiểm tra bản in đen trắng nếu có nền màu.
6. Giữ ảnh đúng tỷ lệ, đặt gần nội dung liên quan và neo ổn định. Không tăng kích thước logo bằng cách kéo méo; phải kiểm tra hình có đủ rõ ở kích thước in.
   Với ảnh đo hoặc ảnh quy trình, kiểm tra đúng bài/mục và nhãn kênh trước khi viết chú thích. Đặt một hình cùng một chú thích trong một khối, rồi mới sang hình tiếp theo; chỉ ghép cặp khi mục đích là so sánh trực tiếp. Tìm ảnh trùng trong toàn tài liệu trước khi dàn.
   Sau khi Word phân trang, rà từng trang có ảnh: nếu nửa dưới trang bỏ trống trong khi ảnh hoặc mục tiếp theo bị đẩy sang trang sau, tìm nguyên nhân ở kích thước hình, đoạn rỗng, quy tắc giữ với đoạn kế hoặc ngắt trang. Điều chỉnh đúng khối gây lỗi rồi cập nhật mục lục; không thu toàn bộ chữ hoặc ảnh một lượt chỉ để giảm số trang.
7. Nếu chỉnh biểu mẫu `.doc` cũ, làm trên bản sao. Chỉ chuyển sang `.docx` khi chuyển đổi thành công và kiểm tra lại bảng, shape, ngắt trang, dấu tiếng Việt; không đổi đuôi tệp hoặc tuyên bố có `.docx` khi thực tế chỉ có `.doc`.

## 3. Khi không có đủ thông số trong mẫu

Nếu mẫu không chứa một thành phần, chọn giá trị theo loại tài liệu và ghi đó là **đề xuất**, không ghi thành “giống mẫu”. Với báo cáo học thuật tiếng Việt trên A4, bộ khởi điểm có thể là: lề trái 3 cm, phải/trên/dưới 2 cm; Times New Roman 13 pt cho nội dung; giãn dòng 1,3–1,5; cách đoạn sau 6 pt; tiêu đề cấp chương 16 pt đậm, cấp mục 14 pt đậm, cấp tiểu mục 13 pt đậm; chú thích 11–12 pt; lề trong ô bảng trên/dưới 0,12–0,18 cm và trái/phải 0,18–0,25 cm. Đây là điểm bắt đầu để dàn thử, không là chuẩn áp cho mọi tài liệu. Mẫu chính thức và số đo của vùng tham chiếu luôn được ưu tiên.

Nếu người dùng muốn bìa có khung nhưng mẫu không cho kích thước, đề xuất khung cách mép giấy khoảng 1–1,5 cm, tăng khoảng cách mép trái khi cần đóng gáy; chọn độ dày đường khoảng 0,5–0,75 pt. Đo lại vùng nội dung để chữ và logo không áp sát khung. Với bảng có chữ dài, để chiều cao hàng tự mở rộng; tránh đặt một con số cố định cho tất cả hàng.

Lưu bảng thông số đã chọn cùng tài liệu làm việc để các lần sửa sau không trôi cỡ chữ hoặc khoảng cách. Nếu người dùng yêu cầu giống một file cụ thể, phải đo lại file đó; không dùng bộ khởi điểm để thay cho việc đối chiếu.

## 4. Kiểm tra sau dàn trang

Đọc lại tài liệu đã lưu bằng Word MCP, rồi kiểm tra cấu trúc OOXML của các thuộc tính MCP không trả về, nhất là giãn dòng và khoảng cách đoạn trong từng ô bảng. Kiểm tra ít nhất trang đầu, một trang có bảng dài, một trang nhiều hình và trang cuối nếu công cụ MCP có khả năng xem trang đã dàn. Với tài liệu ngắn, kiểm tra **mọi trang** khi khả năng này có sẵn. Nếu một trang bị tràn, sửa nguyên nhân tại style/bảng/anchor thay vì thu chữ toàn file.

Ghi rõ đã kiểm tra ở mức nào: nội dung bằng MCP, cấu trúc/thuộc tính OOXML, trang đã dàn qua công cụ phù hợp, hay bản in. Chỉ kết luận “giống mẫu” khi đã quan sát trang đã dàn; không lấy metadata hoặc ảnh chụp màn hình máy tính làm bằng chứng thay thế. Không xuất PDF chỉ để kiểm tra khi người dùng đã yêu cầu chờ xác nhận PDF.
