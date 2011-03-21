;; Newline and indent on RET instead of C-j
;; (add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))
(require 'column-marker)
(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-1 79)))
