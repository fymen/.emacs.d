;;; emacs initialize file

(require 'org)

(org-babel-load-file
 (expand-file-name "emacs.org"
  		           user-emacs-directory))

(if (file-exists-p
     (setq private-file
           (expand-file-name "private.org" user-emacs-directory)))
    (org-babel-load-file private-file))
