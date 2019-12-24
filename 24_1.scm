(use-modules (ice-9 pretty-print))

(define input (read))
(define array (make-array #\. (length input) (length input)))

(define (print-grid g)
  (pretty-print g #:display? #t))

(display input)(newline)
(print-grid array)
