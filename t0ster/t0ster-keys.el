;; Split Windows
(global-set-key [f6] 'split-window-horizontally)
(global-set-key [f7] 'split-window-vertically)
;; (global-set-key [f8] 'delete-window)

;; Some Mac-friendly key counterparts
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "M-z") 'undo)

(define-key ac-mode-map (kbd "M-/") 'auto-complete)

(define-key ropemacs-local-keymap "\C-cg" 'rope-goto-definition)
