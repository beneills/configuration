;; EMMS
(require 'emms-setup)
(require 'emms-volume)
(emms-default)

(emms-default-players)
(setq emms-source-file-default-directory "~/music/")
(setq emms-player-mpg321-parameters '("-o" "alsa"))

(emms-mode-line-disable)
(emms-playing-time-disable-display)

;; lastfm settings in ~/.secret/emacs.el - disabled currently



;; EMMS
;(add-to-list 'load-path "~/.emacs.d/emms")
;(require 'emms-setup)
;(require 'emms-streams)

;(emms-standard)
;(emms-default-players)
;; Don't block other audio apps


