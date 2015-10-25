;;
;; org-mode setup
;;

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

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
   (python . t)
   (gnuplot . t)
   (plantuml . t)
   (emacs-lisp . nil)
   ))

(require 'org-screenshot)


(defvar my/org-basic-task-template "* TODO %^{Task}
SCHEDULED: %^t
%<%Y-%m-%d %H:%M>
:PROPERTIES:
:Effort: %^{effort|1:00|0:05|0:15|0:30|2:00|4:00}
:END:
%?
" "Basic task data")
(setq org-capture-templates
      `(("t" "Tasks" entry
         (file+headline "~/personal/organizer.org" "Tasks")
         ,my/org-basic-task-template)
        ("T" "Quick task" entry
         (file+headline "~/personal/organizer.org" "Tasks")
         "* TODO %^{Task}"
         :immediate-finish t)
        ("i" "Interrupting task" entry
         (file+headline "~/personal/organizer.org" "Tasks")
         "* STARTED %^{Task}"
         :clock-in :clock-resume)
        ("e" "Emacs idea" entry
         (file+headline "~/code/dev/emacs-notes/tasks.org" "Emacs")
         "* TODO %^{Task}"
         :immediate-finish t)
        ("b" "Business task" entry
         (file+headline "~/personal/business.org" "Tasks")
         ,my/org-basic-task-template)
        ("p" "People task" entry
         (file+headline "~/personal/people.org" "Tasks")
         ,my/org-basic-task-template)
        ("j" "Journal entry" plain
         (file+datetree "~/personal/journal.org")
         "%K - %a\n%i\n%?\n"
         :unnarrowed t)
        ("J" "Journal entry with date" plain
         (file+datetree+prompt "~/personal/journal.org")
         "%K - %a\n%i\n%?\n"
         :unnarrowed t)
        ("s" "Journal entry with date, scheduled" entry
         (file+datetree+prompt "~/personal/journal.org")
         "* \n%K - %a\n%t\t%i\n%?\n"
         :unnarrowed t)
        ("db" "Done - Business" entry
         (file+headline "~/personal/business.org" "Tasks")
         "* DONE %^{Task}\nSCHEDULED: %^t\n%?")
        ("dp" "Done - People" entry
         (file+headline "~/personal/people.org" "Tasks")
         "* DONE %^{Task}\nSCHEDULED: %^t\n%?")
        ("dt" "Done - Task" entry
         (file+headline "~/personal/organizer.org" "Tasks")
         "* DONE %^{Task}\nSCHEDULED: %^t\n%?")
        ("q" "Quick note" item
         (file+headline "~/personal/organizer.org" "Quick notes"))
        ("l" "Ledger entries")
        ("lm" "MBNA" plain
         (file "~/personal/ledger")
         "%(org-read-date) %^{Payee}
  Liabilities:MBNA
  Expenses:%^{Account}  $%^{Amount}
" :immediate-finish t)
        ("ln" "No Frills" plain
         (file "~/personal/ledger")
         "%(let ((org-read-date-prefer-future nil)) (org-read-date)) * No Frills
  Liabilities:MBNA
  Assets:Wayne:Groceries  $%^{Amount}
" :immediate-finish t)
        ("lc" "Cash" plain
         (file "~/personal/ledger")
         "%(org-read-date) * %^{Payee}
  Expenses:Cash
  Expenses:%^{Account}  %^{Amount}
")
        ("B" "Book" entry
         (file+datetree "~/personal/books.org" "Inbox")
         "* %^{Title}  %^g
%i
*Author(s):* %^{Author} \\\\
*ISBN:* %^{ISBN}

%?

*Review on:* %^t \\
%a
%U"
         :clock-in :clock-resume)
	("c" "Contact" entry (file "~/personal/contacts.org")
	 "* %(org-contacts-template-name)
:PROPERTIES:
:EMAIL: %(my/org-contacts-template-email)
:END:")
	("n" "Daily note" table-line (file+olp "~/personal/organizer.org" "Daily notes")
	 "| %u | %^{Note} |"
	 :immediate-finish t)
	("r" "Notes" entry
	 (file+datetree "~/personal/organizer.org")
	 "* %?\n\n%i\n"
	 )))
(global-set-key (kbd "C-c c") 'org-capture)

(require 'ox-publish)
(setq org-publish-project-alist
      '(
        ("blog-notes"
         :base-directory "~/gitest/blog/"
         :base-extension "org"
         :publishing-directory "~/gitest/sagebane.github.com/"
         :recursive t
	 :exclude "template.org"
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :section-numbers nil
         :auto-preamble t
         :auto-sitemap t                ; Generate sitemap.org automagically...
         :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
         :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
	 :email "zuijiuru at gmail dot com"
	 )
        ("blog-static"
         :base-directory "~/gitest/blog/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/gitest/sagebane.github.com/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("blog" :components ("blog-notes" "blog-static"))
        ;;
        ))

(provide 'setup-org)


