;; Sources (incomplete list):
;;   http://en.wikipedia.org/wiki/User:Gwern/.emacs
;;   http://www.cabochon.com/~stevey/blog-rants/my-dot-emacs-file.html
;;   EmacsWiki

;; Secrets!
(load-file "~/.secret/emacs.el")

;; Other emacs lisp files
(add-to-list 'load-path "~/.emacs.d/load/")

;; Initialize packages before other init stuff
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/")
	     'APPEND)

(add-to-list 'package-archives
                     '("melpa" . "http://melpa.milkbox.net/packages/")
                     'APPEND)

(setq package-enable-at-startup nil)
(package-initialize)

;; And finally my init files TODO use load-path? ordering?
(let ((init-files (directory-files "~/.emacs.d/init/" nil "^.*\.el$")))
  (mapc 'load-file
	(mapcar (lambda (file) (concat "~/.emacs.d/init/" file)) init-files)))
