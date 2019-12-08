(use-modules (srfi srfi-1))

(define (build-tree orbits name)
  (let ((child (fold (lambda (o, a) (eq? (car o) name)) orbits)))
    (display child)))

(define (get-orbits)
  (let ((o '()))
    (do ((l (read) (read)))
      ((eof-object? l) 'done)
      (set! o (append o (list (string-split (symbol->string l) #\|)))))
    o))

(let ((orbits (get-orbits)))
  (display orbits)
  (build-tree orbits "COM"))

