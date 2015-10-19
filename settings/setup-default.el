;; basic setting

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0)
(column-number-mode 1)

(desktop-save-mode 1)

(show-paren-mode t) ;; 匹配括号高亮
;;; Also highlight parens  
(setq show-paren-delay 0  
      show-paren-style 'parenthesis)

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

;; (setq frame-title-format
;;       '("emacs:%S" (buffer-file-name "%f"
;; 			       (dired-directory dired-directory "%b"))))
(setq frame-title-format "%f %4 %b %Z %* %10 %I")

(load-theme 'hc-zenburn t)
;(load-theme 'monokai t)
;(load-theme 'plan9 t)
;(load-theme 'phoenix-dark-pink t)

;; Setting English Font
(set-face-attribute 'default nil :font "Droid Sans Mono 10") 

;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset (font-spec :family "WenQuanYi Micro Hei Mono"
                                       :size 16)))

;; Highlight current line
(global-hl-line-mode 1)

(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and
we are not at the end of the line, then comment current line.
Replaces default behaviour of comment-dwim,
when it inserts comment at the end of the line. "

  (interactive "*P")
  (comment-normalize-vars)

  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))


(global-set-key "\M-;" 'qiang-comment-dwim-line) 

(dolist (command '(yank yank-pop))
  (eval
   `(defadvice, command (after indent-region activate)
      (and (not current-prefix-arg)
           (member major-mode
                   '(emacs-lisp-mode lisp-mode clojure-mode scheme-mode
                                     haskell-mode ruby-mode rspec-mode
                                     python-mode c-mode c++-mode objc-mode
                                     latex-mode js-mode plain-tex-mode))
           (let ((mark-even-if-inactive transient-mark-mode))
             (indent-region (region-beginning) (region-end) nil))))))

(provide 'setup-default)


;; Chinese sentence
(setq sentence-end
      "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*") 
(setq sentence-end-double-space nil)

(global-set-key [(f5)] 'revert-buffer)
