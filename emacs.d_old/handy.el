;; uniquify: unique buffer names
(require 'uniquify) ;; make buffer names more unique
(setq 
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":"
  uniquify-after-kill-buffer-p t
  uniquify-ignore-buffers-re "^\\*")

;; hl-line: highlight the current line
(when (fboundp 'global-hl-line-mode)
  (global-hl-line-mode t)) ;; turn it on for all modes by default

;; http://www.emacswiki.org/cgi-bin/wiki/ShowParenMode
(when (fboundp 'show-paren-mode)
  (show-paren-mode t)
  (setq show-paren-style 'parenthesis))

;; TODO
;; overrride the default function....
;;(defun emacs-session-filename (SESSION-ID)
;;  (concat "~/.emacs.d/cache/session." SESSION-ID))

;; TODO
;; bookmarks
;;(setq bookmark-default-file "~/.emacs.d/data/bookmarks" ;; bookmarks
;;  bookmark-save-flag 1)                            ;; autosave each change
;; TODO
;; saveplace: save location in file when saving files
;;(setq save-place-file "~/.emacs.d/cache/saveplace")
;;(setq-default save-place t)            ;; activate it for all buffers
;;(require 'saveplace)                   ;; get the package

;; TODO
;; savehist: save some history
;; (setq savehist-additional-variables    ;; also save...
;;   '(search ring regexp-search-ring)    ;; ... my search entries
;;   savehist-autosave-interval 60        ;; save every minute (default: 5 min)
;;   savehist-file "~/.emacs.d/cache/savehist")   ;; keep my home clean
;; (savehist-mode t)                      ;; do customization before activation

;; recentf
;; (require 'recentf)    ;; save recently used files
;; (setq
;;   recentf-save-file "~/.emacs.d/cache/recentf"
;;   recentf-max-saved-items 100     ;; max save 100
;;   recentf-max-menu-items 15)      ;; max 15 in menu
;; (recentf-mode t)                  ;; turn it on

;; TODO
;; abbrevs (abbreviations)
;; (setq abbrev-file-name                 ;; tell emacs where to read abbrev
;;   "~/.emacs.d/data/abbrev_defs")  ;; definitions from...
;; (abbrev-mode t)                        ;; enable abbrevs (abbreviations) ...
;; (setq default-abbrev-mode t            ;; turn it on
;;   save-abbrevs t)                      ;; don't ask
;; (when (file-exists-p abbrev-file-name)
;;   (quietly-read-abbrev-file))          ;;  don't tell
;; (add-hook 'kill-emacs-hook             ;; write when ...
;;   'write-abbrev-file)                  ;; ... exiting emacs

;; ;; filecache: http://www.emacswiki.org/cgi-bin/wiki/FileNameCache
;; (eval-after-load "filecache" 
;;   '(progn (message "Loading file cache...")
;;      (file-cache-add-directory "~/")
;;      (file-cache-add-directory-list '("~/Desktop" "~/Documents"))))

;; ;; backups
;; (setq make-backup-files t ;; do make backups
;;   backup-by-copying t     ;; and copy them here
;;   backup-directory-alist '(("." . "~/.emacs.d/cache/backups")) 
;;   version-control t
;;   kept-new-versions 2
;;   kept-old-versions 5
;;   delete-old-versions t)

;; ;; time-stamps (better not use those in version-controlled files)
;; (setq ;; when there's "Time-stamp: <>" in the first 10 lines of the file
;;   time-stamp-active t        ; do enable time-stamps
;;   time-stamp-line-limit 10   ; check first 10 buffer lines for Time-stamp: <>
;;   time-stamp-format "%04y-%02m-%02d %02H:%02M:%02S (%u)") ; date format
;; (add-hook 'write-file-hooks 'time-stamp) ; update when saving

;; (setq auto-save-list-file-prefix
;;   "~/.emacs.d/cache/auto-save-list/.saves-")

;; (setq ispell-program-name "aspell"
;;   ispell-extra-args '("--sug-mode=ultra"))