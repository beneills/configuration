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
  (setq plan-timer-start-time (current-time)))

(defun plan-timer-stop()
  (interactive)
  (format-seconds "%M %S"
		  (nth 1 (time-subtract (current-time) plan-timer-start-time))))



;; Plan in morning, projects otherwise
(if (first-startup-today-p)
    (switch-to-buffer "plan")
  (switch-to-buffer "projects"))

;; Plan auto-revert mode
(save-current-buffer
  (when (get-buffer "plan")
    (set-buffer "plan")
    (turn-on-auto-revert-mode)))

;; Keys
(global-set-key "\C-cp" 'plan)
