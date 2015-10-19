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

(setq org-latex-pdf-process '("xelatex -shell-escape  %f"
			      "xelatex -shell-escape  %f"))
(setq org-latex-packages-alist
      '("
	\\usepackage{fontspec}
	\\usepackage{array}
	\\usepackage{xcolor}
	\\definecolor{bg}{rgb}{0.95,0.95,0.95}"))

(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)
(setq org-latex-minted-options
      '(
	("bgcolor" "bg")
	("frame" "single")))

(add-to-list 'org-latex-classes
	     '("article-cn"
	      "\\documentclass[11pt]{article}
		[DEFAULT-PACKAGES]
		[PACKAGES]
		\\XeTeXlinebreaklocale ``zh''
		\\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt
		\\newcommand\\fontnamehei{WenQuanYi Zen Hei}
		\\newcommand\\fontnamesong{AR PL UMing CN}
		\\newcommand\\fontnamekai{AR PL KaitiM GB}
		\\newcommand\\fontnamemono{FreeMono}
		\\newcommand\\fontnameroman{FreeSans}
		\\setmainfont[BoldFont=\\fontnamehei]{\\fontnamesong}
		\\setsansfont[BoldFont=\\fontnamehei]{\\fontnamekai}
		\\setmonofont{\\fontnamemono}
		\\setromanfont[BoldFont=\\fontnamehei]{\\fontnamesong}
		\\makeatletter
		\\def\\verbatim@font{\\rmfamily\\small} %verbatim中使用roman字体族
		\\makeatother"
              
	      ("\\section{%s}" . "\\section*{%s}")
	      ("\\subsection{%s}" . "\\subsection*{%s}")
	      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	      ("\\paragraph{%s}" . "\\paragraph*{%s}")
	      ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
	     '("article-img"
	      "\\documentclass[11pt]{article}
		[DEFAULT-PACKAGES]
		[PACKAGES]
		\\usepackage{geometry}
		\\geometry{left=1.5cm,right=1.5cm,top=1.5cm,bottom=1.5cm}"
	      ("\\section{%s}" . "\\section*{%s}")
	      ("\\subsection{%s}" . "\\subsection*{%s}")
	      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	      ("\\paragraph{%s}" . "\\paragraph*{%s}")
	      ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

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

(require 'ox-publish)
(setq org-publish-project-alist
      '(
        ("blog-notes"
         :base-directory "~/gitest/blog/"
         :base-extension "org"
         :publishing-directory "~/gitest/blog-out/"
         :recursive t
	 :exclude "template.org"
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :section-numbers nil
         :auto-preamble t
         :auto-sitemap t                ; Generate sitemap.org automagically...
         :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
         :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
         :author "Feynman.Qi"
         :email "zuijiuru at gmail dot com"
         :style "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/default.css\"/>"
         )
        ("blog-static"
         :base-directory "~/gitest/blog/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/gitest/blog-out/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("blog" :components ("blog-notes" "blog-static"))
        ;;
        ))
(provide 'setup-org)


