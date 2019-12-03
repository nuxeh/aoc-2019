(use-modules (srfi srfi-1))
(import (rnrs))

(define (get-sublist l s f)
  (list-head (list-tail l 4) f))

(define (recurse l p r) #t)

(define (run l r)
  (let-values (((i s) (split-at l 4)))
    (display (string-append i " -> " s))))

(let ((x (read)))
  (let ((i (string-split (symbol->string x) #\,)))
    (display i)
    (newline)
    (display (run i (list 0)))))
