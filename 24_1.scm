(use-modules (ice-9 pretty-print))

(define input (read))
(define dim (length input))
(define array (make-array #\. dim dim))

(define (print-grid g)
  (pretty-print g #:display? #t))

;(define x 0)
;(define y 0)
;(for-each (lambda (line)
;	    (for-each (lambda (char)
;			(array-set! array char y x)
;			(set! x (1+ x)))
;		      line)
;	    (set! y (1+ y))
;	    (set! x 0))
;	  input)

(array-index-map! array (lambda (y x)
			  (list-ref (list-ref input y) x)))

(display input)(newline)
(print-grid array)

(define (n-adjacent? arr y x)
  (define nx 0)
  (define ny 0)
  (if (> y 0)
      (if (eq? (array-ref arr (1- y) x) #\#)
	  (set! ny (1+ ny))))
  (if (< y (1- dim))
      (if (eq? (array-ref arr (1+ y) x) #\#)
	  (set! ny (1+ ny))))
  (if (> x 0)
      (if (eq? (array-ref arr y (1- x)) #\#)
	  (set! nx (1+ nx))))
  (if (< x (1- dim))
      (if (eq? (array-ref arr y (1+ x)) #\#)
	  (set! nx (1+ nx))))
  (+ nx ny))

(define (alive? arr y x)
  (define adj (n-adjacent? arr y x))
  (define ret (array-ref arr y x))
  (if (eq? ret #\#)
      (if (not (eq? adj 1))
	  (set! ret #\.))
      (if (or (eq? adj 1) (eq? adj 2))
	  (set! ret #\#)))
  ret)

(define new-arr (make-array #\. dim dim))
(array-index-map! new-arr (lambda (y x) (alive? array y x)))
(print-grid new-arr)
