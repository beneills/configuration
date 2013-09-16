;; Is this our first startup today? Designed to be called *once* only
(defun first-startup-today-p ()
  (let ((path (format-time-string "~/.emacs.d/daily-startup/%Y-%m-%d.touch")))
    (if (file-exists-p path)
	nil
      (progn (shell-command (concat "touch " path)) t))))

(defun plan()
  "View plan fullscreen"
  (interactive)
  (find-file plan-path)
  (delete-other-windows))

(defun plan-weekly()
  (interactive)
  (shell-command "weekly &"))

(defun plan-timer-start()
  (interactive)
  (setq plan-timer-start-time (current-time))
  (message "Weekly plan timer started"))

(defun plan-timer-stop()
  (interactive)
  (let ((time (format-seconds "%M %S"
			      (nth 1 (time-subtract (current-time) plan-timer-start-time)))))
    (ben-log (format "weekly plan completed in %s" time))
    (message time)))

(defun find-project-files-of-pattern (pattern)
  (split-string (shell-command-to-string (format "echo -n $(find ~/projects -type f -name %s)" pattern)) "\n"))

(defun open-project-files-of-pattern (pattern)
  (mapc 'find-file (find-project-files-of-pattern pattern)))

(defun open-weekly-review-files ()
  (interactive)
  (open-project-files-of-pattern "*review.weekly.org"))

(defun open-monthly-review-files ()
  (interactive)
  (open-project-files-of-pattern "*review.monthly.org"))

;; Plan in morning, projects otherwise
(if (first-startup-today-p)
    (switch-to-buffer "plan")
  (switch-to-buffer "projects"))

;; Plan auto-revert
(save-current-buffer
  (when (get-buffer "plan")
    (set-buffer "plan")
    (turn-on-auto-revert-mode)))

;; auto-save mode
(setq plan-auto-save-timer (run-at-time t 10 (lambda ()
					       (save-current-buffer
						 (when (get-buffer "plan")
						   (set-buffer "plan")
						   (if (and (buffer-file-name) (buffer-modified-p))
						       (save-buffer)))))))
;; (cancel-timer plan-auto-save-timer)


;; Keys
(global-set-key "\C-cp" 'plan)

