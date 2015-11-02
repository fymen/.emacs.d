(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
;;	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;; (setq url-proxy-services '(("no_proxy" . "work\\.com")
;;                            ("https" . "127.0.0.1:1080")))

(org-babel-load-file "~/.emacs.d/emacs.org")

