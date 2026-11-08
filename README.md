# Skill cá nhân

Đây là thư mục nguồn tập trung của skill cá nhân, chuẩn bị để quản lý chung bằng Git. **Không chứa skill hoặc mã plugin AXON.**

| Skill | Chức năng |
| --- | --- |
| [document-authoring](document-authoring/SKILL.md) | Soạn, định dạng và chỉnh tài liệu Word; có references và nguồn Word MCP đi kèm. |
| [structured-workspace](structured-workspace/SKILL.md) | Tạo workspace, AGENTS.md và file dẫn hướng cho các AI. |
| [presentation-from-reference](presentation-from-reference/SKILL.md) | Làm PowerPoint theo nền mẫu, nội dung và ảnh có nguồn. |
| [web-ui-style](web-ui-style/SKILL.md) | Phong cách giao diện web/dashboard: tối giản đơn sắc, viền chuyển sáng mảnh, góc khung ngắm; quy tắc ThingsBoard. |

## Quy tắc bắt buộc cho mọi skill

- Mọi skill trong collection phải tuân theo cấu trúc workspace của [structured-workspace](structured-workspace/SKILL.md): `sandbox/`, `documents/`, `source-code/`, `versions/`, `considerations/`.
- Mọi sản phẩm giao phải có phiên bản `vX.Y.Z` trong thư mục mới `versions/<loại>/<tên>/v<X.Y.Z>/`; không sửa trong `versions/`, không ghi đè bản đã giao.
- Skill mới phải ghi rõ trong SKILL.md đầu ra đặt ở đâu và đánh phiên bản thế nào trước khi được đưa vào collection.

## Một nguồn chỉnh sửa

Sửa trực tiếp các thư mục tại đây. Các đường dẫn cùng tên trong `C:\Users\letha\.codex\skills` là junction dẫn về bản gốc này; chúng chỉ phục vụ máy hiện tại, không phải file để đưa vào Git. AXON nằm ở khu vực plugin riêng, không được sao chép vào collection này.

Mỗi skill có `SKILL.md`, kèm `scripts/`, `assets/` hoặc `references/` nếu cần. Collection này phục vụ Codex và Claude, nằm ngoài mọi workspace dự án. Skill local như `workspace-guide` vẫn thuộc project tương ứng.

## Chuẩn bị Git

- Root collection: `D:\Personal-Skills`.
- Lưu mã và tài nguyên cần thiết; bỏ qua môi trường ảo, cache và file máy cá nhân theo `.gitignore`.
- `document-authoring/word-mcp` chứa nguồn server cần cho skill, không chứa môi trường đang chạy. Cài công cụ trên máy mới theo tài liệu của nó.
- Chưa tạo remote, commit hoặc push trong lần gom này. Khi có yêu cầu push, kiểm tra nội dung staged và remote thực tế trước.
