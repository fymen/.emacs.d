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

(setq frame-title-format
      '("emacs:%S" (buffer-file-name "%f"
			       (dired-directory dired-directory "%b"))))

;(load-theme 'zenburn t)
(load-theme 'monokai t)
;(load-theme 'plan9 t)

;(load-theme 'phoenix-dark-pink t)
(set-default-font "Droid Sans Mono-10")

(provide 'setup-default)
