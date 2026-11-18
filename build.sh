#!/usr/bin/env sh
set -eu
cd "$(dirname "$0")"
thesis_tex_bin="$HOME/Library/TinyTeX/bin/universal-darwin"
if [ -d "$thesis_tex_bin" ]; then
    PATH="$thesis_tex_bin:$PATH"
    export PATH
fi
mkdir -p build
if command -v latexmk >/dev/null 2>&1 && command -v xelatex >/dev/null 2>&1; then
    exec latexmk -xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -outdir=build main.tex
elif [ -n "${TECTONIC_BIN:-}" ]; then
    exec "$TECTONIC_BIN" --synctex --keep-logs --outdir build main.tex
elif command -v tectonic >/dev/null 2>&1; then
    exec tectonic --synctex --keep-logs --outdir build main.tex
elif command -v xelatex >/dev/null 2>&1 && command -v bibtex >/dev/null 2>&1; then
    xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -output-directory=build main.tex
    BIBINPUTS=.: BSTINPUTS=.: bibtex build/main
    xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -output-directory=build main.tex
    xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -output-directory=build main.tex
else
    echo '请安装 TeX Live/MacTeX（含 XeLaTeX、BibTeX），或 Tectonic。' >&2
    exit 1
fi
