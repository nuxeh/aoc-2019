(use-modules (srfi srfi-1))

(define (get-sublist l s f)
  (list-head (list-tail l 4) f))

(define (recurse l p r) #t)

(define (run l r)
  (let ((sp (split-at l 4)))
    (let ((i (cdr sp)))
      (let ((s (car sp)))
        (display (string-append i " -> " s))))))

(let ((x (read)))
  (let ((i (string-split (symbol->string x) #\,)))
    (display i)
    (newline)
    (display (run i (list 0)))))
