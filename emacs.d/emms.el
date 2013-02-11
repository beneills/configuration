;; EMMS
(add-to-list 'load-path "~/.emacs.d/emms")
(require 'emms-setup)
(require 'emms-streams)
(require 'emms-volume)
(emms-standard)
(emms-default-players)
(setq emms-source-file-default-directory "~/Music/")

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
