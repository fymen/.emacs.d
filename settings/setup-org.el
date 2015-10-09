;;
;; org-mode setup
;;
(require 'ox-latex)
(require 'ox-beamer)
(setq org-latex-coding-system 'utf-8)

(setf org-latex-default-packages-alist
      (remove '("AUTO" "inputenc" t) org-latex-default-packages-alist))
(setf org-latex-default-packages-alist
      (remove '("T1" "fontenc" t) org-latex-default-packages-alist))

(setq org-latex-pdf-process '("xelatex -shell-escape -pdf -quiet %f"
			      "xelatex -shell-escape -pdf -quiet %f"))
(setq org-latex-packages-alist
       '("\\usepackage{fontspec}
	\\XeTeXlinebreaklocale ``zh''
	\\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt
%	\\newcommand\\fontnamehei{WenQuanYi Zen Hei}
%	\\newcommand\\fontnamesong{AR PL UMing CN}
%	\\newcommand\\fontnamekai{AR PL KaitiM GB}
%	\\newcommand\\fontnamemono{FreeMono}
%	\\newcommand\\fontnameroman{FreeSans}
%	\\setmainfont[BoldFont=\\fontnamehei]{\\fontnamesong}
%	\\setsansfont[BoldFont=\\fontnamehei]{\\fontnamekai}
%	\\setmonofont{\\fontnamemono}
%	\\setromanfont[BoldFont=\\fontnamehei]{\\fontnamesong}

%\\makeatletter
%\\def\\verbatim@font{\\rmfamily\\small} %verbatim中使用roman字体族
%\\makeatother
\\usepackage{array}
\\usepackage{xcolor}
\\definecolor{bg}{rgb}{0.95,0.95,0.95}

%\\usepackage{geometry}
%\\geometry{left=1.5cm,right=1.5cm,top=1.5cm,bottom=1.5cm}
"))

(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)
(setq org-latex-minted-options
      '(
	("bgcolor" "bg")
	("frame" "single")
	))

;; Make Org use ido-completing-read for most of its completing prompts.
(setq org-completion-use-ido t)

(setq org-use-sub-superscripts (quote {})
      org-export-with-sub-superscripts (quote {})) 
(global-set-key (kbd "C-c s e") 'org-edit-src-code)

(setq org-plantuml-jar-path "/home/oscar/.emacs.d/elpa/contrib/scripts/plantuml.jar")
(setq puml-plantuml-jar-path "/home/oscar/.emacs.d/elpa/contrib/scripts/plantuml.jar")
(add-to-list 'org-src-lang-modes '("plantuml" . puml))

;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (sh . t)
   (dot . t)
   (ditaa . t)
   (gnuplot . t)
   (plantuml . t)
   (emacs-lisp . nil)
   ))

(require 'org-screenshot)


(provide 'setup-org)
