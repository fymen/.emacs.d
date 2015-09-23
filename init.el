(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
;;	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;;
;; basic configuration
;;
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0) 
(column-number-mode 1)
(desktop-save-mode 1)
(show-paren-mode t) ;; 匹配括号高亮

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-x\C-b" 'ibuffer-list-buffers)

(global-set-key (kbd "<f8>") 'eshell)


;; 最短时间显示指令序列
(setq echo-keystrokes 0.1)
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)
;; 防止页面滚动时跳动,scroll-margin 3可以在靠近屏幕边沿3行时就开始滚动,可
;; 以很好的看到上下文
(setq scroll-margin 3
      scroll-conservatively 10000)
(setq ring-bell-function 'ignore)
(mouse-avoidance-mode 'animate)


;; share clipboard with X, 
(setq x-select-enable-clipboard t)
;; share clipboard with app, suite for "C-c"
(setq x-select-enable-primary t)

(setq frame-title-format
      '("emacs:%S" (buffer-file-name "%f"
			       (dired-directory dired-directory "%b"))))

(load-theme 'zenburn t)
(set-default-font "Droid Sans Mono-10")


(ido-mode 1)
(ido-everywhere 1)

;; Use ido everywhere
(require 'ido-ubiquitous)
(ido-ubiquitous-mode 1)

(require 'flx-ido)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)


;; Visual regexp
(require 'visual-regexp)
(define-key global-map (kbd "C-c q") 'vr/query-replace)
(define-key global-map (kbd "C-c r") 'vr/replace)

(define-key global-map (kbd "C-c m") 'vr/mc-mark)


;; Fill column indicator
(require 'fill-column-indicator)
(setq fci-rule-color "#111122")

;; Smart M-x is smart
(require 'smex)
(smex-initialize)

;; Smart M-x
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(require 'multiple-cursors)
(global-set-key (kbd "C-c c c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Default setup of smartparens
(require 'smartparens-config)
(setq sp-autoescape-string-quote nil)
(--each '(css-mode-hook
          restclient-mode-hook
          js-mode-hook
          java-mode
          ruby-mode
          markdown-mode
          groovy-mode
	  c-mode
          scala-mode)
  (add-hook it 'turn-on-smartparens-mode))



(defun linux-c-mode()
  ;; 将回车代替C-j的功能，换行的同时对齐
  (define-key c-mode-map [return] 'newline-and-indent)
  (interactive)
  ;; 设置C程序的对齐风格
  (c-set-style "K&R")
  ;; 自动模式，在此种模式下当你键入{时，会自动根据你设置的对齐风格对齐
  (c-toggle-auto-state)
  ;; TAB键的宽度
  (setq c-basic-offset 4)
  ;; 此模式下，当按Backspace时会删除最多的空格
  (c-toggle-hungry-state)
  ;; 在菜单中加入当前Buffer的函数索引
  (imenu-add-menubar-index)
  ;; 在状态条上显示当前光标在哪个函数体内部
  (which-function-mode)
  (c-toggle-auto-newline 1)
  (c-set-offset 'inextern-lang 0);;在extern c{} 中正常对齐
  )

(defun linux-cpp-mode()
  (define-key c++-mode-map [return] 'newline-and-indent)
  (define-key c++-mode-map [(control c) (c)] 'compile)
  (interactive)
  (c-set-style "K&R")
  (c-toggle-auto-state)
  (c-toggle-hungry-state)
  (setq c-basic-offset 4)
  (imenu-add-menubar-index)
  (which-function-mode)
  (c-set-offset 'inextern-lang 0);;在extern c{} 中正常对齐
  )

(require 'hideshow-org)

;;c程序风格
(add-hook 'c-mode-common-hook 'linux-c-mode)
(add-hook 'c-mode-hook 'hs-org/minor-mode)
(add-hook 'c-mode-hook 'cscope-minor-mode)

;;; yasnippet
;;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
(yas-global-mode 1)

;;; auto complete mode
;;; should be loaded after yasnippet so that they can work together
;(require 'auto-complete-clang)
;(define-key c-mode-map (kbd "C-S-<return>") 'ac-complete-clang)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;; every buffer should have a unique name 
(require 'uniquify)
(setq
 uniquify-buffer-name-style 'post-forward
 uniquify-separator ":")



;;
;; org-mode 
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
\\makeatother
\\usepackage{array}
\\usepackage{xcolor}
\\usepackage{geometry}
\\geometry{left=1.5cm,right=1.5cm,top=1.5cm,bottom=1.5cm}
"))
(setq org-export-latex-listings t)
;(add-to-list 'org-latex-packages-alist '("" "xcolor"))
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)

(global-set-key (kbd "C-c s e") 'org-edit-src-code)



;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (sh . t)
   (ditaa . t)
   (gnuplot . t)
   (emacs-lisp . nil)
   ))

(require 'org-screenshot)

(global-set-key (kbd "C-;") 'avy-goto-char-2)
(global-set-key (kbd "M-g f") 'avy-goto-line)
(global-set-key (kbd "C-'") 'avy-isearch)
(global-set-key (kbd "M-g f") 'avy-goto-line)



(global-set-key (kbd "C-c d") 'kid-sdcv-to-buffer)

(defun kid-sdcv-to-buffer ()
  (interactive)
  (let ((word (if mark-active
                  (buffer-substring-no-properties (region-beginning) (region-end))
		(current-word nil t))))
    (setq word (read-string (format "Search the dictionary for (default %s): " word)
                            nil nil word))
    
    (set-buffer (get-buffer-create "*sdcv*"))
    (buffer-disable-undo)
    (erase-buffer)
    (let ((process (start-process-shell-command "sdcv" "*sdcv*" "sdcv" "-n" word)))
      (set-process-sentinel
       process
       (lambda (process signal)
         (when (memq (process-status process) '(exit signal))
           (unless (string= (buffer-name) "*sdcv*")
					;(setq kid-sdcv-window-configuration (current-window-configuration))
					;(split-window-below)
             (switch-to-buffer-other-window "*sdcv*")
             (local-set-key (kbd "d") 'kid-sdcv-to-buffer)
             (local-set-key (kbd "q") (lambda ()
                                        (interactive)
                                        (bury-buffer)
                                        (unless (null (cdr (window-list))) ; only one window
                                          (delete-window)))))))))))
