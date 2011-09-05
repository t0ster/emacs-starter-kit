(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit/haml-mode"))
(require 'haml-mode)

(add-to-list 'auto-mode-alist '("\\.hamlpy$" . haml-mode))
