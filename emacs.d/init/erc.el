;;; ERC configuration
(require 'erc-services)

(erc-services-mode 1)


     
;;; Set up IRC stuff and connect to my networks.
(defun connect-to-irc ()
  "Connect to IRC."
  (interactive)
  (erc :server "irc.freenode.net" :port 6667
       :nick "Ziarkaen" :full-name "Ziarkaen"))
;  (erc :server "irc.snoonet.org" :port 6667
;       :nick "Ziarkaen" :full-name "Ziarkaen"))


(setq erc-prompt-for-nickserv-password nil)
(setq erc-nickserv-passwords
      `((freenode     (("Ziarkaen" . ,freenode-nickserv-password)))))



(setq erc-autojoin-channels-alist '(("freenode.net" "#emacs" "##French" "##math"
				                    "#ruby" "#latin")))
;				    ("snoonet.org" "#totallanguage")))

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
