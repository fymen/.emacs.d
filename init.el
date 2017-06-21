(require 'package)
(add-to-list 'package-archives
	     ;; '("marmalade" . "http://marmalade-repo.org/packages/") ;
	     '("melpa" . "https://melpa.org/packages/"))
;;        '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize) ;; You might already have this line

(org-babel-load-file
 (expand-file-name "emacs.org"
		   user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(package-selected-packages
   (quote
    (blog-admin yasnippet whole-line-or-region wgrep-ag web-mode wc-mode use-package smartscan smartparens smart-mode-line skewer-mode sdcv rainbow-mode rainbow-delimiters paradox page-break-lines org-page org-bullets olivetti nyan-mode multiple-cursors magit keyfreq ibuffer-vc hungry-delete highlight-symbol hideshow-org helm-projectile helm-gtags helm-fuzzier helm-flx hc-zenburn-theme golden-ratio god-mode gnuplot git-timemachine expand-region esh-buf-stack elfeed-goodies dtrt-indent dired-filetype-face company-flx company-c-headers comment-dwim-2 color-identifiers-mode circe cd-compile blog-minimal beacon avy arch-packer anzu aggressive-indent)))
 '(paradox-github-token t)
 '(sml/active-background-color "dark blue"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
