(use-modules (ice-9 rdelim)) ;read-line

(define input '())

;read input
(do ((c (read-line) (read-line)))
  ((eof-object? c) 'done)
  (set! input (append input (list (string->list c)))))

(display input)(newline)

