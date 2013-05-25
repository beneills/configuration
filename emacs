;; Recursively include ~/.emacs.d files
;;(let* ((my-lisp-dir "~/.emacs.d/")
;;       (default-directory my-lisp-dir))
;;  (setq load-path (cons my-lisp-dir load-path))
;;  (normal-top-level-add-subdirs-to-load-path))
(load "~/.emacs-secret.el") ;; Passwords, etc.
(load "~/.emacs.d/general.el")
(load "~/.emacs.d/misc.el")
(load "~/.emacs.d/handy.el")
(load "~/.emacs.d/emms.el")
(load "~/.emacs.d/modeline.el")
(load "~/.emacs.d/less-css-mode.el")
(load "~/.emacs.d/irc.el")

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

(global-set-key (kbd "C-x C-r") 'ido-recentf-open)
 
(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))


(global-set-key "\C-cs" 'shell)


;; Customize stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(completion-styles (quote (basic partial-completion emacs22 initials)))
 '(erc-hide-list (quote ("JOIN" "PART" "QUIT")))
 '(erc-input-line-position -1)
 '(erc-join-buffer (quote bury))
 '(fill-column 80)
 '(org-agenda-files (quote ("~/Dropbox/tour.org" "~/org/planar.org" "~/org/todo.org")))
 '(org-mobile-files (quote (org-agenda-files)))
 '(safe-local-variable-values (quote ((less-css-compile-at-save . t))))
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 105 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

;; EmacsClient config
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)
(server-start)

;; Stop requiring yes/no full words
(defalias 'yes-or-no-p 'y-or-n-p)

;; Alow file editing as root
(require 'tramp)
(setq tramp-default-method "scp")
(setq recentf-auto-cleanup 'never) ; stop recentf trying to SSH all the time

;; Avoid typing capitals
(setq read-file-name-completion-ignore-case t)

;; Stop switching to IRC Network buffers
(add-to-list 'ido-ignore-buffers "^irc\\.")

(defun kill-all-dired-buffers()
      "Kill all dired buffers."
      (interactive)
      (save-excursion
        (let((count 0))
          (dolist(buffer (buffer-list))
            (set-buffer buffer)
            (when (equal major-mode 'dired-mode)
              (setq count (1+ count))
              (kill-buffer buffer)))
          (message "Killed %i dired buffer(s)." count ))))

;; Magit
(require 'magit)

;; Open this conf file by default
(let ((conf-file "~/conf/emacs"))
     (unless (get-file-buffer conf-file)
       (and (find-file conf-file)
       	    (rename-buffer "config")
	    (end-of-buffer))))

;; Fix clipboard issue
(setq x-select-enable-clipboard t)
(setq x-select-enable-primary nil)
(setq mouse-drag-copy-region nil)

;; Magit
(global-set-key (kbd "C-x g") 'magit-status)

;; No more M-x
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; Scroll bar off
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Easy backward-kill-word OVERWRITES mark-defun binding
(global-set-key (kbd "C-M-h") 'backward-kill-word)

;; Fix STicky CHars caused by my sloppy touch-typing
(defun fix-sticky-chars ()
  (interactive)
  (save-excursion
    (let (case-fold-search 'nil)
      (if (re-search-backward "\\<[[:upper:]]\\{2\\}"
			  0
			  't)
	  (progn (forward-char)
		 (push-mark)
		 (forward-char)
		 (call-interactively 'downcase-region)
		 (message "Fixed a sticky key error.")
		 't)
	'nil))))
	

;; Fix semicolon typo e.g. "didn;t"
(defun fix-semicolon-apostrophe ()
  (interactive)
  (save-excursion
    (if (re-search-backward "\\w;\\w"
			      0
			      't)
	(progn
	 (forward-char)
	 (delete-char 1)
	 (insert "'")
	 (message "Fixed a semi-colon error.")
	 't)
      nil)))

(defun fix-stuff ()
       (interactive)
       (or (call-interactively 'fix-semicolon-apostrophe)
       	   (call-interactively 'fix-sticky-chars)))

(global-set-key (kbd "C-c k") 'fix-stuff)

;; Hide dot-files by default in dired
(require 'dired-x)
(setq dired-omit-files "^\\...+$")
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)))


(require 'package)
;; Add the original Emacs Lisp Package Archive
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
;; Add the user-contributed repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
