(TeX-add-style-hook
 "Week1-template"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("gradescopeexam" "12pt")))
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "gradescopeexam"
    "gradescopeexam12"
    "amsmath"
    "bbm"
    "amsthm"
    "amsfonts"
    "times"
    "graphicx"
    "multicol"
    "datetime"
    "hyperref"
    "comment"
    "listings"
    "xcolor"
    "units"
    "MnSymbol")
   (TeX-add-symbols
    '("vec" 1)
    "R"
    "N"
    "Q"
    "E"
    "one"
    "V"
    "cF"
    "cS"
    "cR"
    "cC"
    "cA")
   (LaTeX-add-environments
    '("prooforbox" LaTeX-env-args ["argument"] 0)
    '("solutionorbox" LaTeX-env-args ["argument"] 0)
    '("question" LaTeX-env-args ["argument"] 0)))
 :latex)

