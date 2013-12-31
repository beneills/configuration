;; Local Variables:
;; eval: (end-of-buffer)
;; End:




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
              scheme-mode sgml-mode sh-mode sml-mode markdown-mode
	      org-mode)))

;Make completion buffers in a shell disappear after 5 seconds.
;<http://snarfed.org/space/why+I+don't+run+shells+inside+Emacs>
(add-hook 'completion-setup-hook
          (lambda () (run-at-time 5 nil
                                  (lambda () (if (not (equal (buffer-name) "*Completions*"))
						 (delete-windows-on "*Completions*"))))))

; TODO: flyspell

;; Give cutomize its own file
(load (setq custom-file "~/.emacs.d/customize.el"))






;; Stop switching to IRC Network buffers
(add-to-list 'ido-ignore-buffers "^irc\\.")

(defalias 'rs 'replace-string)
(require 'emms-score)
(emms-score 1)


(defun git-commit-this-file (commit-message)
  (interactive "sCommit Message: ")
  (let ((filename buffer-file-name))
    (if filename
	(progn (call-process "git" nil nil nil "reset")
	       (call-process "git" nil nil nil "stage" filename)
	       (call-process "git" nil nil nil "commit" "-m" commit-message))
      (message "Buffer has no filename"))))


(defun find-and-commit ()
  (interactive)
  (with-current-buffer (call-interactively 'ido-find-file)
    (add-hook 'after-save-hook
	      (lambda ()
		(call-interactively 'git-commit-this-file)
		(kill-buffer)) nil t)))


(require 'yasnippet)
(mapc (lambda (f)
	(add-to-list 'yas/root-directory
		     (concat "~/.emacs.d/external-snippets/" f)))
      (directory-files "~/.emacs.d/external-snippets/" nil "^[^\.].*$"))
(yas-global-mode 1)


(set-face-attribute 'default nil :height 95) ;; laptop

(flymake-mode 1)

(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.coffee\\'" . js-mode))

(defun reading-time ()
  (interactive)
  (let* ((words-per-minute 200)
	(characters (if (region-active-p)
			(- (region-end) (region-beginning))
		      (point-max)))
	(words (/ characters 5))
	(estimated-time (/ (float words) words-per-minute)))
    (message (format "Estimated reading time: %2s minutes @ %dwpm" estimated-time words-per-minute))))
