(require 'python) ; use python.el

;; Persistency and modes:
(setq
 aquamacs-scratch-file nil ; do not save scratch file across sessions
 initial-major-mode 'emacs-lisp-moden ; *scratch* shows up in emacs-lisp-mode
 )

(if (fboundp 'tabbar-mode) (tabbar-mode -1)) ; no tabbar
(if (fboundp 'one-buffer-one-frame) (one-buffer-one-frame-mode -1)) ; no one-buffer-per-frame
(setq special-display-regexps nil) ; do not open certain buffers in special windows/frames
(set-default 'cursor-type 'box)
