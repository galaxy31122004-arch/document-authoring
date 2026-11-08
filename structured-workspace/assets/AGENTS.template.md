# {{NAME}} — hướng dẫn chung cho AI

`AGENTS.md` là nguồn quy tắc chung cho Codex và Claude. Codex đọc trực tiếp; `CLAUDE.md` dẫn về đây cho Claude. Khi đổi quy tắc, sửa file này. Không tạo hướng dẫn Gemini, Cursor hoặc Copilot.

## Bối cảnh

- Workspace: `{{ROOT}}`.
- Mục đích: {{CONTEXT}}
- Mã nguồn chính nằm ở `source-code/`; thử nghiệm nằm ở `sandbox/`.

## Dự án liên kết

Chỉ ghi dự án, đường dẫn và quyền chỉnh sửa đã được người dùng xác nhận hoặc đã kiểm tra. Hiện chưa khai báo dự án liên kết trong mẫu này.

## Quy tắc làm việc

1. Đọc quy tắc tại thư mục con trước khi sửa phần tương ứng; giữ các lựa chọn đã được người dùng chốt.
2. Giữ project hoàn chỉnh và đường dẫn build. Khi tổ chức lại, cập nhật link/script và xác minh các entrypoint còn chạy.
3. Ảnh hoặc tài liệu có thông tin được lưu trong `documents/sources/<topic>/`; mỗi file có ghi chú `.md` cạnh nguồn, ghi nguồn gốc, yêu cầu, nội dung xác nhận và điểm chưa rõ.
4. Phân biệt dữ liệu thật, dữ liệu mẫu, mô phỏng và suy luận; không dùng ảnh để đoán thông số hoặc kết luận đã chạy phần cứng.
5. Giữ nguyên bản gốc và file người dùng chỉnh. Bản xuất mới không ghi đè bản review; mọi bản giao bắt buộc có phiên bản và lưu ở `versions/` (xem mục Phiên bản).
6. Ghi phương án chưa chốt vào `considerations/`. Không coi phương án là yêu cầu đã duyệt.
7. Báo kết quả dựa trên kiểm tra thực tế phù hợp; ghi rõ những phần chưa chạy. Tài liệu kiểm thử nằm ở `documents/verification/`.

{{DELIVERABLE_SECTIONS}}## Cấu trúc

```text
AGENTS.md                         Quy tắc chung
.agents/skills/                   Skill local bản gốc
.claude/skills/                   File dẫn hướng skill cho Claude
source-code/                      Project và mã nguồn đang duy trì
documents/sources/                Ảnh và tư liệu gốc kèm ghi chú
documents/verification/           Báo cáo kiểm thử
sandbox/                          Thử nghiệm, bản nháp và bản làm dở
sandbox/simulation/               Mô phỏng và thử nghiệm độc lập
versions/                         Bản đã giao/phát hành, luôn theo vX.Y.Z; không sửa, không ghi đè
{{STRUCTURE_EXTRA}}considerations/                   Ý tưởng và vấn đề chưa chốt
```

## Công cụ và MCP

Kiểm tra công cụ hiện có trước khi ghi lệnh hoặc cấu hình. Chưa khai báo công cụ hay MCP cụ thể trong mẫu này; không tự cài đặt hoặc ghi cấu hình giả.

## Skill local

| Skill | Dùng khi |
| --- | --- |
| `workspace-guide` | Tìm đúng thư mục, đọc quy tắc và sắp xếp tư liệu trong workspace này. |

Bản gốc ở `.agents/skills/<name>/SKILL.md`; `.claude/skills/` chỉ dẫn hướng. Client không tự nạp skill thì đọc bản gốc khi công việc phù hợp.

Skill cá nhân dùng chung nằm trong collection ngoài project (máy hiện tại: `{{SKILLS_ROOT}}`), riêng với AXON. `.agents/skills/` chỉ giữ skill local của workspace. Kiểm tra symlink/junction trước khi di chuyển skill đã cài; không kéo theo repo, môi trường chạy hoặc cấu hình riêng của công cụ khác. Không push Git khi chưa được yêu cầu.

## Cập nhật skill

Khi có bài học liên quan trực tiếp tới skill hiện có, cập nhật skill đó trong phạm vi được giao. Nếu cần skill mới ngoài yêu cầu hiện tại, đề xuất mục đích trước; chỉ tạo khi người dùng yêu cầu hoặc xác nhận. Quy tắc chung giữ tại AGENTS.md, không sao chép thành nhiều bộ quy tắc.
