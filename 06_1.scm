(use-modules (srfi srfi-1))

(define (build-tree orbits name depth)
  (let ((child (filter (lambda (o) (equal? (car o) name)) orbits)))
    (display child)
    (if (eq? (length child) 0)
        depth
        (fold + 0 (map (lambda (o) (build-tree orbits o depth)) orbits)))))

(define (get-orbits)
  (let ((o '()))
    (do ((l (read) (read)))
      ((eof-object? l) 'done)
      (set! o (append o (list (string-split (symbol->string l) #\|)))))
    o))

(let ((orbits (get-orbits)))
  (display orbits)(newline)
  (display (build-tree orbits "COM" 0)))

