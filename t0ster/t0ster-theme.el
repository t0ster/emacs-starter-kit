(require 'color-theme)
(color-theme-initialize)
(color-theme-calm-forest)

(blink-cursor-mode)
(global-hl-line-mode 1)
(set-face-attribute 'default nil :height 140)

(require 'sr-speedbar)
(setq sr-speedbar-right-side nil)
(setq speedbar-use-images nil)
(sr-speedbar-toggle)

(setq ac-auto-start nil)
(setq ac-quick-help-delay 0.5)
