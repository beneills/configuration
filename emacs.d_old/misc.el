;; (when (require 'color-theme nil 'noerror)
;;   (when (require 'color-theme-init nil 'noerror)
;;     (color-theme-djcb-dark))
;;   (if (require 'zenburn nil 'noerror)
;;     (color-theme-zenburn)))
;; (setq-default cursor-type '(hbar . 2))

;; ;; the in-frame speedbar
;; (when (require 'sr-speedbar nil 'noerror)
;;   (setq speedbar-supported-extension-expressions
;;     '(".org" ".[ch]\\(\\+\\+\\|pp\\|c\\|h\\|xx\\)?"
;;        ".tex\\(i\\(nfo\\)?\\)?" ".el"
;;        ".java" ".p[lm]" ".pm" ".py"  ".s?html"  "Makefile.am" "configure.ac"))
;;   (setq
;;     sr-speedbar-width-x 20
;;     sr-speedbar-right-side t))

;; ;; tramp, for remote access
;; (require 'tramp)
;; ;; we need a bit more funky pattern, as tramp will start $SHELL
;; ;; (sudo -s), ie., zsh for root user
;; (setq shell-prompt-pattern "^[^a-zA-Z].*[#$%>] *")
;; (setq
;;   tramp-default-method "ssh"
;;   tramp-persistency-file-name "~/.emacs.d/cache/tramp")

;; ;; disable cua and transient mark modes in term-char-mode
;; ;; http://www.emacswiki.org/emacs/AnsiTermHints
;; ;; remember: Term-mode remaps C-x to C-c
;; (defadvice term-char-mode (after term-char-mode-fixes ())
;;   (set (make-local-variable 'cua-mode) nil)
;;   (set (make-local-variable 'transient-mark-mode) nil)
;;   (set (make-local-variable 'global-hl-line-mode) nil)
;;   (ad-activate 'term-char-mode)
;;   (term-set-escape-char ?\C-x))

;; (add-hook 'term-mode-hook 
;;   (lambda()
;;     (local-unset-key (kbd "<tab>"))))

;; ;; multi-term
;; (when (require 'multi-term nil 'noerror)
;;   (setq multi-term-program "/bin/zsh"))


;; ;; w3m / browsing settings
;; (setq w3m-init-file "~/.emacs.d/mylisp/djcb-w3m.el")

;; (if (file-exists-p "/usr/bin/conkeror")
;;   (setq browse-url-browser-function 'browse-url-generic
;;     browse-url-generic-program "/usr/bin/conkeror"
;;      browse-url-default-browser "/usr/bin/conkeror")
;;   (setq
;;     browse-url-browser-function 'browse-url-default-browser))
;; (setq browse-url-new-window-flag t)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; ido-mode
;; ;; http://www.emacswiki.org/cgi-bin/wiki/InteractivelyDoThings
;; (require 'ido) 
;; (ido-mode 'both) ;; for buffers and files
;; (setq 
;;   ido-save-directory-list-file "~/.emacs.d/cache/ido.last"
;;   ido-ignore-buffers ;; ignore these guys
;;   '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"
;;      "^\*compilation" "^\*GTAGS" "^session\.*" "^\*")
;;   ido-work-directory-list '("~/" "~/Desktop" "~/Documents" "~src")
;;   ido-case-fold  t                 ; be case-insensitive
;;   ido-enable-last-directory-history t ; remember last used dirs
;;   ido-max-work-directory-list 30   ; should be enough
;;   ido-max-work-file-list      50   ; remember many
;;   ido-use-filename-at-point nil    ; don't use filename at point (annoying)
;;   ido-use-url-at-point nil         ; don't use url at point (annoying)
;;   ido-enable-flex-matching nil     ; don't try to be too smart
;;   ido-max-prospects 8              ; don't spam my minibuffer
;;   ido-confirm-unique-completion t) ; wait for RET, even with unique completion

;; ;; when using ido, the confirmation is rather annoying...
;;  (setq confirm-nonexistent-file-or-buffer nil)

;; ;; increase minibuffer size when ido completion is active
;; (add-hook 'ido-minibuffer-setup-hook 
;;   (function
;;     (lambda ()
;;       (make-local-variable 'resize-minibuffer-window-max-height)
;;       (setq resize-minibuffer-window-max-height 1))))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; yasnippet mode
;; (when (require 'yasnippet nil 'noerror) ;; not: yasnippet-bundle
;;   (setq yas/root-directory
;;     '("~/.emacs.d/yas/yasnippet/snippets"
;;        "~/.emacs.d/yas/custom")) ;; my own snippets
;;   (mapc 'yas/load-directory yas/root-directory)
;;   (setq yas/wrap-around-region t)
;;   (setq yas/prompt-functions
;;     '(yas/x-prompt yas/ido-prompt))
;;   (yas/global-mode 1) ;;  make it global
;;   (add-to-list 'auto-mode-alist '("yas/.*" . snippet-mode)))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; twitter/identica/advogato
;; ;; http://www.busydoingnothing.co.uk/twitter-el/
;; (autoload 'twitter-get-friends-timeline "twitter" nil t)
;; (autoload 'twitter-status-edit "twitter" nil t)
;; (add-hook 'twitter-status-edit-mode-hook 'longlines-mode)
;; ;; identi.ca: 
;; (autoload 'identica-mode "identica-mode" nil t)
;; (add-hook 'identica-mode-hook
;;   (lambda () (load-library "secrets.el.gpg")))
;; ;; advogato
;; (autoload 'advogato-mode "advogato" nil t)
;; (add-hook 'advogato-mode-hook
;;   (lambda () (load-library "secrets.el.gpg")))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; global keybindings
;; ;;
;; (global-set-key (kbd "RET")         'newline-and-indent)
;; (global-set-key (kbd "C-<f4>")      'kill-buffer-and-window)
;; (global-set-key (kbd "<delete>")    'delete-char)  ; delete == delete    
;; (global-set-key (kbd "M-g")         'goto-line)    ; M-g  'goto-line

;; (when (fboundp 'ibuffer)
;;   (global-set-key (kbd "C-x C-b") 'ibuffer))   ;; ibuffer

;; ;; C-pgup goes to the start, C-pgdw goes to the end
;; (global-set-key (kbd "<C-prior>")
;;   (lambda()(interactive)(goto-char(point-min))))
;; (global-set-key (kbd "<C-next>")
;;   (lambda()(interactive)(goto-char(point-max))))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; programming
;; (autoload 'linum-mode "linum" "mode for line numbers" t) 
;; (global-set-key (kbd "C-<f5>") 'linum-mode)                 ;; line numbers
;; (global-set-key (kbd "C-<f6>") 'magit-status)               ;; ...git mode
;; (global-set-key (kbd "C-<f7>") 'compile)                     ;; compile
;; (global-set-key (kbd "C-<f8>") 'comment-or-uncomment-region) ;; (un)comment

;; (when (fboundp 'sr-speedbar-toggle)
;;   (global-set-key (kbd "C-<f9>") 'sr-speedbar-toggle)
;;   (global-set-key (kbd "C-<f10>") 'sr-speedbar-select-window)) ; speedbar
;; (global-set-key (kbd "C-c d") 'djcb-dup)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; elscreen
;; (setq elscreen-prefix-key (kbd "C-c q")
;;   elscreen-display-tab nil
;;   elscreen-display-screen-number nil)
;; (when (require 'elscreen nil 'noerror)
;;     (global-set-key (kbd "<f12>"    )  'elscreen-create)
;;     (global-set-key (kbd "<s-f12>"   )  'elscreen-kill)  
;;     (global-set-key (kbd "<C-M-tab>")  'elscreen-previous) 
;;     (global-set-key (kbd "<C-tab>"  )  'elscreen-next))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; productivity stuff; f9-f12 
;; (global-set-key (kbd "C-c l") 'org-store-link)  ;; Links
;; (global-set-key (kbd "C-c a") 'org-agenda)      ;; Agenda
;; (global-set-key (kbd "C-c b") 'org-iswitchb)    ;; switch
;; (global-set-key (kbd "<f5>")  'wl)              ;; Wanderlust
;; (global-set-key (kbd "<f6>")  'org-agenda-list) ;; Agenda
;; (global-set-key (kbd "<f7>")  'org-todo-list)   ;; todo-list (NextActions)
;; (global-set-key (kbd "<f8>")  'remember)        ;; remember

;; (global-set-key (kbd "C-c W") ;; wanderlust
;;   (lambda()(interactive)(find-file wl-init-file))) 
;; (global-set-key (kbd "C-c O") ;; org-init
;;   (lambda()(interactive)(find-file "~/.emacs.d/org/djcb-org.el"))) 
;; (global-set-key (kbd "C-c G") ;; gtd.org
;;   (lambda()(interactive)(find-file (concat org-directory
;;                                      "agenda/todo.org"))))
;; (global-set-key (kbd "C-c R") ;; remember.org
;;   (lambda()(interactive)(find-file org-default-notes-file))) 


;; ;; program shortcuts
;; (global-set-key (kbd "C-c E") ;; .emacs
;;   (lambda()(interactive)(find-file "~/.emacs.d/init.el")))
;; ;; Firefox...
;; (global-set-key (kbd "C-c f") 'browse-url-firefox)  ;; Firefox...
;; (setq browse-url-firefox-new-window-is-tab t)  ;; ... use tabs
;; (global-set-key (kbd "C-c i") 'identica-mode) ;; identi.ca
;; (global-set-key (kbd "C-c n") 'normal-mode)

;; (global-set-key (kbd "C-c N") (lambda()(interactive)
;;     (ispell-change-dictionary "nederlands") (flyspell-buffer))) 

;; ;; use super + arrow keys to switch between visible buffers
;; (require 'windmove)
;; (windmove-default-keybindings 'super) ;; will be overridden
;; (global-set-key (kbd "<C-s-left>")  'windmove-left)
;; (global-set-key (kbd "<C-s-right>") 'windmove-right)
;; (global-set-key (kbd "<C-s-up>")    'windmove-up)
;; (global-set-key (kbd "<C-s-down>")  'windmove-down)

;; ;; restore window configuration
;; (require 'winner)
;; (setq winner-dont-bind-my-keys t) ;; winner conflicts with org
;; (global-set-key (kbd "<s-left>")      'winner-undo)
;; (global-set-key (kbd "<XF86Forward>") 'winner-redo)
;; (global-set-key (kbd "<s-right>") 'winner-redo)
;; (global-set-key (kbd "<XF86Back>") 'winner-undo)
;; (winner-mode t)

;; (when (fboundp 'djcb-uber-tab) 
;;   (when (fboundp 'yas/trigger-key)
;;     (setq yas/trigger-key (kbd "C-<tab>")))
;;   (global-set-key (kbd "<tab>") 'djcb-uber-tab)
;;   (global-set-key (kbd "<C-S-iso-lefttab>") 'djcb-uber-tab))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; safe locals
;; ;; we mark these as 'safe', so emacs22+ won't give us annoying
;; ;; warnings
;; (setq safe-local-variable-values
;;       (quote ((auto-recompile . t)
;;               (folding-mode . t)
;;               (outline-minor-mode . t)
;;               auto-recompile outline-minor-mode)))