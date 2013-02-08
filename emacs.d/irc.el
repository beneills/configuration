;;; ERC configuration

(require 'erc-services)

(erc-services-mode 1)
     
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



