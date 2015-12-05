;; Ensure we have just one package available: ob-tangle
(package-initialize)
(require 'ob-tangle)

;; Parse and load literate Org-mode file containing Emacs config
(org-babel-load-file "~/.emacs.d/beneills.org")
