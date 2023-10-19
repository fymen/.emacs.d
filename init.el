;;; emacs initialize file

(require 'org)

(org-babel-load-file
 (expand-file-name "emacs.org"
 		   user-emacs-directory))

(if (file-exists-p "private.org")
    (org-babel-load-file
     (expand-file-name "private.org"
		       user-emacs-directory)))
