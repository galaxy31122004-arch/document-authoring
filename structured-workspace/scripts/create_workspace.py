"""Create a non-destructive workspace scaffold and canonical agent pointers."""
from pathlib import Path
import argparse
import json


VERSION_RULE = (
    'Bắt đầu từ `1.0.0`, căn cứ bản giao gần nhất: đổi nhỏ (định dạng, sửa lỗi) tăng PATCH `1.0.0 → 1.0.1`; '
    'sửa/bổ sung một phần nội dung tăng MINOR và reset PATCH `1.0.1 → 1.1.0`; đổi mục tiêu hoặc cấu trúc toàn bộ '
    'tăng MAJOR và reset hai số sau `1.1.0 → 2.0.0`. Bản xem thử/gửi duyệt không tính là phiên bản. Không sửa trong '
    '`versions/`, không ghi đè bản đã giao, không đánh số lại bản lịch sử khi chưa được yêu cầu.'
)

SOURCE_CODE = '''## Phiên bản (bắt buộc)

Mọi sản phẩm giao trong workspace này đều phải có phiên bản `vX.Y.Z` và nằm trong thư mục mới `versions/<loại>/<tên>/v<X.Y.Z>/`; không có bản giao nào không đánh số, không sửa trong `versions/`, không ghi đè bản đã giao. Mọi skill cá nhân dùng trong workspace đều tuân theo cấu trúc này.

Mỗi project trong `source-code/<project>/` có một số phiên bản đặt ở một chỗ (`VERSION` hoặc manifest build như `package.json`, `pyproject.toml`, `platformio.ini`) và `CHANGELOG.md` ghi từng phiên bản. Bắt đầu từ `0.1.0`; sửa lỗi tăng PATCH, thêm tính năng tăng MINOR, đổi không tương thích tăng MAJOR. Mỗi lần phát hành chép bản build hoặc gói nguồn sang `versions/source-code/<project>/v<X.Y.Z>/` kèm README (phiên bản, ngày, thay đổi, tình trạng kiểm thử); repo Git thì gắn tag `v<X.Y.Z>`. Không xác định được phiên bản trước thì hỏi, không đoán.

'''

PRESENTATIONS = f'''## Phiên bản PowerPoint

Soạn, chỉnh và render thử trong `sandbox/presentations/<topic>/`. Khi giao, chép sang thư mục mới `versions/presentations/<topic>/v<version>/` chứa `<topic>_v<version>.pptx`, `NOI_DUNG.md`, `KICH_BAN_THUYET_TRINH.md`, cùng `scripts/` và `images/` khi cần. {VERSION_RULE}

Nội dung và kịch bản khớp bản PPTX: nội dung nêu từng slide; kịch bản giải thích kỹ cơ chế, lý do thiết kế, tính toán, giới hạn và câu hỏi phản biện. Ghi bản nguồn và thay đổi trong `NOI_DUNG.md`; không dùng một file lời thoại chung cho các bản khác nhau. Nội dung mới cần được duyệt trước khi dựng PPTX; sửa định dạng trong nội dung đã duyệt được tiến hành trực tiếp.

'''

DOCUMENTS = f'''## Phiên bản tài liệu Word

Soạn trong `documents/<ten>/` (hai tệp kế hoạch, `figures/`, `drafts/`); đầu vào gốc ở `documents/sources/`. Khi người dùng xác nhận bản Word đạt, chép sang thư mục mới `versions/documents/<ten>/v<version>/` gồm `<ten>_v<version>.docx` và PDF cùng tên. {VERSION_RULE}

'''

FIRMWARE = '''## Phiên bản firmware

Mỗi phiên bản firmware có một thư mục code riêng trong project: `<project>/firmware/v<version>/` (`src/`, `common/`, README). Chỉ sửa thư mục mới nhất; thư mục cũ đóng băng, không sửa. Bắt đầu phiên bản mới bằng cách chép thư mục hiện tại sang `v<version mới>/` rồi trỏ build sang đó; `firmware/README.md` có bảng các phiên bản (thư mục, nội dung, env build).

Số phiên bản đặt ở một chỗ (PlatformIO: `custom_fw_version` trong `platformio.ini`, script `pre:` chuyển thành `FW_VERSION`), in ra Serial lúc boot. Mỗi lần build chép `.bin`/`.elf` sang `releases/v<version>/<project>-<env>-v<version>.bin` (không đưa vào Git). Firmware chưa phát hành bắt đầu từ `0.1.0`; sửa lỗi tăng PATCH, thêm tính năng tăng MINOR, đổi không tương thích (định dạng gói tin, sơ đồ chân) tăng MAJOR. Khi merge một phiên bản vào nhánh chính: gắn tag `v<version>` và đưa `.bin` lên GitHub Release cùng tag; bản giao cho người dùng chép vào `versions/firmware/<project>/v<version>/`.

Giữ env build cho mỗi phiên bản cũ còn biên dịch được (tên env PlatformIO không được có dấu chấm: `esp32dev-v0_2_0`). Phiên bản cũ không biên dịch được thì chỉ lưu trữ và ghi rõ trong bảng.

'''


