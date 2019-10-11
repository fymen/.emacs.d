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
 '(package-selected-packages
   (quote
    (docker-compose-mode dockerfile-mode docker ox-hugo leetcode circe skewer-mode js2-mode web-mode sdcv elfeed-goodies elfeed esh-buf-stack helm-projectile blog-admin yasnippet whole-line-or-region wgrep-ag wc-mode use-package smartscan smartparens smart-mode-line rainbow-mode rainbow-delimiters paradox page-break-lines org-bullets org olivetti nyan-mode multiple-cursors magit keyfreq ibuffer-vc hungry-delete highlight-symbol hideshow-org helm-pass helm-gtags helm-fuzzier helm-flx hc-zenburn-theme golden-ratio god-mode gnuplot expand-region dtrt-indent dired-filetype-face company-flx company-c-headers comment-dwim-2 color-identifiers-mode cd-compile beacon avy anzu)))
 '(paradox-github-token t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'set-goal-column 'disabled nil)
