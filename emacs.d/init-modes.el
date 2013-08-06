;; Winner mode
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; Remember history between sessions
(savehist-mode t)
(setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))

;; IDO
(ido-mode t)



(require 'uniquify) ;; make buffer names more unique
(setq 
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":"
  uniquify-after-kill-buffer-p t
  uniquify-ignore-buffers-re "^\\*")


;; recentf stuff
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;; Alow file editing as root
(require 'tramp)
(setq tramp-default-method "scp")
(setq recentf-auto-cleanup 'never) ; stop recentf trying to SSH all the time

