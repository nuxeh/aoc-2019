(use-modules (ice-9 pretty-print))
(use-modules (srfi srfi-1)) ;fold

(define input (read))
(define dim (length input))
(define array (make-array #\. dim dim))

(define (print-grid g)
  (pretty-print g #:display? #t))

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

(define (gen a)
  (define new-arr (make-array #\. dim dim))
  (array-index-map! new-arr (lambda (y x) (alive? a y x)))
  new-arr)

(print-grid (gen array))

(define (bio a)
  (define res (make-array 0 dim dim))
  (array-index-map! res (lambda (y x) (if (eq? (array-ref a y x) #\#)
					  (expt 2 (+ x (* y dim)))
					  0)))
  (fold + 0 (map (lambda (e) (fold + 0 e)) (array->list res))))

;(print-grid (bio (gen array)))

(define (run m space bio-ratings)
  (define new (gen space))
  (define b (bio new))
  (if (member b bio-ratings)
      (begin (display b)(newline))
      (run (1+ m) new (append bio-ratings (list b)))))

(run 0 array '())
