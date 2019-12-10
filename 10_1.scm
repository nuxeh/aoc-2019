(use-modules (ice-9 rdelim))

(define (to-bit v)
  (if (equal? v #\#)
      #t
      #f))

(let ((s ""))
  (do ((c (read-line) (read-line)))
      ((eof-object? c) 'done)
      (set! s (string-append s c)))
  (let ((l (string->list s)))
    (let ((m (list->bitvector (map to-bit l))))
      (display m))))
