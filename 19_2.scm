(use-modules (ice-9 rdelim)) ;read-line

(do ((c (read-line) (read-line)))
  ((eof-object? c) 'done)
  (let ((d (string->list c)))
    (display d)(newline)))
