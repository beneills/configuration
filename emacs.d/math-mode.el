(defun insert-math-minor-mode-item (item)
  (insert (format "*%s*: " item)))

(defun insert-definition ()
  (interactive)
  (insert-math-minor-mode-item "Definition"))

(defun insert-theorem ()
  (interactive)
  (insert-math-minor-mode-item "Theorem"))

(defun insert-note ()
  (interactive)
  (insert-math-minor-mode-item "Note"))

(defun insert-proposition ()
  (interactive)
  (insert-math-minor-mode-item "Proposition"))

(defun insert-lemma ()
  (interactive)
  (insert-math-minor-mode-item "Lemma"))

(defun insert-lemma ()
  (interactive)
  (insert-math-minor-mode-item "Example"))


(setq math-minor-mode-keymap
      (let ((map (make-sparse-keymap)))
	(define-key map (kbd "C-c m d") 'insert-definition)
	(define-key map (kbd "C-c m t") 'insert-theorem)
	(define-key map (kbd "C-c m n") 'insert-note)
	(define-key map (kbd "C-c m p") 'insert-proposition)
	(define-key map (kbd "C-c m l") 'insert-lemma)
	(define-key map (kbd "C-c m e") 'insert-example)
	map))

(define-minor-mode math-minor-mode
  "Toggle Math mindor mode."
  nil
  ;; The indicator for the mode line.
  " math"
;;  :group 'yasnippet
  :keymap math-minor-mode-keymap
  (cond (math-minor-mode)
	(insert "Activated")))



