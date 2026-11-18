# Overleaf: select XeLaTeX in Settings; the year selects TeX Live, not the engine.
$pdf_mode = 5;
$xelatex = 'xelatex -interaction=nonstopmode -halt-on-error -file-line-error %O %S';
$max_repeat = 5;
