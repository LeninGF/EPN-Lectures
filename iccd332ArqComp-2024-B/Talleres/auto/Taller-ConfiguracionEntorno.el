;; -*- lexical-binding: t; -*-

(TeX-add-style-hook
 "Taller-ConfiguracionEntorno"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1") ("graphicx" "") ("longtable" "") ("wrapfig" "") ("rotating" "") ("ulem" "normalem") ("amsmath" "") ("amssymb" "") ("capt-of" "") ("hyperref" "") ("fancyhdr" "") ("geometry" "top=25mm" "left=25mm" "right=25mm") ("tabularx" "")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "inputenc"
    "fontenc"
    "graphicx"
    "longtable"
    "wrapfig"
    "rotating"
    "ulem"
    "amsmath"
    "amssymb"
    "capt-of"
    "hyperref"
    "fancyhdr"
    "geometry"
    "tabularx")
   (LaTeX-add-labels
    "sec:org84ddf36"
    "sec:org9674a74"
    "sec:org0ceb3c8"
    "sec:orgc3dd327"
    "sec:orgd69a92f"
    "sec:org990b53d"
    "sec:org17b934e"
    "sec:org0ea1fd4"
    "sec:orgcb7b1cb"
    "sec:org7d183e8"))
 :latex)

