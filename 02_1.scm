(use-modules (srfi srfi-1))
(use-modules (srfi srfi-11))

;(define (get-sublist l s f)
;  (list-head (list-tail l 4) f))

;(define (recurse l p r) #t)

(define (run l r)
  (let-values (((head tail) (split-at l 4)))
    (display head)
    (display tail)))

(let ((x (read)))
  (let ((i (string-split (symbol->string x) #\,)))
    (display i)
    (newline)
    (display (run i (list 0)))))
