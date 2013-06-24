;;;;
;;;; General keybindings
;;;;

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-cs" 'shell)


;;;;
;;;; More sensible defaults
;;;;

;; Set default browser to Chromium
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/usr/bin/chromium")

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
(setq backup-directory-alist '((".*" . "~/.emacs_backups/")))

;; Stop requiring yes/no full words
(defalias 'yes-or-no-p 'y-or-n-p)

;; EmacsClient config
(server-start)

(setq inhibit-startup-message t
  inhibit-startup-echo-area-message t)

(setq require-final-newline t)









;; IDO
(ido-mode t)

;; EMMS
(require 'emms-setup)
(emms-standard)
(emms-default-players)


;; Magit
(when (package-installed-p 'magit)
  (require 'magit)
  (global-set-key (kbd "C-x g") 'magit-status))

;; Open this conf file by default
(let ((conf-file "~/conf/emacs"))
     (unless (get-file-buffer conf-file)
       (and (find-file conf-file)
       	    (rename-buffer "config")
	    (end-of-buffer))))

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





;; ;; Start maximizeded
;; (defun activate-maximized ()
;;   (interactive)
;;   (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
;;                  '(1 "_NET_WM_STATE_MAXIMIZED_VERT"
;; 		     "_NET_WM_STATE_MAXIMIZED_HORZ"))
;; )
;; (if (window-system)
;;   (activate-maximized))

(require 'uniquify) ;; make buffer names more unique
(setq 
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":"
  uniquify-after-kill-buffer-p t
  uniquify-ignore-buffers-re "^\\*")





;; http://www.emacswiki.org/cgi-bin/wiki/ShowParenMode




;;; ERC configuration
(require 'erc-services)

(erc-services-mode 1)

(setq freenode-nickserv-password "TODO")
     
;;; Set up IRC stuff and connect to my networks.
(defun connect-to-irc ()
  "Connect to IRC."
  (interactive)
  (erc :server "irc.freenode.net" :port 6667
       :nick "Ziarkaen" :full-name "Ziarkaen")
  (erc :server "irc.snoonet.org" :port 6667
       :nick "Ziarkaen" :full-name "Ziarkaen"))


(setq erc-prompt-for-nickserv-password nil)
(setq erc-nickserv-passwords
      `((freenode     (("Ziarkaen" . ,freenode-nickserv-password)))))

(global-set-key "\C-cic" 'connect-to-irc)

(setq erc-autojoin-channels-alist '(("freenode.net" "#emacs" "#erc" "##French" "##math" "#haskell" "#hakyll")
				    ("snoonet.org" "#totallanguage")))

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
(setq emms-source-file-default-directory "~/Downloads/")

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




