;; Sources:
;;   http://en.wikipedia.org/wiki/User:Gwern/.emacs
;;   http://www.cabochon.com/~stevey/blog-rants/my-dot-emacs-file.html



;; Secrets!
(load-file "~/.secret/emacs.el")

;;;;
;;;; General keybindings
;;;;

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-cs" 'shell)
(global-set-key "\C-cp" 'plan)
(global-set-key "\C-x\ W" 'rename-file-and-buffer)

;;;;
;;;; More sensible defaults
;;;;

;; Set default browser to Chromium
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/usr/bin/chromium-browser")

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

;; Package Management
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

;; Give cutomize its own file
(setq custom-file "~/.emacs.d/customize.el")
(load custom-file)

;; Avoid typing capitals
(setq read-file-name-completion-ignore-case t)

;; keep last few versions backed up, but save in .emacs_backups/
(setq version-control t)
(setq delete-old-versions t)
(setq backup-directory-alist '((".*" . "~/.emacs_backups/")))

;; Stop requiring yes/no full words
(defalias 'yes-or-no-p 'y-or-n-p)

;; EmacsClient config
(server-start)
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

(setq inhibit-startup-message t
  inhibit-startup-echo-area-message t)

(setq require-final-newline t)


;; Plan
(setq plan-path (format-time-string "~/plans/%Y-%m-%d.org"))
(defun plan()
  "View plan fullscreen"
  (interactive)
  (find-file plan-path)
  (delete-other-windows))

;;; Org Mode - HOOK MUST BE SET BEFORE DEFAULT ORG FILES
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

;; IDO
(ido-mode t)

;; EMMS
(require 'emms-setup)
(emms-standard)
(emms-default-players)


;; Magit
;; (defun magit-status-ben()
;;   "If we are in ~/, use ~/conf as git directory"
;;   (interactive)
;;   (if (equal default-directory "/home/ziarkaen/")
;;       (magit-status "/home/ziarkaen/conf/")
;;       (call-interactively 'magit-status)))
(setq vc-follow-symlinks t) ; make magit work with dotfiles in ~/
(global-set-key (kbd "C-x g") 'magit-status)

;; Startup
(setq default-files `(("emacs-config" . "~/conf/emacs.d/init.el")
		      ("bash-config" . "~/conf/bashrc")
		      ("awesome-config" . "~/conf/config/awesome/rc.lua")
		      ("plan" . ,plan-path)
		      ("daily" . "~/.plan/templates/daily.org")))

(setq default-directories '(("bin" . "~/bin")
			    ("projects" . "~/projects"))) ; we want ~/projects last

(dolist (item default-files)
  (let ((name (car item))
	(path (cdr item)))
     (unless (get-file-buffer path)
       (find-file path)
       (rename-buffer name))))

(dolist (item default-directories)
  (let ((name (car item))
	(path (cdr item)))
     (unless (get-buffer name)
       (dired path)
       (rename-buffer name))))


;; Is this our first startup today? Designed to be called *once* only
(defun first-startup-today-p ()
  (let ((path (format-time-string "~/.emacs.d/daily-startup/%Y-%m-%d.touch")))
    (if (file-exists-p path)
	nil
      (progn (shell-command (concat "touch " path)) t))))

;; Plan in morning, projects otherwise
(if (first-startup-today-p)
    (switch-to-buffer "plan")
  (switch-to-buffer "projects"))


;;;; Dired
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

(defun dired-dotfiles-toggle ()
  "Show/hide dot-files"
  (interactive)
  (when (equal major-mode 'dired-mode)
    (if (or (not (boundp 'dired-dotfiles-show-p)) dired-dotfiles-show-p) ; if currently showing
	(progn
	  (set (make-local-variable 'dired-dotfiles-show-p) nil)
	  (message "h")
	  (dired-mark-files-regexp "^\\\.")
	  (dired-do-kill-lines))
      (progn (revert-buffer) ; otherwise just revert to re-show
	     (set (make-local-variable 'dired-dotfiles-show-p) t)))))

(define-key dired-mode-map (kbd "b") 'dired-dotfiles-toggle)


;; Auto-revert mode
(add-hook 'dired-mode-hook 'turn-on-auto-revert-mode)
(setq auto-revert-verbose nil)


;; Stop switching to IRC Network buffers
(add-to-list 'ido-ignore-buffers "^irc\\.")

;; Avoid typing capitals
(setq read-file-name-completion-ignore-case t)

;; Alow file editing as root
(require 'tramp)
(setq tramp-default-method "scp")
(setq recentf-auto-cleanup 'never) ; stop recentf trying to SSH all the time








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





;; Start maximizeded
(defun activate-maximized ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                 '(1 "_NET_WM_STATE_MAXIMIZED_VERT"
		     "_NET_WM_STATE_MAXIMIZED_HORZ")))
(if (window-system)
    (run-at-time 2 nil 'activate-maximized))

(require 'uniquify) ;; make buffer names more unique
(setq 
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":"
  uniquify-after-kill-buffer-p t
  uniquify-ignore-buffers-re "^\\*")





;; http://www.emacswiki.org/cgi-bin/wiki/ShowParenMode

;;; Shell mode
;(defadvice process-kill-buffer-query-function (around no-prompt-for-shells
;						      protect)
;  "Don't prompt user when killing shell with running process"
;  (message major-mode)
;  (let ((modes '("shell-mode")))
;  (unless (member major-mode modes)
;    ad-do-it)))



;;; ERC configuration
(require 'erc-services)

(erc-services-mode 1)


     
;;; Set up IRC stuff and connect to my networks.
(defun connect-to-irc ()
  "Connect to IRC."
  (interactive)
  (erc :server "irc.freenode.net" :port 6667
       :nick "Ziarkaen" :full-name "Ziarkaen"))
;  (erc :server "irc.snoonet.org" :port 6667
;       :nick "Ziarkaen" :full-name "Ziarkaen"))


(setq erc-prompt-for-nickserv-password nil)
(setq erc-nickserv-passwords
      `((freenode     (("Ziarkaen" . ,freenode-nickserv-password)))))

(global-set-key "\C-cic" 'connect-to-irc)

(setq erc-autojoin-channels-alist '(("freenode.net" "#emacs" "##French" "##math"
				                    "#ruby" "#latin")))
;				    ("snoonet.org" "#totallanguage")))

;; Only use modebar when something important happens
(setq erc-format-query-as-channel-p t
        erc-track-priority-faces-only 'all
        erc-track-faces-priority-list '(erc-error-face
                                        erc-current-nick-face
                                        erc-keyword-face
                                        erc-nick-msg-face
                                        erc-direct-msg-face
                                        erc-dangerous-host-face
                                        erc-prompt-face))
;; Keep prompt anchored to bottom of buffer.  Why would I want it half-way up?!
(require 'erc-goodies)
;;(erc-scroll-to-bottom-mode 1)


;; EMMS
(add-to-list 'load-path "~/.emacs.d/emms")
(require 'emms-setup)
(require 'emms-streams)
(require 'emms-volume)
(emms-standard)
(emms-default-players)
(setq emms-source-file-default-directory "~/music/")

(global-set-key (kbd "C-c e x") 'emms-start)
(global-set-key (kbd "C-c e v") 'emms-stop)

(global-set-key (kbd "C-c e n") 'emms-next)
(global-set-key (kbd "C-c e p") 'emms-previous)
(global-set-key (kbd "C-c e a") 'emms-random)
(global-set-key (kbd "C-c e o") 'emms-show)
(global-set-key (kbd "C-c e h") 'emms-shuffle)
(global-set-key (kbd "C-c e SPC") 'emms-pause)
(global-set-key (kbd "C-c e r") 'emms-toggle-repeat-track)
(global-set-key (kbd "C-c e R") 'emms-toggle-repeat-playlist)

(global-set-key (kbd "C-c e l") 'emms-lyrics-toggle-display-buffer)
(global-set-key (kbd "C-c e L") 'emms-lyrics-visit-lyric)

(global-set-key (kbd "C-c e s") 'emms-lastfm-radio-similar-artists)
(global-set-key (kbd "C-c e k") 'emms-lastfm-radio-skip)

(global-set-key (kbd "C-c e g") 'emms-playlist-mode-go)
;; (global-set-key (kbd "C-c e a") 'emms-add-directory-tree)
(global-set-key (kbd "C-c e t") 'emms-play-directory-tree)

(global-set-key (kbd "C-c e <up>") 'emms-volume-raise)
(global-set-key (kbd "C-c e <down>") 'emms-volume-lower)

;; Don't block other audio apps
(setq emms-player-mpg321-parameters '("-o" "alsa"))






;; Originally from stevey, adapted to support moving to a new directory.
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive
   (progn
     (if (not (buffer-file-name))
         (error "Buffer '%s' is not visiting a file!" (buffer-name)))
     (list (read-file-name (format "Rename %s to: " (file-name-nondirectory
                                                     (buffer-file-name)))))))
  (if (equal new-name "")
      (error "Aborted rename"))
  (setq new-name (if (file-directory-p new-name)
                     (expand-file-name (file-name-nondirectory
                                        (buffer-file-name))
                                       new-name)
                   (expand-file-name new-name)))
  ;; If the file isn't saved yet, skip the file rename, but still update the
  ;; buffer name and visited file.
  (if (file-exists-p (buffer-file-name))
      (rename-file (buffer-file-name) new-name 1))
  (let ((was-modified (buffer-modified-p)))
    ;; This also renames the buffer, and works with uniquify
    (set-visited-file-name new-name)
    (if was-modified
        (save-buffer)
      ;; Clear buffer-modified flag caused by set-visited-file-name
      (set-buffer-modified-p nil))
  (message "Renamed to %s." new-name)))

;; reload
(global-set-key (kbd "C-c g") (lambda () (interactive) (load-file "/home/ziarkaen/.emacs.d/init.el")))

(defun ruby-eval-region()
  "Prints the evaluation of Ruby statements in region to a new output buffer"
  (interactive)
  (let ((output-buffer "Ruby Output"))
    (shell-command-on-region (mark) (point) "ruby" output-buffer)))

;; Ruby
(defun ruby-eval-region()
  "Prints the evaluation of Ruby statements in region to a new output buffer"
  (interactive)
  (let ((output-buffer "Ruby Output"))
    (shell-command-on-region (mark) (point) "ruby" output-buffer)
    (switch-to-buffer output-buffer)))

(defun ruby-pretty-print()
  "Pretty prints the evaluation of a Ruby expression in region to a new output buffer"
  (interactive)
  (save-excursion
    (let ((code (buffer-substring (mark) (point)))
	  (code-buffer (generate-new-buffer "ruby-code")))
      (switch-to-buffer code-buffer)
      (insert (concat "require 'pp'\nputs (" code ")\n"))
      (mark-whole-buffer)
      (ruby-eval-region)
      (kill-buffer code-buffer))))

;; Winner mode
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; Enable all commands
(setq disabled-command-function nil)

;; better buffer list
(global-set-key "\C-x\C-b" 'bs-show)

;; No more fill-column
(global-set-key "\C-x\ f" 'find-file)

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

;; Remember history between sessions
(savehist-mode t)
(setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))
