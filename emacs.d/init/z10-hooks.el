(add-hook 'org-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-c w") 'bold-word)
	    (local-set-key (kbd "C-c b") 'blue-word)
	    (local-set-key (kbd "C-c t") 'org-todo-and-next)))

(add-hook 'markdown-mode-hook
            (lambda ()
              (when buffer-file-name
                (add-hook 'after-save-hook
                          'check-parens
                          nil t))))
