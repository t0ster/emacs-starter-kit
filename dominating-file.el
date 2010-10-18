;; Port this functionality back from Emacs 23 since it's Really Useful

(unless (functionp 'locate-dominating-file)
  (defun locate-dominating-file (file name)
    "Look up the directory hierarchy from FILE for a file named NAME.
Stop at the first parent directory containing a file NAME,
and return the directory.  Return nil if not found."
    ;; We used to use the above locate-dominating-files code, but the
    ;; directory-files call is very costly, so we're much better off doing
    ;; multiple calls using the code in here.
    ;;
    ;; Represent /home/luser/foo as ~/foo so that we don't try to look for
    ;; `name' in /home or in /.
    (setq file (abbreviate-file-name file))
    (let ((root nil)
          (prev-file file)
          ;; `user' is not initialized outside the loop because
          ;; `file' may not exist, so we may have to walk up part of the
          ;; hierarchy before we find the "initial UID".
          (user nil)
          try)
      (while (not (or root
                      (null file)
                      ;; FIXME: Disabled this heuristic because it is sometimes
                      ;; inappropriate.
                      ;; As a heuristic, we stop looking up the hierarchy of
                      ;; directories as soon as we find a directory belonging
                      ;; to another user.  This should save us from looking in
                      ;; things like /net and /afs.  This assumes that all the
                      ;; files inside a project belong to the same user.
                      ;; (let ((prev-user user))
                      ;;   (setq user (nth 2 (file-attributes file)))
                      ;;   (and prev-user (not (equal user prev-user))))
                      (string-match locate-dominating-stop-dir-regexp file)))
        (setq try (file-exists-p (expand-file-name name file)))
        (cond (try (setq root file))
              ((equal file (setq prev-file file
                                 file (file-name-directory
                                       (directory-file-name file))))
               (setq file nil))))
      root))

  (defvar locate-dominating-stop-dir-regexp
    "\\`\\(?:[\\/][\\/][^\\/]+\\|/\\(?:net\\|afs\\|\\.\\.\\.\\)/\\)\\'"))

(unless (fboundp 'region-active-p)
  ;; use-region-p is not built-in in emacs22 or earlier
  (defun region-active-p ()
    "Return t if Transient Mark mode is enabled and the mark is active.

  Most commands that act on the region if it is active and
  Transient Mark mode is enabled, and on the text near point
  otherwise, should use `use-region-p' instead.  That function
  checks the value of `use-empty-active-region' as well."
    (and transient-mark-mode mark-active))
  (defcustom use-empty-active-region nil
    "Whether \"region-aware\" commands should act on empty regions.
  If nil, region-aware commands treat empty regions as inactive.
  If non-nil, region-aware commands treat the region as active as
  long as the mark is active, even if the region is empty.

  Region-aware commands are those that act on the region if it is
  active and Transient Mark mode is enabled, and on the text near
  point otherwise."
    :type 'boolean
    :version "23.1"
    :group 'editing-basics)
  (defun use-region-p ()
    "Return t if the region is active and it is appropriate to act on it.
  This is used by commands that act specially on the region under
  Transient Mark mode.  It returns t if and only if Transient Mark
  mode is enabled, the mark is active, and the region is non-empty.
  If `use-empty-active-region' is non-nil, it returns t even if the
  region is empty.

  For some commands, it may be appropriate to disregard the value
  of `use-empty-active-region'; in that case, use `region-active-p'."
    (and (region-active-p)
         (or use-empty-active-region (> (region-end) (region-beginning)))))
  )

;; We need tramp-cmd in emacs < 23
(require 'tramp-cmds)

(provide 'dominating-file)
