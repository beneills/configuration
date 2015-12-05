
(setq user-full-name    "Ben Eills"
      user-mail-address "ben@beneills.com")

(add-to-list 'load-path "~/.emacs.d/load/")

(setq package-list '(expand-region yaml-mode markdown-mode helm yasnippet magit minimap))

; list the repositories containing them
(setq package-archives '(("gnu"       . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
(package-refresh-contents))

; install the missing packages
(dolist (package package-list)
(unless (package-installed-p package)
(package-install package)))

(setq inhibit-startup-message           t
      inhibit-startup-echo-area-message t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq disabled-command-function nil)

(global-unset-key [(control x)
                   (control c)])
(defalias 'quit 'save-buffers-kill-terminal)

(global-unset-key [(control z)])
(global-unset-key [(control x)
                   (control z)])

(when
    (file-directory-p "/home/ben")
  (setq default-directory "/home/ben"))

(global-set-key (kbd "C-=") 'er/expand-region)

(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR.

  \(fn arg char)"
  'interactive)

(global-set-key "\M-z" 'zap-up-to-char)

(setq org-default-notes-file "~/org/notes.org")

(defun org-todo-and-next ()
  "Toggle todo status and go to next line"
  (interactive)
  (org-todo)
  (search-forward "TODO"))

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c w") 'bold-word)
            (local-set-key (kbd "C-c b") 'blue-word)
            (local-set-key (kbd "C-c t") 'org-todo-and-next)))

;; org-mode
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

(when
    (or (file-exists-p "~/.work-blue")
        (file-exists-p "~/.home"))
  (add-hook 'org-pomodoro-finished-hook
            (lambda ()
              (shell-command "notify-send \"Pomodoro finished\"")))
  (add-hook 'org-pomodoro-break-finished-hook
            (lambda ()
              (shell-command "notify-send \"Pomodoro break finished\""))))

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-x C-i") 'org-pomodoro)))

(when
    (fboundp 'winner-mode)
  (winner-mode 1))

(ido-mode nil)

(require 'recentf nil 'noerror)

;; YAML
 (require 'yaml-mode nil 'noerror)
 (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
 (add-hook 'yaml-mode-hook
           '(lambda ()
              (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; Markdown
(require 'markdown-mode nil 'noerror)
(add-to-list 'auto-mode-alist '
             ("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '
             ("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '
             ("\\.md\\'" . markdown-mode))
(add-hook 'markdown-mode-hook
          (lambda ()
            (when buffer-file-name
              (add-hook 'after-save-hook 'check-parens nil t))))

;; Alow file editing as root
(require 'tramp nil 'noerror)
(setq tramp-default-method "scp")

(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-auto-cleanup 'never)   ; stop recentf trying to SSH all the time

(require 'uniquify nil 'noerror)

;; make buffer names more unique
(setq      uniquify-buffer-name-style 'post-forward     uniquify-separator ":"
           uniquify-after-kill-buffer-p t     uniquify-ignore-buffers-re "^\\*") ;; recentf stuff

;; ;; EMMS
;; (require 'emms-setup nil 'noerror)
;; (require 'emms-volume nil 'noerror)
;; (emms-standard)
;; (emms-default-players)
;; (setq emms-source-file-default-directory "~/music/")
;; (setq emms-player-mpg321-parameters '("-o" "alsa"))
;; (emms-mode-line-disable)
;; (emms-playing-time-disable-display)
;;
;; lastfm settings in ~/.secret/emacs.el - disabled currently
;;
;; EMMS
;; ;(add-to-list 'load-path "~/.emacs.d/emms")
;; ;(require 'emms-setup nil 'noerror)
;; ;(require 'emms-streams nil 'noerror)
;; ;(emms-standard)
;; ;(emms-default-players)

;; ;; Don't block other audio apps
;; (global-set-key (kbd "C-c e x") 'emms-start)
;; (global-set-key (kbd "C-c e v") 'emms-stop)
;; (global-set-key (kbd "C-c e n") 'emms-next)
;; (global-set-key (kbd "C-c e p") 'emms-previous)
;; (global-set-key (kbd "C-c e a") 'emms-random)
;; (global-set-key (kbd "C-c e o") 'emms-show)
;; (global-set-key (kbd "C-c e h") 'emms-shuffle)
;; (global-set-key (kbd "C-c e SPC") 'emms-pause)
;; (global-set-key (kbd "C-c e r") 'emms-toggle-repeat-track)
;; (global-set-key (kbd "C-c e R") 'emms-toggle-repeat-playlist)
;; (global-set-key (kbd "C-c e l") 'emms-lyrics-toggle-display-buffer)
;; (global-set-key (kbd "C-c e L") 'emms-lyrics-visit-lyric)
;; (global-set-key (kbd "C-c e s")
;;                 (lambda ()
;;                   (interactive)
;;                   (emms-score-set-playing 4)))
;; (global-set-key (kbd "C-c e k") 'emms-lastfm-radio-skip)
;; (global-set-key (kbd "C-c e g") 'emms-playlist-mode-go)
;; ;;
;; (global-set-key (kbd "C-c e a") 'emms-add-directory-tree)
;; (global-set-key (kbd "C-c e t") 'emms-play-directory-tree)
;; (global-set-key (kbd "C-c e <up>") 'emms-volume-raise)
;; (global-set-key (kbd "C-c e <down>") 'emms-volume-lower)

;; (require 'emms-score nil 'noerror)
;; (emms-score 1)

(defun ruby-eval-region()   "Prints the evaluation of Ruby statements in region to a new output buffer"   (interactive)   (let ((output-buffer "Ruby Output"))     (shell-command-on-region (mark) (point) "ruby" output-buffer)))

(defun ruby-eval-region()   "Prints the evaluation of Ruby statements in region to a new output buffer"   (interactive)   (let ((output-buffer "Ruby Output"))     (shell-command-on-region (mark) (point) "ruby" output-buffer)     (switch-to-buffer output-buffer)))

(defun ruby-pretty-print()   "Pretty prints the evaluation of a Ruby expression in region to a new output buffer"   (interactive)   (save-excursion     (let ((code (buffer-substring (mark) (point)))      (code-buffer (generate-new-buffer "ruby-code")))       (switch-to-buffer code-buffer)       (insert (concat "require 'pp'\nputs (" code ")\n"))       (mark-whole-buffer)       (ruby-eval-region)       (kill-buffer code-buffer))))

(require 'expand-region nil 'noerror)

;; use helm everywhere
(if (functionp 'helm-mode)
  (helm-mode 1))

(setq helm-command-prefix-key "C-c h")

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(require 'yasnippet nil 'noerror)
(yas-global-mode t)

;;  slow!
;;  (projectile-global-mode)

(global-set-key "\C-cz" 'speedbar)

(setq-default dired-listing-switches "-alhv")

(setq backup-directory-alist '((".*" . "~/.emacs.d/backups")))
(setq version-control t)

(setq delete-old-versions t)

(savehist-mode t)
(setq savehist-additional-variables '(kill-ring
                                      search-ring
                                      regexp-search-ring
                                      qlist))

(setq show-paren-delay 0)
(when (fboundp 'show-paren-mode)
  (show-paren-mode t))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode '(0 . 0))

;; (setq scroll-margin 0
;;       scroll-conservatively 100000
;;       scroll-up-aggressively 0
;;       scroll-down-aggressively 0
;;       scroll-preserve-screen-position t)

(when (fboundp 'global-hl-line-mode) (global-hl-line-mode t))

(make-face 'taylor-special-words)
(set-face-attribute 'taylor-special-words nil :foreground "White" :background "Firebrick")
(let ((pattern "\\<\\(FIXME\\|TODO\\|NOTE\\|WARNING\\|BUGS\\|TO DO\\|FIXME\\|FIX_ME\\|FIX ME\\|HACK\\)"))   (mapc    (lambda (mode)      (font-lock-add-keywords mode `((,pattern 1 'taylor-special-words prepend))))    '(ada-mode c-mode emacs-lisp-mode java-mode haskell-mode               literate-haskell-mode html-mode lisp-mode php-mode python-mode ruby-mode               scheme-mode sgml-mode sh-mode sml-mode markdown-mode             )))

;;(load-theme 'solarized-light t)

;; Magit
;; (defun magit-status-ben()
;;   "If we are in ~/, use ~/conf as git directory"
;;   (interactive)
;;   (if (equal default-directory "/home/ziarkaen/")
;;       (magit-status "/home/ziarkaen/conf/")
;;       (call-interactively 'magit-status)))   (setq vc-follow-symlinks t) ; make magit work with dotfiles in ~/
(global-set-key (kbd "C-x g") 'magit-status)

(server-start)
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;; Start maximizeded
(defun activate-maximized ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                 '(1 "_NET_WM_STATE_MAXIMIZED_VERT"
                  "_NET_WM_STATE_MAXIMIZED_HORZ")))
(if (window-system)
    (run-at-time 2 nil 'activate-maximized))

(let ((config-path "~/.emacs.d/beneills.org"))
  (unless (get-file-buffer config-path)
    (find-file config-path)
    (rename-buffer "config")))

(let ((gtd-path "~/org/gtd.org"))
  (unless (get-file-buffer gtd-path)
    (find-file gtd-path)))

(load (setq custom-file "~/.emacs.d/customize.el"))

;;; ERC configuration   (require 'erc-services nil 'noerror)      (erc-services-mode 1)
;;; Set up IRC stuff and connect to my networks.   (defun connect-to-irc ()     "Connect to IRC."     (interactive)     (erc :server "irc.freenode.net" :port 6667          :nick "Ziarkaen" :full-name "Ziarkaen"))   ;  (erc :server "irc.snoonet.org" :port 6667   ;       :nick "Ziarkaen" :full-name "Ziarkaen"))         (setq erc-prompt-for-nickserv-password nil)   (setq erc-nickserv-passwords         `((freenode     (("Ziarkaen" . ,freenode-nickserv-password)))))            (setq erc-autojoin-channels-alist '(("freenode.net" "#emacs" "##French" "##math"                                                       "#ruby" "#latin")))   ;                                   ("snoonet.org" "#totallanguage")))
;; Only use modebar when something important happens   (setq erc-format-query-as-channel-p t           erc-track-priority-faces-only 'all           erc-track-faces-priority-list '(erc-error-face                                           erc-current-nick-face                                           erc-keyword-face                                           erc-nick-msg-face                                           erc-direct-msg-face                                           erc-dangerous-host-face                                           erc-prompt-face))
;; Keep prompt anchored to bottom of buffer.  Why would I want it half-way up?!   (require 'erc-goodies nil 'noerror)
;;(erc-scroll-to-bottom-mode 1)

;; Originally from stevey, adapted to support moving to a new directory.
;; (defun rename-file-and-buffer
;; (new-name)     "Renames both current buffer and file it's visiting to NEW-NAME."     (interactive
;;                                                                                       (progn
;;                                                                                         (if (not
;;                                                                                              (buffer-file-name))
;;                                                                                             (error
;;                                                                                              "Buffer '%s' is not visiting a file!"
;;                                                                                              (buffer-name)))
;;                                                                                         (list
;;                                                                                          (read-file-name
;;                                                                                           (format
;;                                                                                            "Rename %s to: "
;;                                                                                            (file-name-nondirectory
;;                                                                                             (buffer-file-name)))))))     (if
;;                                                                                                    (equal
;;                                                                                                     new-name
;;                                                                                                     "")
;;                                                                                                    (error
;;                                                                                                     "Aborted
;;  rename")))
;; (setq new-name (if (file-directory-p new-name)
;;                    (expand-file-name (file-name-nondirectory
;;                                       (buffer-file-name))
;;                                      new-name)
;;                  (expand-file-name new-name)))
;; If the file isn't saved yet, skip the file rename, but still update the
;; buffer name and visited file.     (if (file-exists-p (buffer-file-name))         (rename-file (buffer-file-name) new-name 1))     (let ((was-modified (buffer-modified-p)))
;; This also renames the buffer, and works with uniquify       (set-visited-file-name new-name)       (if was-modified           (save-buffer)
;; Clear buffer-modified flag caused by set-visited-file-name         (set-buffer-modified-p nil))     (message "Renamed to %s." new-name)))
(defun ido-recentf-open
  ()     "Use `ido-completing-read' to \\[find-file] a recent file"     (interactive)     (if
                                                                                            (find-file
                                                                                             (ido-completing-read
                                                                                              "Find recent file: "
                                                                                              recentf-list))
                                                                                            (message
                                                                                             "Opening
 file...")
                                                                                          (message
                                                                                           "Aborting")))
(defun my-open-at-point
()
(interactive)
(condition-case nil
    (call-interactively 'org-open-at-point-global)
  (error
   (find-file-at-point))))      (defun ben-log
(message)
(let ((log-command "~/projects/log/log.rb"))
  (shell-command (format "%s %s > /dev/null" log-command message))))      (defun grep-todos
()
(interactive)
(let ((todo-exclude-directories '("~/archive"                                       "~/backup"
                                  "~/bin/brainworkshop_files"
                                  "~/plans"                                       "~/.ido.last"
                                  "~/books"                                       "~/calibre"
                                  "~/conf/emacs.d/elpa"
                                  "~/downloads"                                       "~/images"
                                  "~/music"                                       "~/nobackup"
                                  "~/plans"                                       "~/queue"
                                  "~/torrents"                                       "~/.cache"
                                  "~/.config"                                       "~/.dbus"
                                  "~/.dropbox"
                                  "~/.dropbox-dist"
                                  "~/.emacs_backups"
                                  "~/.gconf"                                       "~/.gem"
                                  "~/.gnome2"
                                  "~/.gnome2_private"
                                  "~/.gstreamer-0.10"
                                  "~/.ido.last"                                       "~/.kde"
                                  "~/.local"                                       "~/.macromedia"
                                  "~/.marks"                                       "~/.matplotlib"
                                  "~/.mozilla"                                       "~/.mplayer"
                                  "~/.onboard"                                       "~/.pan2"
                                  "~/.pki"                                       "~/.plan"
                                  "~/.purple"                                       "~/.sabnzbd"
                                  "~/.secret"                                       "~/.ssh"
                                  "~/.wicd"))           (find-args
                                                         "find ~/ -type d \\(! -path \\.git \\) \\(-path %s \\) -prune -o -type f -exec grep -nH -e TODO {} +"))
  (grep-find (format find-args                          (mapconcat 'identity
                                                                   todo-exclude-directories
                                                                   " -o -path ")))))

(defun kill-current-position ()
  "Kill current position as '</path/to/file>:<line-number>'"
  (interactive)
  (let ((path-with-line-number
         (concat (buffer-file-name) ":" (number-to-string (line-number-at-pos)))))
    (kill-new path-with-line-number)
    (message (concat path-with-line-number " killed."))))

(setq remember-file "~/org/emacs-remember")

(defun remember-key (key)
  (interactive "KKey seq: \n")
  (with-temp-buffer
    (insert (concat (key-description key) "\t;; " (symbol-name (key-binding key)) "\n"))
    (when (file-writable-p remember-file)
      (append-to-file (point-min)
                      (point-max) remember-file))))
(defun remember-command (command)
  (interactive "CCommand: \n")
  (with-temp-buffer
    (insert (concat (symbol-name command) "\n"))
    (when (file-writable-p remember-file)
      (append-to-file (point-min)
                      (point-max) remember-file))))

(global-set-key (kbd "C-c r k") 'remember-key)
(global-set-key (kbd "C-c r c") 'remember-command)

(setq require-final-newline t)
  (setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium-browser")

  ;; Auto-revert mode   (add-hook 'dired-mode-hook 'turn-on-auto-revert-mode)   (setq auto-revert-verbose nil)
  ;;; Shell mode   ;(defadvice process-kill-buffer-query-function (around no-prompt-for-shells   ;                                                     protect)   ;  "Don't prompt user when killing shell with running process"   ;  (message major-mode)   ;  (let ((modes '("shell-mode")))   ;  (unless (member major-mode modes)   ;    ad-do-it)))      (push '("bashrc$" . sh-mode) auto-mode-alist)   (push '("xsession$" . sh-mode) auto-mode-alist)         ;Make completion buffers in a shell disappear after 5 seconds.   ;<http://snarfed.org/space/why+I+don't+run+shells+inside+Emacs>   (add-hook 'completion-setup-hook             (lambda () (run-at-time 5 nil                                     (lambda () (if (not (equal (buffer-name) "*Completions*"))                                                    (delete-windows-on "*Completions*"))))))      ; TODO: flyspell
  ;; Stop switching to IRC Network buffers
  (add-to-list 'ido-ignore-buffers "^irc\\.")
  (defalias 'rs 'replace-string)
  (defun git-commit-this-file (commit-message)
    (interactive "sCommit Message: ")
    (let ((filename buffer-file-name))
      (if filename
          (progn
            (call-process "git" nil nil nil "reset")
            (call-process "git" nil nil nil "stage" filename)
            (call-process "git" nil nil nil "commit" "-m" commit-message))
        (message "Buffer has no filename"))))
  (defun find-and-commit ()
    (interactive)
    (with-current-buffer (call-interactively 'ido-find-file)
      (add-hook 'after-save-hook
                (lambda ()
                  (call-interactively 'git-commit-this-file)
                  (kill-buffer))
                nil t))) ;;

   ;; (mapc (lambda (f)   ;;      (add-to-list 'yas/root-directory   ;;                   (concat "~/.emacs.d/external-snippets/" f)))   ;;       (directory-files "~/.emacs.d/external-snippets/" nil "^[^\.].*$"))   ;; (yas-global-mode 1)         ;; (set-face-attribute 'default nil :height 95) ;; laptop      ;; (flymake-mode 1)      (add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))   (add-to-list 'auto-mode-alist '("\\.coffee\\'" . js-mode))
  (defun reading-time ()
    (interactive)
    (let* ((words-per-minute 200)
           (characters
            (if (region-active-p)
                (- (region-end)
                   (region-beginning))
              (point-max)))
           (words (/ characters 5))
           (estimated-time (/ (float words) words-per-minute)))
      (message (format "Estimated reading time: %2s minutes @ %dwpm" estimated-time words-per-minute))))

;;  (add-hook 'after-init-hook 'org-todo-list)

  (fset 'perl-mode 'cperl-mode)

  (defun mmrz-jump-to-field ()
   (interactive)
   (search-forward "|")
   (search-forward " "))

(define-minor-mode mmrz-mode
  "Mmrz."
  :lighter " mmrz"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c C-c") 'mmrz-jump-to-field)
            map))

(setq macro-file "~/.emacs.d/macros.el")

  ;; TODO
  (defun ben/name-persist-last-macro (symbol)
    (interactive "SName for last kbd macro: ")
    (or last-kbd-macro
        (error "No keyboard macro defined"))
    (and (fboundp symbol)
         (not (get symbol 'kmacro))
         (not (stringp (symbol-function symbol)))
         (not (vectorp (symbol-function symbol)))
         (error "Function %s is already defined and not a keyboard macro"
                symbol))
    (if (string-equal symbol "")
        (error "No command name given"))
    (fset symbol (kmacro-lambda-form (kmacro-ring-head)))
    (put symbol 'kmacro t)

    ;; and save to file
    (with-output-to-temp-buffer
;;      (prin1 (kmacro-lambda-form (kmacro-ring-head)))
      (princ "\n\n")
      (when (file-writable-p macro-file)
        (append-to-file (point-min)
                        (point-max) macro-file))))

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-cs"
                (lambda ()
                  (interactive)
                  (set-process-query-on-exit-flag                      (get-buffer-process
                                                                        (ansi-term "/bin/bash"))
                                                                       nil)))
(global-set-key "\C-x\ W" 'rename-file-and-buffer)
(global-set-key "\C-c\C-o" 'my-open-at-point)

(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key "\C-cic" 'connect-to-irc)

;; better buffer list
(global-set-key "\C-x\C-b" 'bs-show)
;; No more fill-column
(global-set-key "\C-x\ f" 'find-file)
;; reload
(global-set-key (kbd "C-c g")
                (lambda ()
                  (interactive)
                  (load-file "/home/ziarkaen/.emacs.d/init.el")))
;;
;; (define-key dired-mode-map (kbd "b") 'dired-dotfiles-toggle)
(global-set-key "\M-/" 'hippie-expand)

(global-set-key (kbd "C-c C-r") 'rgrep)

(when
    (file-exists-p "~/.work-blue")
  (message "Loading work-blue-specific emacs config...")
  (org-babel-load-file "~/.emacs.d/work-blue.org"))

;;  (load-file "~/.secret/emacs.el")

;; Avoid typing capitals
(setq read-file-name-completion-ignore-case t)

;; (defadvice find-tag (after find-tag-recenter)
;;   "Recenter screen upon find-tag."
;;   (recenter-top-bottom 0))

;; (ad-activate 'find-tag)

(unless  (boundp 'qlist)
  (setq qlist (list)))

(defun add-to-qlist ()
  (interactive)
  (let ((item (or (and transient-mark-mode mark-active
                       (/= (point) (mark))
                       (buffer-substring-no-properties (point) (mark)))
                  (funcall (or find-tag-default-function
                               (get major-mode 'find-tag-default-function)
                               'find-tag-default))
                  "")))
    (message "Adding %s." item)
    (add-to-list 'qlist item)))

(defun add-custom-to-qlist (string)
  (interactive "sItem: ")
  (message "Adding %s." string)
  (add-to-list 'qlist string))

(defun delete-from-qlist ()
  (interactive)
  (message "Deleted %s." (car qlist))
  (setq qlist (cdr qlist)))

(defun copy-from-qlist ()
  (interactive)
  (message "Copied %s." (car qlist))
  (kill-new (car qlist)))

(defun reset-qlist ()
  (interactive)
  (setq qlist (list))
  (message "Qlist reset."))

(defun qlist ()
  (interactive)
  (message "%s" qlist))

(global-set-key (kbd "C-c q a") 'add-to-qlist)
(global-set-key (kbd "C-c q c") 'add-custom-to-qlist)
(global-set-key (kbd "C-c q d") 'delete-from-qlist)
(global-set-key (kbd "C-c q w") 'copy-from-qlist)
(global-set-key (kbd "C-c q q") 'qlist)
(global-set-key (kbd "C-c q r") 'reset-qlist)

(global-set-key (kbd "C-c m") 'minimap-toggle)

(setq translation-repeat-interval 10)
  (setq translation-pause-length 3)
  (setq translation-dictionary-offset 0)
  
;;  (defun translation-load (filename)
;;    (save-excursion
;;      (find-file filename)
;;      (goto-char 1)
;;      (let ((more-lines t))
;;        (while more-lines
;;          (message

  (defun translation-first (translation)
    (nth 0 translation))
  
  (defun translation-second (translation)
    (concat
     (nth 0 translation)
     " -> "
     (nth 1 translation)))
  
  (defun translation-show (translation)
    (run-at-time translation-pause-length nil
                 (lambda (translation)
                   (message (translation-second translation)))
                 translation)
    (message (translation-first translation)) nil)
  
  (defun translation-start (dictionary)
    (interactive)
    (setq translation-dictionary-offset 0)
    (setq translation-timer
          (run-at-time 0 translation-repeat-interval
                       (lambda (dictionary)
                         (let ((translation 
                                (nth
                                 (mod (translation-dictionary-offset) (length dictionary))
                                 dictionary)))
                           (translation-show translation))
                         (setq translation-dictionary-offset
                               (+ 1 translation-dictionary-offset)))
                       dictionary)))
  
  (defun translation-stop ()
    (interactive)
    (cancel-timer translation-timer))
  
  (define-minor-mode tr-mode
    "Toggle tr mode.
     blah."
    ;; The initial value.
    nil
    ;; The indicator for the mode line.
    " Tr"
    nil
    :group 'tr
    (if tr-mode
        (progn
          (setq minor-mode-alist (delq (assoc 'tr-mode minor-mode-alist) minor-mode-alist))
          (add-to-list 'minor-mode-alist `(tr-mode ,(format-time-string " %S"))))
      ()))
