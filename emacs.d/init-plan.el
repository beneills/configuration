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


;; Plan auto-revert mode
(save-current-buffer
  (set-buffer "plan")
  (turn-on-auto-revert-mode))

;; Plan in morning, projects otherwise
(if (first-startup-today-p)
    (switch-to-buffer "plan")
  (switch-to-buffer "projects"))

;; Keys
(global-set-key "\C-cp" 'plan)
