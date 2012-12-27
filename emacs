;; Recursively include ~/.emacs.d files
;;(let* ((my-lisp-dir "~/.emacs.d/")
;;       (default-directory my-lisp-dir))
;;  (setq load-path (cons my-lisp-dir load-path))
;;  (normal-top-level-add-subdirs-to-load-path))
(load "~/.emacs.d/general.el")
(load "~/.emacs.d/misc.el")
(load "~/.emacs.d/handy.el")
(load "~/.emacs.d/modeline.el")
(load "~/.emacs.d/less-css-mode.el")

(ido-mode t)

;; Set default browser to Chromium
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/usr/bin/chromium")

;; Auto-complete mode
(add-to-list 'load-path "/home/ziarkaen/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/ziarkaen/.emacs.d/ac-dict")
(ac-config-default)
(set-default 'ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer ac-source-files-in-current-dir ac-source-symbols))

;; Rope-macs
;; (require 'pymacs)
;; (pymacs-load "ropemacs" "rope-")
;; (setq ropemacs-enable-autoimport t)

;; Yasnippet
(add-to-list 'load-path "~/.emacs.d/yasnippet/")
(require 'yasnippet)
;;(setq yas/trigger-key (kbd "C-c <kp-multiply>"))
(yas/global-mode 1)

(setq ;; scrolling
  scroll-margin 0                        ;; do smooth scrolling, ...
  scroll-conservatively 100000           ;; ... the defaults ...
  scroll-up-aggressively 0               ;; ... are very ...
  scroll-down-aggressively 0             ;; ... annoying
  scroll-preserve-screen-position t)     ;; preserve screen pos with C-v/M-v 

;; Flymake
;; (add-to-list 'load-path "~/.emacs.d/vendor")

;; (add-hook 'find-file-hook 'flymake-find-file-hook)
;; (when (load "flymake" t)
;;   (defun flymake-pyflakes-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                'flymake-create-temp-inplace))
;;        (local-file (file-relative-name
;;             temp-file
;;             (file-name-directory buffer-file-name))))
;;       (list "pycheckers"  (list local-file))))
;;    (add-to-list 'flymake-allowed-file-name-masks
;;              '("\\.py\\'" flymake-pyflakes-init)))
;; (load-library "flymake-cursor")
;; (global-set-key [f10] 'flymake-goto-prev-error)
;; (global-set-key [f11] 'flymake-goto-next-error)

;; ;; Nice lambda symbol
(require 'lambda-mode)
(add-hook 'python-mode-hook #'lambda-mode 1)

;; Org mode
;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; http://mobileorg.ncogni.to/doc/getting-started/using-dropbox/
;; Set to the location of your Org files on your local system
(setq org-directory "~/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")

;; recentf stuff
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(global-set-key "\C-cs" 'shell)


;; Customize stuff
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/Dropbox/tour.org" "~/org/planar.org" "~/org/todo.org")))
 '(org-mobile-files (quote (org-agenda-files)))
 '(safe-local-variable-values (quote ((less-css-compile-at-save . t))))
 '(tooltip-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; EmacsClient config
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)
(server-start)
