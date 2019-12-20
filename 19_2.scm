(use-modules (ice-9 rdelim)) ;read-line

(define (char->bit x)
  (if (equal? x #\#)
      1
      0))

(define (process-line l)
  (let ((dim (string-length l)))
    (let ((d (map char->bit (string->list l))))
      d)))

(do ((c (read-line) (read-line)))
  ((eof-object? c) 'done)
  (let ((d (process-line c)))
    (display d)(newline)))
