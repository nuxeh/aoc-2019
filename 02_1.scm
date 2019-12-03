(define (get-sublist l s f)
  (list-head (list-tail l 4) f))

(define (recurse l p r) #t)

(define (run l r)
  (split-at l 4))

(let ((x (read)))
  (let ((i (string-split (symbol->string x) #\,)))
    (display i)
    (newline)
    (display (list-head i 4))))
