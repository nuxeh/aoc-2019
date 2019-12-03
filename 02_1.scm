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
    (display c)
    (newline)
    (display head)
    (display tail)
    (if (< c n)
      (get-ins tail n (+ n 1))
      head)))

(let ((x (read)))
  (let ((i (string-split (symbol->string x) #\,)))
    (display i)
    (newline)
    (display (get-ins i 1 0))))
