;;;;
;;;; General keybindings
;;;;

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-cs"
		(lambda ()
		  (interactive)
		  (set-process-query-on-exit-flag
		   (get-buffer-process (ansi-term "/bin/bash")) nil)))

(global-set-key "\C-x\ W" 'rename-file-and-buffer)
(global-set-key "\C-c\C-o" 'my-open-at-point)


(global-set-key (kbd "C-x g") 'magit-status)

(global-set-key (kbd "C-x C-r") 'ido-recentf-open)

(global-set-key "\C-cic" 'connect-to-irc)


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

(global-set-key (kbd "C-c e s") (lambda () (interactive) (emms-score-set-playing 4)))
(global-set-key (kbd "C-c e k") 'emms-lastfm-radio-skip)

(global-set-key (kbd "C-c e g") 'emms-playlist-mode-go)
;; (global-set-key (kbd "C-c e a") 'emms-add-directory-tree)
(global-set-key (kbd "C-c e t") 'emms-play-directory-tree)

(global-set-key (kbd "C-c e <up>") 'emms-volume-raise)
(global-set-key (kbd "C-c e <down>") 'emms-volume-lower)

;; org-mode 
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;; better buffer list
(global-set-key "\C-x\C-b" 'bs-show)

;; No more fill-column
(global-set-key "\C-x\ f" 'find-file)


;; reload
(global-set-key (kbd "C-c g") (lambda () (interactive) (load-file "/home/ziarkaen/.emacs.d/init.el")))

(define-key dired-mode-map (kbd "b") 'dired-dotfiles-toggle)

(global-set-key "\M-/" 'hippie-expand)
