(use-modules (ice-9 rdelim))

(let ((s ""))
  (do ((c (read-line) (read-line)))
      ((eof-object? c) 'done)
      (set! s (string-append s c))
      (display (string->list s))(newline)))
