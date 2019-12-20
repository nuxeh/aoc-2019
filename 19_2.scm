(use-modules (ice-9 rdelim)) ;read-line

(define (char->bit x)
  (if (equal? x #\#)
      #t
      #f))

(do ((c (read-line) (read-line)))
  ((eof-object? c) 'done)
  (let ((d (map char->bit (string->list c))))
    (display d)(newline)))
