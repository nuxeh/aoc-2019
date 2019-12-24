(use-modules (ice-9 pretty-print))

(define input (read))
(define arr (make-array #\. (length input) (length input)))

(define (print-grid g)
  (pretty-print g #:display? #t))

(define x 0)
(define y 0)
(for-each (lambda (line)
	    (for-each (lambda (char)
			(array-set! arr char y x)
			(set! x (1+ x)))
		      line)
	    (set! y (1+ y))
	    (set! x 0))
	  input)

(display input)(newline)
(print-grid arr)
