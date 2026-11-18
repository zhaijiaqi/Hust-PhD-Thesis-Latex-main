# 在 VS Code 中编译论文

## 打开项目

使用 Visual Studio Code 打开上级目录的 `博士论文.code-workspace`，或直接打开本项目文件夹。终端中当前的 `code` 命令指向 Cursor，因此推荐用 VS Code 的“文件 → 打开工作区”。

本项目使用用户目录下的 TinyTeX（TeX Live），编译链为 **XeLaTeX → BibTeX → XeLaTeX**，由 latexmk 自动判断执行次数。LaTeX Workshop 已配置好绝对工具路径，不依赖从终端启动 VS Code。

## 日常使用

- 打开 `main.tex` 或 `body/` 下的章节文件，保存后自动编译全文。
- 手动编译：按 **Command + Option + B**，或在命令面板运行 **LaTeX Workshop: Build LaTeX project**。
- 预览：按 **Command + Option + V**，或运行 **LaTeX Workshop: View LaTeX PDF file**，在 VS Code 内打开 PDF。
- 正文跳转到 PDF：按 **Command + Option + J**，或运行 **LaTeX Workshop: SyncTeX from cursor**。
- PDF 跳转到正文：双击 PDF 中的文字（若单独打开文件而未加载工作区，可用 Command + 单击）。
- 文字校对模式：运行 **LaTeX Workshop: Build with recipe**，选择“文字校对：隐藏图像”，生成 `build/preview.pdf`。

编译产物放在 `build/`：正式稿是 **build/main.pdf**，校对稿是 **build/preview.pdf**。项目根目录的 main.pdf 是此前交付快照，日常编译不会覆盖它。

## 终端编译

在本项目目录运行：

```sh
./build.sh
```

也可使用项目终端中的 `latexmk -xelatex -synctex=1 -outdir=build main.tex`。修改文献后正常编译即可，无需手动反复运行 BibTeX。

## 维护

- TinyTeX 安装目录：`/Users/halo/Library/TinyTeX`。
- 本机工具目录：`/Users/halo/Library/TinyTeX/bin/universal-darwin`。
- 缺少宏包时，依据首条错误，使用 `tlmgr install 宏包名` 安装。
- 只有辅助文件异常时才运行 `latexmk -c -outdir=build main.tex`；保留辅助文件可以加快后续编译。
- 图件源与预编译 PDF 的关系见 `Overleaf使用说明.md`；修改 TikZ 绘图源需要另行更新对应 PDF。
- 本地工具绝对路径放在 `.vscode/settings.json`，迁移到另一台电脑时需调整。Overleaf 使用根目录的 `latexmkrc`，不受 VS Code 配置影响。

## 本机核验（2026-11-18）

已安装 TinyTeX v2026.11（TeX Live 2026），并用 VS Code 配置中的实际命令完成全文编译：137 页、121 篇参考文献，首次完整编译约 12 秒；无修改时再次检查约 0.2 秒。正式稿和文字校对稿均编译成功，SyncTeX 正向和反向定位均已验证。没有缺失引用或缺字错误；模板原有的部分排版警告不影响生成 PDF。

请使用 XeLaTeX；pdfLaTeX 无法直接处理本模板的 xeCJK 与字体配置。
