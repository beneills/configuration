;; General setup
;; Adapted from http://www.djcbsoftware.nl/dot-emacs.html
;; Thu Aug  2 22:05:18 2012

(tool-bar-mode -1)                       ;; turn-off toolbar 
(menu-bar-mode -1)                       ;;   ...and menu

;;(setq cua-enable-cua-keys nil)           ;; only for rectangles
;;(cua-mode t)

(setq ;; scrolling
  scroll-margin 0                        ;; do smooth scrolling, ...
  scroll-conservatively 100000           ;; ... the defaults ...
  scroll-up-aggressively 0               ;; ... are very ...
  scroll-down-aggressively 0             ;; ... annoying
  scroll-preserve-screen-position t)     ;; preserve screen pos with C-v/M-v 

(setq fringe-mode '(1 . 0))              ;; emacs 22+
;;(delete-selection-mode 1)                ;; delete the sel with a keyp

(setq x-select-enable-clipboard t        ;; copy-paste should work ...
  interprogram-paste-function            ;; ...with...
  'x-cut-buffer-or-selection-value)      ;; ...other X clients

;; Default anyway?
;; (fset 'yes-or-no-p 'y-or-n-p)            ;; enable y/n answers to yes/no 

(setq completion-ignore-case t           ;; ignore case when completing...
  read-file-name-completion-ignore-case t) ;; ...filenames too

;; TODO Fix
;; (setq-default
;;  frame-title-format
;;  '(:eval
;;    (format "%s@%s:%s"
;;            (or (file-remote-p default-directory 'user) user-login-name)
;;            (or (file-remote-p default-directory 'host) system-name)
;;            (file-name-nondirectory (or (buffer-file-name) default-directory)))))

(setq inhibit-startup-message t          ;; don't show ...    
  inhibit-startup-echo-area-message t)   ;; ... startup messages
(setq require-final-newline t)           ;; end files with a newline


;; Enable copy/kill line when nothin selected
;; slick-copy: make copy-past a bit more intelligent
;; from: http://www.emacswiki.org/emacs/SlickCopy
(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single
line instead."
  (interactive
    (if mark-active (list (region-beginning) (region-end))
      (message "Copied line")
      (list (line-beginning-position)
               (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single
line instead."
  (interactive
    (if mark-active (list (region-beginning) (region-end))
      (list (line-beginning-position)
        (line-beginning-position 2)))))

;; Don't clutter directories wt backup files
(setq backup-directory-alist '(("." . "~/.backup")))


;; Start maximizeded
(defun activate-maximized ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                 '(1 "_NET_WM_STATE_MAXIMIZED_VERT"
		     "_NET_WM_STATE_MAXIMIZED_HORZ"))
)
(if (window-system)
  (activate-maximized))
