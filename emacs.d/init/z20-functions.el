;; Originally from stevey, adapted to support moving to a new directory.
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive
   (progn
     (if (not (buffer-file-name))
         (error "Buffer '%s' is not visiting a file!" (buffer-name)))
     (list (read-file-name (format "Rename %s to: " (file-name-nondirectory
                                                     (buffer-file-name)))))))
  (if (equal new-name "")
      (error "Aborted rename"))
  (setq new-name (if (file-directory-p new-name)
                     (expand-file-name (file-name-nondirectory
                                        (buffer-file-name))
                                       new-name)
                   (expand-file-name new-name)))
  ;; If the file isn't saved yet, skip the file rename, but still update the
  ;; buffer name and visited file.
  (if (file-exists-p (buffer-file-name))
      (rename-file (buffer-file-name) new-name 1))
  (let ((was-modified (buffer-modified-p)))
    ;; This also renames the buffer, and works with uniquify
    (set-visited-file-name new-name)
    (if was-modified
        (save-buffer)
      ;; Clear buffer-modified flag caused by set-visited-file-name
      (set-buffer-modified-p nil))
  (message "Renamed to %s." new-name)))



(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

;;; Org Mode - HOOK MUST BE SET BEFORE DEFAULT ORG FILES
(defun org-todo-and-next ()
       "Toggle todo status and go to next line"
       (interactive)
       (org-todo)
       (search-forward "TODO"))

(defun my-open-at-point ()
  (interactive)
  (condition-case nil
       (call-interactively 'org-open-at-point-global)
     (error (find-file-at-point))))

(defun ben-log (message)
  (let ((log-command "~/projects/log/log.rb"))
    (shell-command (format "%s %s > /dev/null" log-command message))))

(defun grep-todos ()
  (interactive)
  (let ((todo-exclude-directories '("~/archive"
				    "~/backup"
				    "~/bin/brainworkshop_files"
				    "~/plans"
				    "~/.ido.last"
				    "~/books"
				    "~/calibre"
				    "~/conf/emacs.d/elpa"
				    "~/downloads"
				    "~/images"
				    "~/music"
				    "~/nobackup"
				    "~/plans"
				    "~/queue"
				    "~/torrents"
				    "~/.cache"
				    "~/.config"
				    "~/.dbus"
				    "~/.dropbox"
				    "~/.dropbox-dist"
				    "~/.emacs_backups"
				    "~/.gconf"
				    "~/.gem"
				    "~/.gnome2"
				    "~/.gnome2_private"
				    "~/.gstreamer-0.10"
				    "~/.ido.last"
				    "~/.kde"
				    "~/.local"
				    "~/.macromedia"
				    "~/.marks"
				    "~/.matplotlib"
				    "~/.mozilla"
				    "~/.mplayer"
				    "~/.onboard"
				    "~/.pan2"
				    "~/.pki"
				    "~/.plan"
				    "~/.purple"
				    "~/.sabnzbd"
				    "~/.secret"
				    "~/.ssh"
				    "~/.wicd"))
	(find-args "find ~/ -type d \\( ! -path \\.git \\) \\( -path %s \\) -prune -o -type f -exec grep -nH -e TODO {} +"))
    (grep-find (format find-args
		       (mapconcat 'identity todo-exclude-directories " -o -path ")))))
