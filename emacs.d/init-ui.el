;; Scrolling
(setq
  scroll-margin 0
  scroll-conservatively 100000
  scroll-up-aggressively 0
  scroll-down-aggressively 0
  scroll-preserve-screen-position t)

;; GUI
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq fringe-mode '(1 . 0))
(when (fboundp 'global-hl-line-mode) (global-hl-line-mode t))
(when (fboundp 'show-paren-mode)
  (show-paren-mode t))

;; Avoid typing capitals
(setq read-file-name-completion-ignore-case t)

;; Stop requiring yes/no full words
(defalias 'yes-or-no-p 'y-or-n-p)

(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

(setq inhibit-startup-message t
  inhibit-startup-echo-area-message t)

;; Enable all commands
(setq disabled-command-function nil)

;;;;
;;;; More sensible defaults
;;;;

;; Set default browser to Chromium
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/usr/bin/chromium-browser")

;; ;; Start maximizeded
;; (defun activate-maximized ()
;;   (interactive)
;;   (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
;;                  '(1 "_NET_WM_STATE_MAXIMIZED_VERT"
;; 		     "_NET_WM_STATE_MAXIMIZED_HORZ")))
;; (if (window-system)
;;     (run-at-time 2 nil 'activate-maximized))

(setq require-final-newline t)
