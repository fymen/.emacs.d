(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
;;	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))
(add-to-list 'load-path settings-dir)

(require 'setup-default)
(require 'setup-dict)
;(require 'setup-paredit)
(eval-after-load 'ido '(require 'setup-ido))
(eval-after-load 'org '(require 'setup-org))

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

(require 'setup-smartparens)

(require 'xcscope)
;(cscope-setup)

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
  (c-toggle-auto-newline 0)
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

;; auto complete mode
;; should be loaded after yasnippet so that they can work together
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

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
	      (ggtags-mode 1))))


;;; This is the binary name of my scheme implementation  
(setq scheme-program-name "scm")

;(require 'flyspell-lazy)
;(flyspell-lazy-mode 1)
;(flyspell-mode 1)

;; hippie expand is dabbrev expand on steroids
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))
(global-set-key (kbd "M-/") 'hippie-expand)

(global-set-key (kbd "C-x o") 'ace-window)


(global-set-key (kbd "C-;") 'avy-goto-char-2)
(global-set-key (kbd "M-g f") 'avy-goto-line)
(global-set-key (kbd "C-'") 'avy-isearch)
(global-set-key (kbd "M-g f") 'avy-goto-line)


(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'c-mode-hook 'rainbow-delimiters-mode)

;;(require 'diminish)
;;(diminish 'abbrev-mode "Abv")
;;(diminish 'hs-org/minor-mode)
;;
;;
;;(eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
;;(eval-after-load "eldoc" '(diminish 'eldoc-mode))
;;(eval-after-load "paredit" '(diminish 'paredit-mode))
;;(eval-after-load "tagedit" '(diminish 'tagedit-mode))
;;(eval-after-load "elisp-slime-nav" '(diminish 'elisp-slime-nav-mode))
;;(eval-after-load "skewer-mode" '(diminish 'skewer-mode))
;;(eval-after-load "skewer-css" '(diminish 'skewer-css-mode))
;;(eval-after-load "skewer-html" '(diminish 'skewer-html-mode))
;;(eval-after-load "smartparens" '(diminish 'smartparens-mode))
;;(eval-after-load "guide-key" '(diminish 'guide-key-mode))
;;(eval-after-load "whitespace-cleanup-mode" '(diminish 'whitespace-cleanup-mode))
;;(eval-after-load "subword" '(diminish 'subword-mode))

(global-set-key (kbd "C-x w") 'elfeed)

(setq elfeed-feeds
      '("http://nullprogram.com/feed/"
        "http://www.terminally-incoherent.com/blog/feed/"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cfs--current-profile-name "profile3" t)
 '(custom-safe-themes
   (quote
    ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(elfeed-feeds
   (quote
    ("http://feeds.feedburner.com/ruanyifeng" "http://feeds.feedburner.com/yizhe" "http://feed.mifengtd.cn/" "http://feed.feedsky.com/tektalk" "http://www.geekonomics10000.com/feed " "http://feeds2.feedburner.com/xumathena" "http://coolshell.cn/feed " "http://nullprogram.com/feed/" "http://www.terminally-incoherent.com/blog/feed/")) t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(register-input-method
 "chinese-wbim" "euc-cn" 'chinese-wbim-use-package
 "五笔" "汉字五笔输入法" "wb.txt")