def create(root: Path, name: str, context: str, skills_root: str,
           presentations: bool, documents: bool, firmware: bool = False) -> dict:
    root = root.expanduser().resolve()
    template = Path(__file__).resolve().parent.parent / 'assets' / 'AGENTS.template.md'

    sections = SOURCE_CODE
    structure = 'versions/source-code/<project>/   Mỗi bản phát hành code theo phiên bản\n'
    folders = ['source-code', 'documents/sources', 'documents/verification',
               'sandbox/simulation', 'versions/source-code', 'considerations']
    readme_extra = '- `versions/source-code/`: released code snapshots per version.\n'
    if presentations:
        sections += PRESENTATIONS
        structure += 'sandbox/presentations/<topic>/    Slide đang làm và bản render thử\n'
        structure += 'versions/presentations/<topic>/   Mỗi bản giao gồm slide, nội dung, lời thoại, scripts, images\n'
        folders += ['sandbox/presentations', 'versions/presentations']
        readme_extra += '- `versions/presentations/`: delivered presentation bundles (drafts in `sandbox/presentations/`).\n'
    if documents:
        sections += DOCUMENTS
        structure += 'documents/<ten>/                  Tài liệu Word đang soạn (kế hoạch, figures, drafts)\n'
        structure += 'versions/documents/<ten>/         Mỗi bản giao gồm DOCX và PDF\n'
        folders += ['versions/documents']
        readme_extra += '- `versions/documents/`: delivered Word documents with PDF (drafts in `documents/<name>/`).\n'
    if firmware:
        sections += FIRMWARE
        structure += 'versions/firmware/<project>/      Mỗi bản giao gồm .bin theo phiên bản\n'
        folders += ['versions/firmware']
        readme_extra += '- `versions/firmware/`: delivered firmware binaries (source per version in `<project>/firmware/vX.Y.Z/`).\n'

    agent = (template.read_text(encoding='utf-8')
             .replace('{{NAME}}', name).replace('{{ROOT}}', str(root)).replace('{{CONTEXT}}', context)
             .replace('{{SKILLS_ROOT}}', skills_root)
             .replace('{{DELIVERABLE_SECTIONS}}', sections).replace('{{STRUCTURE_EXTRA}}', structure))

    description = 'Read this workspace guide to locate source files, references, outputs, and verification commands.'
    local = f'''---
name: workspace-guide
description: {description}
---

# Workspace guide

Read the repository-root `AGENTS.md` (../../../AGENTS.md from this directory) before work. It is the canonical source of directory conventions, project rules, linked projects and tools. Read applicable child instructions too.

Use the maintained source for edits; put experiments and unfinished drafts in sandbox, references with adjacent source notes in documents/sources, and delivered snapshots in versions. Read the root README for current entrypoints. Do not copy domain rules into this skill or initialize tools and project state merely by opening the workspace.
'''
    pointer = f'''---
name: workspace-guide
description: {description}
---

Read the canonical skill at `.agents/skills/workspace-guide/SKILL.md` from the repository root. Read root `AGENTS.md` for all workspace rules; do not maintain a second rule set here.
'''
    files = {
        'AGENTS.md': agent,
        'CLAUDE.md': '@AGENTS.md\n',
        '.agents/skills/workspace-guide/SKILL.md': local,
        '.agents/skills/README.md': '# Workspace-local skills\n\n- [workspace-guide](workspace-guide/SKILL.md): workspace conventions and entrypoints for Codex and Claude.\n\n'
                                    f'Reusable personal skills belong in a separate collection outside this project ({skills_root} on the current machine), separate from AXON. Do not copy that collection or plugin caches into the workspace.\n',
        '.claude/skills/workspace-guide/SKILL.md': pointer,
        'README.md': f'# {name}\n\n{context}\n\nRead [AGENTS.md](AGENTS.md) for workspace rules.\n\n'
                     '- `source-code/`: maintained projects.\n'
                     '- `documents/sources/`: reference material with source notes.\n'
                     '- `documents/verification/`: verification reports.\n'
                     '- `sandbox/`: experiments, simulations and unfinished drafts.\n'
                     '- `versions/`: delivered snapshots; never edited in place.\n'
                     f'{readme_extra}'
                     '- `considerations/`: open decisions.\n',
    }
    for folder in folders:
        (root / folder).mkdir(parents=True, exist_ok=True)
    created, preserved = [], []
    for relative, content in files.items():
        path = root / relative
        path.parent.mkdir(parents=True, exist_ok=True)
        try:
            with path.open('x', encoding='utf-8', newline='\n') as handle:
                handle.write(content)
            created.append(relative)
        except FileExistsError:
            preserved.append(relative)
    return {'root': str(root), 'created': created, 'preserved': preserved}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, required=True)
    parser.add_argument('--name', required=True)
    parser.add_argument('--context', default='Workspace purpose has not yet been specified.')
    parser.add_argument('--skills-root', default='D:\\Personal-Skills',
                        help='Personal skill collection path on this machine.')
    parser.add_argument('--with-presentations', action='store_true',
                        help='Add PowerPoint versioning rules and folders.')
    parser.add_argument('--with-documents', action='store_true',
                        help='Add Word document versioning rules and folders.')
    parser.add_argument('--with-firmware', action='store_true',
                        help='Add firmware versioning rules (source folder per version, tags, binaries).')
    args = parser.parse_args()
    print(json.dumps(create(args.root, args.name, args.context, args.skills_root,
                            args.with_presentations, args.with_documents, args.with_firmware),
                     ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
