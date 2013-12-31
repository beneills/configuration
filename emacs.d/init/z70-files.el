;; (setq plan-path (format-time-string "~/plans/%Y-%m-%d.org"))
(setq plan-path (format-time-string "~/plans/today.org"))

;; Startup
(setq default-files `(("emacs-config" . "~/conf/emacs.d/init/")
		      ("inbox" . "~/conf/emacs.d/init/z95-inbox.el")
		      ("bash-config" . "~/conf/bashrc")
		      ("awesome-config" . "~/conf/config/awesome/rc.lua")
		      ("x-config" . "~/conf/xsession")
;		      ("plan" . ,plan-path)
		      ))

(setq default-directories '(("bin" . "~/bin")
			    ("projects" . "~/projects"))) ; we want ~/projects last

;; TODO merge these?

;; (dolist (item default-files)
;;   (let ((name (car item))
;; 	(path (cdr item)))
;;      (unless (get-file-buffer path)
;;        (find-file path)
;;        (rename-buffer name))))

;; (dolist (item default-directories)
;;   (let ((name (car item))
;; 	(path (cdr item)))
;;      (unless (get-buffer name)
;;        (dired path)
;;        (rename-buffer name))))
