;; (setq plan-path (format-time-string "~/plans/%Y-%m-%d.org"))
(setq plan-path (format-time-string "~/plans/today.org"))

;; Startup
(setq default-files `(("emacs-config" . "~/conf/emacs.d/init.el")
		      ("bash-config" . "~/conf/bashrc")
		      ("awesome-config" . "~/conf/config/awesome/rc.lua")
		      ("plan" . ,plan-path)
		      ("daily" . "~/.plan/templates/daily.org")))

(setq default-directories '(("bin" . "~/bin")
			    ("projects" . "~/projects"))) ; we want ~/projects last

(dolist (item default-files)
  (let ((name (car item))
	(path (cdr item)))
     (unless (get-file-buffer path)
       (find-file path)
       (rename-buffer name))))

(dolist (item default-directories)
  (let ((name (car item))
	(path (cdr item)))
     (unless (get-buffer name)
       (dired path)
       (rename-buffer name))))
