(require 'package)
(add-to-list 'package-archives
	     ;; '("marmalade" . "http://marmalade-repo.org/packages/") ;
	     '("melpa" . "https://melpa.org/packages/"))
;;        '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize) ;; You might already have this line

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#313131" "#D9A0A0" "#8CAC8C" "#FDECBC" "#99DDE0" "#E090C7" "#A0EDF0" "#DCDCCC"])
 '(custom-safe-themes
   (quote
    ("bcc6775934c9adf5f3bd1f428326ce0dcd34d743a92df48c128e6438b815b44f" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "8577da1641ed4bdf255341ca92e3d0e49c9f4d574458f09ce78159690442cade" default)))
 '(fci-rule-color "#5E5E5E")
 '(paradox-github-token t)
 '(sml/active-background-color "dark blue")
 '(vc-annotate-background "#202020")
 '(vc-annotate-color-map
   (quote
    ((20 . "#C99090")
     (40 . "#D9A0A0")
     (60 . "#ECBC9C")
     (80 . "#DDCC9C")
     (100 . "#EDDCAC")
     (120 . "#FDECBC")
     (140 . "#6C8C6C")
     (160 . "#8CAC8C")
     (180 . "#9CBF9C")
     (200 . "#ACD2AC")
     (220 . "#BCE5BC")
     (240 . "#CCF8CC")
     (260 . "#A0EDF0")
     (280 . "#79ADB0")
     (300 . "#89C5C8")
     (320 . "#99DDE0")
     (340 . "#9CC7FB")
     (360 . "#E090C7"))))
 '(vc-annotate-very-old-color "#E090C7"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-2 ((t (:inherit org-tree-slide-heading-level-2))))
 '(org-level-3 ((t (:inherit org-tree-slide-heading-level-3)))))


(org-babel-load-file
 (expand-file-name "emacs.org"
		   user-emacs-directory))
