;; EMMS
(require 'emms-setup)
(require 'emms-volume)
(emms-standard)
(emms-default-players)
(setq emms-source-file-default-directory "~/music/")
(setq emms-player-mpg321-parameters '("-o" "alsa"))

;; EMMS
;(add-to-list 'load-path "~/.emacs.d/emms")
;(require 'emms-setup)
;(require 'emms-streams)

;(emms-standard)
;(emms-default-players)
;; Don't block other audio apps


