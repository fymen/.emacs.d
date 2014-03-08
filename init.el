 (when (>= emacs-major-version 24)
   (require 'package)
   (package-initialize)
   (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
   )

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0) 
(column-number-mode 1)
(ido-mode 1)
;(graphviz-dot-mode 1)

(load-theme 'nzenburn t)

;(require 'solarized-dark-theme)
;(require 'color-theme)
;(color-theme-comidia)

;(require 'ascope)

(set-default-font "FreeSans-10")
;; 最短时间显示指令序列
(setq echo-keystrokes 0.1)
(setq x-select-enable-clipboard t)
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)
;; 防止页面滚动时跳动,scroll-margin 3可以在靠近屏幕边沿3行时就开始滚动,可
;; 以很好的看到上下文
(setq scroll-margin 3
      scroll-conservatively 10000)
(setq ring-bell-function 'ignore)
(mouse-avoidance-mode 'animate)

;;c程序风格
(add-hook 'c-mode-hook 'linux-c-mode)
(add-hook 'c++-mode-hook 'linux-cpp-mode)
(defun linux-c-mode()
  ;; 将回车代替C-j的功能，换行的同时对齐
  (define-key c-mode-map [return] 'newline-and-indent)
  (interactive)
  ;; 设置C程序的对齐风格
  (c-set-style "K&R")
;; 自动模式，在此种模式下当你键入{时，会自动根据你设置的对齐风格对齐
  (c-toggle-auto-state)
  ;; 此模式下，当按Backspace时会删除最多的空格
  (c-toggle-hungry-state)
;; TAB键的宽度设置为8
  (setq c-basic-offset 8)
  ;; 在菜单中加入当前Buffer的函数索引
  (imenu-add-menubar-index)
  ;; 在状态条上显示当前光标在哪个函数体内部
  (which-function-mode)
  )
(defun linux-cpp-mode()
  (define-key c++-mode-map [return] 'newline-and-indent)
  (define-key c++-mode-map [(control c) (c)] 'compile)
  (interactive)
  (c-set-style "K&R")
  (c-toggle-auto-state)
  (c-toggle-hungry-state)
  (setq c-basic-offset 8)
  (imenu-add-menubar-index)
  (which-function-mode)
  )

(global-set-key (kbd "<f8>") 'eshell)
(global-set-key (kbd "<f5>") 'grep)
(put 'dired-find-alternate-file 'disabled nil)

(setq x-select-enable-clipboard t)


(require 'ox-latex)
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
	\\newcommand\\fontnamekai{AR PL KaitiM Big5}
	\\newcommand\\fontnamemono{FreeMono}
	\\newcommand\\fontnameroman{FreeSans}
	\\setmainfont[BoldFont=\\fontnamehei]{\\fontnamesong}
	\\setsansfont[BoldFont=\\fontnamehei]{\\fontnamekai}
	\\setmonofont{\\fontnamemono}
\\usepackage{geometry}
\\geometry{left=1.5cm,right=1.5cm,top=1.5cm,bottom=1.5cm}
"))
(setq org-export-latex-listings t)
;(add-to-list 'org-latex-packages-alist '("" "xcolor"))
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)


(add-to-list 'org-latex-classes 
	     '("cn-article"
		"\\documentclass{article}
\\usepackage{xcolor}"
		("\\section{%s}" . "\\section*{%s}")
		("\\subsection{%s}" . "\\subsection*{%s}")
		("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		("\\paragraph{%s}" . "\\paragraph*{%s}")
		("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(setq org-latex-minted-options
      '(
;;	("bgcolor" "blue")

))

 (defun my-screenshot()
;; "Take a screenshot into a unique-named file in the current buffer file 
;; directory and insert a link to this file."
   (interactive)
   (setq filename
	 (concat (make-temp-name  
		  (concat (file-name-directory (buffer-file-name)) "images/" ) ) ".png"))
   (if (file-accessible-directory-p (concat (file-name-directory (buffer-file-name)) "images/"))
       (make-directory "images"))
   (call-process-shell-command "scrot" nil nil nil nil "-s" (concat filename ))
    (insert (concat "[["  filename "]]"))
    (org-toggle-inline-images))

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
             (setq kid-sdcv-window-configuration (current-window-configuration))
             (switch-to-buffer-other-window "*sdcv*")
             (local-set-key (kbd "d") 'kid-sdcv-to-buffer)
             (local-set-key (kbd "q") (lambda ()
                                        (interactive)
                                        (bury-buffer)
                                        (unless (null (cdr (window-list))) ; only one window
                                          (delete-window)))))
           (goto-char (point-min))))))))




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(graphviz-dot-preview-extension "pdf")
 '(graphviz-dot-view-command "evince %s")
 '(org-file-apps (quote ((auto-mode . emacs) ("\\.mm\\'" . default) ("\\.x?html?\\'" . default) ("\\.pdf\\'" . "evince %s")))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

