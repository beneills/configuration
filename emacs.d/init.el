;; Sources:
;;   http://en.wikipedia.org/wiki/User:Gwern/.emacs
;;   http://www.cabochon.com/~stevey/blog-rants/my-dot-emacs-file.html

;; Secrets!
(load-file "~/.secret/emacs.el")

;; Package Management
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))


;; keep last few versions backed up, but save in .emacs_backups/
(setq version-control t)
(setq delete-old-versions t)
(setq backup-directory-alist '((".*" . "~/.emacs_backups/")))

;; EmacsClient config
(server-start)

;; Magit
;; (defun magit-status-ben()
;;   "If we are in ~/, use ~/conf as git directory"
;;   (interactive)
;;   (if (equal default-directory "/home/ziarkaen/")
;;       (magit-status "/home/ziarkaen/conf/")
;;       (call-interactively 'magit-status)))
(setq vc-follow-symlinks t) ; make magit work with dotfiles in ~/

;; Auto-revert mode
(add-hook 'dired-mode-hook 'turn-on-auto-revert-mode)
(setq auto-revert-verbose nil)


;; Avoid typing capitals
(setq read-file-name-completion-ignore-case t)

;;; Shell mode
;(defadvice process-kill-buffer-query-function (around no-prompt-for-shells
;						      protect)
;  "Don't prompt user when killing shell with running process"
;  (message major-mode)
;  (let ((modes '("shell-mode")))
;  (unless (member major-mode modes)
;    ad-do-it)))

(push '("bashrc$" . sh-mode) auto-mode-alist)
(push '("xsession$" . sh-mode) auto-mode-alist)

;"Set up highlighting of special words for selected modes."
; <http://www.metasyntax.net/unix/dot-emacs.html>
(make-face 'taylor-special-words)
(set-face-attribute 'taylor-special-words nil :foreground "White" :background "Firebrick")
(let ((pattern "\\<\\(FIXME\\|TODO\\|NOTE\\|WARNING\\|BUGS\\|TO DO\\|FIXME\\|FIX_ME\\|FIX ME\\|HACK\\)"))
  (mapc
   (lambda (mode)
     (font-lock-add-keywords mode `((,pattern 1 'taylor-special-words prepend))))
   '(ada-mode c-mode emacs-lisp-mode java-mode haskell-mode
              literate-haskell-mode html-mode lisp-mode php-mode python-mode ruby-mode
              scheme-mode sgml-mode sh-mode sml-mode markdown-mode)))

;Make completion buffers in a shell disappear after 5 seconds.
;<http://snarfed.org/space/why+I+don't+run+shells+inside+Emacs>
(add-hook 'completion-setup-hook
          (lambda () (run-at-time 5 nil
                                  (lambda () (if (not (equal (buffer-name) "*Completions*"))
						 (delete-windows-on "*Completions*"))))))

; TODO: flyspell

;; Give cutomize its own file
(load "~/.emacs.d/customize.el")

;; Load other init files
(let ((init-files (directory-files "~/.emacs.d/" nil "^init-.*\.el$")))
  (mapc 'load-file 
	(mapcar (lambda (file) (concat "~/.emacs.d/" file)) init-files)))

;; Stop switching to IRC Network buffers
(add-to-list 'ido-ignore-buffers "^irc\\.")
