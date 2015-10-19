;; Default setup of smartparens
(require 'smartparens-config)
(setq sp-autoescape-string-quote nil)

(defmacro def-pairs (pairs)
  `(progn
     ,@(loop for (key . val) in pairs
          collect
            `(defun ,(read (concat
                            "wrap-with-"
                            (prin1-to-string key)
                            "s"))
                 (&optional arg)
               (interactive "p")
               (sp-wrap-with-pair ,val)))))

(def-pairs ((paren        . "(")
            (bracket      . "[")
            (brace        . "{")
	    (underscores  . "_")
	    (single-quote . "'")
	    (double-quote . "\"")
            (back-quote   . "`")))

(define-key smartparens-mode-map (kbd "C-M-a") 'sp-beginning-of-sexp)

(define-key smartparens-mode-map (kbd "C-M-a") 'sp-beginning-of-sexp)
(define-key smartparens-mode-map (kbd "C-M-e") 'sp-end-of-sexp)

(define-key smartparens-mode-map (kbd "C-<down>") 'sp-down-sexp)
(define-key smartparens-mode-map (kbd "C-<up>")   'sp-up-sexp)
(define-key smartparens-mode-map (kbd "M-<down>") 'sp-backward-down-sexp)
(define-key smartparens-mode-map (kbd "M-<up>")   'sp-backward-up-sexp)

(define-key smartparens-mode-map (kbd "C-M-f") 'sp-forward-sexp)
(define-key smartparens-mode-map (kbd "C-M-b") 'sp-backward-sexp)

(define-key smartparens-mode-map (kbd "C-M-n") 'sp-next-sexp)
(define-key smartparens-mode-map (kbd "C-M-p") 'sp-previous-sexp)

(define-key smartparens-mode-map (kbd "C-S-f") 'sp-forward-symbol)
(define-key smartparens-mode-map (kbd "C-S-b") 'sp-backward-symbol)

(define-key smartparens-mode-map (kbd "C-<right>") 'sp-forward-slurp-sexp)
(define-key smartparens-mode-map (kbd "M-<right>") 'sp-forward-barf-sexp)
(define-key smartparens-mode-map (kbd "C-<left>")  'sp-backward-slurp-sexp)
(define-key smartparens-mode-map (kbd "M-<left>")  'sp-backward-barf-sexp)

(define-key smartparens-mode-map (kbd "C-M-t") 'sp-transpose-sexp)
(define-key smartparens-mode-map (kbd "C-M-k") 'sp-kill-sexp)
(define-key smartparens-mode-map (kbd "C-k")   'sp-kill-hybrid-sexp)
(define-key smartparens-mode-map (kbd "M-k")   'sp-backward-kill-sexp)
(define-key smartparens-mode-map (kbd "C-M-w") 'sp-copy-sexp)

(define-key smartparens-mode-map (kbd "C-M-d") 'delete-sexp)

(define-key smartparens-mode-map (kbd "M-<backspace>") 'backward-kill-word)
(define-key smartparens-mode-map (kbd "C-<backspace>") 'sp-backward-kill-word)
;([remap sp-backward-kill-word] 'backward-kill-word)


(define-key smartparens-mode-map (kbd "M-[") 'sp-backward-unwrap-sexp)
(define-key smartparens-mode-map (kbd "M-]") 'sp-unwrap-sexp)

(define-key smartparens-mode-map (kbd "C-x C-t") 'sp-transpose-hybrid-sexp)

(define-key smartparens-mode-map (kbd "C-c (")  'wrap-with-parens)
(define-key smartparens-mode-map (kbd "C-c [")  'wrap-with-brackets)
(define-key smartparens-mode-map (kbd "C-c {")  'wrap-with-braces)
(define-key smartparens-mode-map (kbd "C-c '")  'wrap-with-single-quotes)
(define-key smartparens-mode-map (kbd"C-c \"") 'wrap-with-double-quotes)
(define-key smartparens-mode-map (kbd"C-c _")  'wrap-with-underscores)
(define-key smartparens-mode-map (kbd"C-c `")  'wrap-with-back-quotes)

(add-hook 'emacs-lisp-mode-hook 'turn-on-smartparens-strict-mode)
(add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)

(provide 'setup-smartparens)
