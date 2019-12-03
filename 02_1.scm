(use-modules (srfi srfi-1))
(use-modules (srfi srfi-11))

;(define (get-sublist l s f)
;  (list-head (list-tail l 4) f))

;(define (recurse l p r) #t)

(define (one l i) #t
  )

(define (two l i) #t
  )

(define (get-ins l n c)
  (let-values (((head tail) (split-at l 4)))
    (newline)
    (display c)
    (display head)
    (display tail)
    (if (< c n)
	(if (>= (length tail) 4)
          (get-ins tail n (+ c 1))
	  head)
      head)))

(let ((x (read)))
  (let ((i (string-split (symbol->string x) #\,)))
    (display i)
    (newline)
    (display (get-ins i 4 0))))
