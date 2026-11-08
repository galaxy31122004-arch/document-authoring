# Hình thức báo cáo đồ án môn học — Trường Đại học Thủ Đô Hà Nội

Nguồn: đồ án môn học nhóm 20, Khoa Toán – Công nghệ thông tin (`bcaohocmaynhom20.docx`), đo bằng
`python-docx`. Dùng khi người dùng yêu cầu báo cáo theo mẫu này hoặc nói "giống báo cáo nhóm".
Chỉ lấy hình thức; tên người, đề tài và số liệu phải lấy từ yêu cầu hiện tại.

## Thông số

| Mục | Giá trị |
|---|---|
| Khổ giấy, lề | A4; trái 3 cm, phải/trên/dưới 2 cm (mẫu dùng 3,05/2,54 — mặc định Word) |
| Thân bài | Times New Roman 14 pt, đen, căn đều hai bên, không thụt dòng đầu |
| Giãn dòng | 1,5 và cách đoạn sau 6 pt cho báo cáo dài; mẫu để 1,15 và 0 pt |
| Bìa | 13 pt |
| Heading 1/2/3 | Times New Roman 14 pt **đậm** đen, căn trái, đánh số `1.`, `2.1.`, `4.1.1.`; cách trước 18/12/10 pt, cách sau 6/6/4 pt, bật `keep with next` |
| Bảng | `Table Grid`, chữ 12 pt, hàng tiêu đề đậm căn giữa, nền trắng |
| Chân trang | Trường `PAGE \* MERGEFORMAT`, căn giữa, 11 pt |
| Ngắt trang | Không tự ngắt trang trước chương |

Mẫu gốc để heading **không đậm** và Heading 3 màu xám `434343`; cả hai nên sửa thành đậm, màu đen
để phân cấp còn rõ khi in đen trắng. Mẫu cũng không đánh số hình/bảng — khi tài liệu có nhiều hình
bảng thì bổ sung chú thích `Bảng x.y.` / `Hình x.y.` đậm căn giữa phía trên và dòng `Nguồn:` nghiêng
phía dưới.

## Bìa

Mẫu gốc để bìa trơn, nhưng người dùng muốn **giữ khung và logo** của
[mẫu bìa Quy Nhơn](qnu-cover.md): dựng tài liệu từ `cover-template.docx`, xóa hết đoạn trong
thân bài rồi viết lại các dòng dưới đây, giữ nguyên header trang đầu (khung, logo) và đặt dòng
địa danh/năm vào first-page footer. Không chèn lại khung bằng ảnh rời.

Bố cục chữ trên bìa:

```text
TRƯỜNG ĐẠI HỌC THỦ ĐÔ HÀ NỘI          13 pt, căn giữa
KHOA TOÁN – CÔNG NGHỆ THÔNG TIN       13 pt, đậm, căn giữa
-----    -----                        13 pt, căn giữa
ĐỒ ÁN MÔN HỌC                         13 pt, đậm, căn giữa
ĐỀ TÀI: <tên đề tài>                  13 pt, đậm, căn giữa
    Giảng viên: <họ tên>              13 pt, căn trái, thụt khoảng 2 cm
    Sinh viên thực hiện: <họ tên>
    MSSV: <mã số>
Hà Nội, năm <năm>                     13 pt, đậm, trong first-page footer
```

Khoảng cách giữa các khối đặt bằng `Space Before`, không dùng chuỗi dòng trống. Nhóm nhiều sinh
viên dùng bảng `STT | Họ và tên | MSSV`; một sinh viên thì viết thành dòng và bỏ bảng. Không tự
thêm sinh viên, giảng viên hay lớp không có trong yêu cầu.

## Khác biệt với mẫu NCKH

[Thông số NCKH](nckh-headings.md) dùng Times New Roman 13 pt và heading cách trước 18/8/8 pt. Hai
mẫu không trộn được: chọn một mẫu cho cả tài liệu theo yêu cầu của người dùng, và ghi lựa chọn đó
vào hồ sơ làm việc.
